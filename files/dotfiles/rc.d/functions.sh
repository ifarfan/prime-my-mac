# shell version of ord() and chr()
ord() { printf "0x%x\n" "'$1"; }
chr() { printf $(printf '\\%03o\\n' "$1"); }

# highlight text
highlight() { e="$1"; shift; grep --color=always -Eih "$e|$" "$@"; }

# grep all the history!
histgrep() { grep "$1" "$HISTFILE"; }

# grep process table
psgrep() { psc |grep -v grep |grep -i --color=auto "$@"; }

pspid() { ps xao pid,args |grep -v grep |grep -i "$@" |awk '{print $1}'; }

# killall alternative
pskill() {
  # Check whether a signal was given
  if [[ "$1" =~ '^-[[:alnum:]]+' ]]; then
    SIGNAL=$1
    shift
  else
    SIGNAL="-TERM"
  fi

  PIDS=$(pspid $@)
  if [ -n "$PIDS" ]; then
    echo $PIDS |xargs kill $SIGNAL
  else
    echo "No processes matching '$@' found" 1>&2
  fi
}

# recursively traverse directory tree for git repositories, run git command
# e.g.
#   gittree status
#   gittree diff
gittree() {
    if [ $# -lt 1 ]; then
        echo "Usage: gittree <command>"
        return 1
    fi

    for gitdir in $(find . -type d -name .git); do
        # Display repository name in blue
        repo=$(dirname $gitdir)
        echo -e "\033[34m$repo\033[0m"

        # Run git command in the repositories directory
        cd $repo && git $@
        ret=$?

        # Return to calling directory (ignore output)
        cd - > /dev/null

        # Abort if cd or git command fails
        if [ $ret -ne 0 ]; then
          return 1
        fi

        echo
    done
}

#  Serve current directory with Python's simple HTTP server
serve() {
  local port=${1:-8000}
  python -m SimpleHTTPServer ${port}
}

#  Aliases -- https://natelandau.com/my-mac-osx-bash_profile/
function cd() { builtin cd "$@"; ll; }                       # Always list directory contents upon 'cd'
mcd () { mkdir -p "$1" && cd "$1"; }                # Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }             # Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }            # Opens any file in MacOS Quicklook Preview
