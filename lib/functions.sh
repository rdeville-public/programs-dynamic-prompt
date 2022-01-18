#!/usr/bin/env bash
# """TODO
#
# DESCRIPTION:
#   TODO
#
# """

# SHELLCHECK
# =============================================================================
# Globally disable some shellcheck warning
# shellcheck disable=SC1090,SC2155,SC2154
# SC1090: Can't follow non-constant source. Use a directive to specify
#         location.
# see: https://github.com/koalaman/shellcheck/wiki/SC1090
# SC2155: Declare and assign separately to avoid masking return values.
# see: https://github.com/koalaman/shellcheck/wiki/SC2155
# SC2154: funcstack is referenced but not assigned.
#         location.
# see: https://github.com/koalaman/shellcheck/wiki/SC2154

# DESCRIPTION
# =============================================================================
# Script which store method used to compute prompt_lines

# METHODS
# =============================================================================
_prompt_printf()
{
  # """TODO"""
  # Repeat the string passed as $1 for a given amount of time provided as $1
  # *PARAM $1: string, the string to be repeated
  # *PARAM $2: integer, the number of times the string $1 must be repeated

  str=$1
  num=$2
  v=$(printf "%-${num}s" "$str")
  echo "${v// /$str}"
  return
}

_string_width()
{
  # """TODO"""
  # Compute the size, in term of block for the string passed as $1.
  # *PARAM $1: String, the string for which retrieve its size
  case "$(cat /etc/issue)" in
    *Alpine*)
      echo ${#1}
      ;;
    *Ubuntu|Debian*)
      echo "$1" | wc -L
      ;;
    *)
      echo "$1" | wc -L
      ;;
  esac
}

_check_terminal_emulator()
{
  # """TODO"""
  # Method which check the terminal application, depending on its value,
  # fall back automatically to PROMPT_VERSION 1
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]} $segment_name"
  if [[ -n "${SHELL_APP}" ]]
  then
    export SHELL_APP="${SHELL_APP}"
  else
    export SHELL_APP="$("${PROMPT_DIR}/tools/which_term")"
  fi

  # Determine prompt to load
  if [[ -z "${SHELL_APP}" ]] \
    || [[ "${SHELL_APP}" == "tty" ]] \
    || [[ "${SHELL_APP}" == "unkown" ]]
  then
    # If terminal is tty or unkonwn, force V1 of prompt that is more readable when
    # in TTY
    PROMPT_VERSION=1
  fi
}

_load_all_segment()
{
  # """TODO"""
  # Print the output of all segment referenced in the variable array ${segment}
  # This method should be used with source, like `source <(_load_all_segment)
  # NO PARAM

  for segment_name in "${segment[@]}"
  do
   if [[ ${segment_name} != 'hfill' ]]
   then
      cat "${PROMPT_DIR}/segment/${segment_name}.sh" &
   fi
  done
  wait
}

_source_variables()
{
  # """TODO"""
  # Print the output of  default variable then user defined variables in
  # hosts/common.sh and in hosts/$(hostname).sh if these files exists.
  # This method should be used with source, like `source <(_source_variables)
  # NO PARAM
  local default_cfg_dir="${XDG_DATA_DIR:-"${HOME}/.local/share"}/prompt"
  local cfg_dir="${PROMPT_DATA_DIR:-"${default_cfg_dir}"}"
  local host_cfg_dir="${cfg_dir}/$(hostname)"
  local user_cfg_dir="${cfg_dir}/$(whoami)"
  local cfg_filename="config.sh"

  cat "${PROMPT_DIR}/lib/default_vars.sh"
  if [[ -e "/.dockerenv" && -f "${cfg_dir}/docker/${cfg_filename}" ]]
  then
    cat "${cfg_dir}/docker/${cfg_filename}"
  fi

  if [[ -d "${host_cfg_dir}" ]]
  then
    user_cfg_dir="${host_cfg_dir}/$(whoami)"
    if [[ -e "${host_cfg_dir}/${cfg_filename}" ]]
    then
      cat "${host_cfg_dir}/${cfg_filename}"
    fi
  fi

  if [[ -d "${user_cfg_dir}" && -f "${user_cfg_dir}/${cfg_filename}" ]]
  then
    cat "${user_cfg_dir}/${cfg_filename}"
  fi
}

