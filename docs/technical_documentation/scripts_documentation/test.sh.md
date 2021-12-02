# `test.sh` script

This script is used to test safely the dynamic prompt in a docker container.

The setup of the conainer is done interactively by asking user some details
about its terminal environment and is then run automatically.

## Requirements

In order to test this prompt or your prompt config, you will just need
[docker][docker]. To install it, docker provide a documentation for multiple
systems:

  * [Debian][docker_Debian]
  * [CentOS][docker_CentOS]
  * [Fedora][docker_Fedora]
  * [Ubuntu][docker_Ubuntu]
  * [MacOS][docker_macos]

## Usage of the script

Once done, simply go to whereever you cloned this repo and run the script
`test.sh`:

```bash
cd <PATH_TO_WHERE_IS_DYNAMIC_PROMPT>
./test.sh
```

By default, the script `test.sh` will start in interactive mode asking you some
informations to configure some main variables used by the prompt before building
a docker image and starting the docker container to test your prompt config.

I recommend using interactive mode first. Before running the docker you will be
asked a confirmation and you will be prompt the command line to avoid passing
through the interactive mode the next time.

??? Note "Manual usage of the script (click to reveal)"

    Below is the manual of the script, i.e. what is shown when using `test.sh
    -h`.

    ```
     NAME
        test.sh - Ask user parameter to test prompt config in docker

     SYNOPSIS
        test.sh [ -s shell ] [ -p prompt_version ] [ -a shell_app ] [ -d debug_level ] [ -b ] [ -m ] [ -h ]

     DESCRIPTION
        test.sh is a script that will let you set parameters to test your
        configuration for the prompt line promposed by this repo in a docker
        environment to avoid messing with your actual prompt.

        By default, without any options, the script will pass through some
        interactive dialog boxes to ask you main parameters you want to set. But
        once you know which main parameters you want to test, which are also
        recalled before running the docker when in interactive mode, you can
        override them by passing arguments to the script.

        NOTE: Despite the fact that is a bash script, there is not order on options.

     OPTIONS

        -s,--shell
            The name of the shell you want to test. Possible values are :
              - bash
              - zsh

        -p,--prompt
            The prompt version you want to test. Possible values are :
              - 1
              - 2

        -a,--app
            The terminal emulator value you want to emulate for your test depending
            on support of unicode char and true colors of your terminal.
            Possible values are :
              - unknown: If your terminal emulator does not support neither unicode
                char, neither true colors
              - xterm: If your terminal emulator does support unicode char but does
                not support true colors
              - st: If your terminal emulator does support unicode char and true
                colors.

            Unicode char are special char like some emoji.
            If your terminal support unicode char, you should see a heart between
            the following single quotes: '♡ '

            True colors means your terminal emulator is able to show colors with
            values RGB from 0 to 255.
            If your terminal support true colors, then the between lines
            '======================' should show continous colors, if you only see
            char '-' or discontinous colors, this mean your terminal does not
            support true colors.
    ===============================================================================
    |-----------------------------------------------------------------------------|
    ===============================================================================

        -d,--debug_level
            The debug level you want to be shown. Possible values are :
              - 0: [Default] Show only errors
              - 1: Shown errors and time to compute the prompt
              - 2: Shown errors, warnings and time to compute the prompt
              - 3: Shown errors, warnings, infos and time to compute the prompt

        -m,--mount
            If you set all previous parameter, you can directly build and run the
            docker without the confirmation dialog.


        -b,--build
            If you set all previous parameter, you can directly build and run the
            docker without the confirmation dialog.

        -h,--help
            Print this help
    ```

Below is a description of the behaviour of the script.


## Behaviour of the interactive mode

When running the script for the first time, or when not using all options,
script will ask interactive question to the user to setup variables for the
container to configure the prompt.

This section will describe behaviour of the script in interactive mode with
screenshots.

!!! note
    At any moment, during the execution of the script, you can cancel it by
    pressing `Ctrl+C`

### Shell selection

The first screen you will see will look like this:

![!test.sh Asking Shell][test.sh_ask_shell]

It will ask you which shell emulator you want to test, either:

   * bash (/bin/bash)
   * zsh (/bin/zsh) **[Default]**

### Prompt version selection

The second screen you will see will look like this:

![!test.sh Asking prompt version][test.sh_ask_prompt_version]

It will ask you which version of the prompt you want to test, either:

  * Prompt _v1_<br>
    ![!Prompt v1 default][prompt_v1_default]

  * Prompt _v2_ **[Default]**<br>
    ![!Prompt v2 default][prompt_v2_default]

