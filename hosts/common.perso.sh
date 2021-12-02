#!/usr/bin/env bash
#*******************************************************************************
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
#*******************************************************************************

# SHELLCHECK
# =============================================================================
# shellcheck disable=SC2168,SC2034
#  - SC2168: 'local' is only valid in functions.
#            This error is normal as this files is sourced within a function
#  - SC2034: VARIABLE appears unused. Verify it or export it.
#            This warning is normal as this files is sourced within a function

# DESCRIPTION:
# =============================================================================
# Setup colors and boolean common for all my workstation, define a base
# coloring. Then, I update only needed value in $(hostname).sh file next to this
# file.
#local SEGMENT=(
#  "return_code, tmux, pwd, hfill, keepass, username, hostname"
#  "vcsh, virtualenv, vcs, hfill, kube, openstack, bgjobs"
#)
#local SEGMENT_PRIORITY=(
#  "tmux, username, hostname, keepass, return_code, pwd"
#  "vcsh, virtualenv, kube, openstack, vcs, bgjobs"
#)
#

# CHARACTER ENVIRONMENT SETUP
# =============================================================================
# Check if terminal emulator support unicode char or glyphs.
# To support glyphs, i.e. default character for segment, such as " ",
# I strongly recommend installing nerdfonts, see :
#    - https://github.com/buzzkillhardball/nerdfonts
# And setup your terminal to use one of these fonts.
# Personnaly, I use 'FiraCode Nerd Font'
if [[ -z "${SHELL_APP}" ]] \
  || ! [[ "${UNICODE_SUPPORTED_TERM[*]}" =~ ${SHELL_APP} ]]
then # Prompt does not support glyphs or unicode char
  # ---------------------------------------------------------------------------
  # GENERAL VARIABLES
  # ---------------------------------------------------------------------------
  if [[ ${PROMPT_VERSION} -eq 1 ]]
  then
    # Prompt _v1_
    local PROMPT_ENV_LEFT="["      # v1 Default "["
    local PROMPT_ENV_RIGHT="]"     # v1 Default "]"
    local S_LINE_PROMPT_END=""     # Default ""
    local M_LINE_PROMPT_END=" ﬌ "  # Default " ﬌ "
  else
    # Prompt _v2_
    local PROMPT_ENV_LEFT=""       # v2 Default ""
    local PROMPT_ENV_RIGHT=""      # v2 Default ""
    local S_LINE_PROMPT_END=""    # Default ""
    local M_LINE_PROMPT_END=" ﬌ "  # Default " ﬌ "
  fi
  # ---------------------------------------------------------------------------
  # SEGMENT CHARACTERS
  # ---------------------------------------------------------------------------
  local RETURN_CODE_CHAR=""     # Default " "
  local PWD_CHAR="·"              # Default " "
  local KEEPASS_CHAR="K|"         # Default " "
  local TMUX_CHAR="T|"            # Default " "
  local VCSH_CHAR="V|"            # Default " "
  local KUBE_CHAR="K|"            # Default "⎈ "
  local OPENSTACK_CHAR="O|"       # Default " "
  local VIRTUALENV_CHAR="P|"      # Default " "
  local USERNAME_CHAR="_"         # Default " "
  local HOSTNAME_CHAR="@"         # Default " "
  local BGJOBS_CHAR="&"           # Default "&"
  # ---------------------------------------------------------------------------
  # Git related variable (vcs related)
  # ---------------------------------------------------------------------------
  local GIT_CHAR="¤"              # Default ""
  local GIT_PROMPT_DIRTY="X"      # Default "✗"
  local GIT_PROMPT_CLEAN="V"      # Default "✓"
  local GIT_BRANCH_PREFIX="-|-"   # Default ""
  local GIT_TAG_PREFIX="T ["      # Default "笠["
  local GIT_TAG_SUFFIX="]"        # Default "]"
  local GIT_DETACHED_PREFIX="D [" # Default " ["
  local GIT_DETACHED_SUFFIX="]"   # Default "]"
  local GIT_AHEAD_CHAR="↑"        # Default "ﰵ"
  local GIT_BEHIND_CHAR="↓"       # Default "ﰬ"
  local GIT_UNTRACKED_CHAR="?"    # Default ""
  local GIT_UNSTAGED_CHAR="-"     # Default ""
  local GIT_STAGED_CHAR="+"       # Default ""
  local GIT_STASH_CHAR_PREFIX="{" # Default "{"
  local GIT_STASH_CHAR_SUFFIX="}" # Default "}"
