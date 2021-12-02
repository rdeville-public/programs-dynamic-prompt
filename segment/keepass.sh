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
# Set the variables and methods to compute the content of segment keepass

# VARIABLES
# =============================================================================
# Set variables for keepass segment
local KEEPASS_CHAR="${KEEPASS_CHAR:-"🔐 "}"
local KEEPASS_FG="${KEEPASS_FG:-${DEFAULT_FG}}"
local KEEPASS_BG="${KEEPASS_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_keepass_info()
{
  # If environment variable KEEPASS_NAME exists, print the keepass char and the
  # keepass name
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  if [[ -n ${KEEPASS_NAME} ]]
  then
    info="${KEEPASS_CHAR}${KEEPASS_NAME}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${KEEPASS_CHAR}keepass"
  fi
  echo -e "${info}"
}

_compute_keepass_info_short()
{
  # If environment variable KEEPASS_NAME exists, print the keepass char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  if [[ -n ${KEEPASS_NAME} ]]
  then
    info="${KEEPASS_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${KEEPASS_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_keepass_info()
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

  local info=$(_compute_keepass_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: keepass is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[keepass]="${info}"
    segment_content_clr[keepass]="${info}"
    segment_fg[keepass]="${KEEPASS_FG}"
    segment_bg[keepass]="${KEEPASS_BG}"
  fi
}

_keepass_info_short()
{
  # Required method to get segment in short format. If segment content is
  # non-empty, update arrays used to compute prompt lines. Arrays are such:
  # - segment_content_short:
  #     store content of segment in short version without colors
  # - segment_content_short_clr:
  #     store content of segment in short version with colors if segment use
  #     inner colors
  # NO PARAM

  local info=$(_compute_keepass_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[keepass]="${info}"
    segment_content_short_clr[keepass]="${info}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
