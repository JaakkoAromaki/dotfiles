# ~/.zshrc

# omz
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
)

source "$ZSH/oh-my-zsh.sh"


# p10k
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# completion
autoload -Uz compinit
compinit

# autocompletion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=241'

# aliases
alias ll='ls -l'
alias edit='sudo -e'
alias update='sudo pacman -Syu'
alias rebuild='sudo systemctl daemon-reload'
alias cl='clear'
alias battery='cat /sys/class/power_supply/BAT0/capacity'

# misc
alias penis='echo penis; echo "hihi :3"'
alias dihh="echo 'i want a dih in my ass :3'"
alias dih='echo "zsh: command not found: too small"'
alias dihcord='vesktop'
alias shutup='shutdown now'
alias kys='echo "kill yourself"'

# paths
export PATH=$PATH:/home/hamlak/.spicetify
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
