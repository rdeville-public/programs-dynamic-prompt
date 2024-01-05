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
# Set the variables and methods to compute the content of segment terraform

# VARIABLES
# =============================================================================
# Set variables for terraform segment
local TERRAFORM_CHAR="${TERRAFORM_CHAR:-" "}"
local TERRAFORM_FG="${TERRAFORM_FG:-${DEFAULT_FG}}"
local TERRAFORM_BG="${TERRAFORM_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_terraform_content()
{
  # """TODO"""
  # Compute the content of the terraform segment of the form
  # terraform_workspace
  # NO PARAM

  local terraform_info
  local terraform_workspace="$(terraform workspace show 2>/dev/null)"
  if [[ -n "${terraform_workspace}" ]]
  then
    terraform_info="${terraform_workspace}"
  else
    terraform_info=""
  fi
  echo -e "${terraform_info}"
}

_compute_terraform_info()
{
  # """TODO"""
  # If environment variable TERRAFORM_ENV existss and is not equal to 0, get the
  # terraform current workspace and print it with the terraform char.
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output
  if [[ -n "${TERRAFORM_ENV}" ]]
  then
    cmd_output=$(_compute_terraform_content)
    if [[ -n "${cmd_output}" ]]
    then
      info="${TERRAFORM_CHAR}${cmd_output}"
    fi
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${TERRAFORM_CHAR}context:namespace"
  fi
  echo -e "${info}"
}

_compute_terraform_info_short()
{
  # """TODO"""
  # If environment variable TERRAFORM_ENV print the keepass char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output
  if [[ -z "${TERRAFORM_ENV}" ]]
  then
    cmd_output=$(_compute_terraform_content)
    if [[ -n "${cmd_output}" ]]
    then
      info="${TERRAFORM_CHAR}"
    fi
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${TERRAFORM_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_terraform_info()
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

  local info=$(_compute_terraform_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: terraform is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[terraform]="${info}"
    segment_content_clr[terraform]="${info}"
    segment_fg[terraform]="${TERRAFORM_FG}"
    segment_bg[terraform]="${TERRAFORM_BG}"
  fi
}

_terraform_info_short()
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

  local info=$(_compute_terraform_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[terraform]="${info}"
    segment_content_short_clr[terraform]="${info}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************