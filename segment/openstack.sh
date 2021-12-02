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
# Set the variables and methods to compute the content of segment openstack

# VARIABLES
# =============================================================================
# Set variables for keepass segment
local OPENSTACK_CHAR="${OPENSTACK_CHAR:-"⛅"}"
local OPENSTACK_FG="${OPENSTACK_FG:-${DEFAULT_FG}}"
local OPENSTACK_BG="${OPENSTACK_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_openstack_info()
{
  # """TODO"""
  # If environment variables OS_USER_DOMAIN_NAME and OS_PROJECT_NAME  exists,
  # print the openstack char and the openstack info
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  if [[ -n "${OS_PROJECT_NAME}" ]] && [[ -n "${OS_USER_DOMAIN_NAME}" ]]
  then
    info="${OPENSTACK_CHAR}${OS_PROJECT_NAME}:${OS_USER_DOMAIN_NAME}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${OPENSTACK_CHAR}os_project:os_domain"
  fi
  echo -e "${info}"
}

_compute_openstack_info_short()
{
  # """TODO"""
  # If environment variables OS_USER_DOMAIN_NAME and OS_PROJECT_NAME  exists,
  # print the openstack char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  if [[ -n "${OS_PROJECT_NAME}" ]] && [[ -n "${OS_USER_DOMAIN_NAME}" ]]
  then
    info="${OPENSTACK_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${OPENSTACK_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_openstack_info()
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

  local info=$(_compute_openstack_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: openstack is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[openstack]="${info}"
    segment_content_clr[openstack]="${info}"
    segment_fg[openstack]="${OPENSTACK_FG}"
    segment_bg[openstack]="${OPENSTACK_BG}"
  fi
}

_openstack_info_short()
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

  local info=$(_compute_openstack_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[openstack]="${info}"
    segment_content_short_clr[openstack]="${info}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
