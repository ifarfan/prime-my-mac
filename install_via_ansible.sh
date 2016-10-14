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


#  Include libraries + variables
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $DIR/lib/_globals.sh


#  Update sudo timestamp until script is finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#  Header
echo " ${BLACK}-${NORMAL}  Bootstrap Go!"
echo " ${BLACK}-  ----------------------------------------${NORMAL}"

#  Install components
install_xcode_cli
install_pip 0
install_ansible
install_brew 0

#  Run ansible Provisioning
run_ansible_provisioning

#  Footer
echo " ${BLACK}-  ----------------------------------------${NORMAL}"
echo " ${BLACK}-${NORMAL}  Bootstrap Done!"
