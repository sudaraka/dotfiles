# scr-completion.bash: Autocompletion for screen profiles (scr)
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/scr-completion.bash
# License: CC-BY
#

_scr() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=`find $HOME/.screen/ -maxdepth 1 -type f -printf '%f\n'`

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}

complete -F _scr scr
