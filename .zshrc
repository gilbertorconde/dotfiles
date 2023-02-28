export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(
  git
  colored-man-pages
  zsh-autosuggestions
  sudo
)

. $ZSH/oh-my-zsh.sh


. "/opt/asdf-vm/asdf.sh"

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Configs for if using sway
if [ "${XDG_SESSION_DESKTOP}" = "sway" ]; then
    export XDG_CURRENT_DESKTOP="sway"
fi

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
    alias chrome="/opt/google/chrome/chrome --enable-features=UseOzonePlatform --enable-gpu --ozone-platform=wayland"
fi

# SSH:
# Moved to systemd service at ~/.config/systemd/user/ssh-agent.service

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
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias sway="XDG_SESSION_DESKTOP=sway WLR_DRM_DEVICES=/dev/dri/card0 sway --unsupported-gpu"

alias secondary-near-validator='ssh -o ProxyCommand="ssh -A -W %h:%p -v aws-validators-bastion" secondary-near-validator'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:$HOME/.cargo/bin:$HOME/.local/share/gem/ruby/3.0.0/bin"
# source "$(npm root -g)/@hyperupcall/autoenv/activate.sh"


export PATH="$PATH:/home/gil/.foundry/bin"
