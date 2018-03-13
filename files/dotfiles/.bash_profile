#!/usr/bin/env bash

#  Load bashrc.d files
if [ -d $HOME/.dotfiles/bashrc.d ]; then
    for file in $HOME/.dotfiles/bashrc.d/*.bash; do
        source $file
    done
fi

#  Load rc.d files
if [ -d $HOME/.dotfiles/rc.d ]; then
    for file in $HOME/.dotfiles/rc.d/*.sh; do
        source $file
    done
fi

#  Path to the bash it configuration
export BASH_IT="${HOME}/.bash_it"

#  Lock and Load a custom theme file
#  location /.bash_it/themes/
export BASH_IT_THEME='bobby'

#  (Advanced): Change this to the name of your remote repo if you
#  cloned bash-it with a remote other than origin such as `bash-it`.
#export BASH_IT_REMOTE='bash-it'

#  Set this to false to turn off version control status checking within the prompt for all themes
#export SCM_CHECK=true

#  Set Xterm/screen/Tmux title with only a short hostname.
#  Unomment this (or set SHORT_HOSTNAME to something else),
#  Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

#  Set vcprompt executable path for scm advance info in prompt (demula theme)
#  https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

#  (Advanced): Uncomment this to make Bash-it reload itself automatically
#  after enabling or disabling aliases, plugins, and completions.
#export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source $BASH_IT/bash_it.sh
