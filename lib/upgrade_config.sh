#!/usr/bin/env bash
# *****************************************************************************
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# SHELLCHECK
# =============================================================================
# Globally disable some shellcheck warning
# shellcheck disable=SC2154,SC1090
# SC2154: funcstack is referenced but not assigned.
#         location.
# see: https://github.com/koalaman/shellcheck/wiki/SC2154
# SC1090: Can't follow non-constant source. Use a directive to specify
#         location.
# see: https://github.com/koalaman/shellcheck/wiki/SC1090


# DESCRIPTION:
# =============================================================================
# Script to check if user configuration files are up to date and upgrade them if
# needed

# VARIABLES
# =============================================================================
# Store absolute path of script
SCRIPTPATH="$( cd "$(dirname "$0")" || exit 1 ; pwd -P )"

# METHODS
# =============================================================================
_make_backup()
{
  # Make a backup of the files and inform the user where this backup is
  # *PARAM $1: sting, type of variables that need to be ugpraded, used for
  #            backup suffix

  local idx=0
  local suffix=$1
  local backup_file="${i_file}.before_${suffix}_upgrade.bak_"
  for i_file in "${files_to_replace[@]}"
  do
    # Ensure to not erease previous backup
    while [[ -e ${backup_file}${idx} ]]
    do
      idx=$(( idx + 1 ))
    done
    prompt_debug "A backup of your file ${i_file##*${PROMPT_DIR}/} will be done and called ${backup_file##*${PROMPT_DIR}/}${idx}"
    cp "${i_file}" "${backup_file}${idx}"
  done
}


_ask_confirmation()
{
  # Ask user if he/she wants to upgrade its configuration variables
  # *PARAM $1: sting, type of variables that need to be ugpraded

  local answer=""
  while ! [[ ${answer} =~ (y|Y|yes|YES|ye|YE|n|N|no|NO) ]]
  do
    prompt_debug "Following files seems to not be update to date."
    prompt_debug "You have old $1 variables, do you want to upgrade them ? [Y/n]"
    for i_file in "${files_to_replace[@]}"
    do
      prompt_debug "    - ${i_file}"
    done
    read -r -e answer
    answer=${answer:-Y}
    case ${answer} in
      y|Y|yes|YES|ye|YE)
        return 0
        ;;
      n|N|no|NO)
        prompt_debug "WARNING ! Your prompt might not work !"
        return 1
        ;;
      *)
        echo -e "${E_ERROR}Please enter y|yes or n|no${E_NORMAL}"
        ;;
    esac
  done
}


