# `which_term.sh` script

This script is used by `prompt.sh` to know the name of the terminal application
you used.

It rely on `xdotool` on Linux to obtain the name of the terminal and on the
variable `TERM_PROGRAM` on MacOS.

This script simply print the name of the terminal as output which is then
compared to the variable `UNICODE_SUPPORTED_TERM` and `TRUE_COLOR_TERM`
to know if your terminal is supported, i.e. if it was test and if the project
now if your prompt support unicode character and/or true colors.

Below is the content of this simple script:

??? info "Content of `which_term.sh` (Click to reveal)"
    ```bash
    which_term(){
      # Method to determine which terminal emulator is used.
      # Also set supported list of terminal emulator that support unicode char.
      # Main resource come from :
      # https://askubuntu.com/questions/476641/how-can-i-get-the-name-of-the-current-terminal-from-command-line
      # NO PARAM

      local term
      if who am i | grep tty &> /dev/null && ! [[ "$(uname)" =~ .*Darwin.* ]]
      then
        # If currently in tty but not on MacOS, i.e. Darwin, as all macos terminal
        # are launch in tty and not pty
        term="tty"
      elif [[ -n "${TERM_PROGRAM}" ]]
      then
        # If variable TERM_PROGRAM exists, means user is on MacOS, set term
        # accordingly
        term="${TERM_PROGRAM}"
      elif ! command -v xdotool &> /dev/null || ! xdotool getactivewindow &> /dev/null
      then
        # If xdotool not present, unable to determine the terminal emulator
        # application
        term="unkown"
      else
        term=$(sed -e "s/\x0//g" /proc/"$(xdotool getwindowpid "$(xdotool getactivewindow)")"/cmdline)
        case ${term} in
            # If this terminal is perl program, then the emulator's
            # name is likely the second part of it
            */perl* )
             term=$(basename "$(readlink -f "$(echo "${term}" | cut -d ' ' -f 2)")")
             ;;
            # If this terminal is python program, then the emulator's
            # name is likely the last part of it
            */python*)
              term=${term##*/}
              ;;
            # The special case of gnome-terminal
            *gnome-terminal-server* )
              term="gnome-terminal"
            ;;
            # For other cases, just take the 1st field of $term
            * )
              term=${term/% */}
            ;;
        esac
      fi
      echo ${term}
    }
    which_term
    ```
