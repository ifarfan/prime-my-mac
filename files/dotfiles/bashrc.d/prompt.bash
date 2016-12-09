# set colorful prompt (PS1 doesn't support the color variables set above)
if [[ ${EUID} == 0 ]]; then
  PS1='\[\033[38;5;61m\]$(hostname) \[\033[38;5;33m\]\W\[\033[00;00m\]$(__git_ps1 " (%s)") \[\033[38;5;160m\]\$\[\033[00;00m\] '
else
  PS1='\[\033[38;5;61m\]$(hostname) \[\033[38;5;33m\]\W\[\033[00;00m\]$(__git_ps1 " (%s)") \$ '
fi
