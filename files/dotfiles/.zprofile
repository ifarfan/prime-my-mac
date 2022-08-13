#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
# Include MAN paths by default
path=(
  /usr/local/{bin,sbin}
  /opt/homebrew/opt/python@3.10/bin
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /opt/homebrew/opt/coreutils/libexec/gnubin
  /opt/homebrew/opt/coreutils/libexec/gnuman
  /opt/homebrew/opt/findutils/libexec/gnubin
  /opt/homebrew/opt/findutils/libexec/gnuman
  /opt/homebrew/opt/gnu-getopt/bin
  /opt/homebrew/opt/gnu-indent/libexec/gnubin
  /opt/homebrew/opt/gnu-indent/libexec/gnuman
  /opt/homebrew/opt/gnu-sed/libexec/gnubin
  /opt/homebrew/opt/gnu-sed/libexec/gnuman
  /opt/homebrew/opt/gnu-tar/libexec/gnubin
  /opt/homebrew/opt/gnu-tar/libexec/gnuman
  /opt/homebrew/opt/grep/libexec/gnubin
  /opt/homebrew/opt/grep/libexec/gnuman
  ${HOME}/.krew/bin
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
