#!/usr/bin/env ruby
# frozen_string_literal: true

require "uri"

# Adds `CGI`-like methods for reading and manipulating query strings.
module CleanableURI
  refine URI do
    # @return [Hash]
    def params
      URI.decode_www_form(query).to_h
    end

    # @param key [String]
    # @param value [String]
    # @param append [Boolean] if true, add the new parameter at the end of the
    #   query, instead of at the start
    # @return [String] `self.query`, with the new parameter added
    def add_param(key, value, append: false)
      new_param = [key, value].join("=")
      self.query = if append
                     [query, new_param]
                   else
                     [new_param, query]
                   end.compact.join("&")
    end

    # @param whitelist [Array<String>] any keys not in this list (unless it is
    #   empty) will be removed from `self.query`
    # @param blacklist [Array<String>] any keys in this list will be removed
    #   from `self.query`
    # @return [String, nil] the newly filtered `query`
    def filter_query!(whitelist: [], blacklist: [])
      return unless query
      return query if (whitelist + blacklist).empty?

      query_ = URI.decode_www_form(query)
      query_.delete_if { |k, _v| !whitelist.include?(k) } unless whitelist.empty?
      query_.delete_if { |k, _v| blacklist.include?(k) }
      self.query = URI.encode_www_form(query_) unless query_.empty?
    end

    # Cleans, then returns, `self`.
    # @return [self]
    def clean!
      return self if scheme == "magnet"

      # no-www
      self.host &&= self.host.delete_prefix("www.")
      # HTTPS everywhere
      self.scheme = "https" if scheme == "http"

      # remove tracking parameters
      filter_query!(blacklist: %w[utm_source utm_campaign utm_medium utm_term utm_content])

      if host == "youtu.be"
        add_param("v", path.delete_prefix("/"))
        self.host = "youtube.com"
        self.path = "/watch"
      end

      case host
      when "amazon.com", "amazon.ca"
        if path == "/s"
          filter_query!(whitelist: %w[k])
        else
          self.query = nil
        end
        self.fragment = nil
        if %r{(?<=/dp/)(?<azin>[a-zA-Z0-9]+)} =~ path
          self.path = "/dp/#{azin}"
        end
      when "archiveofourown.org"
        case path
        when %r{^/(collections|works)/}
          whitelist = %w[style]
          filter_query!(whitelist:)
          path.sub!(%r{^/collections/[^/]+}, "")
          self.fragment = nil
        when %r{^/comments/show_comments}
          if params["work_id"]
            self.path = "/works/#{params['work_id']}"
          elsif params["chapter_id"]
            self.path = "/chapters/#{params['chapter_id']}"
          end
          self.query = nil
        end
      when "duckduckgo.com"
        whitelist = %w[q]
        filter_query!(whitelist:)
      when "google.com", "google.ca"
        if %r{/search} =~ path
          whitelist = %w[q]
          whitelist << "tbm" if params["tbm"] == "isch"
          filter_query!(whitelist:)
        end
      when "instagram.com"
        self.query = nil
      when "ruby-doc.org"
        if %r{/(?<area>core|stdlib)(?<_version>-\d\.\d\.\d)/(?<path>[^#?]+)} =~ to_s
          self.path = "/#{area}/#{path}"
        end
      when "open.spotify.com"
        self.query = nil
      when "at.tumblr.com"
        if %r{(?<=at\.tumblr\.com/)(?<user>\w+)/(?<post>\d+)} =~ to_s
          self.host = "tumblr.com"
          self.path = "/#{user}/#{post}"
        end
      when /\.tumblr\.com\Z/
        self.fragment = nil
        if %r{(?<user>\w+)\.tumblr\.com/post/(?<post>\d+)} =~ to_s
          self.host = "tumblr.com"
          self.path = "/#{user}/#{post}"
        elsif %r{(?<user>\w+)\.tumblr\.com(?:/|/page/\d+)?} =~ to_s
          self.host = "tumblr.com"
          self.path = "/blog/#{user}"
        end
      when "youtube.com"
        whitelist = %w[v t]
        filter_query!(whitelist:) if path == "/watch"
      end

      self
    end

    # @return [String] a clean copy of `self`
    def clean
      dup.clean!
    end
  end
end

# Cleans URIs.
module CleanURI
  using CleanableURI

  # @param text [String]
  # @return [String]
  def self.clean(text)
    text.strip!

    # Unescape first if we find an escaped `&`, `=`, or `?`
    if text.match(/%(?:26|3d|3f)/i)
      require "cgi"
      text = CGI.unescape(text)
    end

    uri = URI(text)

    # remove silly indirection
    uri = URI(uri.query) if uri.host == "href.li"
    uri = URI(uri.params["url"]) if uri.host == "gate.sc"

    uri.clean
  rescue URI::InvalidURIError
    "«#{text}»"
  end
end

ARGV << File.join(ENV["XDG_CONFIG_HOME"], ".data", "urls.dirty.txt") if ENV["VSCODE_PID"]

ARGF.to_a.each { |arg| puts CleanURI.clean(arg) }
