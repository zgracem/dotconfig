# ------------------------------------------------------------------------------
# ~zozo/.config/bash/completion/note.bash
# For my "plain text notes" function
# -----------------------------------------------------------------------------

__complete_note()
{
    declare cur=${COMP_WORDS[COMP_CWORD]}
    declare notes=( $(find -H "$dir_notes" -maxdepth 1 -type f -name '*.txt' -printf '%f\n') )

    COMPREPLY=( $(compgen -W "${notes[*]//.txt/}" -- $cur) )
}

complete -F __complete_note note
