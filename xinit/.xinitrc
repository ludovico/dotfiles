#picom &
dwmstatus 2>&1 >/dev/null &
setxkbmap -option caps:escape
exec dwm

#exec gnome-session
