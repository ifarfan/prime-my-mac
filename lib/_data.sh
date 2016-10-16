#!/usr/bin/env bash
#  =============================================================================
#
#  _ D A T A . S H
#
#  =============================================================================


#  pip packages
declare pip_pkgs=(
  ansible
  httpie
  json2yaml
  pygments
)


#  homebrew packages
declare brew_pkgs=(
  awscli
  aws-shell
  colordiff
  coreutils
  cowsay
  dockutil
  fortune
  git-flow
  grc
  gpg
  htop
  hub
  imagemagick
  jq
  ncdu
  nmap
  pup
  pv
  siege
  tmux
  trash
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
  # sequel-pro
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
  cheatsheet
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


#  Fonts ("brew cask search /font./")
#  See: https://github.com/powerline/fonts
declare cask_fonts=(
  dejavu-sans-mono-for-powerline
  inconsolata-for-powerline
  macondo
  macondo-swash-caps
  menlo-for-powerline
  monofur-for-powerline
  quantico
  roboto
  roboto-condensed
  roboto-mono
  roboto-mono-for-powerline
  roboto-sla
  source-code-pro
  ubuntu
  ubuntu-mono-powerline
  verdana
  webdings
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