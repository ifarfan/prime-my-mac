# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#  Source Prezto first
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#  Load zshrc.d files
if [ -d $HOME/.dotfiles/zshrc.d ]; then
    for file in $HOME/.dotfiles/zshrc.d/*.zsh; do
        source $file
    done
fi

#  Load rc.d files
if [ -d $HOME/.dotfiles/rc.d ]; then
    for file in $HOME/.dotfiles/rc.d/*.sh; do
        source $file
    done
fi

#  Enable shell integration with iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /Users/israel.farfan/.config/broot/launcher/bash/br
