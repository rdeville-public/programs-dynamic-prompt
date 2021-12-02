# Add your own segment

This tutorial will describe how to add a segment showing the date. It is a
simple one, but can be made to be dynamic, with colors, etc.

This segment will **never be added** to the main tree, as the aim of this
segment is to be the support of this tutorial. Moreover, I do not need it, but
feel free to keep it versionned on your own branch/fork :wink: and ensure that
it will be untracked when proposing a merge request.

This tutorial assumes that you have made a fork of the main repo, i.e. you
already read and applied
[Keep your configuration][keep_your_configuration] and
[Developers Guidelines][developers_guidelines].

## Build from template

I provide a simple script called `new_segment.sh` in the `root of this repo to
help you to create your own segment.

This script will ask you the name of the new segment you want to create as well
as a short description that will be put in the array of the documentation.

If segment does not already exists, the script will create:

  * A basic segment script in folder `segment/` from the template
    `segment/segment.sh.tpl`
  * A basic documentation of the segment in `docs/configuration/segments/` from
    a template `docs/configuration/segments/segment.md.tpl` and its entry into
    the `mkdocs.yml` file used to generate this documentation.
  * An entry in arrays in following pages:
    * [Home Page][home]
    * [All Supported Segment][home]
    * [Main README.md of the repo][main_repo]

To add your `date` segment, you have two possibilities:

  * Run the script `./new_segment.sh` without options, you will be asked
    interactively the name and a short description of the segment you want to add
    as shown below:

  * Run the script with the name of the segment you want to add as first argument,
    for instance `./new_segment.sh -n date -d "Short description"`

This will automatically create two files:

  * `segment/date.sh` Which host the content of your segment
  * `docs/configuration/segments/date.md`: Which host the documentation of your
    segment

For more information about the script usage, use `-h` options like
`./new_segment.sh -h` or check the online [`new_segment.sh`][new_segment] script
documentation.

## The script `segment/date.sh`

Below is the content of the generated file `segment/date.sh`:

```bash
#!/bin/bash
# *****************************************************************************
# License : GNU General Public License v3.0
# Author  : FirstName LastName <your@email.tld>
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
# Set the variables and methods to compute the content of segment date

# VARIABLES
# =============================================================================
# Set variables for date segment
local DATE_CHAR="${DATE_CHAR:-"X"}"
local DATE_FG="${DATE_FG:-${DEFAULT_FG}}"
local DATE_BG="${DATE_BG:-${DEFAULT_BG}}"

# METHODS
# =============================================================================
_compute_date_info()
{
  # If the output of the command is non-empty, print the date char
  # and the content of the output of the command.
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output="$(echo "segment_content")"
  if [[ -n "${cmd_output}" ]]
  then
    info="${DATE_CHAR}${cmd_output}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${DATE_CHAR}date"
  fi
  echo -e "${info}"
}

_compute_date_info_short()
{
  # If the output of the command is non-empty, print the date char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output="$(echo "segment_content")"
  if [[ -n "${cmd_output}" ]]
  then
    info="${DATE_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${DATE_CHAR}"
  fi
  echo -e "${info}"
}

# REQUIRED METHODS
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_date_info()
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
  local info=$(_compute_date_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: date is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[date]="${info}"
    segment_content_clr[date]="${info}"
    segment_fg[date]="${DATE_FG}"
    segment_bg[date]="${DATE_BG}"
  fi
}

