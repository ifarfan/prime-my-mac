#!/usr/bin/env bash
#  =============================================================================
#
#  B O O T S T R A P . S H
#
#  =============================================================================
#
#  Bootstrap install of first set of OSX tools:
#  - Xcode CLI tools
#  - pip
#  - ansible
#  - homebrew
#
#  To install:
#  curl -fsSL https://github.com/ifarfan/prime-my-mac/bootstrap.sh | bash
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


function status_msg {
	#
	#  status_msg: Print package install status
	#
	[[ "$1" -ne 0 ]] && echo "${BLACK}[${RED}N${BLACK}]${NORMAL} Installing ${BLUE}$2${NORMAL}..." || echo "${BLACK}[${GREEN}Y${BLACK}]${NORMAL} ${BLUE}$2${NORMAL} already installed"
}


function xcode_cli_install {
	#
	#  Xcode CLI tools:
	#  Tell "softwareupdate" that we were installing the CLI tool before and will attempt to continue
	#
	#  With help from: https://github.com/timsutton/osx-vm-templates/blob/master/scripts/xcode-cli-tools.sh
	#
	XCODE_ERR_CODE=$(command -v xcode-select > /dev/null 2>&1; echo $?)
	status_msg "$XCODE_ERR_CODE" "XCode Command Line Tools"

	if [ "$XCODE_ERR_CODE" -ne 0 ]
	then
		touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
		XCODE_CLT_VER=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
		softwareupdate -i "$XCODE_CLT_VER" -v
		rm -rf /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
	fi
}


function pip_install {
	#
	#  pip: via "easy_install"
	#
	PIP_ERR_CODE=$(command -v pip > /dev/null 2>&1; echo $?)
	status_msg "$PIP_ERR_CODE" "pip"
	[[ "$PIP_ERR_CODE" -ne 0 ]] && sudo easy_install pip
}


function ansible_install {
	#
	#  ansible: https://www.ansible.com/
	#
	ANSIBLE_ERR_CODE=$(command -v ansible > /dev/null 2>&1; echo $?)
	status_msg "$ANSIBLE_ERR_CODE" "ansible"
	[[ "$ANSIBLE_ERR_CODE" -ne 0 ]] && sudo pip install ansible --quiet
}


function brew_install {
	#
	#  homebrew: http://brew.sh/
	#
	BREW_ERR_CODE=$(command -v brew > /dev/null 2>&1; echo $?)
	status_msg "$BREW_ERR_CODE" "homebrew"
	[[ "$BREW_ERR_CODE" -ne 0 ]] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}


function all_install {
	echo " ${BLACK}-${NORMAL}  Bootstrap Go!"
	echo " ${BLACK}-  ----------------------------------------${NORMAL}"

	#  Packages
	xcode_cli_install
	pip_install
	ansible_install
	brew_install

	echo " ${BLACK}-  ----------------------------------------${NORMAL}"
	echo " ${BLACK}-${NORMAL}  Bootstrap Done!"
}

all_install
