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
# Set the variables and methods to compute the content of segment hostname

# VARIABLES
# =============================================================================
# Set variables for bgjobs segment
local BGJOBS_CHAR="${BGJOBS_CHAR:-"&"}"
local BGJOBS_FG="${BGJOBS_FG:-${DEFAULT_FG}}"
local BGJOBS_BG="${BGJOBS_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_bgjobs_info()
{
  # """TODO"""
  # If the output of the command is not null, print the bgjobs char
  # and the number of current background jobs
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local nb_jobs=$(jobs | wc -l )
  if [[ -n "${nb_jobs}" ]] && [[ ${nb_jobs} -gt 0 ]]
  then
    info="${BGJOBS_CHAR}${nb_jobs}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${BGJOBS_CHAR}bgjobs"
  fi
  echo -e "${info}"
}

_compute_bgjobs_short()
{
  # """TODO"""
  # If the output of the command is not null, print the bgjobs char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local nb_jobs=$(jobs | wc -l )
  if [[ -n "${nb_jobs}" ]] && [[ ${nb_jobs} -gt 0 ]]
  then
    info="${BGJOBS_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${BGJOBS_CHAR}"
  fi
  echo -e "${info}"
}


# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_bgjobs_info()
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

  local info=$(_compute_bgjobs_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: bgjobs is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[bgjobs]="${info}"
    segment_content_clr[bgjobs]="${info}"
    segment_fg[bgjobs]="${BGJOBS_FG}"
    segment_bg[bgjobs]="${BGJOBS_BG}"
  fi
}

_bgjobs_info_short()
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

  local info=$(_compute_bgjobs_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[bgjobs]="${info}"
    segment_content_short_clr[bgjobs]="${info}"
  fi
}
# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