_date_info_short()
{
  # Required method to get segment in short format. If segment content is
  # non-empty, update arrays used to compute prompt lines. Arrays are such:
  # - segment_content_short:
  #     store content of segment in short version without colors
  # - segment_content_short_clr:
  #     store content of segment in short version with colors if segment use
  #     inner colors
  # NO PARAM

  local info=$(_compute_date_info_short)
  if [[ -n "${info}" ]]
  then
    segment_content_short[date]="${info}"
    segment_content_short_clr[date]="${info}"
  fi
}
# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
```

Before continuing, let us take a quick look at what is it inside.

!!! note
    To make this tutorial more generic, in the following section, i.e. [Quick
    Look][quick_look], I'll use `SEGMENT/segment` instead of `date`.

    For instance `SEGMENT_CHAR` instead of `DATE_CHAR` for variable or
    `_segment_info_short` instead of `_date_info_short` for methods.

    If your segment is called, let us say `cpu_usage`, then the variable will be
    called `CPU_USAGE_CHAR` and method will be called `_cpu_usage_info_short`,
    etc.

### Quick look

#### Main variables

```bash
# Showing segment info
local SEGMENT_CHAR="${SEGMENT_CHAR:-"X"}"
local SEGMENT_FG="${SEGMENT_FG:-${DEFAULT_FG}}"
local SEGMENT_BG="${SEGMENT_BG:-${DEFAULT_BG}}"
```

These are the main variables used by all segments which will mainly define:

  * The basic segment character to display in the beginning of the segment or
    when shorten.

  * The value for foreground and background colors when user does not set
    variable `SEGMENT_FG` and `SEGMENT_BG` in files in `hosts/` folder. By
    default it falls back to the default foreground `DEFAULT_FG` and
    `DEFAULT_BG`, respectively white and black.

These variables are mandatory because they are used by main script `prompt.sh`.

#### `_compute_segment_info()` method

```bash
_compute_segment_info()
{
  # If the output of the command is non-empty, print the segment char
  # and the content of the output of the command.
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output="$(echo "segment_content")"
  if [[ -n "${cmd_output}" ]]
  then
    info="${SEGMENT_CHAR}${cmd_output}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${SEGMENT_CHAR}segment"
  fi
  echo -e "${info}"
}
```

This method is here to echo the content of the segment when the segment is not
shorten. In this basic method, the segment content is computed and stored in
variable `cmd_output`.

If this output is not empty, this output will be the content of the segment.

It will mainly be in this method that you will work to make your own segment.

!!! note
    If global variable `DEBUG_MODE` exists, whatever its value, even if the
    output of the command is empty, then the segment content will be set to a
    fake value to force the display of the segment.


#### `_compute_segment_info_short()` method

```bash
_compute_segment_info_short()
{
  # If the output of the command is non-empty, print the segment char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  cmd_output="$(echo "segment_content")"
  if [[ -n "${cmd_output}" ]]
  then
    info="${SEGMENT_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${SEGMENT_CHAR}"
  fi
  echo -e "${info}"
}
```

This method is almost like the previous one but will echo the shorten version of
the segment, usually only the segment character as show in this example.


!!! note
    If global variable `DEBUG_MODE` exists, whatever its value, even if the
    output of the command is empty, then the segment content will be set to a
    fake value to force the display of the segment.

#### `_segment_info()` method

```bash
_segment_info()
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
  local info=$(_compute_segment_info)
  if [[ -n "${info}" ]]
  then
    # shellcheck disable=SC2154
    # SC2154: segment is referenced but not assigned.
    # -----> Don't know why shellcheck show this warning ??
    # see: https://github.com/koalaman/shellcheck/wiki/SC2154
    segment_content[segment]="${info}"
    segment_content_clr[segment]="${info}"
    segment_fg[segment]="${SEGMENT_FG}"
    segment_bg[segment]="${SEGMENT_BG}"
  fi
}
```

This is one of the two required method by `prompt.sh`. This method will
update arrays to construct your prompt.

!!! important
    Normally, you will not have anything to do here, except if your segment have
    inner colors (see section [Adding colors][adding_inner_colors]). Just leave this
    method like this and especially **DO NOT RENAME IT**, otherwise your segment
    will not work !

As you can see, this method rely on the method `_compute_segment_info`. You can
rename the method `_compute_segment_info` but do not forget to update the call
of you renamed method.

#### `_segment_info_short()` method

```bash
_segment_info_short()
{
  # Required method to get segment in short format. If segment content is
  # non-empty, update arrays used to compute prompt lines. Arrays are such:
  # - segment_content_short:
  #     store content of segment in short version without colors
  # - segment_content_short_clr:
  #     store content of segment in short version with colors if segment use
  #     inner colors
  # NO PARAM

  local info=$(_date_info_short)
  if [[ -n ${info}]]
  then
    info_line_short[$iSegment]="${info}"
    info_line_clr_short[$iSegment]="${info}"
  fi
}
```

This is the second method required by `prompt.sh`. This method will update
arrays used to construct your prompt, mainly arrays storing shorten version of
your segment.

!!! important

    Normally, you will not have anything to do here. Just leave this method like
    this and especially **DO NOT RENAME IT**, otherwise your segment will not
    work !

As you can see, this method rely on the method `_compute_segment_info_short`.
You can rename the method `_compute_segment_info_short` but do not forget to
update the call of your renamed method.

### Compute the date

Now that the untemplated segment script is described, let us go back to our
`date` segment.

As described above, we will need to update method `_compute_date_info` and
`_compute_date_info_short`

Let us assume we want to show the date in 24h format like this `HH:MM`.

The bash command to do so is :

```bash
date "+%H:%M"
```

So let us update the method `_compute_date_info` as shown below:

```bash hl_lines="9"
_compute_date_info()
{
  # If the output of the command is non-empty, print the date char
  # and the content of the output of the command.
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output="$(date "+%H:%M")"
  if [[ -n "${cmd_output}" ]]
  then
    info="${DATE_CHAR}${cmd_output}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${DATE_CHAR}date"
  fi
  echo -e "${info}"
}
```

And let us update the method `_compute_date_info_short` as shown below:

```bash hl_lines="8"
_compute_date_info_short()
{
  # If the output of the command is non-empty, print the date char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  local cmd_output="$(date "+%H:%M")"
  if [[ -n "${cmd_output}" ]]
  then
    info="${DATE_CHAR}"
  elif [[ -n "${DEBUG_MODE}" ]]
  then
    # Force output when debug mode is activated
    info="${DATE_CHAR}"
  fi
  echo -e "${info}"
}
```

If you want, you can also provide a default value for the character shown before
the date. Let us use the character ` `. You will have to update the value of
`DATE_CHAR` at the beginning of the script as shown below:

```bash hl_lines="4"
# VARIABLES
# =============================================================================
# Set variables for date segment
local DATE_CHAR="${DATE_CHAR:-" "}"
local DATE_FG="${DATE_FG:-${DEFAULT_FG}}"
local DATE_BG="${DATE_BG:-${DEFAULT_BG}}"
```

!!! note
    I assume you have made a fork of this repo following [Keep your
    configuration][keep_your_configuration]. I also assume you use the
    `common.sh` file in `hosts/` folder from the `common.example.sh` as I will
    use the content of `common.example.sh` as example for this tutorial. For
    more information, see [Configure your prompt][configure_your_prompt].

Now, let us update the variable `SEGMENT` and `SEGMENT_PRIORITY` in `common.sh`
to show our segment as shown below:

```bash hl_lines="2 7"
local SEGMENT=(
  "tmux, date, pwd, hfill, keepass, username, hostname"
  "vcsh, virtualenv, vcs, hfill, kube, openstack"
)

