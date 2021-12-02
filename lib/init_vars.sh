#!/usr/bin/env bash
# """TODO
#
# DESCRIPTION:
#   TODO
#
# """

# SHELLCHECK
# =============================================================================
# shellcheck disable=SC2034,SC2168
# SC2034: VARIABLE appears unused. Verify it or export it.
#         This warning is normal as this files is sourced within a function
# SC2168: 'local' is only valid in functions.
# see: https://github.com/koalaman/shellcheck/wiki/SC2168


# DESCRIPTION
# =============================================================================
# Script which initialized variable needed by method `_prompt_line` in
# `functions.sh`.
# Initialization done by code `source<$(cat ${PROMPT}/lib/init_vars.sh)`,
# allowing to use `local` in scripts.
# PARAM $1, $2 and $3 are defined in "docstring" of the method `_prompt_line`.

# VARIABLES
# =============================================================================
# Declare variables used to compute prompt line
local prompt_line
local hfill
local prompt_right
local prompt_left
local idx_start
local idx_stop
local curr_segment_fg
local curr_segment_bg
local curr_segment_clr_switch
local segment_idx
local segment
local segment_priority
local segment_content
local segment_content_clr
local segment_content_short
local segment_content_short_clr
local segment_shorten
local segment_removed
local options
local separator
local segment_name
local segment_priority_name
local segment_left_separator
local segment_right_separator
local first_line_prompt=false

# Set variable and associative array depending on the shell.
# This subsitution is for later use when introducing use of RPROMPT
segment_idx=$1
segment_name="$2[${segment_idx}]"
segment_priority_name="$3[${segment_idx}]"

# shellcheck disable=SC2082,SC2154
# SC2082: To expand via indirection, use arrays, ${!name} or (for sh only) eval.
# SC2154: (P)segment_priority_name is referenced but not assigned.
case ${SHELL} in
  *bash)
    # Do a variable name substitution to store content of arrays in segment
    # and segment_priority
    # See: https://www.tldp.org/LDP/abs/html/parameter-substitution.html
    segment="${!segment_name}"
    segment_priority=${!segment_priority_name}
    ;;
  *zsh)
    # Do a variable name substitution to store content of arrays in segment
    # and segment_priority
    # See: http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags
    # - SC2296: Parameter expansions can't start with (, Double check syntax.
    # shellcheck disable=SC2296
    segment=${${(P)segment_name}}
    # shellcheck disable=SC2296
    segment_priority=${(P)segment_priority_name}
    ;;
esac

case ${SHELL} in
  *bash)
    options="-a"
    # Declare arrays for bash
    declare -A segment_content
    declare -A segment_content_clr
    declare -A segment_content_short
    declare -A segment_content_short_clr
    declare -A segment_fg
    declare -A segment_bg
    # Check if the current computed line is the first line of the prompt
    if [[ ${segment_idx} -eq 0 ]]
    then
      first_line_prompt="true"
    fi
    ;;
  *zsh)
    options="-A"
    # Declare arrays for bash
    typeset -A segment_content
    typeset -A segment_content_clr
    typeset -A segment_content_short
    typeset -A segment_content_short_clr
    typeset -A segment_fg
    typeset -A segment_bg
    # Check if the current computed line is the first line of the prompt
    if [[ ${segment_idx} -eq 1 ]]
    then
      first_line_prompt="true"
    fi
esac

# Check if user use `, ` or `,` as separator in SEGMENT
if [[ "${segment}" =~ ", " ]]
then
  separator=", "
else
  separator=","
fi

case ${SHELL} in
  *bash)
    # Split ${segment} into the local array `segment`
    IFS="${separator}" read -r ${options?} segment <<< "${segment}"
    ;;
  *zsh)
    # Split ${segment} into the local array `segment`
    IFS="${separator}" read -r ${options?} segment <<< "${segment}"
    ;;
esac

# Check if user use `, ` or `,` as separator in SEGMENT
if [[ "${segment_priority}" =~ ", " ]]
then
  separator=", "
else
  separator=","
fi

case ${SHELL} in
  *bash)
    # Split ${segment_priority} into the local array `segment_priority`
    IFS="${separator}" read -r ${options?} segment_priority <<< "${segment_priority}"
    ;;
  *zsh)
    # Split ${segment_priority} into the local array `segment_priority`
    IFS="${separator}" read -r ${options?} segment_priority <<< "${segment_priority}"
    ;;
esac

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=bash: ts=2: sw=2: sts=2
# *****************************************************************************
