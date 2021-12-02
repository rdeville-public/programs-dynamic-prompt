# Configure your prompt

This page present you the starting point of using dynamic prompt, address
unicode support and color support as well as the location of configuration.

  * To setup the segment organisation see [Prompt lines configuration][prompt_lines_configuration]
  * To setup general variables see [General variables][general_variables]
  * To configure segment you use see [All suppport segments][all_supported_segments]

## Setup the prompt

!!! note
    If you are testing the prompt in docker using the script `test.sh`, see
    [Testing your prompt][testing], this part is not required as it is done
    automatically in the container.<br>

    It is only required when you are ready to use the dynamic prompt outside the
    container.

Before configuring your workstations prompt coloration, chars, etc. and as
quickly described in the [Home Page][home], there are some global variables that
need to be exported.

This is done by adding some lines in your `~/.bashrc` and/or your `~/.zshrc`
depending on the shell you use.

  * In your `~/.bashrc`:

```bash
# Or whereever you clone this repo
export PROMPT_DIR="${HOME}/.shell/prompt"
# The prompt version you want to use, "1" or "2"
export PROMPT_VERSION="2"
# Not required, but sometimes, the shell emulator variables is not well set
export SHELL="/bin/bash"
# Not required, but you can force to ensure usage of unicode or true colors
export SHELL_APP=<the name of your terminal>

# Source the file that will setup the prompt computation.
source "${PROMPT_DIR}/prompt.sh"

# Explicitly tell bash to use method precmd before letting user to type command.
if ! [[ "${PROMPT_COMMAND}" =~ precmd ]]
then
  export PROMPT_COMMAND="precmd;${PROMPT_COMMAND}"
fi
```

  * In your `~/.zshrc`

```bash
# Or whereever you clone this repo
export PROMPT_DIR="${HOME}/.shell/prompt"
# The prompt version you want to use, "1" or "2"
export PROMPT_VERSION="2"
# Not required, but sometimes, the shell emulator variables is not well set
export SHELL="/bin/bash"
# Not required, but you can force to ensure usage of unicode or true colors
export SHELL_APP=<the name of your terminal>

# Source the file that will setup the prompt computation.
source "${PROMPT_DIR}/prompt.sh"

# No need to add PROMPT_COMMAND for zsh, as it use method precmd, defined in
# ${PROMPT_DIR}/prompt.sh, before letting user to type command.
```


### The `SHELL_APP` variable

There is a special variable for which you might not know the value to set. This
variable is `SHELL_APP`.

```bash
# Not required, but you can force to ensure usage of unicode or true colors
export SHELL_APP=<the name of your terminal>
```

This variable should normally be automatically set, so its not required.

It allows dynamic prompt to know if your terminal support unicode and which kind
of colors it is able to display. Indeed, this dynamic prompt is able to support
true colors, 256 colors and 8 colors as well as unicode characters. But this
mainly depends on the terminal emulator you use.

Normally, the value of this variable is set automatically by dynamic prompt by
calling the script `tool/which_term`.

To know the name of the terminal that will be used by dynamic prompt, run the
script `tool/which_term`.

This script will output a value which is then compared to arrays
`UNICODE_SUPPORTED_TERM` and `TRUE_COLOR_TERM` in
`lib/default_vars.sh`

If you know your terminal emulator support:

  * **Only unicode character but not true colors**, set the value
    of `SHELL_APP` to `xterm`.
  * **Unicode character and true colors**, set the value of `SHELL_APP` to `st`.

Doing so will force dynamic prompt to emulate usage of `xterm` or `st`
behaviour.

If you set `SHELL_APP` to one of this value and you still experience weird
segment characters and/or weird segment separator as shown below:

  * Prompt _v1_ (click on image to enlarge)

![!No Unicode Support][prompt_v1_no_unicode]

  * Prompt _v2_ (click on image to enlarge)

![!No Unicode Support][prompt_v2_no_unicode]

This might come from the fact your terminal emulator does not use font with the
specific unicode characters (or glyphs). I recommend using a [Nerd
Font][nerd_font]. Personnaly I use [FiraCode][firacode] which is the one used
for all screenshots done. And set your terminal emulator to use one of these
fonts.

