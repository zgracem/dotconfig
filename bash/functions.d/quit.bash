quit()
{ #: - uses AppleScript to "nicely" quit an application
  #: $ quit <app name>
  _require osascript || return
  osascript -e "quit app \"${1}\""
}