_check_segment_version()
{
  # Check if files in ${PROMPT_DIR}/hosts have string describing old segment
  # variables, if yes, register these files to be upgraded
  # NO PARAM

  prompt_debug "INFO" "Check if segment variables need to be updated in your config files."
  local segment_check=(
    "USER_"
  )
  for i_file in "${PROMPT_DIR}"/hosts/*.sh
  do
    if ! [[ -L ${i_file} ]]
    then
      idx_start=0
      idx_stop=${#segment_check[@]}
      idx="${idx_start}"
      found="false"
      while [[ "${found}" == "false" ]] && [[ ${idx} -lt ${idx_stop} ]]
      do
        if grep -q "${segment_check[$idx]}" "${i_file}"
        then
          found="true"
        else
          idx=$(( idx + 1 ))
        fi
      done
      if [[ ${found} == "true" ]]
      then
        files_to_replace+=("${i_file}")
      fi
    fi
  done
}


_upgrade_segment_config()
{
  # Upgrade colors variables in configuration files
  # NO PARAM

  local sed_search=(
    "USER_"
  )
  local sed_replace=(
    "USERNAME_"
  )
  for i_file in "${files_to_replace[@]}"
  do
    prompt_debug "Upgrading segment variables for ${i_file}"
    prompt_debug "This might take some time, please be patient"
    while IFS= read -r line
    do
      idx_start=0
      idx_stop=${#sed_search[@]}
      idx=${idx_start}
      found="false"
      while [[ "${found}" == "false" ]] && [[ ${idx} -lt ${idx_stop} ]]
      do
        if echo "${line}" | grep -q "${sed_search[$idx]}"
        then
          found="true"
        else
          idx=$(( idx + 1 ))
        fi
      done
      if [[ ${found} == true ]]
      then
        line="${line/${sed_search[$idx]}/${sed_replace[$idx]}}"
      fi
      echo "$line" >> "${i_file}.tmp"
    done < "${i_file}"
    mv "${i_file}.tmp" "${i_file}"
  done
}


_check_colors_version()
{
  # Check if files in ${PROMPT_DIR}/hosts have string describing colors prefix,
  # like  "38;2", "38;5", if yes, register these files to be upgraded
  # NO PARAM

  prompt_debug "INFO" "Check if colors variables need to be updated in your config files."
  local clrs_check=(
    "FG=\"38;2;[0-9]*;[0-9]*;[0-9]*"
    "BG=\"48;2;[0-9]*;[0-9]*;[0-9]*"
    "FG=\"38;5;[0-9]*"
    "BG=\"48;5;[0-9]*"
  )
  local found="false"
  local idx=0
  for i_file in "${PROMPT_DIR}"/hosts/*.sh
  do
    if ! [[ -L ${i_file} ]]
    then
      idx_start=0
      idx_stop=${#clrs_check[@]}
      idx="${idx_start}"
      found="false"
      while [[ "${found}" == "false" ]] && [[ ${idx} -lt ${idx_stop} ]]
      do
        if grep -q "${clrs_check[$idx]}" "${i_file}"
        then
          found="true"
        else
          idx=$(( idx + 1 ))
        fi
      done
      if [[ ${found} == "true" ]]
      then
        files_to_replace+=("${i_file}")
      fi
    fi
  done
}


_upgrade_colors_config(){
  # Upgrade colors variables in configuration files
  # NO PARAM

  local clrs_prefix=(
    "FG=\"38;2;[0-9]*;[0-9]*;[0-9]*"
    "BG=\"48;2;[0-9]*;[0-9]*;[0-9]*"
    "FG=\"38;5;[0-9]*"
    "BG=\"48;5;[0-9]*"
    "FG=\"3"
    "BG=\"4"
    ";38;5;"
  )
  local sed_pattern=(
    "FG=\"38;2;"
    "BG=\"48;2;"
    "FG=\"38;5;"
    "BG=\"48;5;"
    "FG=\"3"
    "BG=\"4"
    ";38;5;"
  )
  local sed_replace=(
    "FG=\""
    "BG=\""
    "FG=\""
    "BG=\""
    "FG=\""
    "BG=\""
    ";3"
  )
  for i_file in "${files_to_replace[@]}"
  do
    prompt_debug "Upgrading colors variables for ${i_file}"
    prompt_debug "This might take some time, please be patient"
    while IFS= read -r line
    do
      idx_start=0
      idx_stop=${#clrs_prefix[@]}
      idx=${idx_start}
      found="false"
      while [[ "${found}" == "false" ]] && [[ ${idx} -lt ${idx_stop} ]]
      do
        if echo "${line}" | grep -q "${clrs_prefix[$idx]}"
        then
          found="true"
        else
          idx=$(( idx + 1 ))
        fi
      done
      if [[ ${found} == true ]]
      then
        line="${line/${sed_pattern[$idx]}/${sed_replace[$idx]}}"
      fi
      echo "$line" >> "${i_file}.tmp"
    done < "${i_file}"
    mv "${i_file}.tmp" "${i_file}"
  done
}


_process_color_var()
{
  # Check if colors variables need to be upgraded, if yes, upgraded files
  # NO PARAM

  files_to_replace=()
  _check_colors_version
  if [[ ${#files_to_replace[@]} -gt 0 ]]
  then
    if _ask_confirmation "colors"
    then
      _make_backup "colors"
      _upgrade_colors_config
      upgrade="true"
    fi
  fi
}


_process_segment_var()
{
  # Check if segment variables need to be upgraded, if yes, upgraded files
  # NO PARAM

  local files_to_replace=()
  _check_segment_version
  if [[ ${#files_to_replace[@]} -gt 0 ]]
  then
    if _ask_confirmation "segment"
    then
      _make_backup "segment"
      _upgrade_segment_config
      upgrade="true"
    fi
  fi
}


main()
{
  # Main method that that check if there is files that need to be upgraded
  # NO PARAM

  # Source debug method to print info
  old_shell="${SHELL}"
  SHELL="/bin/bash"
  source "${SCRIPTPATH}/debug.sh"
  export SHELL="${old_shell}"
  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"

  local upgrade=false
  _process_segment_var
  _process_color_var

  if [[ ${upgrade} == "true" ]]
  then
    prompt_debug "If your prompt is correctly working, you can delete backups of your files"
    prompt_debug "Else you might need to delete file ${PROMPT_DIR}/.upgraded to restart the upgrade process."
  fi
  SHELL="${old_shell}"
  touch "${PROMPT_DIR}/.upgraded"
}

main

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