If this still does not work, please see sections [Unicode
Support][unicode_support] and [Colors support][color_support]. You can also see
[Add terminal emulator support][add_terminal_emulator_support] where these
issues is adressed more in details.

!!! important
    **When on `tty` or in unsupported terminal emulator, prompt will automatically
    fall back to prompt _v1_.**

!!! warning
    If you use shell framework, like [bash-it][bash-it], [oh-my-zsh][oh-my-zsh]
    or [prezto][prezto]. Their support is not tested yet and can lead to messing
    your prompt.

## Unicode Support

If you do not see default values or your characters are not printed correctly,
this means either :

  * Your terminal emulator does not support glyphs or unicode encoding, even if
    using font which support them,
  * Your terminal emulator does support glyphs but the font you choose does not,
  * Your terminal emulator does support glyphs and the font you choose does too,
    but you will have to modify a scripts in this repo.

If it is the first case, unfortunately, you will not be able to print any
unicode character.

If it is the second case, please see the documentation of your terminal emulator
in order to know how to change the font it uses.

If it is the last case, you will have to add your terminal name in the array
`UNICODE_SUPPORTED_TERM` in the file `lib/default_vars.sh`, or when testing, you
can manually set variable `SHELL_APP` like this :

```bash
## If your terminal emulator support unicode but not true colors
export SHELL_APP=xterm
## If your terminal emulator support unicode and true colors
export SHELL_APP=st
```

Font recall (again), some default character in `common.example.sh` are better
interpreted when using [NerdFonts][nerd_font]. Personnaly I use
[FiraCode][firacode] which is the one used for all screenshots done.

To know the name of the terminal to put in the variables `TRUE_COLOR_TERM` or
`UNICODE_SUPPORTED_TERM`, run the script `tool/which_term`.

More details are provided in
[Add terminal support][add_terminal_emulator_support].


## Colors support

Some terminal emulator support only 8/16 colors, others 256 colors and others
support true colors, i.e. 24 bits colors. Depending on which terminal emulator
you use, you might need to setup colors syntax according to the number of colors
supported by your terminal emulator.

