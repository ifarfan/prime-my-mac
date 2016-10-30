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
  pysphere
  PyVmomi
)


#  homebrew packages
declare brew_pkgs=(
  aircrack-ng
  awscli                            #  AWS cmd line
  aws-shell                         #  Shell for AWS cmds
  cli53                             #  Manage AWS Route53
  cdrtools                          #  Server images tools
  csshx                             #  Multiple simultaneous SSH
  colordiff
  coreutils
  cowsay
  dockutil                          #  Manage the OS X Dock
  findutils
  fortune
  git
  git-flow
  gnu-sed --with-default-names      #  Use linux sed
  grc                               #  Colorize output
  gpg
  homebrew/dupes/grep
  homebrew/dupes/openssh
  homebrew/dupes/screen
  htop
  hub                               #  Automate github
  imagemagick
  jq                                #  JSON parser
  moreutils
  ncdu
  nmap
  node                              #  NodeJS
  pup                               #  HTML parser
  pv                                #  Progres monitor
  siege                             #  Stress testing
  tmux
  trash                             #  Send deleted files to OSX trash
  tree
  unrar
  watch                             #  Linux watch
  wget                              #  Linux wget
  z                                 #  Remember most used cd'ed folders
  bash                              #  Bash 4.x
  bash-completion
)


#  homebrew cask packages
declare cask_pkgs=(
  # 1password
  # cyberduck
  diffmerge
  dropbox
  firefox
  google-chrome
  google-hangouts
  iterm2
  handbrake
  kitematic
  macdown
  # meld
  omnigraffle
  # querious
  sequel-pro
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
#  Laptop
#  Utilities
  a-better-finder-rename            #  Mass file renaming
  alfred                            #  Keyboard hotkeys
  caffeine                          #  Prevent machine from sleeping
  cheatsheet                        #  Shortcuts for most apps
  coconutbattery                    #  Battery health
  electric-sheep                    #  Screen saver
  istat-menus                       #  Menu bar server stats
  max                               #  Audio files
  smcfancontrol                     #  Control fan
  spectacle                         #  Manage app windows
  the-unarchiver                    #  Work with multiple archive formats
  timemachineeditor                 #  Finely manage Time Machine
  unetbootin                        #  Audio files
  watts                             #  Battery calibration
  wireshark                         #  Network sniffer
  xact                              #  Audio files
#  Work-related
  postico                           #  Postgres client
  tunnelblick                       #  Open VPN client
  zoomus                            #  Video conferencing
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
  'Skitch'
  'Calculator'
  'iTerm'
  'OmniGraffle'
  'Sublime Text'
  'System Preferences'
)


#  Dock Folders
declare dock_folders=(
  '/Applications'
  '~/Downloads'
)


#  Apple Apps
declare apple_apps=(
  'App Store'
  'Automator'
  'Calendar'
  'Chess'
  'Contacts'
  'DVD Player'
  'Dashboard'
  'Dictionary'
  'FaceTime'
  'Font Book'
  'Game Center'
  'Image Capture'
  'Launchpad'
  'Mail'
  'Maps'
  'Messages'
  'Mission Control'
  'Notes'
  'Photo Booth'
  'Photos'
  'Preview'
  'QuickTime Player'
  'Reminders'
  'Safari'
  'Stickies'
  'Time Machine'
)


#  Custom git settings
declare git_custom_config=(
  "user.name:Israel Farfan"
  "user.email:israel.farfan@gmx.com"
  "core.editor:nano"
  "github.user:ifarfan"
  "github.token:"
)
