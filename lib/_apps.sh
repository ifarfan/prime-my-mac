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


function google_chrome_app_tweaks {
  status_msg "1" "Custom Google Chrome.app tweaks"

  #  Disable sensitive and senseless swipe-based navigation
  defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

  #  Use the system print dialog
  defaults write com.google.Chrome DisablePrintPreview -bool true
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
  status_msg "1" "Safari.app tweaks"

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


function terminal_app_tweaks {
  status_msg "1" "Custom Terminal.app tweaks"

  #  Only use UTF-8 in Terminal.app
  #  For Terminal theme, see: https://github.com/geerlingguy/mac-dev-playbook
  defaults write com.apple.terminal StringEncodings -array 4
}