For more information about the syntax for terminal that support up to 16 colors
or up to 256 colors:

  * [https://misc.flogisoft.com/bash/tip_colors_and_formatting](https://misc.flogisoft.com/bash/tip_colors_and_formatting)

To know if your terminal support true colors (i.e. 24 bits colors), see:

  * [https://gist.github.com/XVilka/8346728](https://gist.github.com/XVilka/8346728)

**IMPORTANT**, when setting colors variables, you do not need to write the full
syntax, just enter the color code. The surrounded of the color code will be set
by dynamic prompt depending on your terminal. Example of value are shown below:

<center>

| Color            | 8 colors   | 256 colors   | True colors      |
| ---------------- |:----------:|:------------:|:----------------:|
| Red              | 1          | 196          | 255;0;0          |
| Green            | 2          | 046          | 0;255;0          |
| Blue             | 4          | 021          | 0;0;255          |

</center>

!!! important
    When setting fall back colors, i.e. like in `common.example.sh`, when
    terminal support only 16 colors, like `tty`, please use only 8 colors code
    because 16 colors supported is guaranted. In other terms, when using
    fallback colors, value of colors variables should be between 0 to 9 where 0
    is black, 9 is white and 1 - 8 are the 8 primary colors of your terminal.
    This depend on your terminal.

Set of 256 colors supported by 256 colors terminal are shown at the end of the
file `common.exemple.sh` and in the image below. The number on the left of
hexadecimal colors value is the code of this color in 256 colors support.

<center>

![!256_colors][256_colors]

</center>

If you know your terminal emulator should support true colors but does not print
them, you will have to add your terminal name in the table `TRUE_COLOR_TERM` in
the file `lib/default_vars.sh`, or when testing, you can manually set variable
`SHELL_APP` like this :

```bash
## If your terminal emulator support unicode but not true colors
export SHELL_APP=xterm
## If your terminal emulator support unicode and true colors
export SHELL_APP=st
```

To know the name of the terminal to put in the variables `TRUE_COLOR_TERM` or
`UNICODE_SUPPORTED_TERM`, run the script `tool/which_term`.

More details are provided in
[Add terminal support][add_terminal_emulator_support].

## Configuration files

One of the aims of this prompt is to be as easily customizable as possible. It
end up by setting almost all configuration to variables. Variables are :

  * colors of a segment, background and foreground colors mainly
  * special character that start a segment

Prompt _v1_ and _v2_ share almost all variables, just some of them are useless
in prompt _v1_ (mainly background colors variables).

To setup a configuration for your workstations, everything is done in the
`hosts` folder of the repo. There, you will have two possibilities:

  * Create a common configuration shared by all your computer. This can be done
    by creating a file `common.sh` in the `host` folder in the repo.

  * Create a file specific for each computer. This can be done by creating  a
    file which name is the hostname of your computer (for instance, the file
    `death-star.sh` is a configuration for one of my computer which hostname is
    `death-star`) in the `host` folder in the repo.

!!! note
    I strongly recommend copying the file `common.example.sh` as a starting
    point as `common.example.sh` provide a complete configuration for :

      * Prompt _v1_ and _v2_.

      * Terminal emulator that support unicode or not<br>.
        See [Unicode Support][unicode_support]

      * Terminal emulator that support true colors, 256 colors and 8 colors<br>.
        See [Color Support][color_support]

      * Lots of comment to help you making your own configuration.

Finally, you can combine both, create a file `common.sh` to set some default
variables for all your computers and another file with name `$(hostname).sh` to
setup specific configuration which will override the common ones.

Alreay in this repo are files:

  * `common.example.sh` which is a basic complete configuration. It is the one
    used in all this documentation, moreover its already handle multiple
    configuration whether your terminal emulator support unicode chars and true
    colors.
  * `death-star.sh` which is the specific configuration of my computer which
    hostname is `death-star`. In this file, I only overwrite variables that
    define the default background color of my prompt, i.e. the color of the main
    line of the prompt.

All variables in these files are optional. If not set, dynamic prompt will load
default values, i.e. black background and white foreground as shown below when
not configuration exists.

  * The _v1_, "classic" version

![!Prompt v1 No Color][prompt_v1_no_colors]

  * The _v2_, "powerline" version

![!Prompt v2 No Color][prompt_v2_no_colors]

All modifications done in files in `hosts/` folder will be loaded dynamically,
i.e. no need to reload anything once modified as they will be automatically
reloaded. See the gif below:

![!Demo Colors][prompt_demo_colors]

## Configuring Prompt Lines

That's being said, there is now three things two configure:

  * **The organisation of the segment within your prompt lines**

    Before starting customization of colors, chars, etc., you will need to
    configure which segment you want to activate/deactivate and the order in
    which they are displayed and compressed.<br>
    To do so, see [Prompt Lines Configuration][prompt_lines_configuration]

  * **The general variables for prompt _v1_ and prompt _v2_**

    Then once you have choosen the order in which segment are organised you may
    want to configure general variables for prompt _v1_ and _v2_.<br>
    To do so, see [General variables][general_variables]

  * **The segments colors and characters**

    Finally, once this is done, you may want to configure your segments, i.e.
    their background and foreground colors mainly.<br>
    To do so, see [All supported segments][all_supported_segments].


<!-- Link external to the documentation-->
[bash-it]: https://github.com/Bash-it/bash-it
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[prezto]: https://github.com/sorin-ionescu/prezto
[nerd_font]: https://github.com/ryanoasis/nerd-fonts
[firacode]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode

<!-- Local link to the documentation-->
[prompt_lines_configuration]: ./prompt_lines_configuration.md
[home]: ../README.md
[testing]: ../../getting_started/#testing-the-prompt
[add_terminal_emulator_support]: ../adding-features/add_terminal_support.md
[unicode_support]: #unicode-support
[color_support]: #colors-support
[general_variables]: general_variables.md
[all_supported_segments]: all_supported_segments.md

<!-- Link to assets in the documentation -->
[prompt_v1_no_unicode]: ../assets/img/no_unicode_support_v1.png
[prompt_v2_no_unicode]: ../assets/img/no_unicode_support_v2.png
[256_colors]: ../assets/img/256_colors.png
[prompt_v1_no_colors]: ../assets/img/default_no_color_v1.png
[prompt_v2_no_colors]: ../assets/img/default_no_color_v2.png
[prompt_demo_colors]: ../assets/img/demo_colors.gif
