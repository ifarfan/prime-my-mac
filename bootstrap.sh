#!/bin/bash

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
echo " -  Bootstrap Go!"
echo " - ---------------------"


#
#  Xcode CLI tools:
#
#  Tell "softwareupdate" that we were installing the CLI tool before and
#  will attempt install from scratch
#
#  With help from:
#  - https://github.com/timsutton/osx-vm-templates/blob/ce8df8a7468faa7c5312444ece1b977c1b2f77a4/scripts/xcode-cli-tools.sh
#
xcode-select -p > /dev/null 2>&1
XCODE_ERR_CODE=$(echo $?)

if [ "$XCODE_ERR_CODE" -ne 0 ]
then
	echo "[_] - Installing XCode Command Line Tools..."
	touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
	XCODE_CLT_VER=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
	softwareupdate -i "$XCODE_CLT_VER" -v
else
	echo "[X] - 'XCode Command Line Tools' already installed"
fi


#
#  pip:
#  Via "easy_install"
#
pip --version > /dev/null 2>&1
PIP_ERR_CODE=$(echo $?)

if [ "$PIP_ERR_CODE" -ne 0 ]
then
	echo "[_] - Installing pip..."
	sudo easy_install pip
else
	echo "[X] - 'pip' already installed"
fi


#
#  ansible:
#
ansible --version > /dev/null 2>&1
ANSIBLE_ERR_CODE=$(echo $?)

if [ "$ANSIBLE_ERR_CODE" -ne 0 ]
then
	echo "[_] - Installing ansible..."
	sudo pip install ansible --quiet
else
	echo "[X] - 'ansible' already installed"
fi


#
#  homebrew:
#  http://brew.sh/
#
brew --version > /dev/null 2>&1
BREW_ERR_CODE=$(echo $?)

if [ "$BREW_ERR_CODE" -ne 0 ]
then
	echo "[_] - Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo "[X] - 'homebrew' already installed"
fi


#  Exit
echo " - ---------------------"
echo " -  Bootstrap Done!"
exit 0
