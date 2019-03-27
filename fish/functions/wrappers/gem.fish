function gem --description 'RubyGems program'
  in-path gem; or return 127

  set -lx http_proxy
  set -lx https_proxy
  set -lx HTTPS_PROXY

  # See ~/.private/fish/conf.d/proxy.fish
  if string match -eq 'WS*' $hostname
    set http_proxy "http://"$USER":"(cat ~/.p)"@proxy:8080/"
    set https_proxy $http_proxy
    set HTTPS_PROXY $http_proxy
  end

  command gem $argv
end