else # terminal emulator support unicode and glyphs char
  # ---------------------------------------------------------------------------
  # GENERAL VARIABLES
  # ---------------------------------------------------------------------------
  if [[ ${PROMPT_VERSION} -eq 1 ]]
  then
    # Prompt _v1_
    local PROMPT_ENV_LEFT="["     # v1 Default "["
    local PROMPT_ENV_RIGHT="]"    # v1 Default "]"
    local S_LINE_PROMPT_END=""   # Default ""
    local M_LINE_PROMPT_END=" ﬌ " # Default " ﬌ "
  else
    # Prompt _v2_
    local PROMPT_ENV_LEFT=" "    # v2 Default ""
    local PROMPT_ENV_RIGHT=" "   # v2 Default ""
    local S_LINE_PROMPT_END=""   # Default ""
    local M_LINE_PROMPT_END=" ﬌ "   # Default " ﬌ "
  fi
  # ---------------------------------------------------------------------------
  # SEGMENT CHARACTERS
  # ---------------------------------------------------------------------------
  local RETURN_CODE_CHAR=" "     # Default " "
  local PWD_CHAR=" "             # Default " "
  local KEEPASS_CHAR=" "         # Default " "
  local TMUX_CHAR=" "            # Default " "
  local VCSH_CHAR=" "            # Default " "
  local KUBE_CHAR="☸ "            # Default "☸ "
  local OPENSTACK_CHAR=" "       # Default " "
  local VIRTUALENV_CHAR=" "      # Default " "
  local USERNAME_CHAR=" "        # Default " "
  local HOSTNAME_CHAR=" "        # Default " "
  local BGJOBS_CHAR=" "          # Default "&"
  # ---------------------------------------------------------------------------
  # Git related variable (vcs related)
  # ---------------------------------------------------------------------------
  local GIT_CHAR=" "             # Default ""
  local GIT_PROMPT_DIRTY="✗"      # Default "✗"
  local GIT_PROMPT_CLEAN="✓"      # Default "✓"
  local GIT_BRANCH_PREFIX=""     # Default ""
  local GIT_TAG_PREFIX="笠["      # Default "笠["
  local GIT_TAG_SUFFIX="]"        # Default "]"
  local GIT_DETACHED_PREFIX=" [" # Default " ["
  local GIT_DETACHED_SUFFIX="]"   # Default "]"
  local GIT_AHEAD_CHAR="ﰵ"        # Default "ﰵ"
  local GIT_BEHIND_CHAR="ﰬ"       # Default "ﰬ"
  local GIT_UNTRACKED_CHAR="?"    # Default ""
  local GIT_UNSTAGED_CHAR="−"     # Default ""
  local GIT_STAGED_CHAR="+"       # Default ""
  local GIT_STASH_CHAR_PREFIX="{" # Default "{"
  local GIT_STASH_CHAR_SUFFIX="}" # Default "}"
fi
local VCS_CHAR=${GIT_CHAR}        # Default ""
local VCS_COMPRESSED="false"        # Default "true"

