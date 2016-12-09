case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix|screen*)
    # If current terminal is an ssh session, prepend hostname to prompt
    remote_host() {
      if [ -n "$SSH_CONNECTION" ]; then
        echo "$(hostname):"
      fi
    }

    if [ -n "$ZSH_VERSION" ]; then
      function precmd() {
        echo -ne "\033]0;$(remote_host)$(basename $PWD)\007"
      }

      function preexec() {
        # Strip argument list from command
        PROGRAM=$(echo $1 |cut -f1 -d' ')

        echo -ne "\033]0;$(remote_host)${PROGRAM}\007"
      }
    fi

    if [ -n "$BASH" ]; then
      PROMPT_COMMAND='echo -ne "\033]0;$(hostname)\007"'
    fi
  ;;
esac