local SEGMENT_PRIORITY=(
  "tmux, date, username, hostname, keepass, pwd"
  "vcsh, virtualenv, kube, openstack, vcs"
)
```

Normally, your prompt should update from something like :

  * Prompt _v1_

    ![!Prompt v1 default][prompt_v1_default]

  * Prompt _v2_

    ![!Prompt v2 default][prompt_v2_default]

To something like this:

  * Prompt _v1_

    ![!Prompt v1 date segment][prompt_v1_date_segment]

  * Prompt _v2_

    ![!Prompt v2 date segment][prompt_v2_date_segment]

!!! important
    No need to enter any `source` command when working on script in `segment`
    folder, because they are reload automatically. You just need to close the
    file or type `<Enter>` in your terminal.

If you see your segment, this means the default behaviour of your segment is
ready to be customized by the user.

### Customize the segment

Now, our basic segment is ready to be customized by the user.

As we define variable `DATE_CHAR`, `DATE_FG` and `DATE_BG` in the beginning of
the segment scripts, we can use them in the file `common.sh` in the `hosts/`
folder.

Let us choose a magenta background and a yellow foreground. As define in
[Configure your prompt][configure_your_prompt_color_support],
there exists multiple way to define these colors depending on the colors
supported by your terminal.

For this tutorial, I choose the following value:

<center>

| Color                | 8 colors   | 256 colors   | True colors        |
| -------------------- |:----------:|:------------:|:------------------:|
| Yellow  Foreground   | `3`        | `201`        | `255;0;255`        |
| Magenta Background   | `5`        | `226`        | `255;225;0`        |

</center>

Moreover, let us say that I want the character ` ` instead of the clock when
terminal support unicode character and just the character `-` when not.

For more information about the unicode support, please refers to
[Configure your prompt][configure_your_prompt_unicode_support]

Let us update this file `hosts/common.sh` accordingly, (`[...]` means that line
of codes have been hidden):


```bash hl_lines="13 20 34 35 45 46 57 58 73 74 75"
# CHARACTER ENVIRONMENT SETUP
# ===========================================================================
# Check if terminal emulator support unicode char or glyphs.
# [...]
if [[ -z "${SHELL_APP}" ]] \
  || ! [[ "${UNICODE_SUPPORTED_TERM[*]}" =~ ${SHELL_APP} ]]
then # Prompt does not support glyphs or unicode char
  [...]
  # -------------------------------------------------------------------------
  # SEGMENT CHARACTERS
  # -------------------------------------------------------------------------
  [...]
  local DATE_CHAR="-"
else # terminal emulator support unicode and glyphs char
  [...]
  # -------------------------------------------------------------------------
  # SEGMENT CHARACTERS
  # -------------------------------------------------------------------------
  [...]
  local DATE_CHAR=" "
fi
[...]

# COLOR SETUP
# ===========================================================================
# [...]
if [[ "${TRUE_COLOR_TERM[*]}" =~ ${SHELL_APP} ]]
then # Terminal support true colors
  [...]
  # -------------------------------------------------------------------------
  # SEGMENT COLORS
  # -------------------------------------------------------------------------
  [...]
  local DATE_FG="225;225;0"
  local DATE_BG="225;0;255"
  [...]
