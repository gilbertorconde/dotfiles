if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi
if [ "$XDG_SESSION_DESKTOP" = "sway" ]; then
    export XDG_CURRENT_DESKTOP="sway" 
    systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
fi
SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
