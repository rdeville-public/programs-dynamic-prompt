#!/bin/bash
# *****************************************************************************
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
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
# Set the variables and methods to compute the content of segment kube

# VARIABLES
# =============================================================================
# Set variables for kube segment
local KUBE_CHAR="${KUBE_CHAR:-"☸ "}"
local KUBE_FG="${KUBE_FG:-${DEFAULT_FG}}"
local KUBE_BG="${KUBE_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_kube_content()
{
  # Compute the content of the kube segment of the form
  # kube_context:kube_namespace
  # NO PARAM

  local kube_info
  local kube_namespace
  local kube_context="$(kubectl config current-context 2>/dev/null)"
  if [[ -n "${kube_context}" ]]
  then
    local kube_namespace="$(kubectl config view --minify \
      --output 'jsonpath={..namespace}' 2>/dev/null)"
    # Set namespace to 'default' if it is not defined
    kube_namespace="${kube_namespace:-default}"
    kube_info="${kube_context}:${kube_namespace}"
  else
    kube_info=""
  fi
  echo -e "${kube_info}"
}

_compute_kube_info()
{
  # If environment variable KUBE_ENV existss and is not equal to 0, get the
  # kubernetes current context and namespace and print them with the kube char.
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output
  if [[ -n "${KUBE_ENV}" ]] && [[ ${KUBE_ENV} -ne 0 ]]
  then
    cmd_output=$(_compute_kube_content)
    if [[ -n "${cmd_output}" ]]
    then
      info="${KUBE_CHAR}${cmd_output}"
    fi
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${KUBE_CHAR}context:namespace"
  fi
  echo -e "${info}"
}

_compute_kube_info_short()
{
  # If environment variable KUBE_ENV print the keepass char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output
  if [[ -n "${KUBE_ENV}" ]] && [[ ${KUBE_ENV} -ne 0 ]]
  then
    cmd_output=$(_compute_kube_content)
    if [[ -n "${cmd_output}" ]]
    then
      info="${KUBE_CHAR}"
    fi
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${KUBE_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_kube_info()
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

  local info=$(_compute_kube_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: kube is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[kube]="${info}"
    segment_content_clr[kube]="${info}"
    segment_fg[kube]="${KUBE_FG}"
    segment_bg[kube]="${KUBE_BG}"
  fi
}

_kube_info_short()
{
  # Required method to get segment in short format. If segment content is
  # non-empty, update arrays used to compute prompt lines. Arrays are such:
  # - segment_content_short:
  #     store content of segment in short version without colors
  # - segment_content_short_clr:
  #     store content of segment in short version with colors if segment use
  #     inner colors
  # NO PARAM

  local info=$(_compute_kube_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[kube]="${info}"
    segment_content_short_clr[kube]="${info}"
  fi
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
