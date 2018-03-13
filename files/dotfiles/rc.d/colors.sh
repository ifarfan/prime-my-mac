# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS. try to use the external file
# first to take advantage of user additions. use internal bash
# globbing instead of external grep binary.

# Make sure to use GNU versions of utilities are loaded before this file
if [ -f $HOME/.dotfiles/rc.d/gnuutils.sh ]; then
    source $HOME/.dotfiles/rc.d/gnuutils.sh
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

#  Iterm2 coloring
export CLICOLOR=1
export LSCOLORS=exfxbEaEBxxEhEhBaDaCaD
#export LSCOLORS=exfxBxDxCxegedabagacad
#export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

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