# COLOR SETUP
# =============================================================================
# Color syntax
# -----------------------------------------------------------------------------
# Syntax for terminal that support up to 8/16 colors or up to 256 colors:
#   - https://misc.flogisoft.com/bash/tip_colors_and_formatting
# To know if your terminal support true colors (i.e. 24 bits colors), and the
# syntax to use:
#   - https://gist.github.com/XVilka/8346728
#
# FOR THE COLOR CODE, AS SHOWN BELOW, JUST ENTER THE CODE, DO NOT ENTER PREFIX:
#
#  | Color            | 8 colors   | 256 colors   | True colors      |
#  | ---------------- |:----------:|:------------:|:----------------:|
#  | Red Background   | 1          | 196          | 255;0;0          |
#  | Green Background | 2          | 046          | 0;255;0          |
#  | Blue Background  | 4          | 021          | 0;0;255          |
#   etc
#
# Set of 256 hexadecimal colors supported by 256 colors terminal are shown at
# the end of this file.

if [[ "${TRUE_COLOR_TERM[*]}" =~ ${SHELL_APP} ]]
then # Terminal support true colors
  # ---------------------------------------------------------------------------
  # GENERAL VARIABLES
  # ---------------------------------------------------------------------------
  local DEFAULT_FG="0;0;0"             # rgb(000,000,000) #000000
  local DEFAULT_BG="95;0;0"            # rgb(095,000,000) #5F0000
  local CORRECT_WRONG_FG="215;0;0"     # rgb(215,000,000) #D70000
  local CORRECT_RIGHT_FG="0;215;0"     # rgb(000,215,000) #00D700
  # ---------------------------------------------------------------------------
  # SEGMENT COLORS
  # ---------------------------------------------------------------------------
  local RETURN_CODE_FG="0;0;0"         # rgb(000,000,000) #000000
  local RETURN_CODE_BG="215;0;0"       # rgb(215,000,000) #D70000
  local PWD_FG="215;215;215"           # rgb(215,215,215) #D7D7D7
  local PWD_BG="28;28;28"              # rgb(028,028,028) #1C1C1C
  local KEEPASS_FG="255;255;255"       # rgb(255,255,255) #FFFFFF
  local KEEPASS_BG="0;95;95"           # rgb(000,095,095) #005F5F
  local TMUX_FG="0;0;0"                # rgb(000,000,000) #000000
  local TMUX_BG="0;95;135"             # rgb(000,095,135) #005F87
  local VCSH_FG="0;0;0"                # rgb(000,000,000) #000000
  local VCSH_BG="0;95;95"              # rgb(000,095,095) #005F5F
  local KUBE_FG="255;255;255"          # rgb(255,255,255) #FFFFFF
  local KUBE_BG="0;135;255"            # rgb(000,135,255) #0087FF
  local OPENSTACK_FG="255;255;255"     # rgb(255,255,255) #FFFFFF
  local OPENSTACK_BG="135;0;0"         # rgb(135,000,000) #870000
  local VIRTUALENV_FG="0;0;0"          # rgb(000,000,000) #000000
  local VIRTUALENV_BG="95;135;0"       # rgb(095,135,000) #5F8700
  local USERNAME_FG="0;0;0"            # rgb(000,000,000) #000000
  local USERNAME_BG="95;135;0"         # rgb(095,135,000) #5F8700
  local HOSTNAME_FG="0;0;0"            # rgb(000,000,000) #000000
  local HOSTNAME_BG="175;135;0"        # rgb(175,135,000) #AF8700
  local BGJOBS_FG="0;95;135"           # rgb(000,095,135) #005F87
  local BGJOBS_BG="30;30;30"           # rgb(030,030,030) #1E1E1E
  local VCS_FG="95;0;0"                # rgb(095,000,000) #5F0000
  local VCS_BG="30;30;30"              # rgb(030,030,030) #1E1E1E
  # ---------------------------------------------------------------------------
  # Git related variable (vcs related)
  # ---------------------------------------------------------------------------
  local VCS_PROMPT_DIRTY_FG="135;0;0"  # rgb(135,000,000) #870000
  local VCS_PROMPT_CLEAN_FG="0;135;0"  # rgb(000,135,000) #008700
  local VCS_BRANCH_FG="0;95;135"       # rgb(000,095,135) #005F87
  local VCS_TAG_FG="95;0;0"            # rgb(095,000,000) #5F0000
  local VCS_DETACHED_FG="95;0;0"       # rgb(095,000,000) #5F0000
  local VCS_COMMIT_FG="0;95;135"       # rgb(000,095,135) #005F87
  local VCS_AHEAD_FG="0;135;0"         # rgb(000,135,000) #008700
  local VCS_BEHIND_FG="95;0;0"         # rgb(095,000,000) #5F0000
  local VCS_UNTRACKED_FG="135;135;135" # rgb(135,135,135) #878787
  local VCS_UNSTAGED_FG="135;95;0"     # rgb(135,095,000) #875F00
  local VCS_STAGED_FG="0;95;0"         # rgb(000,095,000) #005F00
  local VCS_STASH_FG="95;0;95"         # rgb(095,000,095) #5F005F
