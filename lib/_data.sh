#!/usr/bin/env bash
#  =============================================================================
#
#  _ D A T A . S H
#
#  =============================================================================


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
  dropbox
  firefox
  google-chrome
  google-hangouts
  iterm2
  handbrake
  kitematic
  macdown
  meld
  omnigraffle
  querious
  skitch
  skype
  slack
  spotify
  sublime-text
  teamviewer
  transmit
  unison
  utorrent
  virtualbox
  vagrant
  vagrant-manager
  vlc
)


#  homebrew cask utility packages
declare cask_utils_pkgs=(
  a-better-finder-rename
  alfred
  caffeine
  coconutbattery
  electric-sheep
  istat-menus
  max
  smcfancontrol
  spectacle
  the-unarchiver
  timemachineeditor
  unetbootin
  watts
  wireshark
)


#  Work-related packages
declare cask_work_pkgs=(
  postico
  tunnelblick
  zoomus
)


#  Dock Apps
declare dock_apps=(
  'Google Chrome'
  'OmniGraffle'
  'iTerm'
  'Sublime Text'
  'Skitch'
  'Calculator'
  'System Preferences'
)


#  Dock Folders
declare dock_folders=(
  '/Applications'
  '~/Downloads'
)
