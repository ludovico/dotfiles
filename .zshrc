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
# Local custom settings
# 

if [ -f ~/.zshrc_custom ]; then
    source ~/.zshrc_custom
fi

#######################################################
# Environmental variables
#

export PAGER='less'
export EDITOR='vim'
export GITPATH=`which git`
export CARGO_HOME=$HOME/.cargo
export FZF_DEFAULT_COMMAND='fd --type f'

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
alias r=radian
alias diary='vim ~/Projects/Diary/`date +%Y-%m-%d.md`'
alias start_env='source env/bin/activate'
alias tms='tmux_session'

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

alias exercism_setup='mkdir build && cd build && cmake ..'
alias exercism_watch='fswatch -o ../*.{cpp,h} | xargs -n1 -I{} sh -c "printf \"]1337;ClearScrollback\" && make"'

function tmux_session {
  tmux attach -t $1 || tmux new -s $1
}

export RUST_HOME="$HOME/.cargo/bin"
export PATH="$RUST_HOME/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PATH:$HOME/bin"

if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi
