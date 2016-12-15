#!/usr/bin/env bash
#  =============================================================================
#
#  D A T A . S H
#
#  =============================================================================

#  pip packages
declare pip_pkgs=(
  ansible                           #  First thing in every Mac
  httpie                            #  curl 4 humans
  json2yaml                         #  YAML for the win!
  pgcli                             #  Postgres CLI client
  pygments                          #  File colorization
  PyVmomi                           #  VSphere-related
)

#  homebrew packages
declare brew_pkgs=(
  aircrack-ng
  awscli                            #  AWS cmd line
  aws-shell                         #  Shell for AWS cmds
  cli53                             #  Manage AWS Route53
  cdrtools                          #  Server images tools: mkisofs
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
  lastpass-cli --with-pinentry --with-doc  #  Password manager cli tool
  moreutils
  ncdu
  nmap
  node                              #  NodeJS
  pup                               #  HTML parser
  pv                                #  Progres monitor
  siege                             #  Stress testing
  terminal-notifier                 #  OS X notifications via shell
  tmux
  trash                             #  Send deleted files to OSX trash
  tree
  unrar
  watch                             #  Linux "watch" command
  wget                              #  Linux wget
  z                                 #  Remember most used cd'ed folders
  bash                              #  Bash 4.x
  bash-completion
#
#  Deprecated
#
  # neovim/neovim/neovim              #  vim replacement
)

#  homebrew cask packages
#  :l == laptop-only, :u == "Utilities" folder-only
declare cask_pkgs=(
  diffmerge
  docker-toolbox                    #  Needed by Kitematic, duh!
  dropbox
  firefox
  google-chrome
  google-hangouts
  iterm2
  handbrake
  kitematic
  macdown
  murasaki                          #  epub reader
  omnigraffle
  sequel-pro
  skitch
  skype
  slack
  spotify
  sublime-text
  teamviewer                        # NOTE: will prompt with post-install gui
  unison
  utorrent                          # NOTE: will need manual post-install steps
  virtualbox
  vagrant
  vagrant-manager
  vlc
#
#  Utilities
#
  a-better-finder-rename:u          #  Mass file renaming
  alfred:u                          #  Keyboard hotkeys
  angry-ip-scanner:u                #  IP Scanner
  arrsync:u                         #  Rsync client
  avidemux:u                        #  Video editing
  cheatsheet:u                      #  Shortcuts for most apps
  coconutbattery:lu                 #  Battery health
  electric-sheep:u                  #  Screen saver
  istat-menus:u                     #  Menu bar server stats
  max:u                             #  Audio files
  spectacle:u                       #  Manage app windows
  the-unarchiver:u                  #  Work with multiple archive formats
  timemachineeditor:u               #  Finely manage Time Machine
  tomighty:u                        #  Pomodoro timer
  unetbootin:u                      #  Audio files
  watts:lu                          #  Battery calibration
  wireshark:u                       #  Network sniffer
  xact:u                            #  Audio file converter
#
#  Work-related
#
  postico                           #  Postgres client
  tunnelblick                       #  Open VPN client
  zoomus                            #  Video conferencing, will prompt with post-install gui
#
#  Deprecated
#
  # 1password
  # caffeine:u                        #  Prevent machine from sleeping
  # cyberduck
  # meld
  # querious
  # transmit
  # jubler:u                          #  Subtitle editor
  # smcfancontrol:lu                  #  Control fan
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
  ubuntu-mono-derivative-powerline
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
  'Siri'
  'Stickies'
  'TextEdit'
  'Time Machine'
)
