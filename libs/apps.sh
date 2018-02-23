#!/usr/bin/env bash

#  =============================================================================
#
#  A P P S . S H
#
#  =============================================================================


function activity_monitor_config {
    status_msg "0" "Custom Activity Monitor.app config"

    #  Show the main window when launching Activity Monitor
    defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

    #  Visualize CPU usage in the Activity Monitor Dock icon
    defaults write com.apple.ActivityMonitor IconType -int 5

    #  Show all processes in Activity Monitor
    defaults write com.apple.ActivityMonitor ShowCategory -int 0
}


function electric_sheep_config {
    status_msg "0" "Custom Electric Sheep.app config"

    local ES_FILE="/Library/Screen Savers/Electric Sheep.saver"
    if [ -d "${ES_FILE}" ]; then
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


function git_config {
    status_msg "0" "Git configs"

    #  Copy configs
    mkdir -p "${HOME}/.git"
    for gitfile in ./files/git/_*; do
        gitfile=$(basename ${gitfile} | sed 's/^_\(.*\)/\1/')
        cp -p "./files/git/_${gitfile}" "${HOME}/.git/.${gitfile}"
    done

    #  Symlink to configs
    [[ ! -f "${HOME}/.gitconfig"        ]] && ln -s "${HOME}/.git/.gitconfig"        "${HOME}/.gitconfig"
    [[ ! -f "${HOME}/.gitignore_global" ]] && ln -s "${HOME}/.git/.gitignore_global" "${HOME}/.gitignore_global"
}


function google_chrome_config {
    status_msg "0" "Custom Google Chrome.app config"

    #  Copy master_preferences file for automated install on first use
    #  https://support.google.com/chrome/a/answer/187948
    #  https://support.google.com/chrome/a/answer/188453
    cp -n ./files/chrome_master_preferences.json '/Applications/Google Chrome.app/Contents/MacOS/master_preferences'

    local CHROME_PLIST="$HOME/Library/Preferences/com.google.Chrome.plist"
    if [ -f $CHROME_PLIST ]; then

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


function istatmenus_config {
    status_msg "0" "Custom iStat Menus.app config"
}


function iterm2_config {
#
#  See:
#  http://www.starkandwayne.com/blog/tweaking-iterm2-and-playing-with-plists/
#  https://github.com/fnichol/macosx-iterm2-settings
#  http://www.real-world-systems.com/docs/PlistBuddy.1.html
#  https://iterm2.com/documentation-hidden-settings.html
#
    local ITERM2_PLIST="${HOME}/Library/Preferences/com.googlecode.iterm2.plist"
    if [ -f ${ITERM2_PLIST} ]; then
        status_msg "0" "Custom iTerm2.app config"

        defaults write com.googlecode.iterm2 CursorType -bool false
        defaults write com.googlecode.iterm2 DimInactiveSplitPanes -bool true
        defaults write com.googlecode.iterm2 HideTab -bool false
        defaults write com.googlecode.iterm2 HighlightTabLabels -bool true
        defaults write com.googlecode.iterm2 NoSyncDoNotWarnBeforeMultilinePaste -bool true
        defaults write com.googlecode.iterm2 NoSyncDoNotWarnBeforeMultilinePaste_selection -bool false
        defaults write com.googlecode.iterm2 NoSyncNeverAskAboutSettingAlternateMouseScroll -bool true
        defaults write com.googlecode.iterm2 NoSyncPermissionToShowTip -bool false
        defaults write com.googlecode.iterm2 OnlyWhenMoreTabs -bool true
        defaults write com.googlecode.iterm2 PromptOnQuit -bool false
        defaults write com.googlecode.iterm2 QuitWhenAllWindowsClosed -bool true
        defaults write com.googlecode.iterm2 SUEnableAutomaticChecks -bool true
        defaults write com.googlecode.iterm2 SUSendProfileInfo -bool false
        defaults write com.googlecode.iterm2 UseBorder -bool true
        defaults write com.googlecode.iterm2 WindowNumber -bool true;

        #  Determine if Bookmarks have been set on plist file
        local NB_ERR_CODE=$(defaults read com.googlecode.iterm2 "New Bookmarks" > /dev/null 2>&1; echo $?)

        for bookmark in "${iterm_bookmark_settings[@]}"; do
            if [ ${NB_ERR_CODE} -eq 0 ]; then
                #  Update pre-existing Bookmark key
                /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"${bookmark[key_name]}\" \"${bookmark[key_value]}\"" $ITERM2_PLIST
            else
                #  Add new Bookmark key
                /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"${bookmark[key_value]}\" ${bookmark[key_type]} \"${bookmark[key_value]}\"" $ITERM2_PLIST
            fi
        done


        # if [ ${NB_ERR_CODE} -eq 0 ]; then
        #     #  Set Unlimited scrollback
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Unlimited Scrollback\" \"1\"" $ITERM2_PLIST

        #     #  Set new font
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Normal Font\" \"UbuntuMonoDerivativePowerline-Regular 16\"" $ITERM2_PLIST

        #     #  Set Transparency
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Transparency\" \"0.095800\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Blur\" \"false\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Blur Radius\" \"5.331800\"" $ITERM2_PLIST

        #     #  Set Background
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Background Color\":\"Red Component\"   \"0.072200\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Background Color\":\"Blue Component\"  \"0.072900\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Background Color\":\"Green Component\" \"0.091000\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Background Color\":\"Alpha Component\" \"1.000000\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Background Color\":\"Color Space\" \"Calibrated\"" $ITERM2_PLIST

        #     #  Set Selection Color
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Selection Color\":\"Red Component\"   \"0.087800\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Selection Color\":\"Blue Component\"  \"0.094300\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Selection Color\":\"Green Component\" \"0.267500\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Selection Color\":\"Alpha Component\" \"1.000000\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Set :\"New Bookmarks\":0:\"Selection Color\":\"Color Space\" \"Calibrated\"" $ITERM2_PLIST
        # else
        #     #  Create new profile
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Name\" string \"Default\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Description\" string \"Default\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Working Directory\" string \"${HOME}\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Terminal Type\" string \"xterm-256color\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Silence Bell\" integer \"0\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Visual Bell\" integer \"1\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Flashing Bell\" integer \"0\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Rows\" integer \"25\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Columns\" integer \"80\"" $ITERM2_PLIST

        #     #  Add Unlimited scrollback
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Unlimited Scrollback\" integer \"1\"" $ITERM2_PLIST

        #     #  Add new font
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Normal Font\" string \"UbuntuMonoDerivativePowerline-Regular 16\"" $ITERM2_PLIST

        #     #  Add Transparency
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Transparency\" real \"0.095800\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Blur\" bool \"false\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Blur Radius\" real \"5.331800\"" $ITERM2_PLIST

        #     #  Add Background
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Background Color\":\"Red Component\"   real \"0.072200\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Background Color\":\"Blue Component\"  real \"0.072900\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Background Color\":\"Green Component\" real \"0.091000\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Background Color\":\"Alpha Component\" real \"1.000000\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Background Color\":\"Color Space\" string \"Calibrated\"" $ITERM2_PLIST

        #     #  Add Selection Color
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Selection Color\":\"Red Component\"   real \"0.087800\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Selection Color\":\"Blue Component\"  real \"0.094300\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Selection Color\":\"Green Component\" real \"0.267500\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Selection Color\":\"Alpha Component\" real \"1.000000\"" $ITERM2_PLIST
        #     /usr/libexec/PlistBuddy -c "Add :\"New Bookmarks\":0:\"Selection Color\":\"Color Space\" string \"Calibrated\"" $ITERM2_PLIST
        # fi
    fi

    #  Enable iTerm2 shell integration
    curl -L https://iterm2.com/misc/install_shell_integration_and_utilities.sh | bash
}


function itunes_config {
    status_msg "0" "Custom iTunes.app config"

    #  Disable the Ping sidebar in iTunes (default: false).
    defaults write com.apple.iTunes disablePingSidebar -bool true

    #  Disable all the other Ping stuff in iTunes (default: false).
    defaults write com.apple.iTunes disablePing -bool true

    #  Enable half-star ratings
    defaults write com.apple.iTunes allow-half-stars -bool true

    #  Enable notifications in the dock with album logo
    defaults write com.apple.dock itunes-notifications -bool true
    defaults write com.apple.dock notification-always-show-image -bool true

    #  Restart dock for settings to take effect
    killall Dock
}


function mail_config {
    status_msg "0" "Custom Mail.app config"

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


function messages_config {
    status_msg "0" "Custom Messages.app config"

    #  Disable automatic emoji substitution (i.e. use plain text smileys)
    # defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

    #  Disable smart quotes as it’s annoying for messages that contain code
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

    #  Disable continuous spell checking
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false
}


function safari_config {
    status_msg "0" "Custom Safari.app config"

    #  Set Safari’s home page to `about:blank` for faster loading
    defaults write com.apple.Safari HomePage -string "about:blank"

    #  Prevent Safari from opening ‘safe’ files automatically after downloading
    defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

    #  Show status bar at bottom to view URLs links on hover
    defaults write com.apple.Safari 'ShowStatusBar' -bool true

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


function sublime_text_config {
    #  Confirm Sublime-Text was installed by homebrew
    local SUBL_ERR_CODE=$(brew cask list sublime-text > /dev/null 2>&1; echo $?)
    if [ ${SUBL_ERR_CODE} -eq 0 ]; then
        status_msg "0" "Custom Sublime Text.app config"

        pushd . > /dev/null 2>&1        #  Mark location

        #  Make config folders
        SUBL_CFG_DIR="${HOME}/Library/Application Support/Sublime Text 3"
        mkdir -p "${SUBL_CFG_DIR}/Installed Packages"
        mkdir -p "${SUBL_CFG_DIR}/Packages/User"

        #  Download Sublime Pkg Manager
        if [ ! -f "${SUBL_CFG_DIR}/Installed Packages/Package Control.sublime-package" ]; then
            cd "${SUBL_CFG_DIR}/Installed Packages"
            SUBL_PKG_URL='http://sublime.wbond.net/Package%20Control.sublime-package'
            PKG_FILE=$(curl --silent --output "Package Control.sublime-package" "${SUBL_PKG_URL}")
        fi

        popd > /dev/null 2>&1           #  Return to project root

        #  Copy User Files
        rsync -a -v --ignore-existing "./files/Sublime Text 3/" "${SUBL_CFG_DIR}/"
    fi
}


function terminal_config {
    status_msg "0" "Custom Terminal.app config"

    #  Only use UTF-8 in Terminal.app
    #  For Terminal theme, see: https://github.com/geerlingguy/mac-dev-playbook
    defaults write com.apple.terminal StringEncodings -array 4
}


function timemachine_config {
    status_msg "0" "Custom TimeMachine.app config"

    #  Prevent Time Machine from prompting to use new hard drives as backup volume
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    #  Set TimeMachine backup to every 4 hours (set in seconds)
    sudo defaults write /System/Library/LaunchDaemons/com.apple.backupd-auto StartInterval -int 14400
}
