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

# DESCRIPTION:
# =============================================================================
# Setup colors and boolean common for all my workstation, define a base
# coloring. Then, I update only needed value in $(hostname).sh file next to this
# file.

# Check what kind of terminal we are in.
# PROMPT_VERSION 1
# ----------------------------------------------------------------------------
if [[ "${TRUE_COLOR_TERM[*]}" =~ ${SHELL_APP} ]]
then
  # If terminal emulator is know to support true colors
  local DEFAULT_BG="95;0;0"      # rgb(95,0,0)
elif { [[ "${SHELL_APP}" != "unkown" ]] && [[ "${SHELL_APP}" != "tty" ]]; } && \
  [[ "$(tput colors)" -eq 256 ]]
then
  # If terminal support 256 colors and is not unkown or tty
  local DEFAULT_BG="52"          # #5f0000
else
  # Default case, shell support a maximum to 16 color or shell_app
  # is unkown or tty
  # Fallback case to ensure working coloration
  local DEFAULT_BG="1"          # Red background
fi

# ******************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# ******************************************************************************
