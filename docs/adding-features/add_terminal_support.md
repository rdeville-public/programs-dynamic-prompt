# Add terminal support

During the setup of your prompt, you might have encuntered bad rendering of the
prompt, like wrong characters display or wrong colors display as shown below:

  * The _v1_, "classic" version

    ![!No Unicode Support][prompt_v1_no_unicode]

    ![!Prompt v1 No Color][prompt_v1_no_colors]

  * The _v2_, "powerline" version

    ![!Prompt v2 No Color][prompt_v2_no_colors]

    ![!No Unicode Support][prompt_v2_no_unicode]

This might come from either :

  * Bad colors support of your terminal, see
    [Configure your prompt - Colors support][configure_your_prompt_colors_support]
  * Bad unicode support of your terminal, see
    [Configure your prompt - Unicode support][configure_your_prompt_unicode_support]

In this tutorial, we will see how to check colors and unicode support of your
temrinal, update required variables accordingly and propose a merge request to
add you terminal to the list of supported terminal.

## Check colors support

First things to do is to check what kind of colors support your terminal:

  * True colors, i.e. 24 bits colors
  * 256 colors
  * 8/16 colors

First, let us check the true colors. True colors is colors that can be expressed
in the 24 bits colors space, i.e. for instance in hexadecimal value like
`#ff0000` for red.