_compute_segment_content_v1()
{
  # """TODO"""
  # Update the array segment_content with segment separator if needed
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]} $segment_name"
  if [[ "${segment_name}" == "pwd" ]]
  then
    # If segment is pwd, just add space in front of pwd
    segment_content[$segment_name]=" ${segment_content[$segment_name]}  "
  else
    # If segment is not pwd, add segment spearator around segment content
    segment_content[$segment_name]="${segment_right_separator}${segment_content[$segment_name]}${segment_left_separator}"
  fi
}

_compute_segment_content_v2()
{
  # """TODO"""
  # Update the array segment_content with segment separator
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]} $segment_name"
  segment_content[$segment_name]="${segment_right_separator} ${segment_content[$segment_name]} ${segment_left_separator}"
}


_compute_segment_content_short_v1()
{
  # """TODO"""
  # Update the array segment_content_short with segment separator if needed
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]} $segment_name"
  if [[ ${segment_name} == "pwd" ]]
  then
    # If segment is pwd, just add space in front of pwd
    segment_content_short[$segment_name]=" ${segment_content_short[$segment_name]}"
  else
    # If segment is not pwd, add segment spearator around segment content
    segment_content_short[$segment_name]="${segment_right_separator}${segment_content_short[$segment_name]}${segment_left_separator}"
  fi
}

_compute_segment_content_short_v2()
{
  # """TODO"""
  # Update the array segment_content with segment separator
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]} $segment_name"
  segment_content_short[$segment_name]="${segment_right_separator} ${segment_content_short[$segment_name]} ${segment_left_separator}"
}

_recompute_segment_pwd_content_short_v1()
{
  # """TODO"""
  # Update segment_content of special segment pwd when resizing prompt lines
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  "_${segment_name}_info_short" "${gain}"
  segment_content[pwd]=" ${segment_content_short[pwd]}"
}

_recompute_segment_pwd_content_short_v2()
{
  # """TODO"""
  # Update segment_content of special segment pwd when resizing prompt lines
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  segment_content[pwd]="${segment_right_separator} ${segment_content_short[pwd]} ${segment_left_separator}"
}

