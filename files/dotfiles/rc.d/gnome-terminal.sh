# Gnome terminal doesn't set the TERM variable correctly
if [ "$TERM" = "xterm" ]; then
  export TERM="xterm-256color"
fi
