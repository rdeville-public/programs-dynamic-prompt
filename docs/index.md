---
hide:
  - navigation # Hide navigation
  - toc        # Hide table of contents
---
<!-- markdownlint-disable MD041 -->
{% set curr_repo=subs("dynamic_prompt") %}

<!-- BEGIN MKDOCS TEMPLATE -->
<!--
WARNING, DO NOT UPDATE CONTENT BETWEEN MKDOCS TEMPLATE TAG !
Modified content will be overwritten when updating
-->

<div align="center">

  <!-- Project Title -->
  <a href="{{ git_platform.url }}{{ curr_repo.repo_path_with_namespace }}">
    <img src="{{ curr_repo.logo }}" width="200px">
    <h1>{{ curr_repo.name }}</h1>
  </a>

<hr>

{{ to_html(curr_repo.desc) }}

<hr>

  <b>
IMPORTANT !<br>

Main repo is on
<a href="{{ git_platform.url }}{{ curr_repo.git_slug_with_namespace }}">
  {{ git_platform.name }} - {{ curr_repo.git_name_with_namespace }}</a>.<br>
On other online git platforms, they are just mirrors of the main repo.<br>
Any issues, pull/merge requests, etc., might not be considered on those other
platforms.
  </b>

</div>

<!-- END MKDOCS TEMPLATE -->



## Description

This repo contains scripts allowing you to setup a dynamic and "responsive"
prompt. As I live mainly in terminal and I mainly do sysadmin, I need to know
quickly on which kind of computer I am, personnal, professional, workstation,
server, which OpenStack pool variables are loaded, which Kubernetes
configuration is loaded, etc.

??? note
    Its part of my dotfiles repos which optimize my terminal usage. For now, all
    my dotfiles are not yet clean neither documented. Once done, a link will be
    provided if you want to learn more about how my terminal usage.

The aims of this prompt are:

  * **Support `bash` and `zsh` in a transparent way**

    Before using this prompt, I used shell frameworks [`bash-it`][bash-it] and
    [`oh-my-zsh`][oh-my-zsh]. So, when I needed to add something, I needed to
    work on two prompt configuration. I wanted to centralize this to manage both
    at once. Moreover, my personnal computer use `zsh` while most server I work
    on use `bash`, so I must support both with only one repo and the less
    possible files.

  * **Being fast**

    Prompt with all segments must be shown in less than 250ms in average on my
    computers. In the CI, the average computation time is set to 500ms (because
    CI is done within docker container and poor hardware). Unfortunately, I can
    not ensure you this prompt is able to be shown in this amount of time,
    because this is depending on your hardware[^1].

  * **Being dynamic**

    Show informations of the current folder only if there exists. For instance,
    show python environment informations or git informations only when there
    exists, k8s cluster namespace only when set, etc.

  * **Being responsive**

    When terminal emulator is to short, the prompt must shrink informations
    until hiding them completely when there is not enough space to show all
    segments.

  * **Being fully customizable**

    As I used multiple computers, I need to be able to quickly set a common
    shared configuration (colors, characters, etc) and some computer specific
    configuration. This must be done by modifiying the less possible files.

  * **Being extensible**

    If user need to add a new segment, it should be as easy as possible to do
    so.

  * **Being "discrete"**

    The computation of the prompt lines should export as few functions and
    variables as possible, i.e. functions used in this repo can not be called
    when you can input your command. This is to avoid adding mess in your global
    variables environment as well as your global functions.


??? question "Why this new prompt while there exists similar project like [liquidprompt][liquidprompt] ? (click to reveal)"

    When I started this prompt, I did not know liquidprompt. After quickly
    checking the code, here are some differences I saw:

      * Almost all variables used to show this prompt are not exported and so do
        not add useless variables in your shell environment.
      * This prompt allow you to easily add your own segment.
      * This repo propose you two versions, one quite "classic" and one more
        "powerline" lool alike. Choosing which version to use is done simply by
        changing variable `PROMPT_VERSION` (see [Configure your
        prompt][configure_your_prompt]).
      * This prompt may have few dependencies, like the `git` or the `kubectl`.
        But these dependencies are only requires if you use segments which
        requires these dependencies. In other terms, dependencies are per
        segments, the core of the prompt does not have any dependencies.
      * Every modification, like changing colors, changing segments used or
        their order, adding the code of a new segments, etc., is done
        dynamically, no need to source your `~/.bashrc` or `~/.zshrc` on every
        change. Only changes done to the script `prompt.sh` requires to reload
        your `~/.bashrc` or your `~/.zshrc`

    I may be wrong as I quickly check the code of liquidprompt and I'm open to
    take any remark.

??? question "What about other similar project ? (click to reveal)"

    For the moment, I have forgotten some other projects name, but a common
    things about these projects I remember is that these projects often required
    external dependencies like node or go.

    One of the main goal of this project is to use as low external dependencies
    as possible. Indeed some segments required external dependencies, like git
    and other dependencies are required for developing, like mkdocs.
    But for now, as user, the only dependencies for this prompt are :

    * bash >= 4.0
    * zsh >= 5.0

