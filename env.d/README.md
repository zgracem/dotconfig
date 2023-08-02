# ~/.config/env.d

The contents of this directory are sourced by both POSIX shells and fish to set
up a consistent environment. fish supports a very small subset of POSIX syntax,
but simple instructions like `export VAR=$(cmd_result)` can be expressed within
that limited subset.

Environment variables that are set according to more complex/less portable logic
are sourced from `~/.config/sh/env.d` and `~/.config/fish/env.d`.
