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
# - SC2034: segment_content appears unused. Verify it or export it.
# - SC2155: Declare and assign separately to avoid masking return values.
# - SC2168: 'local' is only valid in functions.

# DESCRIPTION
# =============================================================================
# Set the variables and methods to compute the content of segment docker

# VARIABLES
# =============================================================================
# Set variables for  docker segment
local DOCKER_CHAR="${DOCKER_CHAR:-"🐳"}"
local DOCKER_FG="${DOCKER_FG:-${DEFAULT_FG}}"
local DOCKER_BG="${DOCKER_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_docker_info()
{
  # """TODO"""
  # If the output of the command is non-empty, print the docker char
  # and the content of the output of the command.
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output="$(grep ':/docker/' /proc/self/cgroup  | cut -d "/" -f 3 | sort | uniq )"
  if [[ -n "${cmd_output}" || -e "/.dockerenv" ]]
  then
    info="${DOCKER_CHAR}${cmd_output:0:12}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${DOCKER_CHAR}docker"
  fi
  echo -e "${info}"
}

_compute_docker_info_short()
{
  # """TODO"""
  # Output docker char if docker is non-empty
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output="$(grep ':/docker/' /proc/self/cgroup  | cut -d "/" -f 3 | sort | uniq )"
  if [[ -n "${cmd_output}" ]]
  then
    info="${DOCKER_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${DOCKER_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_docker_info()
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

  local info=$(_compute_docker_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: openstack is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[docker]="${info}"
    segment_content_clr[docker]="${info}"
    segment_fg[docker]="${DOCKER_FG}"
    segment_bg[docker]="${DOCKER_BG}"
  fi
}

_docker_info_short()
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

  local info=$(_compute_docker_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[docker]="${info}"
    segment_content_short_clr[docker]="${info}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
