#!/usr/bin/env bash
# """Script to create a base new segment from template
#
# DESCRIPTION:
#   TODO
#
# """

# SHELLCHECK
# =============================================================================
# Globally disable some shellcheck warning
# shellcheck disable=SC2154,SC2155,SC1090
# SC2154: funcstack is referenced but not assigned.
#         location.
# see: https://github.com/koalaman/shellcheck/wiki/SC2154
# SC2155: Declare and assign separately to avoid masking return values.
# see: https://github.com/koalaman/shellcheck/wiki/SC2155
# SC1090: Can't follow non-constant source. Use a directive to specify
#         location.
# see: https://github.com/koalaman/shellcheck/wiki/SC1090

# DESCRIPTION:
# =============================================================================
# Simple script to help user initialize a new segment from segment/segment.sh.tpl

# VARIABLES
# =============================================================================
# Store absolute path of script
SCRIPTPATH="$( cd "$(dirname "$0")" || exit 1; pwd -P )"

# METHODS
# =============================================================================
usage()
{
  # """TODO"""
  # Print the usage of the script
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"

echo -e "\
${E_BOLD} NAME${E_NORMAL}
    new_segment.sh - Ask user name of a new segment to create prepared file from template.

${E_BOLD} SYNOPSIS${E_NORMAL}
    ${E_BOLD}test.sh \
[ ${E_BOLD}-h${E_NORMAL} ] [ -n ${E_UNDER}segment_name${E_NORMAL} ] [ -d ${E_UNDER}segment_short_desc${normal}]

${E_BOLD} DESCRIPTION${E_NORMAL}
    ${E_BOLD}segment_name.sh${E_NORMAL} is a script that will let you choose the
    name of a new segment you want to add to the dynamic prompt, check if the
    segment already exists in the prompt, if not, will created a basic segment
    file from a template.

    By default, without any options, the script will pass through some
    interactive dialog boxes to ask you main parameters you want to set. But
    you can avoid it by directly passing the name of your segment directly as
    first parameter of the script.

    NOTE: Despite the fact that is a bash script, there is not order on options.

${E_BOLD} OPTIONS${E_NORMAL}
    ${E_BOLD}-h,--help${E_NORMAL}
        Print this help

    ${E_BOLD}-n
        The name of the segment you want to add (space will be replaced by '_')

    ${E_BOLD}-d
        A short description of the segment you want to add, like 'Show the date'
  "

}


check_new_segment_script_exist()
{
  # """TODO"""
  # Ensure a segment file with the name of the new segment user want to create
  # does not exists
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  if [[ -e "${SCRIPTPATH}/segment/${segment_name}.sh" ]]
  then
    echo -e "${E_WARNING}\
+------------------------------------------------------------------------------+
  The segment ${E_BOLD}${segment_name}${E_WARNING} already exists ! Continuing will delete it !
  Press ${E_BOLD}${E_INFO}<Enter>${E_WARNING} to change the name of your segment.
+------------------------------------------------------------------------------+\
${E_NORMAL}"
    read -r
    return 1
  fi
  return 0
}


init_new_segment_script()
{
  # """TODO"""
  # Create an initialized segment file from the template segment/segment.sh.tpl
  # in segment such as name of the script holding the segment is
  # segment/new_segment_name.sh where new_segment_name is choosen by the user
  # NO PARAM

  # Initialize local variable
  local segment_name_lower
  local segment_name_upper
  local segment_template
  local new_segment_file
  local git_username=$(git config user.name)
  local git_usermail=$(git config user.email)

  # Compute remplacement patterns
  segment_name_lower=$(echo "${segment_name}" | tr '[:upper:]' '[:lower:]')
  segment_name_upper=$(echo "${segment_name}" | tr '[:lower:]' '[:upper:]')
  segment_template="${SCRIPTPATH}/segment/segment.sh.tpl"
  new_segment_file="${SCRIPTPATH}/segment/${segment_name}.sh"

  # Create basic segment file from template
  sed -e "s|TPL_SEGMENT_LOWER|${segment_name_lower}|g" \
      -e "s|TPL_SEGMENT_UPPER|${segment_name_upper}|g" \
      -e "s|TPL_GIT_USERNAME|${git_username}|g" \
      -e "s|TPL_GIT_USERMAIL|${git_usermail}|g" \
      "${segment_template}" > "${new_segment_file}"
  return 0
}


