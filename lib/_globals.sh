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


#  pip packages
declare pip_pkgs=(
  httpie
  json2yaml
  pygments
)


#  homebrew packages
declare brew_pkgs=(
  awscli
  aws-shell
  colordiff
  dockutil
  git-flow
  grc
  gpg
  htop
  hub
  imagemagick
  jq
  nmap
  pup
  tmux
  tree
  unrar
  watch
  wget
  z
  bash
  bash-completion
)


#  homebrew cask packages
declare cask_pkgs=(
  1password
  a-better-finder-rename
  alfred
  caffeine
  coconutbattery
  dropbox
  electric-sheep
  firefox
  google-chrome
  google-hangouts
  istat-menus
  iterm2
  handbrake
  kitematic
  macdown
  max
  meld
  omnigraffle
  querious
  skitch
  skype
  slack
  smcfancontrol
  spectacle
  spotify
  sublime-text
  teamviewer
  the-unarchiver
  timemachineeditor
  transmit
  unetbootin
  unison
  utorrent
  virtualbox
  vagrant
  vagrant-manager
  vlc
  watts
  wireshark
)


#  Work-related packages
declare cask_work_pkgs=(
  postico
  tunnelblick
  zoomus
)


function status_msg {
  #
  #  Print package install status
  #
  [[ "$1" -ne 0 ]] && echo "${BLACK}[${RED}N${BLACK}]${NORMAL} Installing ${BLUE}$2${NORMAL}..." || echo "${BLACK}[${GREEN}Y${BLACK}]${NORMAL} ${BLUE}$2${NORMAL} installed"
}


function install_xcode_cli {
  #
  #  Tell "softwareupdate" that we were installing the CLI tool before and will attempt to continue
  #  With help from https://github.com/timsutton/osx-vm-templates/blob/master/scripts/xcode-cli-tools.sh
  #
  XCODE_ERR_CODE=$(xcode-select -p > /dev/null 2>&1; echo $?)
  status_msg "$XCODE_ERR_CODE" "XCode Command Line Tools"

  if [ "$XCODE_ERR_CODE" -ne 0 ]
  then
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    XCODE_CLT_VER=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
    softwareupdate -i "$XCODE_CLT_VER" -v
    rm -rf /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  fi
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


function install_brew {
  #
  #  http://brew.sh/
  #
  BREW_ERR_CODE=$(command -v brew > /dev/null 2>&1; echo $?)
  status_msg "$BREW_ERR_CODE" "homebrew"
  [[ "$BREW_ERR_CODE" -ne 0 ]] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  #  Install packages
  for pkg in "${brew_pkgs[@]}"
  do
     brew install $pkg
  done

  #  Install cask packages
  for pkg in "${cask_pkgs[@]}"
  do
     brew cask install $pkg
  done

  #  Install work-related packages
  for pkg in "${cask_work_pkgs[@]}"
  do
     brew cask install $pkg
  done
}


function install_ansible {
  #
  #  https://www.ansible.com/
  #
  ANSIBLE_ERR_CODE=$(command -v ansible > /dev/null 2>&1; echo $?)
  status_msg "$ANSIBLE_ERR_CODE" "ansible"
  [[ "$ANSIBLE_ERR_CODE" -ne 0 ]] && sudo pip install ansible --quiet
}


function run_ansible_provisioning {
  #
  #  Run ansible playbook
  #
  status_msg 1 "ansible provisioning"
  # TODO: invoke playbook
}