### Unicode support

The third screen you will see will look like this:

![!test.sh Asking unicode support][test.sh_ask_unicode_support]

It will ask you if your terminal support unicode character, i.e if the font you
use in your terminal emulator is able to display character like the heart `❤`

### True colors support

The fourth screen you will see will look like this:

![!test.sh Asking color support][test.sh_ask_color_support]

It will ask you if your terminal support true colors, i.e if the terminal
emulator you use is able to display 24 bits colors.

Normally, you should see a continous colors gradient as shown above, if you do
not see this but something as shown below, this means your terminal emulator
does not support true colors.

![!Prompt No Colors Support 1][prompt_no_colors_support_1]

![!Prompt No Colors Support 2][prompt_no_colors_support_2]

### Debug level selection

The fifth screen will look like this:

![!test.sh Asking debug level][test.sh_ask_debug_level]

Depending on the debug level you will see more or less informations about the
computation of the prompt.

  * `ERROR`, You will only see errors (for now, there is no error handler)
  * `TIME`, **[Default]** you will see errors and the time to compute the prompt as shown below:

![!Prompt Debug time Level][prompt_debug_time_level]

  * `WARNING`, You will see warnings, errors ant the time to compute the prompt (for
    now, there is no warning handler)
  * `INFO`, You will see infos, warnings, errors ant the time to compute the prompt.
    This debug level is strongly discouraged as it will show lots of
    informations and will make the prompt unusable. It is mainly for debug
    purpose, see below:

![!Prompt Debug Info Level][prompt_debug_info_level]

The debug informations are handled by the scripts [`debug.sh`][debug.sh]

### Mounting option

The sixth screen will look like this:

![!Prompt Mounting Option][test.sh_ask_mount_option]

In this step you will be asked if:

  * You want to **mount** the repo in the docker container **[Default]**
  * You want to **copy** the repo in the docker container

**Mounting the repo**

If you choose to **mount** the repo, then, all the current content of folder
where you cloned the dynamic-prompt will be mounted as a volume in the docker
container, in place of `~/.prompt`.

Thus, every modification you will do in the container **will remains** once
leaving the container.

This is the recommended way to test/make your own configuration without messing
your prompt.

**Copying the repo**

If you choose to **copy** the repo, then, all the current content of the folder
where you copie the dynamic-prompt will be copied in the `~/.prompt` folder in
the container.

Thus, every modification you will do in the container **will not remains**  once
leaving the container.

This is the recommended way to develop for the prompt if you have plan a work
session on it and you do not want to mess your actual configuration or if you
want to learn more about the code.

### Confirmation

Finally, the last screen you will see before starting the container is shown
below:

![!test.sh asking confirmation][test.sh_ask_confirmation]

This screen will recap all options you have choosen earlier.

Moreover, this screen will show you the command, and more especially the
arguments, to pass to `test.sh` script to avoid having to pass throught the
interactive mode the next time you want to run the same container configuration.

If everything is right for you, the script will then build an image called
`dynamic-prompt` and will start a container based on this image with the options
you choose.

Then, you will be automatically in the container to test the dynamic prompt
:grinning:.

## Leaving the container

Once leaving the container, if you choose the mount option, you will be prompt
the lines to add to your `~/.bashrc` and/or to your `~/.zshrc` to directly use
the prompt as you configured it in the container as shown below:

![!test.sh leaving container][test.sh_leaving_container]


[docker]: https://www.docker.com/
[docker_Debian]: https://docs.docker.com/install/linux/docker-ce/debian/
[docker_CentOS]: https://docs.docker.com/install/linux/docker-ce/centos/
[docker_Fedora]: https://docs.docker.com/install/linux/docker-ce/fedora/
[docker_Ubuntu]: https://docs.docker.com/install/linux/docker-ce/ubuntu/
[docker_macos]: https://docs.docker.com/docker-for-mac/install/

[debug.sh]: debug.sh.md

[test.sh_ask_prompt_version]: TODO
[test.sh_ask_shell]: TODO
[prompt_v1_default]: TODO
[prompt_v2_default]: TODO
[test.sh_ask_unicode_support]: TODO
[test.sh_ask_color_support]: TODO
[prompt_no_colors_support_1]: TODO
[prompt_no_colors_support_2]: TODO
[test.sh_ask_debug_level]: TODO
[prompt_debug_time_level]: TODO
[prompt_debug_info_level]: TODO
[test.sh_ask_mount_option]: TODO
[test.sh_ask_confirmation]: TODO
[test.sh_leaving_container]: TODO
