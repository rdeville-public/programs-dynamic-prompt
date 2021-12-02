#!/bin/bash
# *****************************************************************************
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# SHELLCHECK
# =============================================================================
# Globally disable some shellcheck warning
# shellcheck disable=SC2034,SC2155,SC2168
# SC2034: segment_content appears unused. Verify it or export it.
# see: https://github.com/koalaman/shellcheck/wiki/SC2034
# SC2155: Declare and assign separately to avoid masking return values.
# see: https://github.com/koalaman/shellcheck/wiki/SC2155
# SC2168: 'local' is only valid in functions.
# see: https://github.com/koalaman/shellcheck/wiki/SC2168

# DESCRIPTION
# =============================================================================
# Set the variables and methods to compute the content of segment username

# VARIABLES
# =============================================================================
# Set variables for username segment
local USERNAME_CHAR="${USERNAME_CHAR:-"👤"}"
local USERNAME_FG="${USERNAME_FG:-${DEFAULT_FG}}"
local USERNAME_BG="${USERNAME_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_username_info()
{
  # Output username char and the name of the current username
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output=$(whoami)
  if [[ -n "${cmd_output}" ]]
  then
    info="${USERNAME_CHAR}${cmd_output}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${USERNAME_CHAR}username"
  fi
  echo -e "${info}"
}

_compute_username_info_short()
{
  # Output username char if username is non-empty
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output=$(whoami)
  if [[ -n "${cmd_output}" ]]
  then
    info="${USERNAME_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${USERNAME_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_username_info()
{
  # Required method to get segment in long format. If segment content is
  # non-empty, update arrays used to compute prompt lines. Arrays are such:
  # - segment_content:
  #     store content of segment without colors
  # - segment_content_clr:
  #     store content of segment with colors if segment use inner colors
  # - segment_fg:
  #     store foreground segment color
  # - segment_bg:
  #     store bacgkround segment color
  # NO PARAM

  local info=$(_compute_username_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: username is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[username]="${info}"
    segment_content_clr[username]="${info}"
    segment_fg[username]="${USERNAME_FG}"
    segment_bg[username]="${USERNAME_BG}"
  fi
}

_username_info_short()
{
  # Required method to get segment in short format. If segment content is
  # non-empty, update arrays used to compute prompt lines. Arrays are such:
  # - segment_content_short:
  #     store content of segment in short version without colors
  # - segment_content_short_clr:
  #     store content of segment in short version with colors if segment use
  #     inner colors
  # NO PARAM

  local info=$(_compute_username_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[username]="${info}"
    segment_content_short_clr[username]="${info}"
  fi
}
# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
