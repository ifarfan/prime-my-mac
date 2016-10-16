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
. $DIR/lib/_globals.sh
. $DIR/lib/_data.sh
. $DIR/lib/_osx.sh
. $DIR/lib/_apps.sh

#  Usage
usage() {
    echo -e "${BOLD}Usage${NORMAL}: $0 [ ${BOLD}--app-tweaks${NORMAL} | ${BOLD}--bash-it${NORMAL} | ${BOLD}--brew${NORMAL} | ${BOLD}--cask${NORMAL} | ${BOLD}--fonts${NORMAL} | ${BOLD}--pip${NORMAL} | ${BOLD}--prezto${NORMAL} | ${BOLD}--osx-tweaks${NORMAL} ]" 1>&2
    echo -e "Note:" 1>&2
    echo -e "- if not arguments are passed, everything installed" 1>&2
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
FG_OSX=false
FG_APPS=false

#  Determine flags enabled
if [ -z "$@" ]
then
    FG_ALL=true                                     #  Install everything!
else
    for arg in "$@"; do
        shift
        case "$arg" in
            --app-tweaks) FG_APPS=true ;;           #  Apps
            --bash-it)    FG_BASH_IT=true ;;        #  bash it
            --brew)       FG_BREW=true ;;           #  Brew
            --cask)       FG_BREW_CASK=true ;;      #  Brew Cask
            --fonts)      FG_BREW_FONTS=true ;;     #  Brew Fonts
            --pip)        FG_PIP=true ;;            #  pip
            --prezto)     FG_PREZTO=true ;;         #  prezto
            --osx-tweaks) FG_OSX=true ;;            #  OS X
            *)            usage ;;
        esac
    done
fi

#  Update sudo timestamp until script is finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#  Install components
[[ "$FG_ALL" || "$FG_PIP" ]]        && install_pip
[[ "$FG_ALL" || "$FG_BREW" ]]       && install_brew
[[ "$FG_ALL" || "$FG_BREW_CASK" ]]  && install_brew_cask
[[ "$FG_ALL" || "$FG_BREW_FONTS" ]] && install_brew_fonts

#  OS X Customizations
if [ "$FG_ALL" || "$FG_OSX" ]
then
    dock_tweaks
    finder_tweaks
    input_device_tweaks
    screen_tweaks
    spotlight_tweaks
    # ssd_tweaks
    miscellaneous_tweaks
fi

#  App specific Customizations
if [ "$FG_ALL" || "$FG_APPS" ]
then
    activity_monitor_app_tweaks
    google_chrome_app_tweaks
    # mail_app_tweaks
    # messages_app_tweaks
    safari_app_tweaks
    terminal_app_tweaks
fi

#  Set user shell last
[[ "$FG_ALL" || "$FG_BASH_IT" ]] && install_bash_it
[[ "$FG_ALL" || "$FG_PREZTO" ]]  && install_prezto
