#!/bin/bash
# """TODO
#
# DESCRIPTION:
#   TODO
#
# """

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
# Set the variables and methods to compute the content of segment return_code

# VARIABLES
# =============================================================================
# Set variables for return_code segment
local RETURN_CODE_CHAR="${RETURN_CODE_CHAR:-"⌦ "}"
local RETURN_CODE_FG="${RETURN_CODE_FG:-${DEFAULT_FG}}"
local RETURN_CODE_BG="${RETURN_CODE_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_return_code_info()
{
  # """TODO"""
  # If the output of the command is non-empty, print the return_code char
  # and the content of the output of the command.
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  if [[ "${EXIT_CODE}" -gt 0 ]]
  then
    info="${RETURN_CODE_CHAR}${EXIT_CODE}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${RETURN_CODE_CHAR}0"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_return_code_info()
{
  # """TODO"""
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
  local info=$(_compute_return_code_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: return_code is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[return_code]="${info}"
    segment_content_clr[return_code]="${info}"
    segment_fg[return_code]="${RETURN_CODE_FG}"
    segment_bg[return_code]="${RETURN_CODE_BG}"
  fi
}

_return_code_info_short()
{
  # """TODO"""
  # Required method to get segment in short format. If segment content is
  # non-empty, update arrays used to compute prompt lines. Arrays are such:
  # - segment_content_short:
  #     store content of segment in short version without colors
  # - segment_content_short_clr:
  #     store content of segment in short version with colors if segment use
  #     inner colors
  # NO PARAM

  local info=$(_compute_return_code_info)
  if [[ -n "${info}" ]]
  then
    segment_content_short[return_code]="${info}"
    segment_content_short_clr[return_code]="${info}"
  fi
}
# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
