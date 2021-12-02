# FAQ & Known issues

## FAQ

### Troubleshoot

#### Why prompt display weird character ?

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

You can see [Add terminal support][add_terminal_support] for more information
about this issue.

### Other questions

#### Why not using some prompt framework like [bash-it][bash-it] [oh-my-zsh][oh-my-zsh] or [prezto][prezto] ?

I used to use bash-it and oh-my-zsh, but I was overhelmed by all their options,
plugins, etc., that I not fully used. Moreover, I had to manage two
configuration, one for bash and one for zsh. So I ended on making my own with
only things I need and I try to unified bash and zsh.

#### Why managing both bash and zsh ?

I do sysadmin, and I try to not install thing that could upset my coworker
which mainly use bash. Moreover, bash is installed by default on most GNU/Linux
distribution, allowing me to get my own prompt on most GNU/Linux distro.

#### Why is there no `date` segment ?

It is intended. I do not need date in my terminal, but I have prepared this
segment. It is the tutorial [Add your own segment][add_segment] to show how to
add your own segment.

This segment is simple to code, so you will need to add it yourself by reading
the [Add your own segment][add_segment].

## Know Issues

**Direnv integration**

When using `direnv`, segment that should be shown because global variables are
set by `direnv` are not shown directly. User must press `<Enter>` once again to
view them (or enter any command). This is due to the fact that the direnv hook
is executed after `precmd` as shown with the gif below.

![!Direnv issue][direnv_issues]


[bash-it]: https://github.com/Bash-it/bash-it
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[prezto]: https://github.com/sorin-ionescu/prezto

[add_segment]: ../adding-features/add_segment.md
[add_terminal_support]: ../adding-features/add_terminal_support.md
[configure_your_prompt_colors_support]: ../configuration/configure_your_prompt.md#colors-support
[configure_your_prompt_unicode_support]: ../configuration/configure_your_prompt.md#unicode-support

[direnv_issues]: TODO

[prompt_v1_no_unicode]: TODO
[prompt_v2_no_unicode]: TODO
[prompt_v1_no_colors]: TODO
[prompt_v2_no_colors]: TODO
