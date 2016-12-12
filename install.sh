#!/usr/bin/env bash
#  =============================================================================
#
#  I N S T A L L . S H
#
#  =============================================================================
#
#  Install OSX tools + customizations:
#  - pip
#  - homebrew + cask + fonts
#  - prezto + bash-it
#
#  =============================================================================


#  Include libraries
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/lib/main.sh
. $DIR/lib/data.sh
. $DIR/lib/osx.sh
. $DIR/lib/apps.sh

#  Usage
usage() {
    echo -e "${BOLD}Usage${NORMAL}: ${0##*/} [ ${BOLD}--all${NORMAL} | ${BOLD}--app-configs${NORMAL} | ${BOLD}--bash-it${NORMAL} | ${BOLD}--brew${NORMAL} | ${BOLD}--cask${NORMAL} | ${BOLD}--dot-files${NORMAL} | ${BOLD}--fonts${NORMAL} | ${BOLD}--pip${NORMAL} | ${BOLD}--prezto${NORMAL} | ${BOLD}--osx-tweaks${NORMAL} ]" 1>&2
    exit 1
}

# Installation flags
FG_ALL=false
FG_PIP=false
FG_BREW=false
FG_BREW_CASK=false
FG_BREW_FONTS=false
FG_PREZTO=false
FG_BASH_IT=false
FG_DOTFILES=false
FG_OSX=false
FG_APPS=false

#  Determine flags enabled via parameters
if [ -z "$@" ]
then
    usage
else
    for arg in "$@"; do
        shift
        case "$arg" in
            --all)         FG_ALL=true ;;               #  EVERYTHING!
            --app-configs) FG_APPS=true ;;              #  Apps
            --bash-it)     FG_BASH_IT=true ;;           #  bash it
            --brew)        FG_BREW=true ;;              #  Brew
            --cask)        FG_BREW_CASK=true ;;         #  Brew Cask
            --dot-files)   FG_DOTFILES=true ;;          #  Dot files
            --fonts)       FG_BREW_FONTS=true ;;        #  Brew Fonts
            --pip)         FG_PIP=true ;;               #  pip
            --prezto)      FG_PREZTO=true ;;            #  prezto
            --osx-tweaks)  FG_OSX=true ;;               #  OS X
            *)             usage ;;
        esac
    done
fi

#  Invoke sudo and update sudo timestamp until script is finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#  Install components
[[ "$FG_ALL" == true || "$FG_PIP" == true ]]        && install_pip
[[ "$FG_ALL" == true || "$FG_BREW" == true ]]       && install_brew
[[ "$FG_ALL" == true || "$FG_BREW_CASK" == true ]]  && install_brew_cask
[[ "$FG_ALL" == true || "$FG_BREW_FONTS" == true ]] && install_brew_fonts

#  OS X Customizations
if [[ "$FG_ALL" == true || "$FG_OSX" == true ]]
then
    #  Tweaks
    dock_tweaks
    finder_tweaks
    input_device_tweaks
    screen_tweaks
    spotlight_tweaks
    ssd_tweaks
    miscellaneous_tweaks
fi

#  App specific Customizations
if [[ "$FG_ALL" == true || "$FG_APPS" == true ]]
then
    # activity_monitor_config
    # electric_sheep_config
    # git_config
    # google_chrome_config
    # # istatmenus_config
    # iterm2_config
    # itunes_config
    # mail_config
    # messages_config
    # safari_config
    sublime_text_config
    # terminal_config
fi

#  Set user shell last
[[ "$FG_ALL" == true || "$FG_BASH_IT" == true ]]  && install_bash_it
[[ "$FG_ALL" == true || "$FG_PREZTO" == true ]]   && install_prezto
[[ "$FG_ALL" == true || "$FG_DOTFILES" == true ]] && install_dotfiles

exit 0