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
# Set the variables and methods to compute the content of segment vcsh

# VARIABLES
# =============================================================================
# Set variables for vcsh segment
local VCSH_CHAR="${VCSH_CHAR:-"🔧 "}"
local VCSH_FG="${VCSH_FG:-${DEFAULT_FG}}"
local VCSH_BG="${VCSH_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_vcsh_info()
{
  # If VCSH_REPO_NAME variable exists, output vcsh char and repo name
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  if [[ -n "${VCSH_REPO_NAME}" ]]
  then
    info="${VCSH_CHAR}${VCSH_REPO_NAME}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${VCSH_CHAR}vcsh_repo"
  fi
  echo -e "${info}"
}

_compute_vcsh_info_short()
{
  # If VCSH_REPO_NAME variable exists, output vcsh char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  if [[ -n "${VCSH_REPO_NAME}" ]]
  then
    info="${VCSH_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${VCSH_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_vcsh_info()
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

  local info=$(_compute_vcsh_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: vcsh is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[vcsh]="${info}"
    segment_content_clr[vcsh]="${info}"
    segment_fg[vcsh]="${VCSH_FG}"
    segment_bg[vcsh]="${VCSH_BG}"
  fi
}

_vcsh_info_short()
{
  # Required method to get segment in short format. If segment content is
  # non-empty, update arrays used to compute prompt lines. Arrays are such:
  # - segment_content_short:
  #     store content of segment in short version without colors
  # - segment_content_short_clr:
  #     store content of segment in short version with colors if segment use
  #     inner colors
  # NO PARAM

  local info=$(_compute_vcsh_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[vcsh]="${info}"
    segment_content_short_clr[vcsh]="${info}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
