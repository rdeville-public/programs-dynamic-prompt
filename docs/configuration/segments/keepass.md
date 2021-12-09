# `keepass` Segment

## Description

This segment show the value of variable `KEEPASS_NAME` when this one is set to
inform me when I have some keepass variables loaded to access my keepass
database from CLI.

I have my own wrapper around keepassxc-cli to use these keepass variables which
is stored in `tools/keepass`. If you want to use it, you are free to do so. You
can put in your a folder in your `PATH`to be able to use it anywhere.

Variables used by the script `tools/keepass` are automatically set using
[direnv][direnv].

To see how to use `direnv` for your folder, see
[Using direnv to setup environment-variables][using_direnv]

This segment is only shown when global shell environment variable `KEEPASS_NAME`
exists and is not empty.

## Requirements

This segment has no requirement as it only show value of variable
`KEEPASS_NAME`.

But if you wish to use it with the script provided, you may require
[keepassxc][keepassxc] to have the command `keepassxc-cli`.

## Variables

<center>

| Variables       | Default   | Description                                        |
| :-------------: | :-------: | :-----------------------------------------------   |
| `KEEPASS_CHAR`  | ` `      | Character to show before the segment content       |
| `KEEPASS_FG`    | white     | Foreground color of segment                        |
| `KEEPASS_BG`    | black     | Background color of segment, **only used by _v2_** |

</center>

## Examples

<center>

|                       | Prompt _v1_                    | Prompt _v2_                    |
| :-:                   |:-----------                   :|:-----------                   :|
| Full Version          | ![!keepass v1 full][keepass_v1_full]   | ![!keepass v2 full][keepass_v2_full]   |
| Maximum Short Version | ![!keepass v1 short][keepass_v1_short] | ![!keepass v2 short][keepass_v2_short] |

</center>

[direnv]: https://direnv.net/
[keepassxc]: https://keepassxc.org/

[using_direnv]: ../../technical_documentation/direnv.md

[keepass_v1_full]: ../../assets/img/keepass_segment_full_v1.png
[keepass_v1_short]: ../../assets/img/keepass_segment_short_v1.png
[keepass_v2_full]: ../../assets/img/keepass_segment_full_v2.png
[keepass_v2_short]: ../../assets/img/keepass_segment_short_v2.png
