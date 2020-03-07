export PROMPT='[%n@%m %c]$ '
export HISTFILE=~/.zsh/histfile
export HISTSIZE=50000
export SAVEHIST=50000
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
setopt autocd extendedglob nomatch HIST_IGNORE_ALL_DUPS
unsetopt beep
bindkey -v
autoload -Uz compinit zmv zcalc colors
compinit
colors

#######################################################
# Environmental variables
#

export GOPATH=$HOME/code/go
export PATH=$PATH:$HOME/bin:$GOPATH/bin
export PAGER='less'
export EDITOR='vim'
export COURSES=$HOME/Courses


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

alias grep='grep --color=auto'
alias ls='ls --color'
alias octave='/Applications/Octave-4.4.0.app/Contents/Resources/usr/bin/octave'
alias mutt='neomutt'
alias ledger="ledger --sort 'date' -f $HOME/documents/regnskap/ledger.dat"

#######################################################
# Suffix aliases
#


#######################################################3
# Functions
#

# Settings for jn
# export JNEDITOR='vim'
# alias jn='~/.journal/jn'

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# function nack() {
	# vim -c "Nack $*"
# }

function pass() {
  if [ -z "$OP_SESSION_familien_skretting_gullvik" ] 
  then
    eval $(op signin familien_skretting_gullvik)
  fi

  SELECTED_ITEM=`op list items | jq '.[].overview.title' -r | dmenu -i`
  RESULT=`op get item $SELECTED_ITEM | \
    jq '.details.fields[] | select(.designation == "username" or .designation == "password") | .value' -r`
    echo $RESULT
}

