# Getting started

In this part of the documentation, we will see how to:

  * Get the code
  * Test the prompt safely
  * Start to configure your prompt
  * Install it to use it
  * Start to add your own segment

## Get the code

There is two way to get the code of the prompt to use it :

  * [Using git](#using-git)
  * [Downloading the last stable release](#download-the-last-release)

### Using git

This repo is versioned using [git][git]. First install it on your computer.

Once this is done, you can clone the repo whereever you want, let us say in a
the folder `~/.shell/prompt` (assuming folder `~/.shell` exists).

```bash
$ git clone git@framagit.org:rdeville/dynamic-prompt.git ~/.shell/prompt
# or
$ git clone https://framagit.org/rdeville/dynamic-prompt.git ~/.shell/prompt
```

### Download the last release

The last stable release is always the branch `master` of the [main repo on
Framagit](https://framagit.org/rdeville/dynamic-prompt).

You can either download it by clicking on the link below:

  * [https://framagit.org/rdeville/dynamic-prompt/-/archive/master/dynamic-prompt-master.zip](https://framagit.org/rdeville/dynamic-prompt/-/archive/master/dynamic-prompt-master.zip)

Or download it with one the following commands:

```bash
wget -O dynamic-prompt.zip https://framagit.org/rdeville/dynamic-prompt/-/archive/master/dynamic-prompt-master.zip
# or
curl -o dynamic-prompt.zip https://framagit.org/rdeville/dynamic-prompt/-/archive/master/dynamic-prompt-master.zip
```

Then unarchive the file `dynamic-prompt.zip` whereever you want.

For the rest of the documentation, I will assume you unarchive the file in the
folder `~/.shell/` and you renamed the outputed directory
`dynamic-prompt-master` simply `prompt`. So the source code should be accessible
in `~/.shell/prompt/`

## Testing the prompt

Before directly use this prompt, I strongly recommend testing it.

In order to test this prompt or your prompt config, you will just need
[docker][docker]. To install it, docker provide a documentation for multiple
systems:

  * [Debian][docker_Debian]
  * [CentOS][docker_CentOS]
  * [Fedora][docker_Fedora]
  * [Ubuntu][docker_Ubuntu]
  * [MacOS][docker_macos]

Once done, simply go to whereever you cloned this repo and run the script
`test.sh`:

```bash
cd ~/.shell/prompt
./test.sh
```

By default, the script `test.sh` will start in interactive mode asking you some
informations to configure some main variables used by the prompt before building
a docker image and starting the docker container to test your prompt config.

I recommend using interactive mode first. Before running the docker you will be
asked a confirmation and you will be prompt the command line to avoid passing
through the interactive mode the next time.

To see more option of the script, type the following command :
```bash
./test.sh -h
```

Or read the [Documentation of the script `test.sh`][doc_test.sh].

Once you confirm the deployment of the container, you will automatically be in
it. Depending on what you choose during the interactive mode there are two
possibilities :

  * The dynamic prompt will be **mounted** as volume to `/root/.prompt`, i.e.
    modifications done in the docker container will remains when leaving the
    container, better for configuration,
  * The repo will be **copied** in the container to `/root/.prompt`, i.e.
    modification will not remains once leaving the container, better for testing
    development as all required tools will be within the container, like git or
    python (for the doc) allowing you to commit and push you modifications.

Within the container, you will be able to test the prompt safely, without
messing your own prompt. You will also be able to make your own configuration,
testing your colors, etc.

If you choose the **mounting** option, i.e. mounting your repo into the
container, once your are satisfied with your configuration, you will be able to
directly use your new configuration and/or setup required variables to use it
once you leave the docker container.

!!! important

    Dynamic prompt use specific unicode characters by defaults. So you might
    experience weird display. Like weird segment characters and/or segment
    separator as shown below:

      * Prompt _v1_ (click on image to enlarge)

      ![!Prompt v1 No Unicode Support][prompt_v1_no_unicode]

      * Prompt _V2_ (click on image to enlarge)

      ![!Prompt v2 No Unicode Support][prompt_v2_no_unicode]

    This might come from multiple component.

    The first issue might come from the fact your terminal emulator does not use
    font with the specific unicode characters (or glyphs) used by dynamic
    prompt. I recommend using a [Nerd Font][nerd_font] as the display font of
    your termina. Personnaly I use [FiraCode][firacode] which is the one used
    for all screenshots done.

    If you experience weird behaviour as described above. Please take a look at
    the [FAQ & Known Issues][FAQ].

## Configuration

All configurations are done within folder `hosts/`.

The dynamic prompt will :

  * First load default values.
  * Check if there is a file `hosts/common.sh`, if so, load configurations
    defined in it.
  * Check if there is a file `hosts/$(hostname).sh`, if so, load configurations
    defined in it which may override values define in `host/common.sh`.

Thus, you can define configurations shared accross all your computer with the
file `hosts/common.sh` and some computer specific configuration with the file
`host/$(hostname).sh`

By default, there is two files that might interest you:

  * `common.example.sh`: An example with all variables set to basic values. This
    is the file use for the most screenshots of this documentation.

  * `death-star.sh`: The file specific to one of my computer which hostname is
    `death-star` in which I override some commonly shared variables setup in
    my `common.sh`.

There is also a subfolder `hosts/examples/` for powerline prompt in which I
propose different powerline character, see examples below.

??? examples "Powerline Examples (Click to reveal)"

    ![!Powerline dots][prompt_v2_powerline_dots]

    ![!Powerline fire][prompt_v2_powerline_fire]

    ![!Powerline round][prompt_v2_powerline_round]

    ![!Powerline spikes][prompt_v2_powerline_spikes]

The best starting point is to copy/paste the file `hosts/common.example.sh` to
`hosts/common.sh`, thus, you will have the configuration use for all this
documentation.

Then, you can read the [Configure your prompt][configure_your_prompt].

## Final setup

Once you have done your configuration and you are satisfied, you will only need
to add the following lines:

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

# No need to add PROMPT_COMMAND for zsh, as it use method precmd before letting
# user to type command.
```

!!! warning
    If you use shell framework, like [bash-it][bash-it], [oh-my-zsh][oh-my-zsh]
    or [prezto][prezto]. Their support is not tested yet and can lead to messing
    your prompt.


## Add your own segments

If you feel the prompt lack a segment you can easy add your own, this can be
done in folder `segment/`.

This folder store all segments currently supported. If you want to add your own,
you will simply need to add your script among these files and setup your prompt
variable `SEGMENT` and `SEGMENT_PRIORITY` to use it.

See [Add your own segment][add_segment], which provide a small tutorial on how
to add your own segment.

## Contributing

Finally, if you want to publish your segment, you can propose a merge request.
To do so, see [Contributing][contributing].

<!-- Link external to this documentation -->
[docker]: https://www.docker.com/
[docker_Debian]: https://docs.docker.com/install/linux/docker-ce/debian/
[docker_CentOS]: https://docs.docker.com/install/linux/docker-ce/centos/
[docker_Fedora]: https://docs.docker.com/install/linux/docker-ce/fedora/
[docker_Ubuntu]: https://docs.docker.com/install/linux/docker-ce/ubuntu/
[docker_macos]: https://docs.docker.com/docker-for-mac/install/
[bash-it]: https://github.com/Bash-it/bash-it
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[prezto]: https://github.com/sorin-ionescu/prezto
[git]: https://git-scm.com/
[nerd_font]: https://github.com/ryanoasis/nerd-fonts
[firacode]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode

<!-- Link local to this documentation -->
[configure_your_prompt]: configuration/configure_your_prompt.md
[doc_test.sh]: technical_documentation/scripts_documentation/test.sh.md
[add_segment]: adding-features/add_segment.md
[contributing]: adding-features/contributing.md
[shell_app_variable]: configuration/configure_your_prompt.md#the-shell_app-variable
[add_terminal_support]: adding-features/add_terminal_support.md
[FAQ]: about/FAQ.md

<!-- Link to assets in this documentation -->
[prompt_v1_no_unicode]: assets/img/no_unicode_support_v1.png
[prompt_v2_no_unicode]: assets/img/no_unicode_support_v2.png

[prompt_v2_powerline_dots]: assets/img/powerline_examples_dots.png
[prompt_v2_powerline_fire]: assets/img/powerline_examples_fire.png
[prompt_v2_powerline_round]: assets/img/powerline_examples_round.png
[prompt_v2_powerline_spikes]: assets/img/powerline_examples_spike.png
