#!/usr/bin/env bash
#  =============================================================================
#
#  I N S T A L L _ V I A _ A N S I B L E. S H
#
#  =============================================================================
#
#  Install of first set of OSX tools:
#  - Xcode CLI tools
#  - pip
#  - ansible
#  - homebrew
#
#  =============================================================================

#  Colors
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

#  Variables
TMP_DIR=~/.tmp
GIT_REPO=https://github.com/ifarfan/prime-my-mac.git


function status_msg {
	#
	#  Print package install status
	#
	[[ "$1" -ne 0 ]] && echo "${BLACK}[${RED}N${BLACK}]${NORMAL} Installing ${BLUE}$2${NORMAL}..." || echo "${BLACK}[${GREEN}Y${BLACK}]${NORMAL} ${BLUE}$2${NORMAL} installed"
}


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


function install_pip {
	#
	#  Install via "easy_install"
	#
	PIP_ERR_CODE=$(command -v pip > /dev/null 2>&1; echo $?)
	status_msg "$PIP_ERR_CODE" "pip"
	[[ "$PIP_ERR_CODE" -ne 0 ]] && sudo easy_install pip
}


function install_ansible {
	#
	#  https://www.ansible.com/
	#
	ANSIBLE_ERR_CODE=$(command -v ansible > /dev/null 2>&1; echo $?)
	status_msg "$ANSIBLE_ERR_CODE" "ansible"
	[[ "$ANSIBLE_ERR_CODE" -ne 0 ]] && sudo pip install ansible --quiet
}


function install_brew {
	#
	#  http://brew.sh/
	#
	BREW_ERR_CODE=$(command -v brew > /dev/null 2>&1; echo $?)
	status_msg "$BREW_ERR_CODE" "homebrew"
	[[ "$BREW_ERR_CODE" -ne 0 ]] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}


function install_git_repo {
	#
	#  Fetch repo with ansible playbook
	#
	status_msg 1 "Git repository"
	[[ -d "$TMP_DIR" ]] && cd $TMP_DIR && git pull && cd - > /dev/null 2>&1 || git clone ${GIT_REPO} $TMP_DIR/
}


function run_ansible_provisioning {
	#
	#  Run ansible playbook
	#
	status_msg 1 "ansible provisioning"
	# TODO: invoke playbook
}


function install_all {
	#  Get sudo password out of the way
	sudo -v

	echo " ${BLACK}-${NORMAL}  Bootstrap Go!"
	echo " ${BLACK}-  ----------------------------------------${NORMAL}"

	#  Install components
	install_xcode_cli
	install_pip
	install_ansible
	install_brew

	#  Get repo
	install_git_repo

	#  Run ansible Provisioning
	run_ansible_provisioning

	echo " ${BLACK}-  ----------------------------------------${NORMAL}"
	echo " ${BLACK}-${NORMAL}  Bootstrap Done!"
}

install_all
