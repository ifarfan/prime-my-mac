#!/usr/bin/env bash

#  =============================================================================
#
#  D A T A . S H
#
#  =============================================================================

#  pip packages
declare pip_pkgs=(
    ansible                           #  1st thing on every Mac
    ansible-lint                      #  2nd thing on every Mac
    bashate                           #  Bash linting
    boto3                             #  AWS SDK
    httpie                            #  curl 4 humans
    json2yaml                         #  YAML for the win!
    pgcli                             #  Postgres CLI client
    pygments                          #  File colorization from terminal
    # udemy-dl                        #  Download Udemy videos (optional)
    virtualenv                        #  Virtual environments
)

#  homebrew packages
declare brew_pkgs=(
    aircrack-ng
    aria2                             #  Beefy download utility
    awscli                            #  AWS cmd line
    aws-shell                         #  Shell for AWS cmds
    cli53                             #  Manage AWS Route53
    cdrtools                          #  Server images tools: mkisofs
    csshx                             #  Multiple simultaneous SSH
    colordiff
    coreutils --with-default-names
    cowsay
    dockutil                          #  Manage the OS X Dock
    findutils --with-default-names
    fortune
    gawk
    git
    git-flow
    gnu-getopt --with-default-names   #  Use linux getopt
    gnu-indent --with-default-names   #  Use linux indent
    gnu-sed --with-default-names      #  Use linux sed
    gnu-tar --with-default-names      #  Use linux tar
    grc                               #  Colorize output
    gpg
    gnutls
    homebrew/dupes/grep
    homebrew/dupes/openssh
    homebrew/dupes/screen
    htop
    hub                               #  Automate github
    imagemagick
    jq                                #  JSON parser
    lastpass-cli --with-pinentry --with-doc  #  Password manager cli tool
    lnav                              #  Log file/folder navigator
    moreutils
    nano
    ncdu
    nmap
    node                              #  NodeJS
    peco                              #  Interactive "grep"
    perceptualdiff                    #  Diff images from cmdline
    pup                               #  HTML parser
    pv                                #  Shell progres bar monitor
    siege                             #  Load testing
    terminal-notifier                 #  OS X notifications via shell
    terraform                         #  Hashicorp's infrastructure-as-code
    tmux
    trash                             #  Send deleted files to OSX trash
    tree
    unrar
    watch                             #  Linux "watch" command
    wget                              #  Linux "wget" command
    z                                 #  Remember most used cd'ed folders
    bash                              #  Bash 4.x
    bash-completion
#
#  Other
#
    http://git.io/sshpass.rb          #  unofficial sshpass install @ https://gist.github.com/arunoda/7790979
#
#  Deprecated
#
  # neovim/neovim/neovim              #  vim replacement
)

