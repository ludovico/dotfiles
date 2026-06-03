export PROMPT='[%n@%m %c]$ '
# export PROMPT='[%n@%m %c]'
export HISTFILE=~/.zsh/histfile
export HISTSIZE=50000
export SAVEHIST=50000

setopt autocd extendedglob nomatch HIST_IGNORE_ALL_DUPS
unsetopt beep
bindkey -v
autoload -Uz compinit zmv zcalc colors
compinit
colors

stty discard undef


#######################################################
# PATH setup
# 

RUST_HOME="$HOME/.cargo/bin"
PATH="$RUST_HOME:$PATH"
PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"
PATH="$PATH:$HOME/.dotfiles/bin"
PATH="$PATH:$HOME/.dotfiles/bin"
export PATH="$PATH:$HOME/.local/bin"

if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
 eval "$(pyenv virtualenv-init -)"
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#######################################################
# Local custom settings
# 

source ~/.zprofile
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

#######################################################
# Environmental variables
#

export PAGER='less'
export EDITOR='vim'
export GITPATH=`which git`
export CARGO_HOME=$HOME/.cargo
export FZF_DEFAULT_COMMAND='fd --type f'
export NODE_COMPILE_CACHE="$HOME/.cache/node-compile-cache"

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
#alias diary='vim ~/Projects/Diary/`date +%Y-%m-%d.md`'
alias start_env='source env/bin/activate'
alias tms='tmux_session'
alias wiki='vim ~/Nextcloud/wiki/index.md'
alias lg='lazygit'
alias ls='eza --icons=auto'
alias ti='task add +inbox'
alias ta='task +arundo'
alias prs='get_prs'

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

#######################################################3
# Funksjoner
#

# Show current working directories for processes matching a name.
# Usage: pcwd pnpm
pcwd() {
  local name="$1"

  if [[ -z "$name" ]]; then
    echo "usage: pcwd <process-name>" >&2
    return 2
  fi

  case "$(uname -s)" in
    Darwin)
      # macOS: lsof wants one PID per invocation here
      pgrep "$name" | xargs -I{} lsof -a -d cwd -p {} | grep -v "^COMMAND"
      ;;

    Linux)
      # Linux: /proc/<pid>/cwd is a symlink to the process PWD
      for pid in $(pgrep "$name"); do
        printf "%s: " "$pid"
        readlink -f "/proc/$pid/cwd" 2>/dev/null || echo "<unreadable>"
      done
      ;;

    *)
      echo "unsupported OS: $(uname -s)" >&2
      return 1
      ;;
  esac
}

function tmux_session {
  tmux attach -t $1 || tmux new -s $1
}

function get_prs {
  gh search prs --review-requested=@me --state=open --json number,title,url,repository --jq '.[] | "\(.repository.nameWithOwner)#\(.number);\(.title);\(.url)"' | column -t -s ';'
}

eval "$(zoxide init --cmd z zsh)"
# source "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/Users/eivind/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# load direnv
eval "$(direnv hook zsh)"

eval "$(mise activate zsh)"
