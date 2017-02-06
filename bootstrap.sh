#!/usr/bin/env bash
#  =============================================================================
#
#  B O O T S T R A P . S H
#
#  =============================================================================
#
#  Install XCode CLI Tools
#  Download repo and run install
#
#  To install:
#  curl -fsSL https://github.com/ifarfan/prime-my-mac/bootstrap.sh | bash
#
#  =============================================================================


#  Variables
REPO_NAME=prime-my-mac
TMP_DIR=${HOME}/.${REPO_NAME}
GIT_REPO=https://github.com/ifarfan/${REPO_NAME}.git


function warning_message {
cat << EOF
            .:'
        __ :'__
     .'\`  \`-'  \`\`.
    :          .-'
    :         :
     :         \`-;
      \`.__.-.__.'


.: PRIME-MY-MAC :.

I know, that logo was cheesy.... but anyways.

Whenever you are ready, press enter (or Ctrl+C, if you changed your mind) and let the installer run.

Be forewarned that this installer is intended for a "virgin" machine with nothing yet configured on it.

Be prepared, as well, to enter your password --when needed-- so that it can perform root-level tasks.

Once the installer has finished, a reboot is in order.

With the above being said: sit back, relax and let the machine do the "brunt" of the work for you.

EOF
    read -p "Press [Enter] to continue... " -n1 -s
}


function install_xcode_cli {
    XCODE_ERR_CODE=$(xcode-select -p > /dev/null 2>&1; echo $?)

    if [ "$XCODE_ERR_CODE" -ne 0 ]; then
        echo "Installing XCode Command Line Tools..."
        osascript  -e "display notification \"Installing XCode Command Line Tools...\" with title \"prime-my-mac\"  subtitle \"...\""

        #
        #  Trick "softwareupdate" into assuming that we were installing the CLI tool before and it will attempt to continue
        #  With lots of help from https://github.com/timsutton/osx-vm-templates/blob/master/scripts/xcode-cli-tools.sh
        #
        touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
        XCODE_CLT_VER=$(softwareupdate --list | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
        softwareupdate --instal "$XCODE_CLT_VER" --verbose
        rm -rf /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    fi
}


function download_and_run_repo {
    #
    #  Download repo and run install
    #
    osascript  -e "display notification \"Downloading git repo and running install...\" with title \"prime-my-mac\"  subtitle \"...\""

    [[ -d "$TMP_DIR" ]] && cd $TMP_DIR && git pull > /dev/null 2>&1 || git clone ${GIT_REPO} $TMP_DIR/
    cd $TMP_DIR && ./install.sh --all
}


function install {
    warning_message
    install_xcode_cli
    download_and_run_repo
}

install