elif ([[ "${SHELL_APP}" != "unkown" ]] && [[ "${SHELL_APP}" != "tty" ]]) \
  && [[ "$(tput colors)" -eq 256 ]]
then # If terminal support 256 colors and is not unkown neither tty
  [...]
  # -------------------------------------------------------------------------
  # SEGMENT COLORS
  # -------------------------------------------------------------------------
  [...]
  local DATE_FG="201"
  local DATE_BG="226"
  [...]
else
  # Default case, shell support a maximum to 16 color or shell_app
  # is unkown or tty
  # Fallback case to ensure working coloration
  [...]
  # -------------------------------------------------------------------------
  # SEGMENT COLORS
  # -------------------------------------------------------------------------
  [...]
  local DATE_FG="3"
  local DATE_BG="5"
  [...]
fi

# PROMPT_VERSION 1
# --------------------------------------------------------------------------
if [[ ${PROMPT_VERSION} -eq  1 ]]
then
  # If PROMPT_VERSION=1, just use the variables we define for prompt v2 but
  # swap background and foreground for some of them (i.e. mainly segment #
  # which background is not black)
  # -------------------------------------------------------------------------
  # SEGMENT COLORS
  # -------------------------------------------------------------------------
  [...]
  # Here we do lazy config and use the color we define as background for date
  # segment as the foreground colors for the same segment in Prompt v1
  local DATE_FG="${DATE_BG}"
  [...]
fi
[...]
```

Normally, now your prompt should look like this:

  * Prompt _v1_

    ![!Prompt v1 date colors user][prompt_v1_date_colors_user]

  * Prompt _v2_

    ![!Prompt v2 date colors user][prompt_v2_date_colors_user]

### Make clock dynamic

Ok, so for now, the clock is always displayed. Let us make it dynamic to show
the date only between 8:00 and 20:00.

To do so, we will need to create a new method, let us say `_compte_date` and we
will need to update methods `_compute_date_info` and `_compute_date_info_short`
again.

There is lots of way to do, some most optmized than other. First let us code the
method that will print the date only if date is between 8:00 and 20:00.

```bash
_compute_date()
{
  # Compute the date, only print the value HH:MM if
  # the hour is between 8:00 and 20:00.
  # NO PARAM

  # Get the hour
  local hour="$(date "+%H")"
  if [[ "${hour}" -ge 8 ]] && [[ "${hour}" -lt 20 ]]
  then
    echo -e "$(date "+%H:%M")"
  fi
}
```

Now let us update `_compute_data_info` and `_compute_date_info_short` to use
this method, (`[...]` means that line of codes have been hidden):

```bash hl_lines="9 10 21 22"
_compute_date_info()
{
  # If the output of the command is non-empty, print the date char
  # and the content of the output of the command.
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  # Use the method `_compute_date`
  local cmd_output="$(_compute_date)"
  [...]
}

_compute_date_info_short()
{
  # If the output of the command is non-empty, print the date char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM

  local info
  # Use the method `_compute_date`
  local cmd_output="$(_compute_date)"
  [...]
}
```

Now date will only be shown between 8:00 and 20:00 as shown below:

  * Prompt _v1_

    ![!Prompt v1 date color inside hours][prompt_v1_date_color_inside_hours]

    ![!Prompt v1 date color outside hours][prompt_v1_date_color_outside_hours]

  * Prompt _v2_

    ![!Prompt v2 date color inside hours][prompt_v2_date_color_inside_hours]

    ![!Prompt v2 date color outside hours][prompt_v2_date_color_outside_hours]

### Adding inner colors

Let us continue and go a little bit more fancy. Let us add colors for hours and
for minutes, for instance, showing hours in green and minutes in red.

To so, we will need:

  * A variable to define the hours color `DATE_FG_HOURS`
  * A variable to define the minutes color `DATE_FG_MINUTES`
  * To add method `_compute_date_color`
  * To update method `_date_info`

First, the variables, `DATE_FG_HOURS` and `DATE_FG_MINUTES`, like
other variables like `DATE_FG`, these variables should be put on top of the
script. Let also configure default value to red and green.

```bash hl_lines="6 7"
# Showing date info
local DATE_CHAR="${DATE_CHAR:-" "}"
local DATE_FG="${DATE_FG:-${DEFAULT_FG}}"
local DATE_BG="${DATE_BG:-${DEFAULT_BG}}"

