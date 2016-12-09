# set colorful prompt (PS1 doesn't support the color variables set above)
if [[ ${EUID} == 0 ]]; then
  PROMPT='%F{61}$(hostname) %F{33}%1~%F{reset}$(__git_ps1 " (%s)") %F{160}%#%F{reset} '
else
  PROMPT='%F{61}$(hostname) %F{33}%1~%F{reset}$(__git_ps1 " (%s)") %F{reset}%# '
fi

RPROMPT='$(vi_mode_prompt_info) $(exit_code_prompt_info)'
