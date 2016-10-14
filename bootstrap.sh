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

#  Download repo and run install
[[ -d "$TMP_DIR" ]] && cd $TMP_DIR && git pull > /dev/null 2>&1 || git clone ${GIT_REPO} $TMP_DIR/
cd $TMP_DIR && ./install_via_shell.sh
