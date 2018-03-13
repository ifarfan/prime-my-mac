#  Use nano as default editor, else fallback to vim
if which nano &> /dev/null; then
    export EDITOR=nano
elif which vim &> /dev/null; then
    export EDITOR=vim
fi
