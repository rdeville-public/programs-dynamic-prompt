# Repo description

Here is a brief description of want files and folder in the repo stands for.

## `ci/` folder

This folder stores the scripts used to validate the prompt either manually when
developing and in the continous integration.

For more details, see [CI scripts][ci_scripts].


## `docs/` folder

This folder store the documentation of this prompt, the configuration and
description for each segments.

It also store images and gifs shown in documentation.

## `hosts/` folder

This folder is here to store your personnal configuration. By default, there is
two files that might interest you:

  * `common.exemple.sh`: An documentated basic set of variables . This is the
    file use for the screenshots above. Then for each workstation I have, they
    have their own configuration file in the form `$(hostname).sh`. For
    instance, file `death-star.sh` is the configuration for one of my computer
    which hostname is `death-star`.
  * `death-stat.sh`: The file specific to one of my computer which hostname is
    `death-star` in which I override some commonly shared variables setup in
    `common.exemple.sh`.

There is also a subfolder `exemples/` which contains multiple configuration.
See [General variables][general_variables] and
[Prompt examples][prompt_examples].

## `lib/ folder

This folder store the main scripts and functions used by this prompt. This is
where the core of the prompt is stored.

## `segment/` folder

This folder store all segments currently supported. If you want to add your own,
you will simply need to add you script in this file and setup your prompt
variable to use it. See [Add your own segment][add_segment] to add your own
segment.

## `test/` folder

This folder store docker configuration to test your prompt configuration without
messing with your current prompt. Normally, nothing need to be done in this
folder which is automatically used by script `test.sh`

## `tools/` folder

This folder store some script I used to ease the way to taking screenshot and
making gifs for the documentation.

## Other files

Here is a quick description files that are in the root of the repo:

  * `CODE_OF_CONDUCT.md`: The code of conduct to follow to participate to this
    project.
  * `CONTRIBUTING.md`: A link the contributing documentation
  * `LICENSE`: The license under which is the dynamic prompt project
  * `mkdocs.yml`: The configuration for [mkdocs][mkdocs] to generate the
    documentation website.
  * `README.md`: A quick introduction to the dynamic prompt and a quick gettng
    started.
  * `requirement.txt`: The list of python requirements to be able to generate
    the documentation.


**Important scripts:**

  * **`promp.sh`**: The main scripts which contains the `precmd` function which is
    used to compute the prompt lines.
  * **`which_term.sh`**: Script called by prompt.sh to know which terminal you
    use. This script can also be used to add your own prompt to the list of
    supported prompt. See [Add terminal support][add_terminal_support] and
    [which_term.sh Documentation][which_term.sh] for more informations.
  * **`new_segment.sh`**: A script to help you add your own segments, see [Add
    your own segment][add_segment] and [new_segment.sh
    documentation][new_segment.sh] for more information.
  * **`test.sh`**: Script to run the prompt in a docker container to test it
    safely. See [Testing][testing] and [test.sh Documentation][test.sh] for more
    informations.


Every main scripts used by this project is listed in [Scripts
documentation][scripts_documentation] which provided a link to individual
more complete documentation of these scripts.




[mkdocs]: https://www.mkdocs.org/

[ci_scripts]: scripts_documentation/ci_scripts.md
[general_variables]: ../configuration/general_variables.md
[prompt_examples]: ../configuration/prompt_examples.md
[add_terminal_support]: ../adding-features/add_terminal_support.md
[which_term.sh]: scripts_documentation/which_term.sh.md
[add_segment]: ../adding-features/add_segment.md
[new_segment.sh]: scripts_documentation/new_segment.sh.md
[testing]: ../getting_started.md#testing-the-prompt
[test.sh]: scripts_documentation/test.sh.md
[scripts_documentation]: scripts_documentation.md
