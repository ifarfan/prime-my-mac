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


function status_msg {
  #
  #  Print package install status
  #
  [[ "$1" -ne 0 ]] && echo "${BLACK}[${RED}N${BLACK}]${NORMAL} Installing ${BLUE}$2${NORMAL}..." || echo "${BLACK}[${GREEN}Y${BLACK}]${NORMAL} ${BLUE}$2${NORMAL} installed"
}


function print_header {
  echo " ${BLACK}-${NORMAL}  Bootstrap Go!"
  echo " ${BLACK}-  ----------------------------------------${NORMAL}"
}


function print_footer {
  echo " ${BLACK}-  ----------------------------------------${NORMAL}"
  echo " ${BLACK}-${NORMAL}  Bootstrap Done!"
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
     sudo pip install $pkg
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
  for pkg in "${cask_utils_pkgs[@]}"
  do
     brew cask install --appdir="/Applications/Utilities" $pkg
  done

  #  Install work-related packages
  for pkg in "${cask_work_pkgs[@]}"
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
  if [ -d "~/.bash_it" ]
  then
    bash-it update
  else
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh
  fi
  chsh -s /bin/bash
}
