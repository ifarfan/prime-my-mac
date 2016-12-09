# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS. try to use the external file
# first to take advantage of user additions. use internal bash
# globbing instead of external grep binary.

# Make sure to use GNU versions of utilities are loaded before this file
if [ -f $HOME/.shellrc/rc.d/gnuutils.sh ]; then
  . $HOME/.shellrc/rc.d/gnuutils.sh
fi

# enable colors for ls, etc. prefer $HOME/.dir_colors
if which dircolors &> /dev/null; then
  if [[ -f $HOME/.dir_colors ]]; then
    eval $(dircolors -b $HOME/.dir_colors)
  elif [[ -f /etc/DIR_COLORS ]]; then
    eval $(dircolors -b /etc/DIR_COLORS)
  fi
fi

# enable --color switch for grep commands
for cmd in grep fgrep egrep; do
  if echo hi |$cmd -q --color=auto hi &> /dev/null; then
    alias $cmd="$cmd --color=auto"
  fi
done

# enable --color switch for ls command, if supported
if ls --color=auto &> /dev/null; then
  alias ls="ls --color=auto"
fi

# macos ls doesn't support ls --color, but uses CLICOLOR environment variable
export CLICOLOR=1

# try to keep environment pollution down, EPA loves us.
unset match_lhs


# define prompt colors shell-independently
if [[ -n ${ZSH_VERSION-} ]]; then
  c_red="%F{160}"
  c_green="%F{64}"
  c_yellow="%F{136}"
  c_blue="%F{33}"
  c_clear="%F{reset}"
else
  # Using \[ and \] around colors is necessary to prevent
  # issues with command line editing/browsing/completion!
  c_red=$'\033[38;5;160m'
  c_green=$'\033[38;5;64m'
  c_yellow=$'\033[38;5;136m'
  c_blue=$'\033[38;5;33m'
  c_clear=$'\033[0;00m'
fi
