#!/bin/bash
# *****************************************************************************
# License : GNU General Public License v3.0
# Author  : TPL_GIT_USERNAME <TPL_GIT_USERMAIL>
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
# Set the variables and methods to compute the content of segment TPL_SEGMENT_LOWER

# VARIABLES
# =============================================================================
# Set variables for TPL_SEGMENT_LOWER segment
local TPL_SEGMENT_UPPER_CHAR="${TPL_SEGMENT_UPPER_CHAR:-"X"}"
local TPL_SEGMENT_UPPER_FG="${TPL_SEGMENT_UPPER_FG:-${DEFAULT_FG}}"
local TPL_SEGMENT_UPPER_BG="${TPL_SEGMENT_UPPER_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_TPL_SEGMENT_LOWER_info()
{
  # If the output of the command is non-empty, print the TPL_SEGMENT_LOWER char
  # and the content of the output of the command.
  # If DEBUG_MODE exists, force the output of the segment 
  # NO PARAM

  local info
  local cmd_output="$(echo "segment_content")"
  if [[ -n "${cmd_output}" ]]
  then
    info="${TPL_SEGMENT_UPPER_CHAR}${cmd_output}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${TPL_SEGMENT_UPPER_CHAR}TPL_SEGMENT_LOWER"
  fi
  echo -e "${info}"
}

_compute_TPL_SEGMENT_LOWER_info_short()
{
  # If the output of the command is non-empty, print the TPL_SEGMENT_LOWER char
  # If DEBUG_MODE exists, force the output of the segment 
  # NO PARAM

  local info
  local cmd_output="$(echo "segment_content")"
  if [[ -n "${cmd_output}" ]]
  then
    info="${TPL_SEGMENT_UPPER_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${TPL_SEGMENT_UPPER_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_TPL_SEGMENT_LOWER_info()
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
  local info=$(_compute_TPL_SEGMENT_LOWER_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: TPL_SEGMENT_LOWER is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[TPL_SEGMENT_LOWER]="${info}"
    segment_content_clr[TPL_SEGMENT_LOWER]="${info}"
    segment_fg[TPL_SEGMENT_LOWER]="${TPL_SEGMENT_UPPER_FG}"
    segment_bg[TPL_SEGMENT_LOWER]="${TPL_SEGMENT_UPPER_BG}"
  fi
}

_TPL_SEGMENT_LOWER_info_short()
{
  # Required method to get segment in short format. If segment content is
  # non-empty, update arrays used to compute prompt lines. Arrays are such:
  # - segment_content_short:
  #     store content of segment in short version without colors
  # - segment_content_short_clr:
  #     store content of segment in short version with colors if segment use
  #     inner colors
  # NO PARAM

  local info=$(_compute_TPL_SEGMENT_LOWER_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[TPL_SEGMENT_LOWER]="${info}"
    segment_content_short_clr[TPL_SEGMENT_LOWER]="${info}"
  fi
}
# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
