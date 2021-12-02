#!/usr/bin/env bash
# """TODO
#
# DESCRIPTION:
#   TODO
#
# """

# SHELLCHECK
# =============================================================================
# Globally disable some shellcheck warning
# shellcheck disable=SC1090,SC2154,SC2155
# SC1090: Can't follow non-constant source. Use a directive to specify
#         location.
# see: https://github.com/koalaman/shellcheck/wiki/SC1090
# SC2154: openstack is referenced but not assigned.
# see: https://github.com/koalaman/shellcheck/wiki/SC2154
# SC2155: Declare and assign separately to avoid masking return values.
# see: https://github.com/koalaman/shellcheck/wiki/SC2155

# DESCRIPTION:
# =============================================================================
# Main script to compute the prompt line. Sourced once when loggin defining the
# precmd method

# METHODS
# =============================================================================
precmd()
{
  # """TODO"""
  # Main method call before letting the user typing input command.
  # Nothing to do for zsh, which will automatically use it
  # For bash, need to add following lines in the ~/.bashrc
  # ```
  #   # Check if precmd not alread in variable PROMPT_COMMAND
  #   if ! [[ "${PROMPT_COMMAND}" =~ precmd ]]
  #   then
  #     PROMPT_COMMAND="precmd;${PROMPT_COMMAND}"
  #   fi
  # ```
  # NO PARAM
  # shellcheck disable=SC2034
  # SC2034: EXIT_CODE appears unused. Verify it or export it.
  local EXIT_CODE="$?"
  # Load debug function to be able to print debug infos
  source "${PROMPT_DIR}/lib/debug.sh"
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  # Initialize time counter
  if [[ "${DEBUG_LEVEL}" =~ (TIME|WARNING|INFO|DEBUG) ]]
  then
    local start=$(date +%S%N | sed "s/^0*//")
  fi
  local COLUMNS=$(tput cols)
  # shellcheck disable=SC2034
  # SC2034: HOST appears unused. Verify it or export it
  # see: https://github.com/koalaman/shellcheck/wiki/SC2034
  local HOST=$(hostname)
  # Load shared methods
  source <(cat "${PROMPT_DIR}/lib/functions.sh")
  # Check if terminal emulator is support or fallback to v1
  _check_terminal_emulator
  # Load default and user defined variables
  source <(_source_variables)
  # Main computation
  _main_prompt
  # Unset function to not be shown as autocompletion
  # shellcheck disable=SC2013
  #  SC2013: To read lines rather than words, pipe/redirect to a 'while read'
  # loop.
  # see: https://github.com/koalaman/shellcheck/wiki/SC2013
  # Search all function in lib/functions.sh to unset them to ensure they are not
  # shown as global functions
  for i_function in $(grep -E "^[a-z_0-9]\(\)" "${PROMPT_DIR}/lib/functions.sh")
  do
    unset -f "${i_function/\(\)/}"
  done
  if [[ "${DEBUG_LEVEL}" =~ (TIME|WARNING|INFO|DEBUG) ]]
  then
    local end=$(date +%S%N | sed 's/^0*//')
    # Remove leading 0
    local spent=$(( ${end#0} - ${start#0} ))
    # Print time
    prompt_debug "TIME" "Total precmd ${spent}ns=~$(( spent / 1000 ))μs=~$(( spent / 1000000 ))ms"
  fi
}

# Check if user configuration is up to date
if ! [[ -f ${PROMPT_DIR}/.upgraded ]]
then
  "${PROMPT_DIR}/lib/upgrade_config.sh"
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
