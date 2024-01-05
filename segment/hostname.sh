#!/bin/bash
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
# Set variables for  hostname segment
local HOSTNAME_CHAR="${HOSTNAME_CHAR:-"💻"}"
local HOSTNAME_FG="${HOSTNAME_FG:-${DEFAULT_FG}}"
local HOSTNAME_BG="${HOSTNAME_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_hostname_info()
{
  # """TODO"""
  # If the output of the command is non-empty, print the hostname char
  # and the content of the output of the command.
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output
  # if command hostname
  # then
  #   cmd_output="$(hostname)"
  # else
    cmd_output="$(cat /etc/hostname)"
  # fi
  if [[ -n "${cmd_output}" ]]
  then
    info="${HOSTNAME_CHAR}${cmd_output}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${HOSTNAME_CHAR}hostname"
  fi
  echo -e "${info}"
}

_compute_hostname_info_short()
{
  # """TODO"""
  # Output hostname char if hostname is non-empty
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output
  # if command hostname
  # then
  #   cmd_output="$(hostname)"
  # else
    cmd_output="$(cat /etc/hostname)"
  # fi
  if [[ -n "${cmd_output}" ]]
  then
    info="${HOSTNAME_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${HOSTNAME_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_hostname_info()
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

  local info=$(_compute_hostname_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: openstack is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[hostname]="${info}"
    segment_content_clr[hostname]="${info}"
    segment_fg[hostname]="${HOSTNAME_FG}"
    segment_bg[hostname]="${HOSTNAME_BG}"
  fi
}

_hostname_info_short()
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

  local info=$(_compute_hostname_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[hostname]="${info}"
    segment_content_short_clr[hostname]="${info}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************