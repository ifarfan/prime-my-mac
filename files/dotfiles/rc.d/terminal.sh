#  Some niceties
export BLOCKSIZE=1k

export TERM=xterm-256color                          # for common 256 color terminals (e.g. gnome-terminal)
#export TERM=screen-256color                        # for a tmux -2 session (also for screen)
#export TERM=rxvt-unicode-256color                  # for a colorful rxvt unicode session

#  Enable shell integration with iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
