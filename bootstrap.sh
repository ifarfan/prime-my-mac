#!/usr/bin/env bash
#  =============================================================================
#
#  B O O T S T R A P . S H
#
#  =============================================================================
#
#  Download repo and run install
#
#  To install:
#  curl -fsSL https://github.com/ifarfan/prime-my-mac/bootstrap.sh | bash
#
#  =============================================================================


#  Variables
TMP_DIR=~/.tmp_install
GIT_REPO=https://github.com/ifarfan/prime-my-mac.git


function install_xcode_cli {
  #
  #  Tell "softwareupdate" that we were installing the CLI tool before and will attempt to continue
  #  With help from https://github.com/timsutton/osx-vm-templates/blob/master/scripts/xcode-cli-tools.sh
  #
  XCODE_ERR_CODE=$(xcode-select -p > /dev/null 2>&1; echo $?)
  status_msg "$XCODE_ERR_CODE" "XCode Command Line Tools"

  if [ "$XCODE_ERR_CODE" -ne 0 ]
  then
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    XCODE_CLT_VER=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
    softwareupdate -i "$XCODE_CLT_VER" -v
    rm -rf /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  fi
}


function download_repo {
    #  Download repo and run install
    [[ -d "$TMP_DIR" ]] && cd $TMP_DIR && git pull > /dev/null 2>&1 || git clone ${GIT_REPO} $TMP_DIR/
    cd $TMP_DIR && ./install.sh
}


function install_all {
    install_xcode_cli
    download_repo
}

install_all
