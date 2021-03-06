#!/usr/bin/env bash

#
#  I N S T A L L . S H
#
#  Install OSX tools + customizations:
#  - pip
#  - homebrew + cask + fonts
#  - prezto + bash-it
#


#  Include libraries
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
for INCLUDE in $DIR/libs/*; do
    source ${INCLUDE}
done

#  Usage
usage() {
    echo -e "${BOLD}Usage${NORMAL}: ${0##*/} [ ${BOLD}--all${NORMAL} | ${BOLD}--app-configs${NORMAL} | ${BOLD}--bash-it${NORMAL} | ${BOLD}--brew${NORMAL} | ${BOLD}--cask${NORMAL} | ${BOLD}--dot-files${NORMAL} | ${BOLD}--fonts${NORMAL} | ${BOLD}--pip${NORMAL} | ${BOLD}--prezto${NORMAL} | ${BOLD}--osx-tweaks${NORMAL} | ${BOLD}--apple-store${NORMAL} ]" 1>&2
    exit 1
}

# Installation flags
FG_ALL=false
FG_APPS=false
FG_BASH_IT=false
FG_BREW=false
FG_BREW_CASK=false
FG_BREW_FONTS=false
FG_DOTFILES=false
FG_MAS=false
FG_OSX=false
FG_PIP=false
FG_PREZTO=false

#  Determine flags enabled via parameters
if [ -z "$@" ]; then
    usage
else
    for arg in "$@"; do
        shift
        case "$arg" in
            --all)         FG_ALL=true ;;               #  EVERYTHING!
            --apple-store) FG_MAS=true ;;               #  Apple Store
            --app-configs) FG_APPS=true ;;              #  Apps
            --bash-it)     FG_BASH_IT=true ;;           #  bash it
            --brew)        FG_BREW=true ;;              #  Brew
            --cask)        FG_BREW_CASK=true ;;         #  Brew Cask
            --dot-files)   FG_DOTFILES=true ;;          #  Dot files
            --fonts)       FG_BREW_FONTS=true ;;        #  Brew Fonts
            --osx-tweaks)  FG_OSX=true ;;               #  OS X
            --pip)         FG_PIP=true ;;               #  pip
            --prezto)      FG_PREZTO=true ;;            #  prezto
            *)             usage ;;
        esac
    done
fi

#  Invoke sudo and update sudo timestamp until script is finished
sudo -v
while true; do
    sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#  Enable "All Apps" install
security_allow_run_all_apps true

#  Install components
[[ "$FG_ALL" == true || "$FG_PIP" == true ]]        && install_pip
[[ "$FG_ALL" == true || "$FG_BREW" == true ]]       && install_brew
[[ "$FG_ALL" == true || "$FG_BREW_CASK" == true ]]  && install_brew_cask
[[ "$FG_ALL" == true || "$FG_BREW_FONTS" == true ]] && install_brew_fonts
[[ "$FG_ALL" == true || "$FG_MAS" == true ]]        && install_mas

#  OS X Customizations
if [[ "$FG_ALL" == true || "$FG_OSX" == true ]]; then
    dock_tweaks
    finder_tweaks
    input_device_tweaks
    screen_tweaks
    spotlight_tweaks
    ssd_tweaks
    energy_tweaks
    miscellaneous_tweaks
    security_tweaks
fi

#  App specific Customizations
if [[ "$FG_ALL" == true || "$FG_APPS" == true ]]; then
    activity_monitor_config
    electric_sheep_config
    google_chrome_config
    iterm2_config
    itunes_config
    mail_config
    messages_config
    safari_config
    sublime_text_config
    terminal_config
    vscode_config
fi

#  Set user shell last
[[ "$FG_ALL" == true || "$FG_BASH_IT"  == true ]] && install_bash_it
[[ "$FG_ALL" == true || "$FG_PREZTO"   == true ]] && install_prezto
[[ "$FG_ALL" == true || "$FG_DOTFILES" == true ]] && install_dotfiles

#  Done!
status_msg "1" "is now complete"
exit 0