## Prompt description

### Prompt illustration

In the following section, I will present the prompt with default prompt line,
i.e. default segments organisation, and with the colors provided by the file
`host/common.example.sh`. You will be able change segments organisation and
colors as descibed in [Configure your prompt][configure_your_prompt].

First of all, this repo propose two "version" of the prompt:

  * The _v1_ which is kind of "classic" and is also the fallback version.
  * The _v2_ which is more "powerline" like.

!!! note
    As there is not differences in behaviour neither in display whether you use
    `bash` or `zsh`, the shell will not be specified in all screenshots of this
    documentation

Here are some screenshots of both prompt version :

  * The _v1_ is "classic" as show belown for bash and zsh (click on image to enlarge).

![!Prompt v1][prompt_v1]

  * The _v2_ is more "powerline" look alike as shown below for bash and zsh (click on image to enlarge).

![!Prompt v2][prompt_v2]

In both case, (almost) all parts (colors, character, which segment to show, in
which order, etc.) are customizable. You can either choose to show only some
segments or change their colors depending on what you prefer.

The above show the prompt when no "environment" is loaded, i.e. only segment
`pwd`, `hostname` and `username` are actually displayed. The colored horizontal
line is here to know quickly on which type of computer I am (for instance, red
for professional workstation, magenta for professional servers, green for
personnal workstation, yellow for personal servers, etc.). All colors of the
prompt (the current directory, the username, etc.) can be easily change for each
computer based on its hostname as described in [Configure your
prompt][configure_your_prompt].

Below is what prompt looks like when almost most supported segments are loaded.

Not all supported segment are displayed, because some segments might have be
added after taking these screenshots, see below the up-to-date list of supported
segments.

  * The _v1_, "classic" version (click on image to enlarge)

![!Prompt v1 Full][prompt_v1_full]

  * The _v2_, "powerline" version (click on image to enlarge)

![!Prompt v2 Full][prompt_v2_full]

Supported segments/environment are :

<center>

