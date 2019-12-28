# Pyenv settings
export PATH="/Users/user/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# nsml settings
export PATH="/Users/user/nsml_client.darwin.amd64.dev:$PATH"
export PATH="/Users/user/nsml_client.darwin.amd64.jp:$PATH"

# terminal settings
export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH="/Users/user/.oh-my-zsh"
ZSH_THEME="powerlevel9k/powerlevel9k"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# naver machine setting
alias cnsdb="sudo docker -H cnsmldb104.clova.nfra.io exec -it agent bash"
