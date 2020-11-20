export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nano

if [ "$XDG_SESSION_DESKTOP" = "sway" ] ; then
    export _JAVA_AWT_WM_NONREPARENTING=1
    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export BROWSER="/usr/bin/google-chrome-stable"
fi