| Name                                                 | Short Description                       |
| :-------------------------                           | :-------------------------------------- |
| [return_code](configuration/segments/return_code.md) | Exit code of the previous command   |
| [hfill](configuration/segments/hfill.md)             | Special segment to fill terminal line   |
| [pwd](configuration/segments/pwd.md)                 | Current path                            |
| [bgjobs](configuration/segments/bgjobs.md)           | Number of background jobs               |
| [hostname](configuration/segments/hostname.md)       | Hostname of the computer                |
| [keepass](configuration/segments/keepass.md)         | Keepass variables loaded                |
| [kube](configuration/segments/kube.md)               | Kubernetes context                      |
| [openstack](configuration/segments/openstack.md)     | OpenStack context                       |
| [tmux](configuration/segments/tmux.md)               | Tmux windows and pane                   |
| [username](configuration/segments/username.md)       | Current username                        |
| [vcsh](configuration/segments/vcsh.md)               | Name of the vcsh repo                   |
| [vcs](configuration/segments/vcs.md)                 | Version control informations            |
| [virtualenv](configuration/segments/virtualenv.md)   | Virtual environment informations        |
| [date](configuration/segments/date.md) | Show the date |
<!-- TPL_NEW_SEGMENT (Comment for the script `new_segment.sh` DO NOT DELETE !!!-->

</center>

!!! important
    `date` segment **will never be added** to the repo as it is use as support
    to the tutorial [Add your own segment][dynamic_prompt_add_segment] and is
    quite simple to setup :wink:.

For every segments, colors and characters can be configured
individually to be shown or not (see [Configure your
prompt][configure_your_prompt]).

Moreover, when logged as `root` all the prompt shift to bold, thus I know
visually that I am `root` and things I do can be dangerous. See below for a
examples.

  * The _v1_, "classic" version (click on image to enlarge)

![!Prompt v1 root full][prompt_v1_root_full]

  * The _v2_, "powerline" version (click on image to enlarge)

![!Prompt v2 root full][prompt_v2_root_full]

Finally, examples above show prompt filling the terminal line, but you can also
configure your prompt to have a more "standard" display as shown below:


  * The _v1_, "classic" version

With few segments (click on image to enlarge)

![!Prompt v1 "Standard" display][prompt_v1_standard_display]

With more segments (click on image to enlarge)

![!Prompt v1 "Standard" display full][prompt_v1_standard_display_full_info]

  * The _v2_, "powerline" version

With few segments (click on image to enlarge)

![!Prompt v2 "Standard" display][prompt_v2_standard_display]

With more segments (click on image to enlarge)

![!Prompt v2 "Standard" display full][prompt_v2_standard_display_full_info]

!!! important
    **When in `tty` or in unsupported terminal emulator, prompt will
    automatically fall back to prompt _v1_.**

### Environment contraction

When there is not enough space to show all segments completely, they will be
contracted to show minimal informations, usually only the character of the
segment.

The more your terminal will shorten, the less segment informations will be
shown. Order on which segments are contracted are always in the same order,
defined by user (see [Configure your prompt][configure_your_prompt]). Finally,
if there is really not enough space, some information will be completely hidden.

Exemple of contraction are shown below for both prompt version.

  * Prompt _v1_ (click on image to enlarge)

![!Prompt v1 Shrink][prompt_v1_shrink]

  * Prompt _v2_ (click on image to enlarge)

![!Prompt v2 Shrink][prompt_v2_shrink]

??? warning "Warning about the contraction behaviour ! (click to reveal)"

    GIFs above only show contraction behaviour.

    But as variable `PS1` for `bash` and `PROMPT` for `zsh` are only computed
    before printing them, i.e. before printing the prompt, when you resize your
    terminal emulator, you will need to press `Enter` once to recompute the size
    of your prompt and so update the display of the prompt.

    When resizing your terminal, before pressing `Enter`, you prompt might look
    like shown below.

    * When increasing size of terminal emulator

    Prompt _v1_ (click on image to enlarge)

    ![!Prompt v1 Increase terminal size][prompt_v1_resized_plus]

    Prompt _v2_ (click on image to enlarge)

    ![!Prompt v2 Increase terminal size][prompt_v2_resized_plus]

    * When decreasing size of terminal emulator

    Prompt _v1_ (click on image to enlarge)

    ![!Prompt v1 Decrease terminal size][prompt_v1_resized_minus]

    Prompt _v2_ (click on image to enlarge)

    ![!Prompt v2 Decrease terminal size][prompt_v2_resized_minus]

### Default prompt colors

By default, if no user configuration exists, no colors will be set, as shown
below for both versions.

  * Prompt _v1_ (click on image to enlarge)

![!Prompt v1 No Colors][prompt_v1_no_colors]

  * Prompt _v2_ (click on image to enlarge)

![!Prompt v2 No Colors][prompt_v2_no_colors]


## Go further & documentation

If you want to try this prompt, view how to configure it and more:

  * Visit the [documentation][documentation].
    * Check the [Getting started][getting_started] to get the code and learn how
      to test the prompt.
    * Look at [Configure your prompt][configure_your_prompt] to start
      customizing your prompt.
    * Look at [Add your own segment][dynamic_prompt_add_segment] to add your own
      segment easily.
  * Look at the Project [release notes][release_notes].
  * Check the [FAQ & Known Issues][FAQ].
  * Want to [contribute][contributing] ?

## Futur possible updates

Here is a list of idea I may work on one day, if I have the time and/or the will
to do so. But these are not guaranteed. However, if you want some of these
features and/or you want to contribute in any way, I will be glad to help you.

  - [ ] : Test integration with
    - [ ] : [bash-it][bash-it]
    - [ ] : [oh-my-zsh][oh-my-zsh]
  - [ ] : Propose an automatic/interactive install script.

<!-- Footnotes -->
[^1]:
  As information, my two main computers have following hardware configurations:

    - Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz / 16Go DDR4 RAM 1200Mhz
    - Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz / 16Go DDR3 RAM 1333Mhz
    - But I play with some RPi and Brix Gigabyte like (Intel Celeron) :wink:


<!-- link external to this documentation -->
[bash-it]: https://github.com/Bash-it/bash-it
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[liquidprompt]: https://github.com/nojhan/liquidprompt

<!-- link "local" to this documentation -->
[documentation]: README.md
[getting_started]: getting_started.md
[configure_your_prompt]: configuration/configure_your_prompt.md
[dynamic_prompt_add_segment]: adding-features/add_segment.md
[release_notes]: about/release_notes.md
[FAQ]: about/FAQ.md
[contributing]: adding-features/contributing.md

<!-- link to image local to documentation -->
[prompt_v1]: assets/img/base_prompt_v1.png
[prompt_v2]: assets/img/base_prompt_v2.png
[prompt_v1_full]: assets/img/full_prompt_v1.png
[prompt_v2_full]: assets/img/full_prompt_v2.png
[prompt_v1_root_full]: assets/img/full_prompt_v1_root.png
[prompt_v2_root_full]: assets/img/full_prompt_v2_root.png
[prompt_v1_standard_display]: assets/img/prompt_v1_standard.png
[prompt_v1_standard_display_full_info]: assets/img/prompt_v1_standard_full.png
[prompt_v2_standard_display]: assets/img/prompt_v2_standard.png
[prompt_v2_standard_display_full_info]: assets/img/prompt_v2_standard_full.png
[prompt_v1_shrink]: assets/img/shrink_v1.gif
[prompt_v2_shrink]: assets/img/shrink_v2.gif
[prompt_v1_resized_plus]: assets/img/increase_term_size_v1.png
[prompt_v2_resized_plus]: assets/img/increase_term_size_v2.png
[prompt_v1_resized_minus]: assets/img/decrease_term_size_v1.png
[prompt_v2_resized_minus]: assets/img/decrease_term_size_v2.png
[prompt_v1_no_colors]: assets/img/default_no_color_v1.png
[prompt_v2_no_colors]: assets/img/default_no_color_v2.png