init_new_segment_documentation()
{
  # """TODO"""
  # Initialize local variable
  local segment_name_lower
  local segment_name_upper
  local segment_template
  local new_segment_file
  local git_username=$(git config user.name)
  local git_usermail=$(git config user.email)

  # Compute remplacement patterns
  segment_name_lower=$(echo "${segment_name}" | tr '[:upper:]' '[:lower:]')
  segment_name_upper=$(echo "${segment_name}" | tr '[:lower:]' '[:upper:]')

  index_doc_array="| [${segment_name}](configuration/segments/${segment_name}.md) | ${segment_short_desc} |"
  index_file="${SCRIPTPATH}/docs/README.md"

  readme_doc_array="| [${segment_name}](configuration/segments/${segment_name}.md) | ${segment_short_desc} |"
  readme_file="${SCRIPTPATH}/README.md"

  all_segment_doc_array="| [${segment_name}](segments/${segment_name}.md) | ${segment_short_desc} |"
  all_segment_file="${SCRIPTPATH}/docs/configuration/all_supported_segments.md"

  mkdocs_line="######- ${segment_name} segment: configuration/segments/${segment_name}.md"
  mkdocs_file="${SCRIPTPATH}/mkdocs.yml"

  segment_template="${SCRIPTPATH}/docs/configuration/segments/segment.md.tpl"
  new_segment_file="${SCRIPTPATH}/docs/configuration/segments/${segment_name}.md"

  # Create basic segment file from template
  line=$(( $(grep -n "TPL_NEW_SEGMENT" "${index_file}" | cut -d ":" -f 1) - 1 ))
  sed -i "${line}i ${index_doc_array}" "${index_file}"
  line=$(( $(grep -n "TPL_NEW_SEGMENT" "${readme_file}" | cut -d ":" -f 1) - 1 ))
  sed -i "${line}i ${readme_doc_array}" "${readme_file}"
  line=$(( $(grep -n "TPL_NEW_SEGMENT" "${all_segment_file}" | cut -d ":" -f 1) - 1 ))
  sed -i "${line}i ${all_segment_doc_array}" "${all_segment_file}"
  line=$(( $(grep -n "TPL_NEW_SEGMENT" "${mkdocs_file}" | cut -d ":" -f 1) - 1 ))
  sed -i "${line}i ${mkdocs_line}" "${mkdocs_file}"
  sed -i "s/######/      /g" "${mkdocs_file}"
  sed -e "s|TPL_SEGMENT_LOWER|${segment_name_lower}|g" \
      -e "s|TPL_SEGMENT_UPPER|${segment_name_upper}|g" \
      "${segment_template}" > "${new_segment_file}"
  return 0

}

create_new_segment_from_template()
{
  # """TODO"""
  # Check if segment does not already exists, if not init the script and the
  # documentation.
  # NO PARAM

  # Ensure new segment does not exists
  if ! check_new_segment_script_exist
  then
    return 1
  fi
  init_new_segment_script
  init_new_segment_documentation
  return 0
}


ask_confirmation()
{
  # """TODO"""
  # Recap user parameter and present what will be done
  # NO PARAM
  while [[ ${answer} -ne 1 ]] && [[ ${answer} -ne 2 ]]
  do
    echo -e "${E_INFO}\
+------------------------------------------------------------------------------+
|     This whill init the segment ${segment_name} - ${segment_short_desc}
|
|     Do you want to continue [Y/n] ?
+------------------------------------------------------------------------------+
| Press ${E_ERROR}${E_BOLD}<Ctrl+C>${E_INFO} to cancel                                                     |
+------------------------------------------------------------------------------+
${E_NORMAL}"
    read -r -e answer
    answer=${answer:-Y}
    case ${answer} in
      y|Y|yes|YES|ye|YE)
        return 0
        ;;
      n|N|no|NO)
        return 1
        ;;
      *)
        echo -e "${E_ERROR}Please enter y|yes or n|no${E_NORMAL}"
        ;;
    esac
  done
}


