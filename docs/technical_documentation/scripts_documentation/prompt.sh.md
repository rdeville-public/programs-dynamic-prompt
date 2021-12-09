# `prompt.sh` script

This script is composed of only one function `precmd` which is used by `bash`
and `zsh` to compute the content of the prompt line to show.

It is sourced when opening a terminal (or loggin in tty) and source required
files such as `lib/functions.sh`, `lib/debug.sh` to then call function to
compute the prompt.

It also check if the user prompt required an upgrade if need.

The fact that this file mainly source other files is to ensure dynamicity of the
development, as such, every modification done to other scripts are reload
automatically as they are resourced each time.

Thus only modification done in this files requires to resource `~/.bashrc` or
`/.zshrc`.