local DATE_FG_HOURS="${DATE_FG_HOURS:-2}"
local DATE_FG_MINUTES="${DATE_FG_MINUTES:-1}"
```

These variable have default value and user can overwrite them in its
configuration files `common.sh` and/or `$(hostname).sh` in `hosts/` folder.


!!! important
    We will not need to update method `_compute_date` because this method will
    print plaintext content of the segment, i.e. without color, and is needed to
    compute size of segment rendering and especially for special segment
    `hfill`.

Now, let us add the method `_compute_date_color`. The method
`_compute_date_color` will print colored text of the segment.

Fortunately, to manage colors in your segment, you will not have to handle
colors prefix like `\e` or `\x1b` as scripts `prompt.sh` handle it in
variable `CLR_PREFIX` and `CLR_SUFFIX`. You will just need to add these
variables before and after your variable `DATE_FG_HOURS` and `DATE_FG_MINUTES`.

Below is the content of the `_compute_date_color` method:

```bash
_compute_date_color()
{
  # Get the hour
  local hour=$(date "+%H")
  local minute=$(date "+%M")
  # We will need to reset colors to print separator and the end of the segment
  # in _v1_ correctly
  local reset_color

  # Keep dynamic date, i.e. only show date if between 8:00 and 20:00
  if [[ ${hour} -ge 8 ]] && [[ ${hour} -lt 20 ]]
  then
    # Construct the colored hours
    hour=${CLR_PREFIX}${DATE_FG_HOURS}${CLR_SUFFIX}${hour}
    # Construct the colored minute
    minute=${CLR_PREFIX}${DATE_FG_MINUTES}${CLR_SUFFIX}${minute}
    # Construct the resetter color
    reset_color=${CLR_PREFIX}${DATE_FG}${CLR_SUFFIX}
    # Print the color segement
    echo -e "${DATE_CHAR} ${hour}${reset_color}:${minute}${reset_color}"
  fi
}
```

Finally, as our new segment now have inline color, let us update method
`_date_info`:

```bash hl_lines="8 9"
_date_info()
{
  # Required method to get segment in long format
  local info=$(_compute_date_info)
  if [[ -n "${info}" ]]
  then
    info_line[$iSegment]="${info}"
    # Call the colored version of the method _compute_date
    info_line_clr[$iSegment]="$(_compute_date_color)"
    info_line_fg[$iSegment]="${DATE_FG}"
    info_line_bg[$iSegment]="${DATE_BG}"
  fi
}
```

Normally, now your segment will only be printed between 8:00 and 20:00 and such
that hours are in red, minutes are in green and the rest of the segment is in
yellow as shown below (except if user change colors values in its configuration
files).

  * The _v1_, "classic" version

    ![!Prompt v1 date inner color inside hours][prompt_v1_date_inner_color_inside_hours]

    ![!Prompt v1 date inner color outside hours][prompt_v1_date_color_outside_hours]

  * The _v2_, "powerline" version


    ![!Prompt v2 date inner color inside hours][prompt_v2_date_inner_color_inside_hours]

    ![!Prompt v2 date inner color outside hours][prompt_v2_date_color_outside_hours]

If you are proud of your segment, or you simply think it can be used by other
users, you may want to submit your segment to be merge on the main repo.

But first, let us now document it.

### Document the code

As stated in PEP8 of python, code is more often read than write, and so should
be easily understand by a human. But it often is not easy to make it "human
readable" when using bash, especially if your segment is complex and optimized.

So, we will document the methods `_compute_date`, `_compute_date_color`.
`_compute_date_info` and  `_compute_date_info_short`.

!!! note "`_compute_date_info` and `_compute_date_info_short`"
    These methods already have a base documentation, you may not need to update
    them but you will need to review them to be sure.

!!! note "`_date_info` and `_date_info_short`"

    No need to document methods `_date_info` and `_date_info_short` as these
    method are already documented from the template segment and normally you do
    not have made huge modification in their behaviour.

Moreover, unfortunately, there is no docstring in bash, we will use comment like
describe in [Developers Guidelines][developers_guidelines_style_code]:


??? Example "Example (Click to reveal)"
    ```bash
    function func_name()
    {
      # This is a docstring like expliciting what func_name do
      # *PARAM $1: string, explicit description of the required (`*`) expected string
      # PARAM $2: string, explicit description of the optional expected string
      # NO PARAM: -> Means that NO PARAM is required or optional for this
      #             function
    }
    ```

So apply to our methods, this will give:

```bash hl_lines="3 4 5 11 12 13 14 20 21 22 23 29 30 31"
_compute_date()
{
  # Print the date in HH:MM format when date is between 8:00 and 20:00 without
  # colors
  # NO PARAM
  [...]
}

_compute_date_info_color()
{
  # Print the date in HH:MM format when date is between 8:00 and 20:00, such
  # that hours is in color defined by DATE_FG_HOURS and minutes is in colors
  # defined by DATE_FG_MINUTES
  # NO PARAM
  [...]
}

