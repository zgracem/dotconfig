function gem --description 'RubyGems program'
  in-path gem; or return 127

  # See ~/.private/fish/conf.d/proxy.fish
  if test -n "$ALL_PROXY"
    set -lx http_proxy "http://"$USER":"(cat ~/.p)"@proxy:8080/"
    set -lx https_proxy $http_proxy
    set -lx HTTPS_PROXY $http_proxy
  end

  command gem $argv
end
