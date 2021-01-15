#!/usr/bin/env bash
#
#  this file is sourced by all *interactive* bash shells on startup,
#  including some apparently interactive shells such as scp and rcp
#  that can't tolerate any output. Make sure this doesn't display
#  anything or bad things will happen!

#  test for an interactive shell. there is no need to set anything
#  past this point for scp and rcp, and it's important to refrain from
#  outputting anything in those cases.
#
if [[ $- != *i* ]] ; then
    # shell is non-interactive. be done now!
    return
fi

[ -f $HOME/.bash_profile ] && source $HOME/.bash_profile
[ -f $HOME/.iterm2_shell_integration.bash ] && source $HOME/.iterm2_shell_integration.bash
