_inPath osascript || return
quit()
{ #: - uses AppleScript to "nicely" quit an application
  #: $ quit <app name>
  osascript -e "quit app \"${1}\""
}