ask_segment_short_desc()
{
  # """TODO"""
  # Ask the user the short desc of the new segment
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  while [[ -z ${segment_short_desc} ]]
  do
    segment_short_desc=""
    # Ask the segment name
    echo -e "\
+------------------------------------------------------------------------------+
|   Please provided a short description of your segmen like 'Show the date'.   |
|   ${E_DIM}Press ${E_NORMAL}<Ctrl+C>${E_DIM} to Cancel${E_NORMAL}                                                   |
+------------------------------------------------------------------------------+"
    read -r -e segment_short_desc
    # Ensure user provide a segment name
    if [[ -z "${segment_short_desc}" ]]
    then
      echo -e "${E_ERROR}\
+------------------------------------------------------------------------------+
|           ${E_BOLD}ERROR - You did not provide any segment description${E_ERROR}                |
|     Press ${E_BOLD}${E_INFO}<Enter>${E_ERROR} to Continue or ${E_BOLD}<Ctrl+C>${E_ERROR} to Cancel                          |
+------------------------------------------------------------------------------+
${E_NORMAL}"
      read -r
      return 1
    fi
  done
  return 0
}


ask_segment_name()
{
  # """TODO"""
  # Ask the user the name of the new segment
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  segment_name=""
  while [[ -z "${segment_name}" ]]
  do
    # Ask the segment name
    echo -e "\
+------------------------------------------------------------------------------+
|   What is the name you want to use for your new segment ?                    |
|   ${E_DIM}Press ${E_NORMAL}<Ctrl+C>${E_DIM} to Cancel${E_NORMAL}                                                   |
+------------------------------------------------------------------------------+"
    read -r -e segment_name
    # Ensure user provide a segment name
    if [[ -z "${segment_name}" ]]
    then
      echo -e "${E_ERROR}\
+------------------------------------------------------------------------------+
|           ${E_BOLD}ERROR - You did not provide any segment name !${E_ERROR}                     |
|     Please enter a segment name.                                             |
|     Press ${E_BOLD}${E_INFO}<Enter>${E_ERROR} to Continue or ${E_BOLD}<Ctrl+C>${E_ERROR} to Cancel                          |
+------------------------------------------------------------------------------+${E_NORMAL}"
      read -r
    fi
  done
  return 0
}


main()
{
  # """TODO"""
  # Main method that ask the user the segment name if not provided, then check
  # if segment with same name already exists, if not create the new segment from
  # template.
  # PARAM $1: string, the name of the new segment or -h to print usage of the
  # script.

  # Load script allowing to use debug metho
  prompt_debug "INFO" "Starting process of creating new segment"
  # Initialize local variables
  local segment_name="$1"
  local segment_short_desc="$2"
  local segment_created="false"
  # Parse arguments
  while [[ $# -gt 0 ]]
  do
    case $1 in
      -h)
        usage
        exit 0
        ;;
      -n)
        shift
        segment_name="$1"
        shift
        ;;
      -d)
        shift
        segment_short_desc="$1"
        shift
        ;;
    esac
  done
  # Start the process of creating new segment
  segment_created="false"
  while [[ ${segment_created} == "false" ]]
  do
    if [[ -z "${segment_name}" ]]
    then
      ask_segment_name
    fi
    if [[ -z "${segment_short_desc}" ]]
    then
      ask_segment_short_desc
    fi
    if [[ -n "${segment_short_desc}" ]] && [[ -n "${segment_name}" ]]
    then
      segment_name=$(echo "${segment_name}" | tr '[:upper:]' '[:lower:]')
      # As these method return 0 when everything is OK, we should convert this 0
      # to 1
      if ask_confirmation && create_new_segment_from_template
      then
        segment_created="true"
      else
        segment_name=""
        segment_short_desc=""
      fi
    fi
  done
}

source "${PROMPT_DIR}/lib/debug.sh"
old_shell=${SHELL}
SHELL="/bin/bash"
main "$@"
SHELL=${old_shell}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