elif { [[ "${SHELL_APP}" != "unkown" ]] && [[ "${SHELL_APP}" != "tty" ]]; } \
  && [[ "$(tput colors)" -eq 256 ]]
then # If terminal support 256 colors and is not unkown neither tty
  # ---------------------------------------------------------------------------
  # GENERAL VARIABLES
  # ---------------------------------------------------------------------------
  local DEFAULT_FG="16"          # rgb(000,000,000) #000000
  local DEFAULT_BG="52"          # rgb(095,000,000) #5F0000
  local CORRECT_WRONG_FG="160"   # rgb(215,000,000) #D70000
  local CORRECT_RIGHT_FG="40"    # rgb(000,215,000) #00D700
  # ---------------------------------------------------------------------------
  # SEGMENT COLORS
  # ---------------------------------------------------------------------------
  local RETURN_CODE_FG="16"      # rgb(000,000,000) #000000
  local RETURN_CODE_BG="160"     # rgb(215,000,000) #D70000
  local PWD_FG="188"             # rgb(215,215,215) #D7D7D7
  local PWD_BG="234"             # rgb(028,028,028) #1C1C1C
  local KEEPASS_FG="234"         # rgb(255,255,255) #FFFFFF
  local KEEPASS_BG="23"          # rgb(000,095,095) #005F5F
  local TMUX_FG="16"             # rgb(000,000,000) #000000
  local TMUX_BG="24"             # rgb(000,095,135) #005F87
  local VCSH_FG="16"             # rgb(000,000,000) #000000
  local VCSH_BG="23"             # rgb(000,095,095) #005F5F
  local KUBE_FG="234"            # rgb(255,255,255) #FFFFFF
  local KUBE_BG="33"             # rgb(000,135,255) #0087FF
  local OPENSTACK_FG="234"       # rgb(255,255,255) #FFFFFF
  local OPENSTACK_BG="88"        # rgb(135,000,000) #870000
  local VIRTUALENV_FG="16"       # rgb(000,000,000) #000000
  local VIRTUALENV_BG="64"       # rgb(095,135,000) #5F8700
  local USERNAME_FG="16"         # rgb(000,000,000) #000000
  local USERNAME_BG="64"         # rgb(095,135,000) #5F8700
  local HOSTNAME_FG="16"         # rgb(000,000,000) #000000
  local HOSTNAME_BG="136"        # rgb(175,135,000) #AF8700
  local BGJOBS_FG="24"           # rgb(000,095,135) #005F87
  local BGJOBS_BG="234"          # rgb(028,028,028) #1C1C1C
  local VCS_FG="52"              # rgb(095,000,000) #5F0000
  local VCS_BG="234"             # rgb(028,028,028) #1C1C1C
  # ---------------------------------------------------------------------------
  # Git related variable (vcs related)
  # ---------------------------------------------------------------------------
  local VCS_PROMPT_DIRTY_FG="88" # rgb(135,000,000) #870000
  local VCS_PROMPT_CLEAN_FG="28" # rgb(000,135,000) #008700
  local VCS_BRANCH_FG="24"       # rgb(000,095,135) #005F87
  local VCS_TAG_FG="52"          # rgb(095,000,000) #5F0000
  local VCS_DETACHED_FG="52"     # rgb(095,000,000) #5F0000
  local VCS_COMMIT_FG="24"       # rgb(000,095,135) #005F87
  local VCS_AHEAD_FG="28"        # rgb(000,135,000) #008700
  local VCS_BEHIND_FG="52"       # rgb(095,000,000) #5F0000
  local VCS_UNTRACKED_FG="102"   # rgb(135,135,135) #878787
  local VCS_UNSTAGED_FG="94"     # rgb(135,095,000) #875F00
  local VCS_STAGED_FG="022"      # rgb(000,095,000) #005F00
  local VCS_STASH_FG="52"        # rgb(095,000,095) #5F005F