_compute_date_info()
{
  # If the output of the command is non-empty, print the date char
  # and the content of the output of the command.
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM
  [...]
}

_compute_date_info_short()
{
  # If the output of the command is non-empty, print the date char
  # If DEBUG_MODE exists, force the output of the segment
  # NO PARAM
  [...]
}
```

Let us also check the description generated from the template segment:

```bash hl_lines="3"
# DESCRIPTION
# =============================================================================
# Set the variables and methods to compute the content of segment date
[...]
```

Alright, now, we will do update the documentation describing configuration of
all segment.


## Document your segment


### Documentation

You will also need to :

  * Update the documentation of your segment, i.e.
    `docs/configuration/segments/date.md` which have been automatically generated
    when calling the script `new_segment.sh`
  * Review some files use by this documentation:

    * `mkdocs.yaml`: which describe the architecture of this documentation
    * `docs/configuration/all_supported_segments.md`: which list the supported
      segment
    * `docs/configuration/README.md`: which have an arrays listing the supported
      segment
    * `README.md`: which also have an arrays listing the supported
      segment

### Segment documentation

When calling the script `new_segment.sh`, it automatically generate a basic
documentation files `docs/configuration/segments/date.md` which content should
look like shown below:

```markdown
# `date` Segment

## Description

This segment show date information of the form <TODO:segment_form>.

This segment is shown only when <TODO:segment_constraint>.

## Requirements

This segment has no requirement.

## Variables

<center>

| Variables                | Default                | Description                                         |
| :-------------:          | :-------:              | :-------------------------------------------------- |
| `DATE_CHAR` | `<TODO:segment_char> ` | Character to show before the segment content        |
| `DATE_FG`   | white                  | Foreground color of segment                         |
| `DATE_BG`   | black                  | Background color of segment, **only used by _v2_**  |

<TODO:segment_variables>

</center>

## Examples

<center>

|                       | Prompt _v1_                                                | Prompt _v2_                                                |
| :-:                   | -----------                                                | -----------                                                |
| Full Version          | ![!date v1 full][date_v1_full]   | ![!date v2 full][date_v2_full]   |
| Maximum Short Version | ![!date v1 short][date_v1_short] | ![!date v2 short][date_v2_short] |

</center>

[date_v1_full]: <TODO:segment_screenshots>
[date_v1_short]: <TODO:segment_screenshots>
[date_v2_full]: <TODO:segment_screenshots>
[date_v2_short]: <TODO:segment_screenshots>
```

As you seen, there is multiple `<TODO>`, which is where you will need to update
documentation.

#### `<TODO:segment_form>`

You should replace this tag by an explicit description of the form of the
segment. In our case the content will be simply be `HH:MM` :

```markdown hl_lines="3"
## Description

This segment show date information of the form HH:MM.
```

#### `<TODO:segment_constraint>`

If your segment is only shown under certain circumstances, the you should
describe them here. In our case, the content will be `date is between 8:00 and
20:00`.

If your segment is always shown, like segment `username`, you can delete this
line.

```markdown hl_lines="5"
## Description

This segment show date information of the form HH:MM.

This segment is shown only when date is between 8:00 and 20:00.
```
## Requirements

If your segment need requirement, like command (not usually in Unix system) to
be in the `PATH`, specify it here. Otherwise, you can simply write `This segment
as no requirements.`

```markdown hl_lines="3"
## Requirements

This segment as no requirements.
```

#### `<TODO:segment_char>`

Here you will have to put the character you choose to be put before the segment
content. In our case, the content will be ` `:

```markdown hl_lines="5"
## Variables

<center>

| Variables       | Default   | Description                                         |
| :-------------: | :-------: | :-------------------------------------------------- |
| `DATE_CHAR`     | ` `      | Character to show before the segment content        |
| `DATE_FG`       | white     | Foreground color of segment                         |
| `DATE_BG`       | black     | Background color of segment, **only used by _v2_**  |

</center>
```

#### `<TODO:segment_variables>`

Here, you will have to add extra variables you create for your segment in the
table. In our case, the updated content will be :

```markdown
## Variables

<center>

| Variables         | Default   | Description                                         |
| :-------------:   | :-------: | :-------------------------------------------------- |
| `DATE_CHAR`       | ` `      | Character to show before the segment content        |
| `DATE_FG`         | white     | Foreground color of segment                         |
| `DATE_BG`         | black     | Background color of segment, **only used by _v2_**  |
| `DATE_FG_HOURS`   | red       | Foreground color of hours                           |
| `DATE_FG_MINUTES` | green     | Foreground color of minutes                         |

