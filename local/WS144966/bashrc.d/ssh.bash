# SSH aliases to lowercase

alias m='newwin --title minerva ssh minerva'
alias mr='newwin --title minerva ssh minerva.remote'
alias er='newwin --title erato ssh erato'
alias wf='newwin --title webfaction ssh webfaction'

### ZGM disabled 2015-10-05 -- slows down .bashrc
# for alias in m er mr wf; do
#     eval "$(alias $alias | tr '[[:upper:]]' '[[:lower:]]')"
#     unset alias
# done

