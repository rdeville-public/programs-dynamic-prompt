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
# Set the variables and methods to compute the content of segment virtualenv

# VARIABLES
# =============================================================================
# Set variables for virtualenv segment
local VIRTUALENV_CHAR="${VIRTUALENV_CHAR:-"🐍"}"
local VIRTUALENV_FG="${VIRTUALENV_FG:-${DEFAULT_FG}}"
local VIRTUALENV_BG="${VIRTUALENV_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_virtualenv_info()
{
  # If global variable VIRTUAL_ENV exists, means we are in a python virtual
  # environment (for now, only python is supported). Then print the virtual env
  # char, the python version and the name of the virtualenv
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local virtualenv
  local version
  local info
  if [[ -n "${VIRTUAL_ENV}" ]]
  then
    # Remove everything before the last occurence of '/'
    virtualenv=${VIRTUAL_ENV##*/}
    # Remove everything after the last occurence of '-'
    virtualenv=${virtualenv%-*}
    # Redirection to handle Python2 that output version on stderr
    version=$(python -V 2>&1)
    # Remove everythin before the last occurence of ' '
    version=${version##* }
    info="${VIRTUALENV_CHAR}v${version}:${virtualenv}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${VIRTUALENV_CHAR}vX.X.X:venv"
  fi
  echo -e "${info}"
}

_compute_virtualenv_info_short()
{
  # If global variable VIRTUAL_ENV exists, means we are in a python virtual
  # environment (for now, only python is supported). Then print the virtual env
  # char.
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  if [[ -n "${VIRTUAL_ENV}" ]]
  then
    info="${VIRTUALENV_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${VIRTUALENV_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_virtualenv_info()
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

  local info=$(_compute_virtualenv_info)
  if [[ -n "${info}" ]]
  then
    segment_content[virtualenv]="${info}"
    segment_content_clr[virtualenv]="${info}"
    segment_fg[virtualenv]="${VIRTUALENV_FG}"
    segment_bg[virtualenv]="${VIRTUALENV_BG}"
  fi
}

_virtualenv_info_short()
{
  # Required method to get segment in short format. If segment content is
  # non-empty, update arrays used to compute prompt lines. Arrays are such:
  # - segment_content_short:
  #     store content of segment in short version without colors
  # - segment_content_short_clr:
  #     store content of segment in short version with colors if segment use
  #     inner colors
  # NO PARAM

  local info=$(_compute_virtualenv_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[virtualenv]="${info}"
    segment_content_short_clr[virtualenv]="${info}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
