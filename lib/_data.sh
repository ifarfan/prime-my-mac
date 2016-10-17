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
  aircrack-ng
  awscli
  aws-shell
  colordiff
  coreutils
  cowsay
  dockutil
  findutils
  fortune
  git-flow
  gnu-sed --with-default-names
  grc
  gpg
  homebrew/dupes/grep
  homebrew/dupes/openssh
  homebrew/dupes/screen
  htop
  hub
  imagemagick
  jq
  moreutils
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
  menlo-for-powerline
  monofur-for-powerline
  quantico
  roboto
  roboto-condensed
  roboto-mono
  roboto-mono-for-powerline
  source-code-pro
  ubuntu
  ubuntu-mono-powerline
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