</center>
```

#### `<TODO:segment_screenshots>`

Finally, you will need to add screenshots of your segment.

You are free to use any colors configuration you want for these screenshots, the
idea is to show what content is displayer by the segment.

Files should be in folder `docs/img/segments/`, you are free to choose the name
you wants. In this tutorial, we will choose :

  * `prompt_v1_date_color_inside_hour.png` and
    `prompt_v2_date_color_inside_hour.png` for the segment when not shorten in
    prompt _v1_ and prompt _v2_.<br>

    Prompt _v1_<br>
    ![!Prompt v1 date color inside hours][prompt_v1_date_inner_color_inside_hours]

    Prompt _v2_<br>
    ![!Prompt v2 date inner color inside hours][prompt_v2_date_inner_color_inside_hours]

  * `prompt_v1_date_color_short.png` and
    `prompt_v2_date_color_short.png` for the segment when shorten in
    prompt _v1_ and prompt _v2_.

    Prompt _v1_<br>
    ![!Prompt v1 date color short][prompt_v1_date_color_short]

    Prompt _v2_<br>
    ![!Prompt v2 date color short][prompt_v2_date_color_short]

So the content of the tag will be :

```markdown
[date_v1_full]: ../img/segments/prompt_v1_date_inner_color_inside_hours.png
[date_v1_short]: ../img/segments/prompt_v1_date_color_short.png
[date_v2_full]: ../img/segments/prompt_v2_date_inner_color_inside_hours.png
[date_v2_short]: ../img/segments/prompt_v2_date_color_short.png
```

#### Final version of segment documentation

Here is the final content of the documentation of the segment date, highlighted
lines are lines that have been modified:

```markdown hl_lines="3 5 9 17 20 21 36 37 38 39"
## Description

This segment show date information of the form HH:MM.

This segment is shown only when <TODO:segment_constraint>.

## Requirements

This segment as no requirements.

## Variables

<center>

| Variables         | Default   | Description                                         |
| :-------------:   | :-------: | :-------------------------------------------------- |
| `DATE_CHAR`       | ` `      | Character to show before the segment content        |
| `DATE_FG`         | white     | Foreground color of segment                         |
| `DATE_BG`         | black     | Background color of segment, **only used by _v2_**  |
| `DATE_FG_HOURS`   | red       | Foreground color of hours                           |
| `DATE_FG_MINUTES` | green     | Foreground color of minutes                         |

</center>

## Examples

<center>

|                       | Prompt _v1_                      | Prompt _v2_                      |
| :-:                   | -----------                      | -----------                      |
| Full Version          | ![!date v1 full][date_v1_full]   | ![!date v2 full][date_v2_full]   |
| Maximum Short Version | ![!date v1 short][date_v1_short] | ![!date v2 short][date_v2_short] |

</center>

[date_v1_full]: ../img/segments/prompt_v1_date_inner_color_inside_hours.png
[date_v1_short]: ../img/segments/prompt_v1_date_color_short.png
[date_v2_full]: ../img/segments/prompt_v2_date_inner_color_inside_hours.png
[date_v2_short]: ../img/segments/prompt_v2_date_color_short.png
```

??? example "How this content will be rendered (Clic to reveal)"
    ## Description

    This segment show date information of the form HH:MM.

    This segment is shown only when <TODO:segment_constraint>.

    ## Requirements

    This segment as no requirements.

    ## Variables

    <center>

    | Variables         | Default   | Description                                         |
    | :-------------:   | :-------: | :-------------------------------------------------- |
    | `DATE_CHAR`       | ` `      | Character to show before the segment content        |
    | `DATE_FG`         | white     | Foreground color of segment                         |
    | `DATE_BG`         | black     | Background color of segment, **only used by _v2_**  |
    | `DATE_FG_HOURS`   | red       | Foreground color of hours                           |
    | `DATE_FG_MINUTES` | green     | Foreground color of minutes                         |

    </center>

    ## Examples

    <center>

    |                       | Prompt _v1_                      | Prompt _v2_                      |
    | :-:                   | -----------                      | -----------                      |
    | Full Version          | ![!date v1 full][date_v1_full]   | ![!date v2 full][date_v2_full]   |
    | Maximum Short Version | ![!date v1 short][date_v1_short] | ![!date v2 short][date_v2_short] |

    </center>

### Review 'All supported segment', 'Home Page' and 'Main Readme'

Normally, when calling script `new_segment.sh`, it should have automatically
added a line to the tables in the followin files:

  * `docs/configuration/all_supported_segments.md`

    This line should be present at the end of the table :

    ```markdown
    | [date](../segments/date.md) | Show the date |
    ```

  * `docs/README.md`

    This line should be present at the end of the table :

    ```markdown
    | [date](configuration/segments/date.md) | Show the date |
    ```

  * `README.md`

    This line should be present at the end of the table :

    ```markdown
    | [date](configuration/segments/date.md) | Show the date |
    ```

If these lines are not present, please add it.

### Review 'mkdocs.yml'

This documentation is generated using [MkDocs][mkdocs] which require a
configuration file called `mkdocs.yml` to describe the documentation
architecture.

Normally, when calling script `new_segment.sh`, it should have automatically
added a line in the key `nav.Configuration.Segments Configuration` which link
to the segment configuration.

This line should be present:

```yaml hl_lines="7"
[...]
nav:
  [...]
  - Configuration:
    - Segment Configuration:
      [...]
      - date: configuration/segments/date.md