else
  # Default case, shell support a maximum to 16 color or shell_app
  # is unkown or tty
  # Fallback case to ensure working coloration
  # ---------------------------------------------------------------------------
  # GENERAL VARIABLES
  # ---------------------------------------------------------------------------
  local DEFAULT_FG="0"           # Usually black
  local DEFAULT_BG="1"           # Usually red
  local CORRECT_WRONG_FG="1"     # Usually red
  local CORRECT_RIGHT_FG="2"     # Usually green
  # ---------------------------------------------------------------------------
  # SEGMENT COLORS
  # ---------------------------------------------------------------------------
  local RETURN_CODE_FG="0"       # Usually black
  local RETURN_CODE_BG="1"       # Usually red
  local PWD_FG="9"               # Usually white
  local PWD_BG="0"               # Usually black
  local KEEPASS_FG="0"           # Usually white
  local KEEPASS_BG="6"           # Usually cyan
  local TMUX_FG="0"              # Usually black
  local TMUX_BG="4"              # Usually blue
  local VCSH_FG="0"              # Usually black
  local VCSH_BG="6"              # Usually cyan
  local KUBE_FG="0"              # Usually black
  local KUBE_BG="4"              # Usually blue
  local OPENSTACK_FG="9"         # Usually white
  local OPENSTACK_BG="1"         # Usually red
  local VIRTUALENV_FG="0"        # Usually black
  local VIRTUALENV_BG="2"        # Usually green
  local USERNAME_FG="0"          # Usually black
  local USERNAME_BG="2"          # Usually green
  local HOSTNAME_FG="0"          # Usually black
  local HOSTNAME_BG="3"          # Usually yellow
  local BGJOBS_FG="4"            # Usually blue
  local BGJOBS_BG="1"            # Usually black
  local VCS_FG="1"               # Usually red
  local VCS_BG="0"               # Usually black
  # ---------------------------------------------------------------------------
  # Git related variable (vcs related)
  # ---------------------------------------------------------------------------
  local VCS_PROMPT_DIRTY_FG="1"  # Usually red
  local VCS_PROMPT_CLEAN_FG="2"  # Usually green
  local VCS_BRANCH_FG="4"        # Usually blue
  local VCS_TAG_FG="1"           # Usually red
  local VCS_DETACHED_FG="1"      # Usually red
  local VCS_COMMIT_FG="4"        # Usually blue
  local VCS_AHEAD_FG="2"         # Usually green
  local VCS_BEHIND_FG="1"        # Usually red
  local VCS_UNTRACKED_FG="9"     # Usually white
  local VCS_UNSTAGED_FG="3"      # Usually yellow
  local VCS_STAGED_FG="2"        # Usually green
  local VCS_STASH_FG="5"         # Usually magenta
fi

