#!/usr/bin/env bash
#  =============================================================================
#
#  _ G L O B A L S . S H
#
#  =============================================================================


#  Colors
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

#  Homebrew settings
export HOMEBREW_VERBOSE=0
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

#  Folders
APPLE_APPS_DIR='/Applications'
UTILS_APPS_DIR='/Applications/Utilities'

#  Determine if it's a laptop
#  SEE: http://arstechnica.com/civis/viewtopic.php?f=19&t=1118530
[[ "$(sysctl -n hw.model | grep -q -i book; echo $?)" -eq 0 ]] && IS_LAPTOP=true || IS_LAPTOP=false


function status_msg {
  #
  #  Print package install status
  #
  [[ "$1" -ne 0 ]] && echo "${BOLD}[${RED}N${BOLD}]${NORMAL} Installing ${BLUE}$2${NORMAL}..." || echo "${BOLD}[${GREEN}Y${BOLD}]${NORMAL} ${BLUE}$2${NORMAL} installed"
}


function install_pip {
  #
  #  Install via "easy_install"
  #
  PIP_ERR_CODE=$(command -v pip > /dev/null 2>&1; echo $?)
  status_msg "$PIP_ERR_CODE" "pip"
  [[ "$PIP_ERR_CODE" -ne 0 ]] && sudo easy_install pip

  #  Install pip packages
  for pkg in "${pip_pkgs[@]}"
  do
     sudo -H pip install $pkg --quiet --disable-pip-version-check
  done
}


function brew_me {
  #
  #  http://brew.sh/
  #
  BREW_ERR_CODE=$(command -v brew > /dev/null 2>&1; echo $?)
  status_msg "$BREW_ERR_CODE" "homebrew"
  [[ "$BREW_ERR_CODE" -ne 0 ]] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}


function install_brew {
  brew_me

  #  Install packages
  for pkg in "${brew_pkgs[@]}"
  do
     brew install $pkg
  done
}


function install_brew_cask {
  brew_me

  #  Install cask packages
  brew tap "caskroom/cask"
  for pkg in "${cask_pkgs[@]}"
  do
     brew cask install $pkg
  done
}


function install_brew_fonts {
  brew_me

  #  Install cask fonts
  brew tap "caskroom/fonts"
  for font in "${cask_fonts[@]}"
  do
    brew cask install font-$font
  done
}


function move_apple_apps {
  if [ "${#apple_apps[@]}" -gt 0 ]
  then
    cd ${APPLE_APPS_DIR}
    [[ ! -d "Apple" ]] && sudo mkdir "Apple"

    for app in "${apple_apps[@]}"
    do
       [[ -d "${app}.app" ]] && sudo mv "${app}.app" "${APPLE_APPS_DIR}/Apple/"
    done
    cd -
  fi
}



function install_prezto {
  if [ -d "$HOME/.zprezto" ]
  then
    cd "$HOME/.zprezto" && git pull && git submodule update --init --recursive
  else
    git clone --recursive https://github.com/sorin-ionescu/prezto.git $HOME/.zprezto
    rcfiles=($HOME/.zprezto/runcoms/z*)
    for rcfile in "${rcfiles[@]}"
    do
      ln -s "$rcfile" "$HOME/.${rcfile##*/}"
    done
    chsh -s /bin/zsh
  fi
}


function install_bash_it {
  status_msg "$BREW_ERR_CODE" "bash-it"


  if [ -d "~/.bash_it" ]
  then
    bash-it update
  else
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh
  fi
  chsh -s /bin/bash
}
