# pyve-completion.bash: Autocompletion for pyve function
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/pyve-completion.bash
# License: CC-BY
#

_pyve() {
    local cur prev opts
    COMPREPLY=()

    DIR_BASE=`basename $PYVEDIR`

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=`find $PYVEDIR/ -maxdepth 1 -type d ! -name "$DIR_BASE" -printf '%f\n'`

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}

complete -F _pyve pyve
