export PROMPT='[%n@%m %c]$ '
export HISTFILE=~/.zsh/histfile
export HISTSIZE=50000
export SAVEHIST=50000
setopt autocd extendedglob nomatch HIST_IGNORE_ALL_DUPS
unsetopt beep
bindkey -v
autoload -Uz compinit zmv zcalc colors
compinit
colors

#######################################################
# Environmental variables
#

export PATH=$PATH:$HOME/bin
export PAGER='less'
export EDITOR='vim'
export GITPATH=`which git`


#######################################################
# Key bindings
#

bindkey -M vicmd '\e[1~' beginning-of-line
bindkey -M vicmd '\e[4~' end-of-line
bindkey -M vicmd '\e[5~' beginning-of-history
bindkey -M vicmd '\e[6~' end-of-history
bindkey -M vicmd '\e[3~' delete-char
bindkey -M vicmd '\e[2~' quoted-insert
bindkey -M viins '\e[1~' beginning-of-line
bindkey -M viins '\e[4~' end-of-line
bindkey -M viins '\e[5~' beginning-of-history
bindkey -M viins '\e[6~' end-of-history
bindkey -M viins '\e[3~' delete-char
bindkey -M viins '\e[2~' quoted-insert


#######################################################
# Aliases
#

alias vim=nvim
alias ls='ls -G'

#######################################################
# Suffix aliases
#

alias -s png='gpicview'
alias -s png='gpicview'
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s no=$BROWSER
alias -s uk=$BROWSER
alias -s gif='gpicview'
#alias -s sxw='soffice'
#alias -s doc='soffice'
alias -s gz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR
alias config="$GITPATH --git-dir=$HOME/.cfg/ --work-tree=$HOME"

#######################################################3
# Funksjoner
#
