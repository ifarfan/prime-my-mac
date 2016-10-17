#!/usr/bin/env bash
#  =============================================================================
#
#  _ G L O B A L S . S H
#
#  Note: https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
#  =============================================================================


function app_store_tweaks {
  #  Enable the WebKit Developer Tools in the Mac App Store
  # defaults write com.apple.appstore WebKitDeveloperExtras -bool true

  #  Enable Debug Menu in the Mac App Store
  # defaults write com.apple.appstore ShowDebugMenu -bool true

  #  Enable the automatic update check
  defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

  #  Check for software updates daily, not just once per week
  # defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

  #  Download newly available updates in background
  # defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

  #  Install System data files & security updates
  defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

  #  Automatically download apps purchased on other Macs
  # defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

  #  Turn on app auto-update
  # defaults write com.apple.commerce AutoUpdate -bool true

  #  Allow the App Store to reboot machine on macOS updates
  # defaults write com.apple.commerce AutoUpdateRestartRequired -bool true
}


function dock_tweaks {
  status_msg "1" "Custom Dock tweaks"

  #  Remove everything off the dock first
  dockutil --remove all --no-restart

  #  Add new dock apps
  for dock_item in "${dock_apps[@]}"
  do
    dockutil --add "/Applications/${dock_item}.app"
  done

  #  Add new dock folders
  for dock_item in "${dock_folders[@]}"
  do
    dockutil --add "${dock_item}" --view grid --display folder --sort name
  done

  #  Enable highlight hover effect for the grid view of a stack (Dock)
  defaults write com.apple.dock mouse-over-hilite-stack -bool true

  #  Set the icon size of Dock items
  defaults write com.apple.dock tilesize -int 30

  #  Change minimize/maximize window effect
  defaults write com.apple.dock mineffect -string "scale"

  #  Enable spring loading for all Dock items
  defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

  #  Show indicator lights for open applications in the Dock
  defaults write com.apple.dock show-process-indicators -bool true

  #  Show only open applications in the Dock
  # defaults write com.apple.dock static-only -bool true

  #  Don’t animate opening applications from the Dock
  # defaults write com.apple.dock launchanim -bool false

  #  Speed up Mission Control animations
  # defaults write com.apple.dock expose-animation-duration -float 0.1

  #  Don’t group windows by application in Mission Control
  #  (i.e. use the old Exposé behavior instead)
  # defaults write com.apple.dock expose-group-by-app -bool false

  #  Remove the auto-hiding Dock delay
  # defaults write com.apple.dock autohide-delay -float 0

  #  Remove the animation when hiding/showing the Dock
  # defaults write com.apple.dock autohide-time-modifier -float 0

  #  Automatically hide and show the Dock
  defaults write com.apple.dock autohide -bool true

  #  Make Dock icons of hidden applications translucent
  defaults write com.apple.dock showhidden -bool true

  #  Disable Dashboard
  defaults write com.apple.dashboard mcx-disabled -bool true

  #  Don’t show Dashboard as a Space
  defaults write com.apple.dock dashboard-in-overlay -bool true

  #  Don’t automatically rearrange Spaces based on most recent use
  # defaults write com.apple.dock mru-spaces -bool false

  #  Disable the Launchpad gesture (pinch with thumb and three fingers)
  defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

  #  Enable the 'reduce transparency' option on Yosemite. Save GPU cycles.
  defaults write com.apple.universalaccess reduceTransparency -bool true

  #  Hot corners
  #  Possible values:
  #   0: no-op
  #   2: Mission Control
  #   3: Show application windows
  #   4: Desktop
  #   5: Start screen saver
  #   6: Disable screen saver
  #   7: Dashboard
  #  10: Put display to sleep
  #  11: Launchpad
  #  12: Notification Center

  #  Bottom right screen corner → Mission Control
  # defaults write com.apple.dock wvous-br-corner -int 2
  # defaults write com.apple.dock wvous-br-modifier -int 0

  #  Top right screen corner → Put display to sleep
  # defaults write com.apple.dock wvous-tr-corner -int 10
  # defaults write com.apple.dock wvous-tr-modifier -int 0

  #  Bottom left screen corner → Desktop
  defaults write com.apple.dock wvous-bl-corner -int 4
  defaults write com.apple.dock wvous-bl-modifier -int 0
}


