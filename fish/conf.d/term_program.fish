string match -q com.panic.LocalTerminal "$XPC_SERVICE_NAME"
and set -gx TERM_PROGRAM Prompt_3

# Disable Primary Device Attribute reporting for terminals that don't support it
# <https://fishshell.com/docs/current/terminal-compatibility.html#term-compat-primary-da>
set -l no_pda_support iTerm.app
if contains "$TERM_PROGRAM" $no_pda_support; and not contains no-query-term $fish_features
    set -Ua fish_features no-query-term
end
