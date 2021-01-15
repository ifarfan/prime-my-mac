#!/usr/bin/env bash

#
#  M A I N . S H
#


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

#  Determine if it's a laptop
#  SEE: http://arstechnica.com/civis/viewtopic.php?f=19&t=1118530
[[ "$(sysctl -n hw.model | grep -q -i book; echo $?)" -eq 0 ]] && IS_LAPTOP=true || IS_LAPTOP=false

#  Determine OS minor version
#  SEE: https://coderwall.com/p/4yz8dq/determine-os-x-version-from-the-command-line
OS_MINOR=$(defaults read loginwindow SystemVersionStampAsString | cut -d'.' -f2)

function status_msg {
    #
    #  Print package install status
    #
    if [[ "$1" -ne 0 ]]; then
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
    [ "$BREW_ERR_CODE" -ne 0 ] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    #  Copy aggresive .curl file to optimize brew installs
    cp -n "./files/dotfiles/.curl" "${HOME}/.curl"
}


function install_pip {
    install_homebrew

    local PYTHON_ERR_CODE=$(brew list --formula | grep -q python; echo $?)

    status_msg "$PYTHON_ERR_CODE" "python"
    if [ "${PYTHON_ERR_CODE}" -ne 0 ]; then
        #  Install latest version of Python
        brew install python

        #  Update pip + setuptools
        status_msg "$PYTHON_ERR_CODE" "pip + setuptools"
        pip3 install --upgrade pip setuptools
    fi

    #  Install pip packages
    for pkg in "${pip_pkgs[@]}"; do
        /usr/local/opt/python@3.9/bin/pip3 install $pkg --quiet
    done
}


function install_brew {
    install_homebrew

    #  Install packages
    for pkg in "${brew_pkgs[@]}"; do
        brew install ${pkg}
    done
}


function install_brew_cask {
    install_homebrew

    #  Install cask packages
    brew tap homebrew/cask
    for pkg in "${cask_pkgs[@]}"; do

        if [[ ${pkg} =~ ":" ]]; then
            #  Get package extra-attributes
            pkg_name=$(echo ${pkg}   | cut -d ':' -f1)
            pkg_atribs=$(echo ${pkg} | cut -d ':' -f2)

            if [[ ${pkg_atribs} =~ "l" ]]; then
                # Laptop only packages
                [[ $IS_LAPTOP == true ]] && brew install --cask ${pkg_name}
            else
                brew install --cask ${pkg_name}
            fi
        else
            #  Standard package
            brew install --cask ${pkg}
        fi
    done
}


function install_brew_fonts {
    install_homebrew

    #  A few fonts still run under svn
    brew install svn

    #  Install cask fonts
    brew tap homebrew/cask-fonts
    for font in "${cask_fonts[@]}"; do
        brew install --cask font-$font
    done
}


function install_prezto {
    status_msg "1" "prezto"

    if [ -d "${HOME}/.zprezto" ]; then
        status_msg "0" "prezto"

        pushd . > /dev/null 2>&1        #  Mark location
        cd "${HOME}/.zprezto" && git fetch --all && git reset --hard origin/master && git submodule update --init --recursive
        popd > /dev/null 2>&1           #  Return to project root
    else
        status_msg "1" "prezto"

        #  Install prezto + change shell to zsh
        git clone --recursive https://github.com/sorin-ionescu/prezto.git ${HOME}/.zprezto
        rcfiles=(${HOME}/.zprezto/runcoms/z*)
        for rcfile in "${rcfiles[@]}"; do
            ln -s "$rcfile" "${HOME}/.${rcfile##*/}"
        done
        chsh -s /bin/zsh
    fi
}


function install_bash_it {
    status_msg "1" "bash-it"

    if [ -d "${HOME}/.bash_it" ]; then
        bash-it update
    else
        git clone --depth=1 https://github.com/Bash-it/bash-it.git ${HOME}/.bash_it
        ${HOME}/.bash_it/install.sh
    fi
    chsh -s /bin/bash

    #  Install Docker autocomplete
    for d in docker docker-machine docker-compose; do
        ln -s "/Applications/Docker.app/Contents/Resources/etc/${d}.bash-completion" "/usr/local/etc/bash_completion.d/${d}.bash-completion"
    done
}


function install_dotfiles {
    #
    #  nano syntax-highlight
    #
    if [ -f "${HOME}/.nanorc" ]; then
        status_msg "0" "nano"
        pushd . > /dev/null 2>&1
        cd "${HOME}/.nano" && git fetch --all && git reset --hard origin/master
        popd > /dev/null 2>&1
    else
        status_msg "1" "nano"
        git clone https://github.com/scopatz/nanorc.git ${HOME}/.nano
        ln -s ${HOME}/.nano/nanorc ${HOME}/.nanorc
    fi

    #
    #  dircolors
    #
    if [ -f "${HOME}/.dircolors" ]; then
        status_msg "0" "dircolors"

        pushd . > /dev/null 2>&1
        cd "${HOME}/.dircolors-solarized" && git fetch --all && git reset --hard origin/master
        popd > /dev/null 2>&1
    else
        status_msg "1" "dircolors"
        git clone --recursive https://github.com/seebi/dircolors-solarized.git ${HOME}/.dircolors-solarized
        ln -s "${HOME}/.dircolors-solarized/dircolors.256dark" "${HOME}/.dircolors"
    fi

    #
    #  colorize
    #
    if [ -d "${HOME}/.grc" ]; then
        status_msg "0" "colorize"

        pushd . > /dev/null 2>&1
        cd "${HOME}/.grc" && git fetch --all && git reset --hard origin/master
        popd > /dev/null 2>&1
    else
        status_msg "1" "colorize"
        git clone https://github.com/garabik/grc.git ${HOME}/.grc
    fi

    #
    #  git
    #
    status_msg "0" "Git configs"
    cp -R ./files/git "${HOME}/.git"
    for g_file in ./files/git/.*; do
        gitfile=$(basename ${g_file})
        ln -sf "${HOME}/.git/${gitfile}" "${HOME}/${gitfile}"
    done

    #
    #  Activate .dotfiles
    #
    status_msg "0" "Dot-files"
    cp -R ./files/dotfiles "${HOME}/.dotfiles"
    for d_file in ./files/dotfiles/.*; do
        dotfile=$(basename ${d_file})
        ln -sf "${HOME}/.dotfiles/${dotfile}" "${HOME}/${dotfile}"
    done

    #  Enable iTerm2 shell integration
    curl -L https://iterm2.com/shell_integration/bash -o ~/.iterm2_shell_integration.bash
    curl -L https://iterm2.com/shell_integration/zsh  -o ~/.iterm2_shell_integration.zsh
}


function install_mas {
    #  ! NOTE
    #  ! mas-cli requires a full install of XCode, disabling it for now
    return
    #
    #  Install MAS cmd line (If older than 'High Sierra', use tap)
    #
    # [[ ${OS_MINOR} -ge 13 ]] && brew install mas || brew install mas-cli/tap/mas

    # #  Install packages
    # for pkg in "${mas_pkgs[@]}"; do
    #     mas install ${pkg}
    # done
}
