function bind_dollar
  switch (commandline -t)[-1]
    case "!"
      commandline -t ""
      commandline -f history-token-search-backward
    case "*"
      commandline -i '$'
  end
end
