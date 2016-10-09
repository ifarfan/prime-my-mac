#!/usr/bin/env bash

#=======================================================================
#
#  B O O T S T R A P . S H
#
#=======================================================================
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
#=======================================================================

function status_msg {
	#
	#  status_msg: Print package install status
	#
	[[ "$1" -ne 0 ]] && echo "[_] - Installing '$2'..." || echo "[X] - '$2' already installed"
}


function xcode_cli_install {
	#
	#  Xcode CLI tools:
	#
	#  Tell "softwareupdate" that we were installing the CLI tool before and will attempt install from scratch
	#
	#  With help from:
	#  - https://github.com/timsutton/osx-vm-templates/blob/ce8df8a7468faa7c5312444ece1b977c1b2f77a4/scripts/xcode-cli-tools.sh
	#
	XCODE_ERR_CODE=$(command -v xcode-select > /dev/null 2>&1; echo $?)
	status_msg "$XCODE_ERR_CODE" "XCode Command Line"

	if [ "$XCODE_ERR_CODE" -ne 0 ]
	then
		touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
		XCODE_CLT_VER=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
		softwareupdate -i "$XCODE_CLT_VER" -v
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
	echo " -  Bootstrap Go!"
	echo " - ---------------------"

	#  Packages
	xcode_cli_install
	pip_install
	ansible_install
	brew_install

	#  Exit
	echo " - ---------------------"
	echo " -  Bootstrap Done!"
}

all_install
exit 0
