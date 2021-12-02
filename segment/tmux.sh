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
# Set the variables and methods to compute the content of segment tmux

# VARIABLES
# =============================================================================
# Set variables for tmux segment
local TMUX_CHAR="${TMUX_CHAR:-" "}"
local TMUX_FG="${TMUX_FG:-${DEFAULT_FG}}"
local TMUX_BG="${TMUX_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_tmux_info()
{
  # """TODO"""
  # If global variable TMUX exists, output tmux char to the current Pane and
  # Windows name
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  if [[ -n "${TMUX}" ]]
  then
    info="${TMUX_CHAR}$(tmux display-message -p "#S:#W")"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${TMUX_CHAR}session:window"
  fi
  echo -e "${info}"
}

_compute_tmux_info_short()
{
  # """TODO"""
  # If global variable TMUX exists, output tmux char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  if [[ -n "${TMUX}" ]]
  then
    info="${TMUX_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${TMUX_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_tmux_info()
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

  local info=$(_compute_tmux_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: openstack is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[tmux]="${info}"
    segment_content_clr[tmux]="${info}"
    segment_fg[tmux]="${TMUX_FG}"
    segment_bg[tmux]="${TMUX_BG}"
  fi
}

_tmux_info_short()
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

  local info=$(_compute_tmux_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[tmux]="${info}"
    segment_content_short_clr[tmux]="${info}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
