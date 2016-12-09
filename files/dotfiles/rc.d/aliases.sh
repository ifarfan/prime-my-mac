# trick to make aliases available when using sudo
alias sudo='sudo '

# common ls aliases
alias ll='ls -hal'
alias la='ls -A'
alias l='ls -CF'

# Use neovim if available
if which nvim &> /dev/null; then
  alias vim='nvim -p'
  alias vi='nvim -p'
# Fallback to vim
elif which vim &> /dev/null; then
  alias vi='vim -p'
fi

# display all the history!
alias history="cat $HISTFILE"

# use colordiff if available
if which colordiff &> /dev/null; then
  alias diff='colordiff'
fi

# hexdump using od
alias hd='od -Ax -tx1z -v'

# alias for nice ps output (macos/linux versions)
if [[ "$(uname)" == "Darwin" ]]; then
  alias psc='ps xao pid,state,user,args'
elif [[ "$(uname)" == "Linux" ]]; then
  alias psc='ps xawfo pid,state,user,args'
fi

# alias for using rsync with sudo and ssh
alias rrsync='rsync --rsync-path sudo\ rsync --recursive --perms --copy-links --verbose --compress --rsh=ssh'

# sum (e.g. echo 1 2 3 |sum)
alias sum="xargs | tr ' ' '+' | bc"

# alias rg to ag/grep if ripgrep is not available
if ! which rg &> /dev/null; then
  # Use ag if available
  if which ag &> /dev/null; then
    alias rg='ag'
  else
    # Fallback to grep -R
    rg() { grep -R $1 *; }
  fi
fi

# Fallback to grep -Ri if ag is not installed
if ! which ag &> /dev/null; then
  ag() { grep -Ri $1 *; }
fi

# use vimpager as pager if available
if which vimpager &> /dev/null; then
  export PAGER="vimpager"
  alias more=$PAGER
  alias less=$PAGER
fi

# use vimcat instead of pygmetize as hcat alias
if which vimcat &> /dev/null; then
  alias hcat=vimcat
fi
