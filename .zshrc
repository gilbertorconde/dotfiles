export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(
  git
  colored-man-pages
  zsh-autosuggestions
  sudo
)
. $ZSH/oh-my-zsh.sh

# Configs for if using sway
if [ "${XDG_SESSION_DESKTOP}" = "sway" ]; then
    export MOZ_ENABLE_WAYLAND=1
    alias chrome="/opt/google/chrome/chrome --enable-features=UseOzonePlatform --enable-gpu --ozone-platform=wayland"
fi


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

# SSH KEYS: (with propper ~/.ssh/config this is no longer needed)
# $HOME/.add-ssh-keys.sh

# tty editor
export EDITOR=nano

# Alias:
# alias waybar="waybar --config $HOME/.config/waybar/config.json"
alias update="yay -Sy archlinux-keyring --noconfirm --needed && yay -Suyy --noconfirm"
alias install="yay -S --noconfirm"
alias remove="yay -Rcns"
alias search="yay -Ss"
alias please='eval "sudo $(fc -ln -1)"'
alias czsh="gedit $HOME/.zshrc &"
alias csway="/usr/bin/code-oss --new-window --file-uri $HOME/.config/sway/configure-sway.code-workspace &"
alias wsudo="sudo -E "
alias sway-update="yay -Sy --noconfirm swayidle-git sway-git wlroots-git swaylock-effects-git swaybg-git"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias sway="XDG_SESSION_DESKTOP=sway WLR_DRM_DEVICES=/dev/dri/card0 sway --unsupported-gpu"

# Path and envs
export PATH="$PATH:$HOME/.rvm/bin:$HOME/.local/bin" # Add RVM and local bin to PATH for scripting

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

# ADD GO LANG TO PATH
GOPATH=$HOME/go
export PATH="$PATH:$HOME/go/bin"


# Add a system description on terminal startup
# neofetch

# $HOME/Documents/samsung/check-samsung.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