_compute_hfill_size()
{
  # """TODO"""
  # Compute the size of special hfill segment by updating content of
  # segment_content and segment_content_short arrays which store content of
  # segment without colors.
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  # Set idx according to the shell used
  case ${SHELL} in
    *bash)
      idx_start=0
      idx_stop=${#segment[@]}
      idx_stop_priority=${#segment_priority[@]}
      ;;
    *zsh)
      idx_start=1
      idx_stop=$(( ${#segment[@]} + 1 ))
      idx_stop_priority=$(( ${#segment_priority[@]} + 1 ))
      ;;
  esac

  # Compute the prompt line content without colors
  for segment_name in "${segment[@]}"
  do
    if [[ ${segment_name} != "^hfill$" ]] && [[ -n "${segment_content[$segment_name]}" ]]
    then
      # If segment is not hfill and have content, compute its content and add it
      # to the prompt line
      _compute_segment_content_v${PROMPT_VERSION}
      prompt_line+="${segment_content[$segment_name]}"
    elif [[ ${PROMPT_VERSION} -eq 2 ]]
    then
      # Else, segment if hfill and in prompt v2, switch segment separator to use
      # the right powerline character
      segment_left_separator=""
      segment_right_separator="${PROMPT_ENV_RIGHT}"
    fi
  done
  # Compute the size of the space remaining
  gain=$(( COLUMNS - $(_string_width "${prompt_line}") ))

  # Reset idx
  idx=${idx_start}
  # Must reinit empty arrays
  segment_shorten=()
  segment_removed=()
  # If remaining space is less that 5, compute the responsivness of the prompt
  # line
  prompt_debug "DEBUG" "Content of prompt line before resize"
  prompt_debug "DEBUG" "prompt_line : ${prompt_line}"
  prompt_debug "DEBUG" "Size of prompt_line : $(_string_width "${prompt_line}")"
  prompt_debug "DEBUG" "Size of prompt_line : ${#prompt_line}"
  prompt_debug "DEBUG" "Size of hfill : ${gain}"
  prompt_debug "DEBUG" "Size of prompt : $(tput cols)"
  prompt_debug "DEBUG" "${prompt_line}"
  while [[ ${gain} -lt 5 ]] && [[ ${#segment_removed[@]} -ne ${#segment_priority[@]} ]]
  do
    segment_name="${segment_priority[idx]}"
    if ! [[ "${segment_shorten[*]}" =~ ^${segment_name}$ ]] \
      && [[ ${#segment_shorten[@]} -ne ${#segment_priority[@]} ]] \
      && [[ -n "${segment_content[${segment_name}]}" ]]
    then
      # If segment not already shortened and not all segment are shortened
      if [[ ${segment_name} == "pwd" ]]
      then
        # Recompute size of special segment pwd when shortened
        "_${segment_name}_info_short" "${gain}"
      fi
      # Update content of segment_content array by replacing with the shortened
      # version with separator to compute new gain
      _compute_segment_content_short_v${PROMPT_VERSION}
      # Recompute remaining space by adding the difference between
      # segment_content and segment_content_short with separator
      gain=$(( gain \
        + ( $(_string_width "${segment_content[$segment_name]}" ) \
          - $(_string_width "${segment_content_short[$segment_name]}" ) \
          ) \
        ))
      # Update content of segment_content array by removing segment separator
      segment_content[$segment_name]=${segment_content_short[$segment_name]}
      segment_content_clr[$segment_name]=${segment_content_short_clr[$segment_name]}
      # Add this segment the list of shortened segment
      segment_shorten+=("${segment_name}")
      prompt_debug "WARNING" "Shorten segment ${segment_name}"
    elif [[ -n "${segment_content[${segment_name}]}" ]]
    then
      # Recompute remaining space by adding the size of the content_segment
      # which will be removed
      gain=$(( gain + $(_string_width "${segment_content[$segment_name]}") ))
      if [[ "${segment_priority[*]}" =~ "pwd" ]] && [[ ${segment_name} != "pwd" ]]
      then
        # Recompute size of special segment pwd when shortening any others
        # segment. No need when it is the segment that will be removed
        _recompute_segment_pwd_content_short_v${PROMPT_VERSION}
        segment_content[pwd]=${segment_content_short[pwd]}
        segment_content_clr[pwd]=${segment_content_short_clr[pwd]}
      fi
      # Empty segment_content
      segment_content[$segment_name]=""
      segment_content_clr[$segment_name]=""
      # Add this segment to the list of removed segment
      segment_removed+=("${segment_name}")
      prompt_debug "WARNING" "Hide segment ${segment_name}"
    fi
    idx=$(( idx + 1 ))
    # When reaching the number of segment to shorten, reset index to start
    # removing segment
    if [[ $idx -ge ${idx_stop_priority} ]]
    then
      idx=${idx_start}
      _init_segment_separator_v2
    fi
  done
  # Compute the space that will be stored in hfill
  hfill="$(_prompt_printf " " ${gain} )"
  prompt_debug "DEBUG" "Size of final hfill : ${#hfill}"
}

_compute_final_prompt_line_v1()
{
  # """TODO"""
  # Compute the content of the prompt line in the final form, i.e. with colored
  # segment.
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]} $segment_name"
  # Set current segment foreground
  curr_segment_fg="${CLR_PREFIX}${CLR_FG_PREFIX}${segment_fg[$segment_name]}${CLR_SUFFIX}"
  if [[ ${segment_name} == "pwd" ]]
  then
    # If segment is pwd, does not put segment separator arount segment content
    if [[ ${PROMPT_VERSION} -eq 1  ]]
    then
      if [[ "${segment_content[$segment_name]}" == "${segment_content_short[$segment_name]}" ]]
      then
        prompt_line+="${curr_segment_fg} ${segment_content_clr[$segment_name]}"
      else
        prompt_line+="${curr_segment_fg} ${segment_content_clr[$segment_name]}  "
      fi
    else
      prompt_line+="${curr_segment_fg} ${segment_content_clr[$segment_name]}"
    fi
  else
    # Add the segment content to the prompt line
    prompt_line+="${curr_segment_fg}${segment_left_separator}${segment_content_clr[$segment_name]}${curr_segment_fg}${segment_right_separator}"
  fi
}

_compute_final_prompt_line_v2()
{
  # """TODO"""
  # Compute the content of the prompt line in the final form, i.e. with colored
  # segment. The main part is to check the next non-empty segment to set the
  # segment separator accordingly
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]} $segment_name"
  # Initialize and set local variables
  local next_segment_bg=""
  local temp_idx=$(( i_segment + 1 ))
  local next_segment_name="${segment[temp_idx]}"
  # Search for the next non empty segment still not hfill neither last segment
  while [[ "$(( temp_idx ))" -lt "${idx_stop}" ]] \
     && [[ "${next_segment_name}" != "hfill" ]] \
     && [[ -z "${segment_content[$next_segment_name]}" ]]
  do
    temp_idx=$(( temp_idx + 1 ))
    next_segment_name="${segment[temp_idx]}"
  done
  if [[ "${next_segment_name}" == "hfill" ]] &&  [[ "${first_line_prompt}" == "true" ]]
  then
    # If next segment is hfill in the first line prompt, set background color
    next_segment_bg="${CLR_PREFIX}${CLR_BG_PREFIX}${DEFAULT_BG}${CLR_SUFFIX}"
  elif [[ "${next_segment_name}" == "hfill" ]] &&  [[ "${first_line_prompt}" == "false" ]]
  then
    # If next segment is hfill not in the first line prompt, set background as
    # empty
    next_segment_bg="${NORMAL}"
  elif [[ -n "${next_segment_name}" ]]
  then
    # Else, if not last segment, set next segment color background accordingly
    next_segment_bg="${CLR_PREFIX}${CLR_BG_PREFIX}${segment_bg[${next_segment_name}]}${CLR_SUFFIX}"
  fi
  # Get segment content with colos
  segment_info="${segment_content_clr[$segment_name]}"
  if [[ -n "${segment_info}" ]]
  then
    # If segment non-empty, set all needed colors
    curr_segment_bg="${CLR_PREFIX}${CLR_BG_PREFIX}${segment_bg[${segment_name}]}${CLR_SUFFIX}"
    curr_segment_fg="${CLR_PREFIX}${CLR_FG_PREFIX}${segment_fg[${segment_name}]}${CLR_SUFFIX}"
    curr_segment_clr_switch="${CLR_PREFIX}${CLR_FG_PREFIX}${segment_bg[${segment_name}]}${CLR_SUFFIX}"
    # Compute segment separator colors
    if [[ -n "${segment_right_separator}" ]]
    then
      prompt_right="${curr_segment_clr_switch}${segment_right_separator}"
    elif [[ -n "${segment_left_separator}" ]]
    then
      prompt_left="${next_segment_bg}${curr_segment_clr_switch}${segment_left_separator}"
    fi
    # Add colored segment_info to line
    prompt_line+="${prompt_right}${curr_segment_fg}${curr_segment_bg} ${segment_info} ${prompt_left}"
  fi
}

_compute_final_hfill_content_v1()
{
  # """TODO"""
  # Add the content of hfill to the prompt line. No need to manage background
  # colors because already set for v1 during initialization of the prompt line
  # in _init_final_prompt_line
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  prompt_line+="${hfill}"
  if [[ $(whoami) == "root" ]]
  then
    prompt_line+="${BOLD}"
  fi
}

_compute_final_hfill_content_v2()
{
  # """TODO"""
  # Compute content of hfill in its final form, i.e. colored for first line
  # empty for others lines
  # NO PARAM

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  # Reset segment separator used by v2
  prompt_right=""
  prompt_left=""
  if [[ ${first_line_prompt} == "true" ]]
  then
    # If first line, colored background and segment separator accordingly
    clr_switch="${CLR_PREFIX}${CLR_FG_PREFIX}${DEFAULT_BG}${CLR_SUFFIX}"
    prompt_line+="${clr_switch}${CLR_PREFIX}${CLR_BG_PREFIX}${DEFAULT_BG}${CLR_SUFFIX}${hfill}"
  else
    # If not first line, make hfill with no background
    prompt_line+="${NORMAL}${hfill}"
  fi
  if [[ $(whoami) == "root" ]]
  then
    prompt_line+="${BOLD}"
  fi
  # Update segment separator
  segment_right_separator="${PROMPT_ENV_RIGHT}"
  segment_left_separator=""
}

_compute_final_prompt_line()
{
  # """TODO"""
  # Compute the final content of the prompt line from previously computed
  # responsivness.
  # *PARAM $1 : integer, the index of the arrays SEGMENT and SEGMENT_PRIORITY to
  #             consider

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  for ((i_segment=idx_start; i_segment<idx_stop; i_segment++))
  do
    # Get segment name
    segment_name="${segment[i_segment]}"
    if [[ ${segment_name} != "hfill" ]] &&  [[ -n "${segment_content[$segment_name]}" ]]
    then
      # If segment is not special hfill and its content is not empty, compute
      # its final form.
      _compute_final_prompt_line_v${PROMPT_VERSION}
    elif [[ ${segment_name} == "hfill" ]]
    then
      # Compute hfill segment
      _compute_final_hfill_content_v${PROMPT_VERSION}
    fi
  done
  if ! [[ ${SEGMENT[idx_prompt_line]} =~ hfill ]]
  then
    if [[ ${PROMPT_VERSION} -eq 1 ]]
    then
      fg_clr="DEFAULT_BG"
    else
      fg_clr="${segment[$(( idx_stop - 1 ))]}_BG"
    fi
    case ${SHELL} in
      *bash)
        fg_clr="${fg_clr^^}"
        fg_clr="${!fg_clr}"
        ;;
      *zsh)
        fg_clr="${fg_clr:u}"
        # - SC2296: Parameter expansions can't start with (, Double check syntax.
        # shellcheck disable=SC2296
        fg_clr="${(P)fg_clr}"
        ;;
    esac
    fg_clr="${CLR_FG_PREFIX}${fg_clr}"
    if [[ ${PROMPT_VERSION} -eq 2 ]]
    then
      prompt_line+="${NORMAL}${CLR_PREFIX}${fg_clr}${CLR_SUFFIX}${S_LINE_PROMPT_END}"
    fi
  fi
}

_init_segment_separator_v1()
{
  # """TODO"""
  # Set the segment separator for v2
  # NO PARAM

  segment_right_separator="${PROMPT_ENV_RIGHT}"
  segment_left_separator="${PROMPT_ENV_LEFT}"
}

_init_segment_separator_v2()
{
  # """TODO"""
  # Set the segment separator for v2
  # NO PARAM

  segment_right_separator=""
  segment_left_separator="${PROMPT_ENV_LEFT}"
}

_init_final_prompt_line()
{
  # """TODO"""
  # Initialize the starting of the prompt line, such as setting bold when root
  # user, fill line with background color if v1, etc.
  # NO PARAM

  # If user is root, the full line will be BOLD
  if [[ "$(whoami)" == root ]]
  then
    prompt_line+="${BOLD}"
  fi
  # Reset segment separator
  _init_segment_separator_v${PROMPT_VERSION}
  # If v1 and first line of prompt, fill the background
  if [[ ${PROMPT_VERSION} -eq 1 ]] && [[ "${first_line_prompt}" == "true" ]]
  then
    prompt_line+="${CLR_PREFIX}${CLR_BG_PREFIX}${DEFAULT_BG}${CLR_SUFFIX}"
  fi
}

_prompt_line()
{
  # """TODO"""
  # Method that compute a line of prompt from a given array and priority array.
  # *PARAM $1 : integer, the index of the arrays SEGMENT and SEGMENT_PRIORITY to
  #             consider
  # *PARAM $2 : string, name of the array to use to compute the prompt_line, for
  #             instance SEGMENT or RPROMPT
  # *PARAM $2 : string, name of the priority array to use to compute the
  #             prompt_line, for instance SEGMENT_PRIORITY or RPROMPT_PRIORITY

  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  # Load declaration of all variables needed to compute the prompt line
  source <(cat "${PROMPT_DIR}/lib/init_vars.sh")
  # Load content of all segment scripts
  source <(_load_all_segment)
  # Fill previously declared local arrays for each segment of the current
  # computed prompt line:
  for segment_name in "${segment[@]}"
  do
    # Do not compute it for special segment `hfill`
    if [[ ${segment_name} != "hfill" ]]
    then
      "_${segment_name}_info" "${segment_name}"
      "_${segment_name}_info_short"
    fi
  done
  # Initialize segment separator
  _init_segment_separator_v${PROMPT_VERSION}
  # Event if this condition is shared between v1 and v2, can not be put in
  # ${PROMPT_DIR}/lib/init_vars.sh) because of the return closure
  if [[ "${#segment_content[@]}" -eq 0 ]]
  then
    echo ""
    return
  fi
  # Run the actual computation and get the filling string
  _compute_hfill_size
  # Reset line string that store the prompt line
  prompt_line=""
  # Compute starting of prompt line
  _init_final_prompt_line
  # Compute the content of prompt line
  _compute_final_prompt_line
  # Reset background and foreground at the end of prompt line
  prompt_line+="${NORMAL}"
  # Output the content to be catched when called
  echo -e "${prompt_line}"
}

# SC2155: Declare and assign separately to avoid masking return values.
# shellcheck disable=SC2155
_main_prompt()
{
  # """TODO"""
  # Use both `FUNCNAME` for bash and `funcstack` for zsh
  prompt_debug "INFO" "Entering ${FUNCNAME[0]}${funcstack[1]}"
  # Declare local variable
  local final_prompt
  local idx_prompt_line
  local idx_start_prompt_lines
  local idx_stop_prompt_lines
  local last_idx
  local fg_clr
  local prompt_line
  # Initialiaze counter depending of shell
  case ${SHELL} in
    *bash)
      idx_start_prompt_lines=0
      idx_stop_prompt_lines=${#SEGMENT[@]}
      ;;
    *zsh)
      idx_start_prompt_lines=1
      idx_stop_prompt_lines=$(( ${#SEGMENT[@]} + 1 ))
      ;;
  esac
  # Compute final prompt lines for each lines defined in SEGMENT
  for (( idx_prompt_line=idx_start_prompt_lines;
         idx_prompt_line<idx_stop_prompt_lines;
         idx_prompt_line++ ))
  do
    prompt_debug "INFO" "Computing prompt line ${idx_prompt_line} SEGMENT"
    # Avoid using subshell to compute prompt_line
    # https://unix.stackexchange.com/questions/334543/capture-the-output-of-a-shell-function-without-a-subshell
    prompt_line="$(_prompt_line "${idx_prompt_line}" "SEGMENT" "SEGMENT_PRIORITY")"
    # If segment line is not empty
    if [[ -n "${prompt_line}" ]]
    then
      if [[ -z "${final_prompt}" ]]
      then
        if [[ ${PROMPT_VERSION} -eq 1 ]] && ! [[ ${SEGMENT[*]} =~ "hfill" ]]
        then
          fg_clr="DEFAULT_BG"
          case ${SHELL} in
            *bash)
              fg_clr="${fg_clr^^}"
              fg_clr="${!fg_clr}"
              ;;
            *zsh)
              fg_clr="${fg_clr:u}"
              # - SC2296: Parameter expansions can't start with (, Double check
              #           syntax.
              # shellcheck disable=SC2296
              fg_clr="${(P)fg_clr}"
              ;;
          esac
          fg_clr="${CLR_FG_PREFIX}${fg_clr}"
          # If final_prompt is still empty
          prompt_line+="${NORMAL}${CLR_PREFIX}${fg_clr}${CLR_SUFFIX}${S_LINE_PROMPT_END}"
        fi
        final_prompt="${final_prompt}${prompt_line}"
      else
        final_prompt="${final_prompt}\n${prompt_line}"
      fi
      # If line is not empty, update idx of the last non empty line
      last_idx=${idx_prompt_line}
    fi
  done
  # If last segment has hfill segment, set input char in the new line
  if [[ ${SEGMENT[last_idx]} =~ "hfill" ]]
  then
    final_prompt+="\n"
  fi
  # Compute ending of final_prompt depending on the terminal
  case ${SHELL} in
    *bash)
      if [[ $(whoami) == "root" ]]
      then
        final_prompt+="${NORMAL}${BOLD}"
      else
        final_prompt+="${NORMAL}"
      fi
      if [[ ${SEGMENT[last_idx]} =~ "hfill" ]]
      then
        final_prompt+="${M_LINE_PROMPT_END}"
      fi
      final_prompt="$(echo -e "${final_prompt}")"
      # Finally export PS1 variable for bash
      export PS1="${final_prompt}"
      ;;
    *zsh)
      if [[ $(whoami) == "root" ]]
      then
        # SC2034: zle_highlight appears unused. Verify it or export it.
        # shellcheck disable=SC2034
        zle_highlight=(default:bold)
      else
        # SC2034: zle_highlight appears unused. Verify it or export it.
        # shellcheck disable=SC2034
        zle_highlight=(default:normal)
      fi
      if [[ ${SEGMENT[last_idx]} =~ "hfill" ]]
      then
        final_prompt+="${M_LINE_PROMPT_END}"
      fi
      s_prompt="Correct ${CLR_PREFIX}${CLR_FG_PREFIX}${CORRECT_WRONG_FG}${CLR_SUFFIX}%R%f to ${CLR_PREFIX}${CLR_FG_PREFIX}${CORRECT_RIGHT_FG}${CLR_SUFFIX}%r%f [Nyae]?"
      # Finally export PROMPTS variables for zsh
      export PROMPT=$(echo -e "${final_prompt}")
      export RPROMPT=""
      export SPROMPT=$(echo -e "${s_prompt}")
      ;;
  esac
}

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=bash: ts=2: sw=2: sts=2
# *****************************************************************************
