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
# Set the variables and methods to compute the content of segment pwd

# VARIABLES
# =============================================================================
# Set variables for keepass segment
local PWD_CHAR="${PWD_CHAR:-"📁 "}"
local PWD_FG="${PWD_FG:-${DEFAULT_FG}}"
local PWD_BG="${PWD_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_pwd_info()
{
  # """TODO"""
  # Compute current pwd, replace ${HOME} by ~.
  # NO PARAM

  local info
  info=$(pwd)
  # Replace ${HOME} by '~'
  info="${PWD_CHAR}${info/${HOME}/"~"}"
  echo -e "${info}"
}

_compute_pwd_info_short()
{
  # """TODO"""
  # Compute pwd short version such that path will :
  #  - start by ~/ if in ${HOME}, else by /
  #  - middle content of path will be compressed by ...
  #  - end of path will still have 7 characters
  # *PARAM $1 : integer, current hfill size

  # Init local variables
  local local_hfill
  local info
  local start_prefix_pos
  local start_suffix_pos
  local prefix_size
  local suffix_size
  local max_shorten
  local_hfill=$1
  # Compute current path
  info=$(_compute_pwd_info)
  # Compute size of prefix to remove
  prefix_size=$(( local_hfill * -1 + 10 ))
  # If not in ${HOME}
  if [[ "${info}" != "${PWD_CHAR}~" ]]
  then
    # Compute the starting position of the prefix to remove
    if [[ "${info}" =~ \~ ]]
    then
      start_prefix_pos=$(( $(_string_width "${PWD_CHAR}") + 2 ))
    else
      start_prefix_pos=$(( $(_string_width "${PWD_CHAR}") + 1 ))
    fi
    # Compute the maximum shorten size of path
    max_shorten="${info:0:$start_prefix_pos}...${info:$(( $(_string_width "${info}") - 5 ))}"
    if [[ $(( $(_string_width "${info}") - prefix_size )) -lt $(_string_width "${max_shorten}") ]]
    then
      # If current path minus the prefix will lead to path shorten to the
      # maximum shorten path, set value of segment to the maximum shorten path.
      info="${max_shorten}"
    else
      # Remove the prefix from the current path
      start_suffix_pos=$(( start_prefix_pos + prefix_size + 1 ))
      suffix_size=$(( $(_string_width "${info}") - start_suffix_pos ))
      pwd_prefix="${info:$start_prefix_pos:$prefix_size}"
      info="${info/$pwd_prefix/...}"
    fi
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_pwd_info()
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

  local info=$(_compute_pwd_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: kube is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[pwd]="${info}"
    segment_content_clr[pwd]="${info}"
    segment_fg[pwd]="${PWD_FG}"
    segment_bg[pwd]="${PWD_BG}"
  fi
}

_pwd_info_short()
{
  # """TODO"""
  # Required method to get segment in short format. If segment content is
  # non-empty, update arrays used to compute prompt lines. Arrays are such:
  # - segment_content_short:
  #     store content of segment in short version without colors
  # - segment_content_short_clr:
  #     store content of segment in short version with colors if segment use
  #     inner colors
  # *PARAM $1 : integer, current hfill size
  local info
  local hfill_size="$1"
  info=$(_compute_pwd_info_short "${hfill_size}")
  if [[ -n "${info}" ]]
  then
    segment_content_short[pwd]="${info}"
    segment_content_short_clr[pwd]="${info}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
