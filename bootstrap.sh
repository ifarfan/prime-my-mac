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


function install_xcode_cli {
    XCODE_ERR_CODE=$(xcode-select -p > /dev/null 2>&1; echo $?)

    if [ "$XCODE_ERR_CODE" -ne 0 ]
    then
        echo "Installing XCode Command Line Tools..."

        #
        #  Tell "softwareupdate" that we were installing the CLI tool before and it will attempt to continue
        #  With help from https://github.com/timsutton/osx-vm-templates/blob/master/scripts/xcode-cli-tools.sh
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
    [[ -d "$TMP_DIR" ]] && cd $TMP_DIR && git pull > /dev/null 2>&1 || git clone ${GIT_REPO} $TMP_DIR/
    cd $TMP_DIR && ./install.sh --all
}


function install {
    install_xcode_cli
    download_and_run_repo
}

install
