#!/usr/bin/env bash
#  =============================================================================
#
#  _ A P P S . S H
#
#  =============================================================================


function activity_monitor_app_tweaks {
  status_msg "1" "Custom Activity Monitor.app tweaks"

  #  Show the main window when launching Activity Monitor
  defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

  #  Visualize CPU usage in the Activity Monitor Dock icon
  defaults write com.apple.ActivityMonitor IconType -int 5

  #  Show all processes in Activity Monitor
  defaults write com.apple.ActivityMonitor ShowCategory -int 0
}


function electric_sheep_app_tweaks {
  status_msg "1" "Custom Electric Sheep.app tweaks"

  ES_FILE="/Library/Screen Savers/Electric Sheep.saver"
  if [ -f "${ES_FILE}" ]
  then
    defaults -currentHost write com.apple.screensaver 'CleanExit' -string "YES"
    defaults -currentHost write com.apple.screensaver 'PrefsVersion' -int "100"
    defaults -currentHost write com.apple.screensaver 'idleTime' -int "600"
    defaults -currentHost write com.apple.screensaver "moduleDict" -dict-add "moduleName" -string "Electric Sheep"
    defaults -currentHost write com.apple.screensaver "moduleDict" -dict-add "path" -string "${ES_FILE}"
    defaults -currentHost write com.apple.screensaver "moduleDict" -dict-add "type" -int "0"
    defaults -currentHost write com.apple.screensaver 'ShowClock' -bool "false"
    defaults -currentHost write com.apple.screensaver 'tokenRemovalAction' -int "0"

    killall cfprefsd
  fi
}


function git_app_tweaks {
  #  Copy git global config files
  cp -n ./files/_gitignore_global ${HOME}/.gitignore_global
  cp -n ./files/_gitconfig        ${HOME}/.gitconfig

  #  Set global, custom git config values
  for key in "${git_custom_config[@]}"
  do
     git config --global "${key%%:*}" "${key#*:}"
  done
}


function google_chrome_app_tweaks {
  status_msg "1" "Custom Google Chrome.app tweaks"

  CHROME_PLIST="~/Library/Preferences/com.google.Chrome.plist"
  if [ -f $CHROME_PLIST ]
  then

    #  Allow installing user scripts via GitHub Gist or Userscripts.org
    defaults write com.google.Chrome ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"

    #  Disable the all too sensitive backswipe on trackpads
    defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

    #  Disable the all too sensitive backswipe on Magic Mouse
    defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false

    #  Use the system-native print preview dialog
    defaults write com.google.Chrome DisablePrintPreview -bool true

    #  Expand the print dialog by default
    defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
  fi
}


function istatmenus_tweaks {
  status_msg "1" "Custom iStat Menus.app tweaks"
}


function iterm2_tweaks {
#  http://www.starkandwayne.com/blog/tweaking-iterm2-and-playing-with-plists/
#  https://github.com/fnichol/macosx-iterm2-settings
  ITERM2_PLIST="~/Library/Preferences/com.googlecode.iterm2.plist"
  if [ -f $ITERM2_PLIST ]
  then
    status_msg "1" "Custom iTerm2.app tweaks"

    defaults write com.googlecode.iterm2 CursorType -bool false
    defaults write com.googlecode.iterm2 DimInactiveSplitPanes -bool true
    defaults write com.googlecode.iterm2 HideTab -bool false
    defaults write com.googlecode.iterm2 HighlightTabLabels -bool true
    defaults write com.googlecode.iterm2 NoSyncDoNotWarnBeforeMultilinePaste -bool true
    defaults write com.googlecode.iterm2 "NoSyncDoNotWarnBeforeMultilinePaste_selection" -bool false
    defaults write com.googlecode.iterm2 NoSyncNeverAskAboutSettingAlternateMouseScroll -bool true
    defaults write com.googlecode.iterm2 NoSyncPermissionToShowTip -bool false
    defaults write com.googlecode.iterm2 OnlyWhenMoreTabs -bool true
    defaults write com.googlecode.iterm2 PromptOnQuit -bool false
    defaults write com.googlecode.iterm2 QuitWhenAllWindowsClosed -bool true
    defaults write com.googlecode.iterm2 SUEnableAutomaticChecks -bool true
    defaults write com.googlecode.iterm2 SUSendProfileInfo -bool false
    defaults write com.googlecode.iterm2 UseBorder -bool true
    defaults write com.googlecode.iterm2 WindowNumber -bool true;

    #  Set new font
    /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Normal Font\" \"UbuntuMonoDerivativePowerline-Regular 16\"" $ITERM2_PLIST
  fi
}


function mail_app_tweaks {
  status_msg "1" "Custom Mail.app tweaks"

  #  Disable send and reply animations in Mail.app
  defaults write com.apple.mail DisableReplyAnimations -bool true
  defaults write com.apple.mail DisableSendAnimations -bool true

  #  Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
  defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

  #  Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
  # defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

  #  Display emails in threaded mode
  defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
  # defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
  # defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

  #  Disable inline attachments (just show the icons)
  defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

  #  Disable spell checking
  # defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"
}


function messages_app_tweaks {
  status_msg "1" "Custom Messages.app tweaks"

  #  Disable automatic emoji substitution (i.e. use plain text smileys)
  # defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

  #  Disable smart quotes as it’s annoying for messages that contain code
  defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

  #  Disable continuous spell checking
  defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false
}


function safari_app_tweaks {
  status_msg "1" "Custom Safari.app tweaks"

  #  Set Safari’s home page to `about:blank` for faster loading
  defaults write com.apple.Safari HomePage -string "about:blank"

  #  Prevent Safari from opening ‘safe’ files automatically after downloading
  defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

  #  Disable Safari’s thumbnail cache for History and Top Sites
  defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

  #  Enable Safari’s debug menu
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

  #  Enable the Develop menu and the Web Inspector in Safari
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

  #  Add a context menu item for showing the Web Inspector in web views
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
}


function sublime_text_tweaks {
  #  Confirm Sublime-Text was installed by homebrew
  SUBL_ERR_CODE=$(brew cask list sublime-text > /dev/null 2>&1; echo $?)
  if [ ${SUBL_ERR_CODE} -eq 0 ]
  then
    status_msg "1" "Custom Sublime Text.app tweaks"

    #  Make config folders
    SUBL_CFG_DIR="${HOME}/Library/Application Support/Sublime Text 3"
    mkdir -p "${SUBL_CFG_DIR}/Installed Packages"
    mkdir -p "${SUBL_CFG_DIR}/Packages/User"

    #  Download Sublime Pkg Manager
    if [ ! -f "${SUBL_CFG_DIR}/Installed Packages/Package Control.sublime-package" ]
    then
      cd "${SUBL_CFG_DIR}/Installed Packages"
      SUBL_PKG_URL = 'http://sublime.wbond.net/Package%20Control.sublime-package'
      PKG_FILE=$(curl -silent -output "Package Control.sublime-package" "${SUBL_PKG_URL}")
    fi

    #  Copy User Files
    rsync -a -v --ignore-existing "./files/Sublime Text 3/" "${SUBL_CFG_DIR}/"
  fi
}


function terminal_app_tweaks {
  status_msg "1" "Custom Terminal.app tweaks"

  #  Only use UTF-8 in Terminal.app
  #  For Terminal theme, see: https://github.com/geerlingguy/mac-dev-playbook
  defaults write com.apple.terminal StringEncodings -array 4
}
