#!/usr/bin/env bash
# *****************************************************************************
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# SHELLCHECK
# =============================================================================
# Globally disable some shellcheck warning

# DESCRIPTION
# =============================================================================
# Script which method used to print debug information

# METHODS
# =============================================================================
prompt_debug()
{
  # Method that print a string depending of the debug level asked by the user.
  # The more debug level is high, the more information will be shown.
  # Error message, i.e. string with debug severity of 0, are always shown !
  # If not debug level provided, i.e. $1 is not [0-3], then $1 will be print as
  # the info.
  # *PARAM $1 : str, String to print as info
  # *PARAM $1 : integer, debug severity of string to print, such as:
  #             - 3 info message
  #             - 2 warning message
  #             - 1 time message
  #             - 0 error spent message
  # *PARAM $2 : (required if PARAM $1 is [0-3]
  #             Integer, usually used for time in ms

  # COLORING ECHO OUTPUT
  # ---------------------------------------------------------------------------
  # Some exported variable I sometimes use in my script to echo informations in
  # colors. Base on only 8 colors to ensure portability of color when in tty
  # Don't know why, when put elsewhere, these export does not work
  export E_NORMAL="\e[0m"    # Normal (white fg & transparent bg)
  export E_BOLD="\e[1m"      # Bold
  export E_DIM="\e[2m"       # Dim
  export E_ITALIC="\e[3m"    # Italic
  export E_UNDERLINE="\e[4m" # Underline
  export E_DEBUG="\e[0;35m"    # Magenta fg
  export E_INFO="\e[0;32m"     # Green fg
  export E_WARNING="\e[0;33m"  # Yellow fg
  export E_ERROR="\e[0;31m"    # Red fg
  export E_TIME="\e[0;34m"     # Cyan fg

  # Get log level
  local msg_severity="$1"
  if [[ "${msg_severity}" =~ ^(ERROR|TIME|WARNING|INFO|DEBUG)$ ]]
  then
    shift
    local msg="$*"
    local clr="E_${msg_severity}"
    case ${SHELL} in
      *bash)
        clr="${!clr}"
        ;;
      *zsh)
        # shellcheck disable=SC2154
        #  SC2154: (P)clr is referenced but not assigned.
        clr="${(P)clr}"
        ;;
    esac
    case ${PROMPT_DEBUG_LEVEL} in
      DEBUG)
        if [[ "${msg_severity}" =~ (DEBUG|INFO|WARNING|TIME|ERROR) ]]
        then
          echo -e "${clr}[${msg_severity}] ${msg}${E_NORMAL}"
        fi
        ;;
      INFO)
        if [[ "${msg_severity}" =~ (INFO|WARNING|TIME|ERROR) ]]
        then
          echo -e "${clr}[${msg_severity}] ${msg}${E_NORMAL}"
        fi
        ;;
      WARNING)
        if [[ "${msg_severity}" =~ (WARNING|TIME|ERROR) ]]
        then
          echo -e "${clr}[${msg_severity}] ${msg}${E_NORMAL}"
        fi
        ;;
      TIME)
        if [[ "${msg_severity}" =~ (TIME|ERROR) ]]
        then
          echo -e "${clr}[${msg_severity}] ${msg}${E_NORMAL}"
        fi
        ;;
      ERROR)
        if [[ "${msg_severity}" =~ (ERROR) ]]
        then
          echo -e "${clr}[${msg_severity}] ${msg}${E_NORMAL}"
        fi
        ;;
    esac
  else
    local msg="$*"
    echo -e "${E_INFO}[INFO] ${msg}${E_NORMAL}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