# PROMPT_VERSION 1
# ----------------------------------------------------------------------------
if [[ ${PROMPT_VERSION} -eq  1 ]]
then
  # If PROMPT_VERSION=1, just use the variables we define for prompt v2 but
  # swap background and foreground for some of them (i.e. mainly segment which
  # background is not black)
  # ---------------------------------------------------------------------------
  # SEGMENT COLORS
  # ---------------------------------------------------------------------------
  local RETURN_CODE_FG="${RETURN_CODE_FG}"
  local PWD_FG="${PWD_FG}"
  local KEEPASS_FG="${KEEPASS_BG}"
  local TMUX_FG="${TMUX_BG}"
  local VCSH_FG="${VCSH_BG}"
  local KUBE_FG="${KUBE_BG}"
  local OPENSTACK_FG="${OPENSTACK_BG}"
  local VIRTUALENV_FG="${VIRTUALENV_BG}"
  local USERNAME_FG="${USERNAME_BG}"
  local HOSTNAME_FG="${HOSTNAME_BG}"
  local BGJOBS_FG="${BGJOBS_FG}"
  local VCS_FG="${VCS_FG}"
  # ---------------------------------------------------------------------------
  # Git related variable (vcs related)
  # ---------------------------------------------------------------------------
  local VCS_PROMPT_DIRTY_FG="${VCS_PROMPT_DIRTY_FG}"
  local VCS_PROMPT_CLEAN_FG="${VCS_PROMPT_CLEAN_FG}"
  local VCS_BRANCH_FG="${VCS_BRANCH_FG}"
  local VCS_TAG_FG="${VCS_TAG_FG}"
  local VCS_DETACHED_FG="${VCS_DETACHED_FG}"
  local VCS_COMMIT_FG="${VCS_COMMIT_FG}"
  local VCS_AHEAD_FG="${VCS_AHEAD_FG}"
  local VCS_BEHIND_FG="${VCS_BEHIND_FG}"
  local VCS_UNTRACKED_FG="${VCS_UNTRACKED_FG}"
  local VCS_UNSTAGED_FG="${VCS_UNSTAGED_FG}"
  local VCS_STAGED_FG="${VCS_STAGED_FG}"
  local VCS_STASH_FG="${VCS_STASH_FG}"
fi


# Equivalent hexadecimal color for each code value for the 256 colors when term
# support it.
# Usefull when using vim-plugin colorizer or any plugin show hex colors
# =============================================================================
              # 016 #000000 # 017 #00005f # 018 #000087 # 019 #0000af
