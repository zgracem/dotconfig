# ----------------------------------------------------------------------------
# Visual Studio Code terminal integration for fish
# <https://code.visualstudio.com/docs/terminal/shell-integration>
# ----------------------------------------------------------------------------
# To install:
#
# 1) Place this file at `~/.config/fish/conf.d/vscode-shellintegration.fish`.
#
# 2) Add lines to the beginning and the end of the `fish_prompt` function in
#    `~/.config/fish/functions/fish_prompt.fish`, as follows:
#
#     function fish_prompt
#         __vsc_fish_prompt_before
#         # ...existing code...
#         __vsc_fish_prompt_after
#     end
#
# 3) Restart fish.
# ----------------------------------------------------------------------------

function __vsc_esc
    if string match -q "$TERM_PROGRAM" "vscode"
        builtin printf "\e]633;%s\a" (string join ';' $argv)
    end
end

function __vsc_preexec --on-event fish_preexec
    __vsc_esc "C"
    __vsc_esc "E" "$argv"
end

function __vsc_postexec --on-event fish_postexec
    __vsc_esc "D" $status
end

function __vsc_update_cwd --on-event fish_prompt
    __vsc_esc "P" "Cwd=$PWD"
end

function __vsc_clear --on-event fish_cancel
    __vsc_esc "D"
end

function __vsc_fish_prompt_before
    __vsc_esc "A"
end

function __vsc_fish_prompt_after
    __vsc_esc "B"
end
