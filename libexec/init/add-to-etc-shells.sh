#!/usr/bin/env bash

# This script is called by a Makefile to add shells in /usr/local/bin to
# /etc/shells, unless they are already present.

function etc_shells_has() {
    command grep -q "^$(type -p "$1")\$" /etc/shells
}

function etc_shells_add () {
    etc_shells_has "$1" || builtin type -p "$1" | sudo tee -a /etc/shells
}

function main() {
    for shell in "$@"; do
        etc_shells_add "$shell" || exit
    done
}

main "$@"
