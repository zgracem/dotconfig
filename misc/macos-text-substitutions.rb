#!/usr/bin/env ruby

# Instructions:
#   1. Execute this script
#   2. Open System Preferences > Keyboard > Text
#   3. Drag the .plist file from the Desktop into the shortcuts area
#   4. Manually delete any duplicates :(
#
# Source: <support.apple.com/en-ca/HT204006>

require "plist" # `gem install plist` <github.com/patsplat/plist>
require "yaml"

timestamp  = Time.now.strftime("%F at %H.%M.%S")
plist_file = "#{Dir.home}/Desktop/Text Substitutions #{timestamp}.plist"
yaml_data  = YAML.load(DATA)

File.open(plist_file, "w+") { |f| f.write(yaml_data.to_plist) }

__END__
---
# Fractions

- phrase:   ½
  shortcut: 1//2
- phrase:   ⅓
  shortcut: 1//3
- phrase:   ¼
  shortcut: 1//4
- phrase:   ⅕
  shortcut: 1//5
- phrase:   ⅙
  shortcut: 1//6
- phrase:   ⅛
  shortcut: 1//8
- phrase:   ⅔
  shortcut: 2//3
- phrase:   ¾
  shortcut: 3//4
- phrase:   ⅖
  shortcut: 2//5
- phrase:   ⅗
  shortcut: 3//5
- phrase:   ⅜
  shortcut: 3//8
- phrase:   ⅘
  shortcut: 4//5
- phrase:   ⅚
  shortcut: 5//6
- phrase:   ⅝
  shortcut: 5//8
- phrase:   ⅞
  shortcut: 7//8

# Greek letters

- phrase:   α
  shortcut: ;alpha
- phrase:   β
  shortcut: ;beta
- phrase:   Δ
  shortcut: ;delta
- phrase:   λ
  shortcut: ;lambda
- phrase:   μ
  shortcut: ;micro
- phrase:   Ω
  shortcut: ;omega

# Arrows

- phrase:   ↑
  shortcut: ;uarr
- phrase:   ↓
  shortcut: ;darr
- phrase:   →
  shortcut: ;rarr
- phrase:   ←
  shortcut: ;larr
- phrase:   ⇒
  shortcut: ==>>

# OS-related

- phrase:   ⌥
  shortcut: ;alt
- phrase:   ⇧
  shortcut: ;shift
- phrase:   ⌘
  shortcut: ;cmd
- phrase:   ⌃
  shortcut: ;ctrl
- phrase:   ↩
  shortcut: ;return
- phrase:   ⎋
  shortcut: ;esc
- phrase:   ⌫
  shortcut: ;backspace

# Typographical

- phrase:   ©
  shortcut: ;copy
- phrase:   ®
  shortcut: (r)
- phrase:   ™
  shortcut: tm
- phrase:   €
  shortcut: ;euro
- phrase:   §
  shortcut: ssect
- phrase:   ¶
  shortcut: ppara
- phrase:   ·
  shortcut: mdd
- phrase:   ə
  shortcut: ;schwa

# Emoji

- phrase:   ಠ_ಠ
  shortcut: lod
- phrase:   (╯°□°）╯︵ ┻━┻)
  shortcut: tableflip
- phrase:   '¯\_(ツ)_/¯'
  shortcut: sshrug
- phrase:   '🇨🇦'
  shortcut: ;canada

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
  shortcut: ;check
- phrase:   ♪
  shortcut: ;8th
- phrase:   ♫
  shortcut: ;88th
- phrase:   ♪♫
  shortcut: ;8ths

# Phrases

- phrase:   vis-à-vis
  shortcut: vis-a-vis

# For iPhone

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