#  homebrew cask packages
#  :l == laptop-only, :u == "Utilities" folder-only
declare cask_pkgs=(
    anaconda
    diffmerge
    docker
    dropbox
    firefox
    free-ruler                        #  ruler gui
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
    vlc
#
#  Utilities
#
    a-better-finder-rename            #  Mass file renaming
    alfred                            #  Keyboard hotkeys
    angry-ip-scanner                  #  IP Scanner
    arrsync                           #  Rsync client
    avidemux                          #  Video editing
    cheatsheet                        #  Shortcuts for most apps
    coconutbattery:l                  #  Battery health
    electric-sheep                    #  Screen saver
    flycut                            #  Clipboard manager
    istat-menus                       #  Menu bar server stats
    max                               #  Audio files
    spectacle                         #  Manage app windows
    the-unarchiver                    #  Work with multiple archive formats
    timemachineeditor                 #  Finely manage Time Machine
    tomighty                          #  Pomodoro timer
    unetbootin                        #  Audio files
    watts:l                           #  Battery calibration
    wireshark                         #  Network sniffer
    xact                              #  Audio file converter
#
#  Work-related
#
    postico                           #  Postgres client
    tunnelblick                       #  Open VPN client
    x-lite                            #  VOIP client
    zoomus                            #  Video conferencing, will prompt with post-install gui
#
#  Deprecated
#
  # 1password
  # caffeine                          #  Prevent machine from sleeping
  # cyberduck
  # docker-toolbox                    #  Needed by Kitematic, duh!
  # hipchat                           #  :(
  # meld                              #  Diff tool
  # querious
  # transmit
  # jubler                            #  Subtitle editor
  # smcfancontrol:l                   #  Control fan
  # vagrant-manager
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

#  iTerm settings in plist file
declare iterm_bookmark_settings=(
    [key_name]="ASCII Anti Aliased" [key_type]="integer" [key_value]=1
    [key_name]="Ambiguous Double Width" [key_type]="integer" [key_value]=0
    [key_name]="Ansi 0 Color\":\"Blue Component" [key_type]="real" [key_value]="0.1937013864517212"
    [key_name]="Ansi 0 Color\":\"Green Component" [key_type]="real" [key_value]="0.155759260058403"
    [key_name]="Ansi 0 Color\":\"Red Component" [key_type]="integer" [key_value]=0
    [key_name]="Ansi 1 Color\":\"Blue Component" [key_type]="real" [key_value]="0.1414571404457092"
    [key_name]="Ansi 1 Color\":\"Green Component" [key_type]="real" [key_value]="0.1084065511822701"
    [key_name]="Ansi 1 Color\":\"Red Component" [key_type]="real" [key_value]="0.8192697763442993"
    [key_name]="Ansi 10 Color\":\"Blue Component" [key_type]="real" [key_value]="0.3829848766326904"
    [key_name]="Ansi 10 Color\":\"Green Component" [key_type]="real" [key_value]="0.3566595613956451"
    [key_name]="Ansi 10 Color\":\"Red Component" [key_type]="real" [key_value]="0.2767199277877808"
    [key_name]="Ansi 11 Color\":\"Blue Component" [key_type]="real" [key_value]="0.4385056495666504"
    [key_name]="Ansi 11 Color\":\"Green Component" [key_type]="real" [key_value]="0.4071767330169678"
    [key_name]="Ansi 11 Color\":\"Red Component" [key_type]="real" [key_value]="0.3243661820888519"
    [key_name]="Ansi 12 Color\":\"Blue Component" [key_type]="real" [key_value]="0.5168579816818237"
    [key_name]="Ansi 12 Color\":\"Green Component" [key_type]="real" [key_value]="0.5096293091773987"
    [key_name]="Ansi 12 Color\":\"Red Component" [key_type]="real" [key_value]="0.4405802488327026"
    [key_name]="Ansi 13 Color\":\"Blue Component" [key_type]="real" [key_value]="0.7290843725204468"
    [key_name]="Ansi 13 Color\":\"Green Component" [key_type]="real" [key_value]="0.3389629721641541"
    [key_name]="Ansi 13 Color\":\"Red Component" [key_type]="real" [key_value]="0.3479863405227661"
    [key_name]="Ansi 14 Color\":\"Blue Component" [key_type]="real" [key_value]="0.5636365413665771"
    [key_name]="Ansi 14 Color\":\"Green Component" [key_type]="real" [key_value]="0.5648583769798279"
    [key_name]="Ansi 14 Color\":\"Red Component" [key_type]="real" [key_value]="0.5059919357299805"
    [key_name]="Ansi 15 Color\":\"Blue Component" [key_type]="real" [key_value]="0.8640598058700562"
    [key_name]="Ansi 15 Color\":\"Green Component" [key_type]="real" [key_value]="0.9579439163208008"
    [key_name]="Ansi 15 Color\":\"Red Component" [key_type]="real" [key_value]="0.9894341826438904"
    [key_name]="Ansi 2 Color\":\"Blue Component" [key_type]="real" [key_value]="0.02020875550806522"
    [key_name]="Ansi 2 Color\":\"Green Component" [key_type]="real" [key_value]="0.5411549210548401"
    [key_name]="Ansi 2 Color\":\"Red Component" [key_type]="real" [key_value]="0.4497745335102081"
    [key_name]="Ansi 3 Color\":\"Blue Component" [key_type]="real" [key_value]="0.02348481118679047"
    [key_name]="Ansi 3 Color\":\"Green Component" [key_type]="real" [key_value]="0.4675142467021942"
    [key_name]="Ansi 3 Color\":\"Red Component" [key_type]="real" [key_value]="0.6474647521972656"
    [key_name]="Ansi 4 Color\":\"Blue Component" [key_type]="real" [key_value]="0.7823141813278198"
    [key_name]="Ansi 4 Color\":\"Green Component" [key_type]="real" [key_value]="0.462659478187561"
    [key_name]="Ansi 4 Color\":\"Red Component" [key_type]="real" [key_value]="0.1275488436222076"
    [key_name]="Ansi 5 Color\":\"Blue Component" [key_type]="real" [key_value]="0.4351663589477539"
    [key_name]="Ansi 5 Color\":\"Green Component" [key_type]="real" [key_value]="0.1080246344208717"
    [key_name]="Ansi 5 Color\":\"Red Component" [key_type]="real" [key_value]="0.7773894071578979"
    [key_name]="Ansi 6 Color\":\"Blue Component" [key_type]="real" [key_value]="0.5250227451324463"
    [key_name]="Ansi 6 Color\":\"Green Component" [key_type]="real" [key_value]="0.570823609828949"
    [key_name]="Ansi 6 Color\":\"Red Component" [key_type]="real" [key_value]="0.1467953473329544"
    [key_name]="Ansi 7 Color\":\"Blue Component" [key_type]="real" [key_value]="0.7978110313415527"
    [key_name]="Ansi 7 Color\":\"Green Component" [key_type]="real" [key_value]="0.8900123834609985"
    [key_name]="Ansi 7 Color\":\"Red Component" [key_type]="real" [key_value]="0.916110634803772"
    [key_name]="Ansi 8 Color\":\"Blue Component" [key_type]="real" [key_value]="0.1517027318477631"
    [key_name]="Ansi 8 Color\":\"Green Component" [key_type]="real" [key_value]="0.1178361028432846"
    [key_name]="Ansi 8 Color\":\"Red Component" [key_type]="integer" [key_value]=0
    [key_name]="Ansi 9 Color\":\"Blue Component" [key_type]="real" [key_value]="0.07353043556213379"
    [key_name]="Ansi 9 Color\":\"Green Component" [key_type]="real" [key_value]="0.2132530063390732"
    [key_name]="Ansi 9 Color\":\"Red Component" [key_type]="real" [key_value]="0.7417625784873962"
    [key_name]="BM Growl" [key_type]="integer" [key_value]=1
    [key_name]="Background Color\":\"Blue Component" [key_type]="real" [key_value]="0.1517027318477631"
    [key_name]="Background Color\":\"Green Component" [key_type]="real" [key_value]="0.1178361028432846"
    [key_name]="Background Color\":\"Red Component" [key_type]="integer" [key_value]=0
    [key_name]="Background Image Location" [key_type]="string" [key_value]=""
    [key_name]="Badge Color\":\"Alpha Component" [key_type]="real" [key_value]="0.5"
    [key_name]="Badge Color\":\"Blue Component" [key_type]="integer" [key_value]=0
    [key_name]="Badge Color\":\"Color Space" [key_type]="string" [key_value]="Calibrated"
    [key_name]="Badge Color\":\"Green Component" [key_type]="integer" [key_value]=0
    [key_name]="Badge Color\":\"Red Component" [key_type]="integer" [key_value]=1
    [key_name]="Blinking Cursor" [key_type]="integer" [key_value]=0
    [key_name]="Blur" [key_type]="integer" [key_value]=1
    [key_name]="Blur Radius" [key_type]="real" [key_value]="5.61171875"
    [key_name]="Bold Color\":\"Blue Component" [key_type]="real" [key_value]="0.5636365413665771"
    [key_name]="Bold Color\":\"Green Component" [key_type]="real" [key_value]="0.5648583769798279"
    [key_name]="Bold Color\":\"Red Component" [key_type]="real" [key_value]="0.5059919357299805"
    [key_name]="Character Encoding" [key_type]="integer" [key_value]=4
    [key_name]="Close Sessions On End" [key_type]="integer" [key_value]=1
    [key_name]="Columns" [key_type]="integer" [key_value]=80
    [key_name]="Command" [key_type]="string" [key_value]=""
    [key_name]="Cursor Color\":\"Blue Component" [key_type]="real" [key_value]="0.5168579816818237"
    [key_name]="Cursor Color\":\"Green Component" [key_type]="real" [key_value]="0.5096293091773987"
    [key_name]="Cursor Color\":\"Red Component" [key_type]="real" [key_value]="0.4405802488327026"
    [key_name]="Cursor Guide Color\":\"Alpha Component" [key_type]="real" [key_value]="0.25"
    [key_name]="Cursor Guide Color\":\"Blue Component" [key_type]="integer" [key_value]=1
    [key_name]="Cursor Guide Color\":\"Color Space" [key_type]="string" [key_value]="Calibrated"
    [key_name]="Cursor Guide Color\":\"Green Component" [key_type]="real" [key_value]="0.91"
    [key_name]="Cursor Guide Color\":\"Red Component" [key_type]="real" [key_value]="0.65"
    [key_name]="Cursor Text Color\":\"Blue Component" [key_type]="real" [key_value]="0.1937013864517212"
    [key_name]="Cursor Text Color\":\"Green Component" [key_type]="real" [key_value]="0.155759260058403"
    [key_name]="Cursor Text Color\":\"Red Component" [key_type]="integer" [key_value]=0
    [key_name]="Custom Command" [key_type]="string" [key_value]="No"
    [key_name]="Custom Directory" [key_type]="string" [key_value]="No"
    [key_name]="Default Bookmark" [key_type]="string" [key_value]="No"
    [key_name]="Description" [key_type]="string" [key_value]="Default"
    [key_name]="Disable Window Resizing" [key_type]="integer" [key_value]=1
    [key_name]="Flashing Bell" [key_type]="integer" [key_value]=0
    [key_name]="Foreground Color\":\"Blue Component" [key_type]="real" [key_value]="0.5168579816818237"
    [key_name]="Foreground Color\":\"Green Component" [key_type]="real" [key_value]="0.5096293091773987"
    [key_name]="Foreground Color\":\"Red Component" [key_type]="real" [key_value]="0.4405802488327026"
    [key_name]="Guid" [key_type]="string" [key_value]="D9CD6010-E58D-4FE0-8293-2B3D93E9332F"
    [key_name]="Horizontal Spacing" [key_type]="integer" [key_value]=1
    [key_name]="Idle Code" [key_type]="integer" [key_value]=0
    [key_name]="Jobs to Ignore\":\"0" [key_type]="data" [key_value]="rlogin"
    [key_name]="Jobs to Ignore\":\"1" [key_type]="data" [key_value]="ssh"
    [key_name]="Jobs to Ignore\":\"2" [key_type]="data" [key_value]="slogin"
    [key_name]="Jobs to Ignore\":\"3" [key_type]="data" [key_value]="telnet"
    [key_name]="Keyboard Map\":\"0x2d-0x40000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0x2d-0x40000\":\"Text" [key_type]="string" [key_value]=0x1f
    [key_name]="Keyboard Map\":\"0x32-0x40000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0x32-0x40000\":\"Text" [key_type]="string" [key_value]=0x00
    [key_name]="Keyboard Map\":\"0x33-0x40000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0x33-0x40000\":\"Text" [key_type]="string" [key_value]=0x1b
    [key_name]="Keyboard Map\":\"0x33-0x40000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0x33-0x40000\":\"Text" [key_type]="string" [key_value]=0x1c
    [key_name]="Keyboard Map\":\"0x35-0x40000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0x35-0x40000\":\"Text" [key_type]="string" [key_value]=0x1d
    [key_name]="Keyboard Map\":\"0x36-0x40000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0x36-0x40000\":\"Text" [key_type]="string" [key_value]=0x1e
    [key_name]="Keyboard Map\":\"0x37-0x40000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0x37-0x40000\":\"Text" [key_type]="string" [key_value]=0x1f
    [key_name]="Keyboard Map\":\"0x38-0x40000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0x38-0x40000\":\"Text" [key_type]="string" [key_value]=0x7f
    [key_name]="Keyboard Map\":\"0xf700-0x220000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf700-0x220000\":\"Text" [key_type]="string" [key_value]="[12A"
    [key_name]="Keyboard Map\":\"0xf700-0x240000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf700-0x240000\":\"Text" [key_type]="string" [key_value]="[15A"
    [key_name]="Keyboard Map\":\"0xf700-0x260000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf700-0x260000\":\"Text" [key_type]="string" [key_value]="[16A"
    [key_name]="Keyboard Map\":\"0xf700-0x280000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0xf700-0x280000\":\"Text" [key_type]="string" [key_value]="0x1b 0x1b 0x5b 0x41"
    [key_name]="Keyboard Map\":\"0xf701-0x220000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf701-0x220000\":\"Text" [key_type]="string" [key_value]="[12B"
    [key_name]="Keyboard Map\":\"0xf701-0x240000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf701-0x240000\":\"Text" [key_type]="string" [key_value]="[15B"
    [key_name]="Keyboard Map\":\"0xf701-0x260000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf701-0x260000\":\"Text" [key_type]="string" [key_value]="[16B"
    [key_name]="Keyboard Map\":\"0xf701-0x280000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0xf701-0x280000\":\"Text" [key_type]="string" [key_value]="0x1b 0x1b 0x5b 0x42"
    [key_name]="Keyboard Map\":\"0xf702-0x220000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf702-0x220000\":\"Text" [key_type]="string" [key_value]="[12D"
    [key_name]="Keyboard Map\":\"0xf702-0x240000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf702-0x240000\":\"Text" [key_type]="string" [key_value]="[15D"
    [key_name]="Keyboard Map\":\"0xf702-0x260000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf702-0x260000\":\"Text" [key_type]="string" [key_value]="[16D"
    [key_name]="Keyboard Map\":\"0xf702-0x280000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0xf702-0x280000\":\"Text" [key_type]="string" [key_value]="0x1b 0x1b 0x5b 0x44"
    [key_name]="Keyboard Map\":\"0xf703-0x220000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf703-0x220000\":\"Text" [key_type]="string" [key_value]="[12C"
    [key_name]="Keyboard Map\":\"0xf703-0x240000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf703-0x240000\":\"Text" [key_type]="string" [key_value]="[15C"
    [key_name]="Keyboard Map\":\"0xf703-0x260000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf703-0x260000\":\"Text" [key_type]="string" [key_value]="[16C"
    [key_name]="Keyboard Map\":\"0xf703-0x280000\":\"Action" [key_type]="integer" [key_value]=11
    [key_name]="Keyboard Map\":\"0xf703-0x280000\":\"Text" [key_type]="string" [key_value]="0x1b 0x1b 0x5b 0x43"
    [key_name]="Keyboard Map\":\"0xf704-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf704-0x20000\":\"Text" [key_type]="string" [key_value]="[12P"
    [key_name]="Keyboard Map\":\"0xf705-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf705-0x20000\":\"Text" [key_type]="string" [key_value]="[12Q"
    [key_name]="Keyboard Map\":\"0xf706-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf706-0x20000\":\"Text" [key_type]="string" [key_value]="[12R"
    [key_name]="Keyboard Map\":\"0xf707-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf707-0x20000\":\"Text" [key_type]="string" [key_value]="[12S"
    [key_name]="Keyboard Map\":\"0xf708-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf708-0x20000\":\"Text" [key_type]="string" [key_value]="[152~"
    [key_name]="Keyboard Map\":\"0xf709-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf709-0x20000\":\"Text" [key_type]="string" [key_value]="[172~"
    [key_name]="Keyboard Map\":\"0xf70a-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf70a-0x20000\":\"Text" [key_type]="string" [key_value]="[182~"
    [key_name]="Keyboard Map\":\"0xf70b-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf70b-0x20000\":\"Text" [key_type]="string" [key_value]="[192~"
    [key_name]="Keyboard Map\":\"0xf70c-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf70c-0x20000\":\"Text" [key_type]="string" [key_value]="[202~"
    [key_name]="Keyboard Map\":\"0xf70d-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf70d-0x20000\":\"Text" [key_type]="string" [key_value]="[212~"
    [key_name]="Keyboard Map\":\"0xf70e-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf70e-0x20000\":\"Text" [key_type]="string" [key_value]="[232~"
    [key_name]="Keyboard Map\":\"0xf70f-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf70f-0x20000\":\"Text" [key_type]="string" [key_value]="[242~"
    [key_name]="Keyboard Map\":\"0xf729-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf729-0x20000\":\"Text" [key_type]="string" [key_value]="[12H"
    [key_name]="Keyboard Map\":\"0xf729-0x40000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf729-0x40000\":\"Text" [key_type]="string" [key_value]="[15H"
    [key_name]="Keyboard Map\":\"0xf72b-0x20000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf72b-0x20000\":\"Text" [key_type]="string" [key_value]="[12F"
    [key_name]="Keyboard Map\":\"0xf72b-0x40000\":\"Action" [key_type]="integer" [key_value]=10
    [key_name]="Keyboard Map\":\"0xf72b-0x40000\":\"Text" [key_type]="string" [key_value]="[15F"
    [key_name]="Keyboard Map\":\"Link Color\":\"Alpha Component" [key_type]="integer" [key_value]=1
    [key_name]="Keyboard Map\":\"Link Color\":\"Blue Component" [key_type]="real" [key_value]="0.678"
    [key_name]="Keyboard Map\":\"Link Color\":\"Color Space" [key_type]="string" [key_value]="Calibrated"
    [key_name]="Keyboard Map\":\"Link Color\":\"Green Component" [key_type]="real" [key_value]="0.27"
    [key_name]="Keyboard Map\":\"Link Color\":\"Red Component" [key_type]="real" [key_value]="0.023"
    [key_name]="Mouse Reporting" [key_type]="integer" [key_value]=1
    [key_name]="Name" [key_type]="string" [key_value]="Default"
    [key_name]="Non Ascii Font" [key_type]="string" [key_value]="Monaco 12"
    [key_name]="Non-ASCII Anti Aliased" [key_type]="integer" [key_value]=1
    [key_name]="Normal Font" [key_type]="string" [key_value]="UbuntuMonoDerivativePowerline-Regular 16"
    [key_name]="Only The Default BG Color Uses Transparency" [key_type]="string" [key_value]=0
    [key_name]="Option Key Sends" [key_type]="integer" [key_value]=0
    [key_name]="Prompt Before Closing 2" [key_type]="integer" [key_value]=0
    [key_name]="Right Option Key Sends" [key_type]="integer" [key_value]=0
    [key_name]="Rows" [key_type]="integer" [key_value]=25
    [key_name]="Screen" [key_type]="string" [key_value]="-1"
    [key_name]="Scrollback Lines" [key_type]="integer" [key_value]=1000
    [key_name]="Selected Text Color\":\"Alpha Component" [key_type]="integer" [key_value]=1
    [key_name]="Selected Text Color\":\"Blue Component" [key_type]="real" [key_value]="0.7186503410339355"
    [key_name]="Selected Text Color\":\"Color Space" [key_type]="string" [key_value]="Calibrated"
    [key_name]="Selected Text Color\":\"Green Component" [key_type]="real" [key_value]="0.7200272083282471"
    [key_name]="Selected Text Color\":\"Red Component" [key_type]="real" [key_value]="0.6539754867553711"
    [key_name]="Selection Color\":\"Alpha Component" [key_type]="integer" [key_value]=1
    [key_name]="Selection Color\":\"Blue Component" [key_type]="real" [key_value]="0.09438608586788177"
    [key_name]="Selection Color\":\"Color Space" [key_type]="string" [key_value]="Calibrated"
    [key_name]="Selection Color\":\"Green Component" [key_type]="real" [key_value]="0.267566442489624"
    [key_name]="Selection Color\":\"Red Component" [key_type]="real" [key_value]="0.08782456815242767"
    [key_name]="Send Code When Idle" [key_type]="integer" [key_value]=0
    [key_name]="Shortcut" [key_type]="string" [key_value]=""
    [key_name]="Silence Bell" [key_type]="integer" [key_value]=0
    [key_name]="Sync Title" [key_type]="integer" [key_value]=0
    [key_name]="Tags\":\"0" [key_type]="dict" [key_value]=""
    [key_name]="Terminal Type" [key_type]="string" [key_value]="xterm-256color"
    [key_name]="Transparency" [key_type]="real" [key_value]="0.09791743713017752"
    [key_name]="Unlimited Scrollback" [key_type]="integer" [key_value]=1
    [key_name]="Use Bold Font" [key_type]="integer" [key_value]=1
    [key_name]="Use Bright Bold" [key_type]="integer" [key_value]=1
    [key_name]="Use Italic Font" [key_type]="integer" [key_value]=1
    [key_name]="Use Non-ASCII Font" [key_type]="integer" [key_value]=0
    [key_name]="Vertical Spacing" [key_type]="integer" [key_value]=1
    [key_name]="Visual Bell" [key_type]="integer" [key_value]=1
    [key_name]="Window Type" [key_type]="integer" [key_value]=0
    [key_name]="Working Directory" [key_type]="string" [key_value]="${HOME}"
)


#  Whether we'll use custom-filled ~/Applications instead of /Application
CUSTOM_APPS_DIR=0
