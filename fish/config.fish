set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths

### EXPORT ###
set fish_greeting
set TERM "xterm-256color"
set EDITOR "emacsclient -t -a ''"
set VISUAL "emacsclient -c -a emacs"

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

### COLORS ###
set fish_color_normal '#8be9fd'
set fish_color_autosuggestion '#6272a4'
set fish_color_command '#8be9fd'
set fish_color_error '#ff5555'
set fish_color_param '#8be9fd'

### ALIASES ###

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# emacs
alias emacs="emacsclient -c -a 'emacs'"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"

# Using "exa" instead of "ls"
alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'

# grep coloring
alias grep='grep --color=auto'

# Ask for confirmation before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

colorscript random
starship init fish | source
