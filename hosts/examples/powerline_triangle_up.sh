#!/usr/bin/env bash
#*******************************************************************************
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
#*******************************************************************************

# SHELLCHECK
# =============================================================================
# shellcheck disable=SC2168,SC2034
#  - SC2168: 'local' is only valid in functions.
#            This error is normal as this files is sourced within a function
#  - SC2034: VARIABLE appears unused. Verify it or export it.
#            This warning is normal as this files is sourced within a function

# CHARACTER ENVIRONMENT SETUP
# =============================================================================
# Check if terminal emulator support unicode char or glyphs.
# To support glyphs, i.e. default character for segment, such as " ",
# I strongly recommend installing nerdfonts, see :
#    - https://github.com/buzzkillhardball/nerdfonts
# And setup your terminal to use one of these fonts.
# Personnaly, I use 'FiraCode Nerd Font'
if [[ -n "${SHELL_APP}" ]] \
  || [[ "${UNICODE_SUPPORTED_TERM[*]}" =~ ${SHELL_APP} ]]
then # terminal emulator support unicode and glyphs char
  # ---------------------------------------------------------------------------
  # GENERAL VARIABLES
  # ---------------------------------------------------------------------------
  if [[ ${PROMPT_VERSION} -eq 2 ]]
  then
    # Prompt _v2_
    local PROMPT_ENV_LEFT=" "    # v2 Default " " | v1 Default "]"
    local PROMPT_ENV_RIGHT=" "   # v2 Default " " | v1 Default "["
  fi
fi

# ******************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# ******************************************************************************
