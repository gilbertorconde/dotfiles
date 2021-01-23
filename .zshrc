export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(
  git
  colored-man-pages
  zsh-autosuggestions
  sudo
)
. $ZSH/oh-my-zsh.sh


# SSH:
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# SSH KEYS:
$HOME/.add-ssh-keys.sh

# tty editor
export EDITOR=nano

# Alias:
alias update="yay -Suyy --noconfirm"
alias install="yay -S --noconfirm"
alias remove="yay -Rcns"
alias search="yay -Ss"
alias please='eval "sudo $(fc -ln -1)"'
alias czsh="gedit $HOME/.zshrc &"
alias csway="/usr/bin/code-oss --new-window --file-uri $HOME/.config/sway/configure-sway.code-workspace &"
alias wsudo="sudo -E "
alias sway-update="yay -Sy --noconfirm swayidle-git wayland-protocols-git sway-git waybar-git wlroots-git swaylock-git swaybg-git"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias sway="XDG_SESSION_DESKTOP=sway WLR_DRM_DEVICES=/dev/dri/card0 sway --my-next-gpu-wont-be-nvidia"
## my alias:
. $HOME/myalias

# Path and envs
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# NVM
## place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc


# Add a system description on terminal startup
neofetch