# 020 #0000d7 # 021 #0000ff # 022 #005f00 # 023 #005f5f # 024 #005f87
# 025 #005faf # 026 #005fd7 # 027 #005fff # 028 #008700 # 029 #00875f
# 030 #008787 # 031 #0087af # 032 #0087d7 # 033 #0087ff # 034 #00af00
# 035 #00af5f # 036 #00af87 # 037 #00afaf # 038 #00afd7 # 039 #00afff
# 040 #00d700 # 041 #00d75f # 042 #00d787 # 043 #00d7af # 044 #00d7d7
# 045 #00d7ff # 046 #00ff00 # 047 #00ff5f # 048 #00ff87 # 049 #00ffaf
# 050 #00ffd7 # 051 #00ffff # 052 #5f0000 # 053 #5f005f # 054 #5f0087
# 055 #5f00af # 056 #5f00d7 # 057 #5f00ff # 058 #5f5f00 # 059 #5f5f5f
# 060 #5f5f87 # 061 #5f5faf # 062 #5f5fd7 # 063 #5f5fff # 064 #5f8700
# 065 #5f875f # 066 #5f8787 # 067 #5f87af # 068 #5f87d7 # 069 #5f87ff
# 070 #5faf00 # 071 #5faf5f # 072 #5faf87 # 073 #5fafaf # 074 #5fafd7
# 075 #5fafff # 076 #5fd700 # 077 #5fd75f # 078 #5fd787 # 079 #5fd7af
# 080 #5fd7d7 # 081 #5fd7ff # à82 #5fff00 # 083 #5fff5f # 084 #5fff87
# 085 #5fffaf # 086 #5fffd7 # 087 #5fffff # 088 #870000 # 089 #87005f
# 090 #870087 # 091 #8700af # 092 #8700d7 # 093 #8700ff # 094 #875f00
# 095 #875f5f # 096 #875f87 # 097 #875faf # 098 #875fd7 # 099 #875fff
# 100 #878700 # 101 #87875f # 102 #878787 # 103 #8787af # 104 #8787d7
# 105 #8787ff # 106 #87af00 # 107 #87af5f # 108 #87af87 # 109 #87afaf
# 110 #87afd7 # 111 #87afff # 112 #87d700 # 113 #87d75f # 114 #87d787
# 115 #87d7af # 116 #87d7d7 # 117 #87d7ff # 118 #87ff00 # 119 #87ff5f
# 120 #87ff87 # 121 #87ffaf # 122 #87ffd7 # 123 #87ffff # 124 #af0000
# 125 #af005f # 126 #af0087 # 127 #af00af # 128 #af00d7 # 129 #af00ff
# 130 #af5f00 # 131 #af5f5f # 132 #af5f87 # 133 #af5faf # 134 #af5fd7
# 135 #af5fff # 136 #af8700 # 137 #af875f # 138 #af8787 # 139 #af87af
# 140 #af87d7 # 141 #af87ff # 142 #afaf00 # 143 #afaf5f # 144 #afaf87
# 145 #afafaf # 146 #afafd7 # 147 #afafff # 148 #afd700 # 149 #afd75f
# 150 #afd787 # 151 #afd7af # 152 #afd7d7 # 153 #afd7ff # 154 #afff00
# 155 #afff5f # 156 #afff87 # 157 #afffaf # 158 #afffd7 # 159 #afffff
# 160 #d70000 # 161 #d7005f # 162 #d70087 # 163 #d700af # 164 #d700d7
# 165 #d700ff # 166 #d75f00 # 167 #d75f5f # 168 #d75f87 # 169 #d75faf
# 170 #d75fd7 # 171 #d75fff # 172 #d78700 # 173 #d7875f # 174 #d78787
# 175 #d787af # 176 #d787d7 # 177 #d787ff # 178 #d7af00 # 179 #d7af5f
# 180 #d7af87 # 181 #d7afaf # 182 #d7afd7 # 183 #d7afff # 184 #d7d700
# 185 #d7d75f # 186 #d7d787 # 187 #d7d7af # 188 #d7d7d7 # 189 #d7d7ff
# 190 #d7ff00 # 191 #d7ff5f # 192 #d7ff87 # 193 #d7ffaf # 194 #d7ffd7
# 195 #d7ffff # 196 #ff0000 # 197 #ff005f # 198 #ff0087 # 199 #ff00af
# 200 #ff00d7 # 201 #ff00ff # 202 #ff5f00 # 203 #ff5f5f # 204 #ff5f87
# 205 #ff5faf # 206 #ff5fd7 # 207 #ff5fff # 208 #ff8700 # 209 #ff875f
# 210 #ff8787 # 211 #ff87af # 212 #ff87d7 # 213 #ff87ff # 214 #ffaf00
# 215 #ffaf5f # 216 #ffaf87 # 217 #ffafaf # 218 #ffafd7 # 219 #ffafff
# 220 #ffd700 # 221 #ffd75f # 222 #ffd787 # 223 #ffd7af # 224 #ffd7d7
# 225 #ffd7ff # 226 #ffff00 # 227 #ffff5f # 228 #ffff87 # 229 #ffffaf
# 230 #ffffd7 # 231 #ffffff # 232 #080808 # 233 #121212 # 234 #1c1c1c
# 235 #262626 # 236 #303030 # 237 #3a3a3a # 238 #444444 # 239 #4e4e4e
# 240 #585858 # 241 #626262 # 242 #6c6c6c # 243 #767676 # 244 #808080
# 245 #8a8a8a # 246 #949494 # 247 #9e9e9e # 248 #a8a8a8 # 249 #b2b2b2
# 250 #bcbcbc # 251 #c6c6c6 # 252 #d0d0d0 # 253 #dadada # 254 #e4e4e4
# 255 #eeeeee

# ******************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# ******************************************************************************