To check if your terminal support true colors, you can first see the following
page :

  * [https://gist.github.com/XVilka/8346728](https://gist.github.com/XVilka/8346728)

If your terminal is not in the list, this may not means that your terminal does
not support true colors. Previous link provide a script to test if your terminal
support true which is recalled below:

```awk
awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'
```
Run this code, if your terminal support true colors, you should see something like:

![!True Colors Support][true_colors_support]

If you see something like :

![!Fake True Colors Support][fake_true_colors_support]

This means that your terminal does not support true colors but is making an
approximation of their values.

If you see something like :

![!No True Colors Support][no_true_colors_support]

This means that your terminal does not support true colors at all.

If your terminal does not support true colors, then you have nothing to do as
the prompt will automatically determine the number of supported colors using the
command `tput colors`.

If you terminal does support true colors, you might want to add it to the list
of the terminal that support true colors. To do so, you will first need to know
the "name" of your terminal.

This can be done with the script `which_term.sh` which rely on
[`xdotool`](https://manpages.ubuntu.com/manpages/trusty/man1/xdotool.1.html).
You may need to install it. Way to install it depends on your distro.

Once installed, simply run the script `which_term.sh` at the root of the repo.

```bash
# Ask which term we are using
./which_term.sh
```

The output of the script should be a simple line with the name of your temrinal,
like :

  - `st`
  - `xterm`
  - `urxvt`
  - `terminator`
  - `iTerm.app`
  - `VSCode.app`
  - etc

This value is the one you should add in the file `lib/default_vars.sh` in the
array `TRUE_COLOR_TERM`. For instance, if your terminal support true colors and
its name is `my_term_program`, you should update value of `TRUE_COLOR_TERM` as
shown below:

```bash hl_lines="5"
# VARIABLES
# =============================================================================
# Setup array to store supported terminal
local UNICODE_SUPPORTED_TERM=("st" "terminator" "xterm" "iTerm.app")
local TRUE_COLOR_TERM=("st" "terminator" "iTerm.app" "my_term_program")
```

## Check unicode support

Second things to do is to check if your terminal support unicode characters.

To do so, you can see the following page which provide code to test if your
terminal support unicode characters:

  * [https://rosettacode.org/wiki/Terminal_control/Unicode_output](https://rosettacode.org/wiki/Terminal_control/Unicode_output)

As example, we will take the shell code provided in this page:

```shell
unicode_tty() {
  # LC_ALL supersedes LC_CTYPE, which supersedes LANG.
  # Set $1 to environment value.
  case y in
  ${LC_ALL:+y})		set -- "$LC_ALL";;
  ${LC_CTYPE:+y})	set -- "$LC_CTYPE";;
  ${LANG:+y})		set -- "$LANG";;
  y)			return 1;;  # Assume "C" locale not UTF-8.
  esac
  # We use 'case' to perform pattern matching against a string.
  case "$1" in
  *UTF-8*)		return 0;;
  *)			return 1;;
  esac
}

if unicode_tty; then
  # printf might not know \u or \x, so use octal.
  # U+25B3 => UTF-8 342 226 263
  printf "\342\226\263\n"
else
  echo "HW65001 This program requires a Unicode compatible terminal" >&2
  exit 252    # Incompatible hardware
fi
```

Put this lines in a script, let say `test_unicode.sh`, then execute it :

```shell
# To test bash
bash test_unicode.sh
# To test zsh
zsh test_unicode.sh
```

If you see this character `△`, i.e. an empty triangle, this means your actual
terminal configuration support unicode.

If you do not see this character, do not loose hope, your terminal might still
support unicode. First, check your locale using the command `locale`:

```bash
locale
LANG=en_US.UTF-8
LANGUAGE=
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=
```

If your locale does not end with `UTF-8`, then it most likely this come from
here. Check your distro documentation to change your locale to an `UTF-8` local.

If your local does end with `UTF-8`, then issue might come from the font
your terminal use.

I recommend using one of the [NerdFont][nerdfont]. Personnaly I use
[FiraCode][firacode] which is the one used for all screenshots done. And set
your terminal emulator to use one of these fonts.

I also recommend using one these fonts because some default segment character
are not official unicode character and so might not be display by most
"standard" fonts

Configuration of your fonts used by your terminal emulator depends on it, so
please refers to the documentation of your terminal emulator to know how to
change the fonts.

If you never manage to see the character `△`, i.e. an empty triangle,
unfortunately this means your terminal emulator is not able to print unicode
characters. Or it is able to do so but this might require advanced configuration
which can not be adressed here. Please refers to your terminal documentation.

If you finally get to the point where you see the character `△`,
congratulations :tada:, this means your terminal is able to support unicode.

So, as for true colors support, you might want to add it to the list of the
terminal that support unicode. To do so, you will first need to know the "name"
of your terminal.

This can be done with the script `which_term.sh` which rely on
[`xdotool`](https://manpages.ubuntu.com/manpages/trusty/man1/xdotool.1.html).
You may need to install it. Way to install it depends on your distro.

Once installed, simply run the script `which_term.sh` at the root of the repo.

```bash
# Ask which term we are using
./which_term.sh
```

The output of the script should be a simple line with the name of your temrinal,
like :

  - `st`
  - `xterm`
  - `urxvt`
  - `terminator`
  - `iTerm.app`
  - `VSCode.app`
  - etc

This value is the one you should add in the file `lib/default_vars.sh` in the
array `TRUE_COLOR_TERM`. For instance, if your terminal support true colors and
is name is `my_term_program`, you should update value of `UNICODE_SUPPORTED_TERM` as
shown below:

```bash hl_lines="4"
# VARIABLES
# =============================================================================
# Setup array to store supported terminal
local UNICODE_SUPPORTED_TERM=("st" "terminator" "xterm" "iTerm.app" "my_term_program")
local TRUE_COLOR_TERM=("st" "terminator" "iTerm.app")
```


!!! note "When support both **unicode** and **true colors**"
    If your terminal support both unicode chars and true colors, you will need
    to add it in both variables `UNICODE_SUPPORTED_TERM` and `TRUE_COLOR_TERM`
    as shown below:

    ```bash hl_lines="4 5"
    # VARIABLES
    # =============================================================================
    # Setup array to store supported terminal
    local UNICODE_SUPPORTED_TERM=("st" "terminator" "xterm" "iTerm.app" "my_term_program")
    local TRUE_COLOR_TERM=("st" "terminator" "iTerm.app" "my_term_program")
    ```


## Ready to publish

Once eveything is done, you might want to propose a merge request to update the
list of support terminal.

First take screenshots of your terminal showing it supports unicode and/or true
colors. Then prepare a merge request as described in :

  * [Developers Guidelines-6. Prepare your merge request][prepare_merge_request].

And finally, you can propose your merge request as explain in :

  * [Developers Guidelines-7. Propose your merge request][propose_merge_request].

!!! important
    **Do not forget to post your screenshots with your merge request**


<!-- Link external to this documentation -->
[nerdfont]: https://github.com/ryanoasis/nerd-fonts
[firacode]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode

<!-- Link local to this documentation -->
[configure_your_prompt_colors_support]: ../configuration/configure_your_prompt.md#colors-support
[configure_your_prompt_unicode_support]: ../configuration/configure_your_prompt.md#unicode-support
[prepare_merge_request]: developers_guidelines.md#6-prepare-your-merge-request
[propose_merge_request]: developers_guidelines.md#7-propose-your-merge-request
[prompt_v1_no_unicode]: TODO
[prompt_v2_no_unicode]: TODO
[prompt_v1_no_colors]: TODO
[prompt_v2_no_colors]: TODO
[true_colors_support]: TODO
[fake_true_colors_support]: TODO
[no_true_colors_support]: TODO
