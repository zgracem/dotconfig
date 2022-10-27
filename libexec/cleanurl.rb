#!/usr/bin/env ruby

require "uri"

def filter_query(query_string, whitelist: [], blacklist: [])
  return unless query_string

  query = URI.decode_www_form(query_string)
  query.delete_if { |k, _v| !whitelist.include?(k) } unless whitelist.empty?
  query.delete_if { |k, _v|  blacklist.include?(k) }
  URI.encode_www_form(query) unless query.empty?
end

def add2query(new_pair, query = nil)
  [new_pair, query].compact.join("&")
end

def clean_url(text)
  if text.match(/%(?:26|3d|3f)/i)
    require "cgi"
    text = CGI.unescape(text)
  end

  uri = URI(text)

  return uri.to_s if uri.scheme == "magnet"

  # remove silly indirection
  uri = URI(uri.query) if uri.host == "href.li"
  # no-www
  uri.host = uri.host&.delete_prefix("www.")
  # HTTPS everywhere
  uri.scheme = "https" if uri.scheme == "http"

  uri.query = filter_query(uri.query, blacklist: %w[utm_source utm_campaign utm_medium utm_term utm_content])

  if uri.host == "youtu.be"
    uri.query = ["v=#{uri.path.delete_prefix('/')}", uri.query].compact.join("&")
    uri.host = "youtube.com"
    uri.path = "/watch"
  end

  case uri.host
  when "amazon.com", "amazon.ca"
    uri.query = uri.path == "/s" ? filter_query(uri.query, whitelist: %w[k]) : nil
    uri.fragment = nil
    if %r{(?<=/dp/)(?<azin>[a-zA-Z0-9]+)} =~ uri.path
      uri.path = "/dp/#{azin}"
    end
  when "duckduckgo.com"
    uri.query = filter_query(uri.query, whitelist: %w[q])
  when "google.com", "google.ca"
    if %r{/search} =~ uri.path
      params = uri.query ? URI.decode_www_form(uri.query).to_h : {}
      whitelist = %w[q]
      whitelist << "tbm" if params["tbm"] == "isch"
      uri.query = filter_query(uri.query, whitelist:)
    end
  when "instagram.com"
    uri.query = nil
  when "ruby-doc.org"
    if %r{/(?<area>core|stdlib)(?<_version>-\d\.\d\.\d)/(?<path>[^#?]+)} =~ uri.to_s
      uri.path = "/#{area}/#{path}"
    end
  when "open.spotify.com"
    uri.query = nil
  when "youtube.com"
    uri.query = filter_query(uri.query, whitelist: %w[v t]) if uri.path == "/watch"
  end

  uri.to_s
rescue URI::InvalidURIError
  text.to_s
end

ARGV << "#{ENV['XDG_CONFIG_HOME']}/.data/urls.txt" if ARGV.empty? && ENV["VSCODE_PID"]

ARGF.to_a.each { |text| puts clean_url(text) }
