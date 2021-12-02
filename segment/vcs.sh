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
# shellcheck disable=SC2034,SC2155,SC2168,SC1090
# SC2034: segment_content appears unused. Verify it or export it.
# see: https://github.com/koalaman/shellcheck/wiki/SC2034
# SC2155: Declare and assign separately to avoid masking return values.
# see: https://github.com/koalaman/shellcheck/wiki/SC2155
# SC2168: 'local' is only valid in functions.
# see: https://github.com/koalaman/shellcheck/wiki/SC2168
# SC1090: Can't follow non-constant source. Use a directive to specify
#         location.
# see: https://github.com/koalaman/shellcheck/wiki/SC1090

# DESCRIPTION
# =============================================================================
# Set the variables and methods to compute the content of segment vcs

# VARIABLES
# =============================================================================
# Set variables for vcs segment
local VCS_CHAR="${VCS_CHAR:-"±"}"
local VCS_FG="${VCS_FG:-${DEFAULT_FG}}"
local VCS_BG="${VCS_BG:-${DEFAULT_BG}}"
# VCS Inner colors and boolean to define if user want inner colors
local VCS_COMPRESSED="${VCS_COMPRESSED:-"false"}"
local VCS_COLORED="${VCS_COLORED:-"true"}"
local VCS_DETACHED_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_DETACHED_FG:-${VCS_FG}}${CLR_SUFFIX}"
local VCS_TAG_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_TAG_FG:-${VCS_FG}}${CLR_SUFFIX}"
local VCS_COMMIT_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_COMMIT_FG:-${VCS_FG}}${CLR_SUFFIX}"
local VCS_BRANCH_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_BRANCH_FG:-${VCS_FG}}${CLR_SUFFIX}"
local VCS_BEHIND_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_BEHIND_FG:-${VCS_FG}}${CLR_SUFFIX}"
local VCS_AHEAD_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_AHEAD_FG:-${VCS_FG}}${CLR_SUFFIX}"
local VCS_STASH_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_STASH_FG:-${VCS_FG}}${CLR_SUFFIX}"
local VCS_UNTRACKED_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_UNTRACKED_FG:-${VCS_FG}}${CLR_SUFFIX}"
local VCS_UNSTAGED_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_UNSTAGED_FG:-${VCS_FG}}${CLR_SUFFIX}"
local VCS_STAGED_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_STAGED_FG:-${VCS_FG}}${CLR_SUFFIX}"
local VCS_PROMPT_DIRTY_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_PROMPT_DIRTY_FG:-${VCS_FG}}${CLR_SUFFIX}"
local VCS_PROMPT_CLEAN_FG="${CLR_PREFIX}${CLR_FG_PREFIX}${VCS_PROMPT_CLEAN_FG:-${VCS_FG}}${CLR_SUFFIX}"

# METHODS
# =============================================================================
__vcs_determine_soft()
{
  # """TODO"""
  # Search for vcs software used and if within a versionned repo
  # NO PARAM

  local vcs_software
  if command -v git > /dev/null 2>&1 \
      && [ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]
  then
    vcs_software="git"
  fi
  echo ${vcs_software}
}

_compute_vcs_info()
{
  # """TODO"""
  # If vcs_software is not empty, this means that within a supported versionned
  # folder. Compute the states of the repo to be print. The output of this
  # method does not use segment inner color
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local vcs_software="$(__vcs_determine_soft)"
  if [[ -n "${vcs_software}" ]]
  then
    # Construct command to be run to get prompt info for the vcs software
    # This method should accept two boolean, the first define the compressed
    # version and the second the colored output (see below)
    vcs_cmd="_${vcs_software}_get_prompt_info"
    # Load method related to this vcs software
    source <(cat "${PROMPT_DIR}/segment/vcs/${vcs_software}.sh")
    # If command to have prompt info for the vcs software exists, build the
    # segment information
    if command -v "${vcs_cmd}" > /dev/null 2>&1
    then
      info=$(${vcs_cmd} "${VCS_COMPRESSED}" false)
    fi
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${VCS_CHAR} fake versioned repo"
  fi
  echo -e "${info}"
}

_compute_vcs_info_clr()
{
  # """TODO"""
  # If vcs_software is not empty, this means that within a supported versionned
  # folder. Compute the states of the repo to be print. The output of this
  # method use segment inner color
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM
  local info
  local vcs_software="$(__vcs_determine_soft)"
  if [[ -n "${vcs_software}" ]]
  then
    vcs_cmd="_${vcs_software}_get_prompt_info"
    source <(cat "${PROMPT_DIR}/segment/vcs/${vcs_software}.sh")
    if command -v "${vcs_cmd}" > /dev/null 2>&1
    then
      info=$(${vcs_cmd} "${VCS_COMPRESSED}" "${VCS_COLORED}")
    fi
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${VCS_CHAR} fake versioned repo"
  fi
  echo -e "${info}"
}

_compute_vcs_info_short()
{
  # """TODO"""
  # If vcs_software is not empty, this means that within a supported versionned
  # folder. Output the vcs char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local vcs_software="$(__vcs_determine_soft)"
  if [[ -n "${vcs_software}" ]]
  then
    info="${VCS_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${VCS_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_vcs_info()
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

  local info=$(_compute_vcs_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: vcs is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[vcs]="${info}"
    segment_content_clr[vcs]="$(_compute_vcs_info_clr)"
    segment_fg[vcs]="${VCS_FG}"
    segment_bg[vcs]="${VCS_BG}"
  fi
}

_vcs_info_short()
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

  local info=$(_compute_vcs_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[vcs]="${info}"
    segment_content_short_clr[vcs]="${info}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