[...]
```

If this line is not present, you will need to add it manually.

### Render the documentation

Finally, ensure your documentation is rendered correctly. To do so, you will
need following dependencies:

  - python3
  - pip
  - pipenv (optional)

!!! note
    Pipenv is here to help making the python virtual environment. If you are
    used to manipulate python virtual environment, do it your preferred way ;-).

The installation of `pipenv` is done using `pip`:

```bash
  pip install pipenv
```

Once pipenv is install, you can install the python virtual environment and
activate it with the following commands:

```bash
# Assuming you are at the root of the repo
# Install the virtual environment
pipenv install
# Activate it
pipenv shell
```

!!! note
    If you are using `virtualenv` segment, this one should activate and show
    you the name of the virtual environment and python version used in this
    virtual environment :grinning:.

Now, run the following commands:

```bash
mkdocs server
```

This will allow you to navigate through this documentation locally, with the
following url [http://localhost:8000](http://localhost:8000).
You can know check :

  * The left side if your segment is shown.

    ![!Date segment index documentation][date_segment_index_documentation]

  * The pages [All supported segments][all_supported_segments] and [Home
    Page][home], if your segment is added to the table.

    ![!Date segment all supported segments][date_segment_all_supported_segments]

  * The documentation of your segment is accessible and well rendered.

    ![!Date segment documentation][date_segment_documentation]

If yes, you are then ready to publish your segment :grinning: !

## Ready to publish

Once eveything is done, you can now propose a merge request on the branch
`develop` on the main repo to propose your segment by first preparing your merge
request as described in :

  * [Developers Guidelines-6. Prepare your merge request][prepare_merge_request].

And finally, you can propose your merge request as explain in :

  * [Developers Guidelines-7. Propose your merge request][propose_merge_request].


[mkdocs]: https://www.mkdocs.org/
[main_repo]: https://framagit.org/rdeville/dynamic-prompt/-/blob/master/README.md

[home]: ../README.md
[all_supported_segments]: ../configuration/all_supported_segments.md
[quick_look]: #quick-look
[adding_inner_colors]: #adding-inner-colors
[developers_guidelines]: ./developers_guidelines.md
[developers_guidelines_style_code]: ./developers_guidelines.md#style-code
[keep_your_configuration]: ../configuration/keep_your_configuration.md
[configure_your_prompt]: ../configuration/configure_your_prompt.md
[configure_your_prompt_color_support]: ../configuration/configure_your_prompt.md#colors-support
[configure_your_prompt_unicode_support]: ../configuration/configure_your_prompt.md#unicode-support
[prepare_merge_request]: developers_guidelines.md#6-prepare-your-merge-request
[propose_merge_request]: developers_guidelines.md#7-propose-your-merge-request
[all_supported_segments]: ../configuration/all_supported_segments.md
[new_segment]: ../technical_documentation/scripts_documentation/new_segment.sh.md

[prompt_v1_default]: TODO
[prompt_v2_default]: TODO
[Prompt_v1_date_segment]: TODO
[prompt_v2_date_segment]: TODO
[prompt_v1_date_colors_user]: TODO
[prompt_v2_date_colors_user]: TODO
[prompt_v1_date_color_inside_hours]: TODO
[prompt_v1_date_color_outside_hours]: TODO
[prompt_v2_date_color_inside_hours]: TODO
[prompt_v2_date_color_outside_hours]: TODO
[prompt_v1_date_inner_color_inside_hours]: TODO
[prompt_v2_date_inner_color_inside_hours]: TODO
[prompt_v1_date_color_short]: TODO
[prompt_v2_date_color_short]: TODO

[date_v1_full]: TODO../img/segments/prompt_v1_date_inner_color_inside_hours.png
[date_v1_short]: TODO../img/segments/prompt_v1_date_color_short.png
[date_v2_full]: TODO../img/segments/prompt_v2_date_inner_color_inside_hours.png
[date_v2_short]: TODO../img/segments/prompt_v2_date_color_short.png

[date_segment_index_documentation]: TODO
[date_segment_all_supported_segments]: TODO
[date_segment_documentation]: TODO
