#!/usr/bin/env ruby

# Instructions:
#   1. Execute this script
#   2. Open System Preferences > Keyboard > Text
#   3. Drag the .plist file from the Desktop into the shortcuts area
#   4. Manually delete any duplicates :(
#
# See also: <support.apple.com/en-ca/HT204006>

require "yaml"
require "plist" # `gem install plist` <github.com/patsplat/plist>

def create_plist(output_file = nil)
  timestamp = Time.now.strftime("%F at %H.%M.%S")
  output_file ||= "#{Dir.home}/Desktop/Text Substitutions #{timestamp}.plist"
  yaml_data = YAML.load(DATA)

  File.open(output_file, "w+") { |file| file.write(yaml_data.to_plist) }
end

# Debug function.
def create_json
  yaml_data = YAML.load(DATA)
  json_output = JSON.pretty_generate(yaml_data)
  puts json_output
end

create_plist

__END__
---
# Arrows

- phrase:   "→"
  shortcut: "->>"
- phrase:   "←"
  shortcut: "<<-"
- phrase:   "⇒"
  shortcut: "==>>"

# Typographical

- phrase:   ©
  shortcut: (c)
- phrase:   ®
  shortcut: (r)
- phrase:   ™
  shortcut: (tm)
- phrase:   §
  shortcut: ssect
- phrase:   ¶
  shortcut: ppara
- phrase:   ·
  shortcut: mdd
- phrase:   ə
  shortcut: sschwa

# Emoji

- phrase:   ಠ_ಠ
  shortcut: lod
- phrase:   (╯°□°）╯︵ ┻━┻)
  shortcut: tableflip
- phrase:   '¯\_(ツ)_/¯'
  shortcut: sshrug
- phrase:   '🇨🇦'
  shortcut: ccanada
- phrase:   '👉👊'
  shortcut: rrtj

# Math

- phrase:   ±
  shortcut: +/-
- phrase:   −
  shortcut: '?-'
- phrase:   ×
  shortcut: '?x'
- phrase:   ÷
  shortcut: '?/'
- phrase:   ²
  shortcut: ^2
- phrase:   ³
  shortcut: ^3

# Other symbols

- phrase:   ✓
  shortcut: ccheck
- phrase:   ♪
  shortcut: 8th
- phrase:   ♫
  shortcut: 88th
- phrase:   ♪♫
  shortcut: 8ths

# Phrases

- phrase:   vis-à-vis
  shortcut: vis-a-vis

# For iPhone

- phrase:   
  shortcut: applesymbol
- phrase:   <i></i>
  shortcut: <i
- phrase:   <a href=""></a>
  shortcut: hhref
- phrase:   w/out
  shortcut: wout
- phrase:   w/
  shortcut: ww
- phrase:   b/c
  shortcut: bc
- phrase:   b/w
  shortcut: bw
- phrase:   e.g.
  shortcut: eg
- phrase:   i.e.
  shortcut: ie

## Ducking autocorrect

- phrase:   fuck
  shortcut: fuck
- phrase:   fucking
  shortcut: fucking
- phrase:   be
  shortcut: br
- phrase:   so
  shortcut: so
