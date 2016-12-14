#!/usr/bin/env bash
#  =============================================================================
#
#  M A I N . S H
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

#  Homebrew settings
export HOMEBREW_VERBOSE=0
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

#  Folders
APPLE_APPS_DIR='/Applications'
UTILS_APPS_DIR='/Applications/Utilities'

#  Determine if it's a laptop
#  SEE: http://arstechnica.com/civis/viewtopic.php?f=19&t=1118530
[[ "$(sysctl -n hw.model | grep -q -i book; echo $?)" -eq 0 ]] && IS_LAPTOP=true || IS_LAPTOP=false


function status_msg {
  #
  #  Print package install status
  #
  if [[ "$1" -ne 0 ]]
  then
    echo "${BOLD}[${RED}N${BOLD}]${NORMAL} Installing ${BLUE}$2${NORMAL}..."
    osascript \
      -e "on run(argv)" \
      -e "  return display notification \"Installing \" & item 1 of argv with title \"prime-my-mac\"  subtitle \"...\"" \
      -e "end" \
      -- "$2"
  else
    echo "${BOLD}[${GREEN}Y${BOLD}]${NORMAL} ${BLUE}$2${NORMAL} installed"
    osascript \
      -e "on run(argv)" \
      -e "  return display notification item 1 of argv & \" installed\" with title \"prime-my-mac\"  subtitle \"...\"" \
      -e "end" \
      -- "$2"
  fi
}


function install_homebrew {
  #
  #  http://brew.sh/
  #
  local BREW_ERR_CODE=$(command -v brew > /dev/null 2>&1; echo $?)
  status_msg "$BREW_ERR_CODE" "homebrew"
  [[ "$BREW_ERR_CODE" -ne 0 ]] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  #  Copy aggresive .curl file to manage brew installs
  cp -n "./files/_curlrc_brew" "${HOME}/.curl"
}


function install_pip {
  install_homebrew

  local PYTHON_ERR_CODE=$(brew list | grep -q python; echo $?)

  status_msg "$PYTHON_ERR_CODE" "python"
  if [ "${PYTHON_ERR_CODE}" -ne 0 ]
  then
    #  Install latest version of Python
    brew install python

    #  Update pip + setuptools
    status_msg "$PYTHON_ERR_CODE" "pip + setuptools"
    pip install --upgrade pip setuptools
  fi

  #  Install pip packages
  for pkg in "${pip_pkgs[@]}"
  do
    pip install $pkg --quiet
  done
}


function install_brew {
  install_homebrew

  #  Install packages
  for pkg in "${brew_pkgs[@]}"
  do
     brew install ${pkg}
  done
}


function install_brew_cask {
  install_homebrew

  #  Install cask packages
  brew tap "caskroom/cask"
  for pkg in "${cask_pkgs[@]}"
  do

    if [[ ${pkg} =~ ":" ]]
    then
      #  Get package extra-attributes
      pkg_name=$(echo ${pkg}   | cut -d ':' -f1)
      pkg_atribs=$(echo ${pkg} | cut -d ':' -f2)

      # #  Utilities go to their sub-folder
      # [[ ${pkg_atribs} =~ "u" ]] && UTIL_PATH="--appdir=/Applications/Utilities" || UTIL_PATH=""

      if [[ ${pkg_atribs} =~ "l" ]]
      then
        # Laptop only packages
        # [[ $IS_LAPTOP == true ]] && brew cask install ${UTIL_PATH} ${pkg_name}
        [[ $IS_LAPTOP == true ]] && brew cask install ${pkg_name}
      else
        # brew cask install ${UTIL_PATH} ${pkg_name}
        brew cask install ${pkg_name}
      fi
    else
      #  Standard package
      brew cask install ${pkg}
    fi
  done
}


function install_brew_fonts {
  install_homebrew

  #  Install cask fonts
  brew tap "caskroom/fonts"
  for font in "${cask_fonts[@]}"
  do
    brew cask install font-$font
  done
}


function move_apple_apps {
  if [ "${#apple_apps[@]}" -gt 0 ]
  then
    cd ${APPLE_APPS_DIR}
    [[ ! -d "Apple" ]] && sudo mkdir "Apple"

    for app in "${apple_apps[@]}"
    do
       [[ -d "${app}.app" ]] && sudo mv "${app}.app" "${APPLE_APPS_DIR}/Apple/"
    done
    cd -
  fi
}


function dir_colors {

  pushd . > /dev/null 2>&1      #  Mark location

  if [ -d "${HOME}/.dircolors-solarized" ]
  then
    status_msg "0" "dircolors"
    cd "${HOME}/.dircolors-solarized" && git pull
  else
    status_msg "1" "dircolors"
    git clone --recursive https://github.com/seebi/dircolors-solarized.git ${HOME}/.dircolors-solarized
  fi

  #  Symlink to theme
  [[ ! -f "${HOME}/.dircolors" ]] && ln -s "${HOME}/.dircolors-solarized/dircolors.256dark" "${HOME}/.dircolors"

  popd > /dev/null 2>&1           #  Return to project root
}


function install_prezto {
  dir_colors

  pushd . > /dev/null 2>&1        #  Mark location

  if [ -d "${HOME}/.zprezto" ]
  then
    status_msg "0" "prezto"

    cd "${HOME}/.zprezto" && git pull && git submodule update --init --recursive
  else
    status_msg "1" "prezto"

    git clone --recursive https://github.com/sorin-ionescu/prezto.git ${HOME}/.zprezto
    rcfiles=(${HOME}/.zprezto/runcoms/z*)
    for rcfile in "${rcfiles[@]}"
    do
      ln -s "$rcfile" "${HOME}/.${rcfile##*/}"
    done
    chsh -s /bin/zsh
  fi

  popd > /dev/null 2>&1           #  Return to project root

  #  Copy over customizations
  for zshfile in zshrc zpreztorc
  do
    cp -p "./files/prezto/_${zshfile}" "${HOME}/.zprezto/runcoms/${zshfile}"
  done

  #  Custom theme
  cp -p "./files/prezto/agnoster.zsh-theme" "${HOME}/.zprezto/modules/prompt/external/agnoster/agnoster.zsh-theme"
}


function install_bash_it {
  status_msg "1" "bash-it"

  dir_colors

  if [ -d "${HOME}/.bash_it" ]
  then
    bash-it update
  else
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ${HOME}/.bash_it
    ${HOME}/.bash_it/install.sh
  fi
  chsh -s /bin/bash
}

function install_dotfiles {
  #  With lots of help from:
  #  - https://github.com/chr4/shellrc
  #  - https://github.com/sorin-ionescu/dotfiles
  cp -R ./files/dotfiles "${HOME}/.dotfiles"

  #  Activate .dotfiles
  for dotfile in bashrc bash_profile inputrc zshrc zlogin
  do
    ln -sf .dotfiles/${dotfile} .${dotfile}
  done
}
