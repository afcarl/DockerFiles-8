# Path to your oh-my-zsh installation.
export ZSH=/home/.oh-my-zsh

# Theme
ZSH_THEME="refined"

# Plugins
plugins=(git autojump wd sm zsh_reload)

source "$ZSH/oh-my-zsh.sh"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Anaconda path
export PATH="/home/miniconda3/bin:$PATH"