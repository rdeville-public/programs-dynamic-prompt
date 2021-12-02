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
# shellcheck disable=SC2034,SC2168
# SC2034: VAR appears unused. Verify it or export it.
# see: https://github.com/koalaman/shellcheck/wiki/SC2034
# SC2168: 'local' is only valid in functions.
# see: https://github.com/koalaman/shellcheck/wiki/SC2168

# DESCRIPTION
# =============================================================================
# Setup some default variables used in common.example.sh, v1.sh and v2.sh to
# check if terminal emulator support unicode characters and true colors
# Except for UNICODE_SUPPORTED_TERM and TRUE_COLOR_TERM every other variables
# can be overwriten by user in common.sh

# VARIABLES
# =============================================================================
# Setup array to store supported terminal
local UNICODE_SUPPORTED_TERM=(
  "st" "terminator" "xterm" "iTerm.app"
)
local TRUE_COLOR_TERM=(
  "st" "terminator" "iTerm.app"
)

# Set default SEGMENT array
local SEGMENT=(
  "return_code, tmux, pwd, hfill, keepass, username, hostname"
  "vcsh, virtualenv, vcs, hfill, kube, openstack"
)
# Set default SEGMENT_PRIORITY array
local SEGMENT_PRIORITY=(
  "tmux, username, hostname, keepass, pwd, return_code"
  "vcsh, virtualenv, kube, openstack, vcs"
)

# Set surrounding color code to be able to print color in the prompt depending
# on the SHELL_APP, i.e. the terminal emulator used.
if [[ "${TRUE_COLOR_TERM[*]}" =~ ${SHELL_APP} ]]
then
  local BASE_CLR_PREFIX="\x1b["
  local BASE_CLR_SUFFIX="m"
  local CLR_FG_PREFIX="38;2;"
  local CLR_BG_PREFIX="48;2;"
  local DEFAULT_FG="255;255;255"
  local DEFAULT_BG="0;0;0"
elif { [[ "${SHELL_APP}" != "unkown" ]] && [[ "${SHELL_APP}" != "tty" ]]; } && \
  [[ "$(tput colors)" -eq 256 ]]
then
  local BASE_CLR_PREFIX="\033["
  local BASE_CLR_SUFFIX="m"
  local CLR_FG_PREFIX="38;5;"
  local CLR_BG_PREFIX="48;5;"
  local DEFAULT_FG="231"
  local DEFAULT_BG="16"
else
  local BASE_CLR_PREFIX="\e["
  local BASE_CLR_SUFFIX="m"
  local CLR_FG_PREFIX="3"
  local CLR_BG_PREFIX="4"
  local DEFAULT_FG="9"
  local DEFAULT_BG="0"
fi

# Set escape color codes
if [[ -z "${CI}" ]]
then
  case ${SHELL} in
    *bash)
      local CLR_PREFIX="\[${BASE_CLR_PREFIX}"
      local CLR_SUFFIX="${BASE_CLR_SUFFIX}\]"
      ;;
    *zsh)
      local CLR_PREFIX="%{${BASE_CLR_PREFIX}"
      local CLR_SUFFIX="${BASE_CLR_SUFFIX}%}"
      ;;
  esac
else
  case ${SHELL} in
    *bash)
      local CLR_PREFIX="${BASE_CLR_PREFIX}"
      local CLR_SUFFIX="${BASE_CLR_SUFFIX}"
      ;;
    *zsh)
      local CLR_PREFIX="${BASE_CLR_PREFIX}"
      local CLR_SUFFIX="${BASE_CLR_SUFFIX}"
      ;;
  esac
fi

# Set value of basic colors manipulato
local DEFAULT_NORMAL="0"
local DEFAULT_BOLD="1"
local DEFAULT_ITALIC="3"
local DEFAULT_UNDERLINE="4"
local NORMAL="${CLR_PREFIX}0${CLR_SUFFIX}"
local BOLD="${CLR_PREFIX}1${CLR_SUFFIX}"
local ITALIC="${CLR_PREFIX}3${CLR_SUFFIX}"
local UNDERLINE="${CLR_PREFIX}4${CLR_SUFFIX}"

local RETURN_CODE_FG="${RETURN_CODE_FG:-${DEFAULT_FG}}"
local CORRECT_WRONG_FG="${CORRECT_WRONG_FG:-${DEFAULT_FG}}"
local CORRECT_RIGHT_FG="${CORRECT_RIGHT_FG:-${DEFAULT_FG}}"

# Set default segment séparator
if [[ ${PROMPT_VERSION} -eq 1 ]]
then
  local PROMPT_ENV_LEFT="["
  local PROMPT_ENV_RIGHT="]"
else
  local PROMPT_ENV_LEFT=""
  local PROMPT_ENV_RIGHT=""
fi

local S_LINE_PROMPT_END=""     # Default ""
local M_LINE_PROMPT_END=" ﬌ "  # Default " ﬌ "

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
