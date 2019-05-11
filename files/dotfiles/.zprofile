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
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/opt/coreutils/libexec/gnuman
  /usr/local/opt/findutils/libexec/gnubin
  /usr/local/opt/findutils/libexec/gnuman
  /usr/local/opt/gnu-getopt/bin
  /usr/local/opt/gnu-indent/libexec/gnubin
  /usr/local/opt/gnu-indent/libexec/gnuman
  /usr/local/opt/gnu-sed/libexec/gnubin
  /usr/local/opt/gnu-sed/libexec/gnuman
  /usr/local/opt/gnu-tar/libexec/gnubin
  /usr/local/opt/gnu-tar/libexec/gnuman
  /usr/local/opt/grep/libexec/gnubin
  /usr/local/opt/grep/libexec/gnuman
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