function finder_tweaks {
  status_msg "1" "Custom Finder tweaks"

  #  Allow quitting via ⌘ + Q; doing so will also hide desktop icons
  defaults write com.apple.finder QuitMenuItem -bool true

  #  Set Desktop as the default location for new Finder windows
  #  For other paths, use `PfLo` and `file:///full/path/here/`
  defaults write com.apple.finder NewWindowTarget -string "PfDe"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

  #  Show icons for hard drives, servers, and removable media on the desktop
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

  #  Show all filename extensions
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  #  Show status bar
  defaults write com.apple.finder ShowStatusBar -bool true

  #  Show path bar
  defaults write com.apple.finder ShowPathbar -bool true

  #  Allow text selection in Quick Look
  defaults write com.apple.finder QLEnableTextSelection -bool true

  # Display full POSIX path as Finder window title
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  #  Keep folders on top when sorting by name
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  #  When performing a search, search the current folder by default
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  #  Disable the warning when changing a file extension
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  #  Set sidebar icon size to medium
  defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

  #  Enable spring loading for directories
  # defaults write NSGlobalDomain com.apple.springing.enabled -bool true

  #  Remove the spring loading delay for directories
  # defaults write NSGlobalDomain com.apple.springing.delay -float 0.1

  #  Avoid creating .DS_Store files on network volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  #  Automatically open a new Finder window when a volume is mounted
  defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
  defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
  defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

  #  Enable snap-to-grid for icons on the desktop and in other icon views
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

  # Increase grid spacing for icons on the desktop and in other icon views
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

  #  Set the size of icons on the desktop and in other icon views
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist

  #  Use list view in all Finder windows by default: `icnv`, `Nlsv`, `clmv`, `Flwv`
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

  #  Show the ~/Library folder
  chflags nohidden ~/Library

  # Show the /Volumes folder
  sudo chflags nohidden /Volumes

  # Expand the following File Info panes: "General", "Open with", and "Sharing & Permissions"
  defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Preview -bool false \
    Privileges -bool true
}


function input_device_tweaks {
  status_msg "1" "Custom Input Devices tweaks"

  # #  Trackpad: map bottom right corner to right-click
  # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
  # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
  # defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
  # defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

  #  Increase sound quality for Bluetooth headphones/headsets
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

  #  Disable “natural” (Lion-style) scrolling
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

  #  Enable full keyboard access for all controls
  #  (e.g. enable Tab in modal dialogs - 0 = text boxes and lists, 2/3 = all controls)
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 0

  #  Use scroll gesture with the Ctrl (^) modifier key to zoom
  defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
  defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

  #  Follow the keyboard focus while zoomed in
  defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

  #  Disable press-and-hold for keys in favor of key repeat
  # defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

  #  Set a blazingly fast keyboard repeat rate, and make it happen more quickly.
  # defaults write NSGlobalDomain InitialKeyRepeat -int 20
  # defaults write NSGlobalDomain KeyRepeat -int 1

  #  Disable auto-correct
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
}


function miscellaneous_tweaks {
  status_msg "1" "Custom Miscellaneous OS tweaks"

  #  Always show scrollbars
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

  #  Set standby delay to 24 hours (default is 1 hour)
  #  You can check current values with `pmset -g`.
  sudo pmset -a standbydelay 86400

  #  Disable system sleep
  sudo pmset -a sleep 0

  #  Expand save panel by default
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  #  Expand print panel by default
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  #  Save to disk (not to iCloud) by default
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  #  Automatically quit printer app once the print jobs complete
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

  #  Disable the “Are you sure you want to open this application?” dialog
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  #  Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
  sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

  #  Restart automatically if the computer freezes
  sudo systemsetup -setrestartfreeze on

  #  Disable Notification Center
  # launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null
  #  To re-enable, run:
  # launchctl load -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist && open /System/Library/CoreServices/NotificationCenter.app/

  #  Disable game center
  launchctl unload /System/Library/LaunchAgents/com.apple.gamed.plist 2> /dev/null

  #  Disable smart quotes when typing
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

  #  Disable smart dashes when typing
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  #  Set the timezone; see `sudo systemsetup -listtimezones` for other values
  sudo systemsetup -settimezone "America/New_York" > /dev/null

  #  Enable AirDrop over Ethernet and on unsupported Macs running Lion
  defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

  #  Prevent Time Machine from prompting to use new hard drives as backup volume
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

  #  Prevent Photos from opening automatically when devices are plugged in
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
}


function screen_tweaks {
  status_msg "1" "Custom Screen tweaks"

  #  Set background to dark-grey color
  sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '/Library/Desktop Pictures/Solid Colors/Solid Gray Dark.png'"

  #  Password prompt after sleep or screen saver
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0

  #  Save screenshots to desktop as PNG, no shadows
  defaults write com.apple.screencapture location -string "${HOME}/Desktop"
  defaults write com.apple.screencapture type -string "png"
  defaults write com.apple.screencapture disable-shadow -bool true

  #  Enable subpixel font rendering on non-Apple LCDs
  defaults write NSGlobalDomain AppleFontSmoothing -int 2

  #  Enable HiDPI display modes
  sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
}


function ssd_tweaks {
  status_msg "1" "Custom SSD tweaks"

  #  Disable local Time Machine snapshots
  sudo tmutil disablelocal

  #  Disable hibernation (speeds up entering sleep mode)
  sudo pmset -a hibernatemode 0

  #  Remove the sleep image file to save disk space
  sudo rm /Private/var/vm/sleepimage
  #  Create a zero-byte file instead and make sure it can’t be rewritten
  sudo touch /Private/var/vm/sleepimage
  sudo chflags uchg /Private/var/vm/sleepimage

  # Disable the sudden motion sensor as it’s not useful for SSDs
  sudo pmset -a sms 0
}


function spotlight_tweaks {
  status_msg "1" "Custom Spotlight tweaks"

  #  Disable Spotlight indexing for any volume that gets mounted and has not yet
  #  been indexed before.
  #  Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
  sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

  # Restart spotlight
  killall mds > /dev/null 2>&1

  #  Make sure indexing is enabled for the main volume
  sudo mdutil -i on / > /dev/null

  #  Rebuild the index from scratch
  sudo mdutil -E / > /dev/null
}
