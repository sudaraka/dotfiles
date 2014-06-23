# cdp-completion.bash: Autocompletion for cdp (cd $PROJECTSDIR) function
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/cdp-completion.bash
# License: CC-BY
#

_cdp() {
    local cur prev opts
    COMPREPLY=()

    PROJECTSDIR_BASE=`basename $PROJECTSDIR`

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=`find $PROJECTSDIR -maxdepth 1 -type d ! -name "$PROJECTSDIR_BASE" -printf '%f\n'`

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}

complete -F _cdp cdp
