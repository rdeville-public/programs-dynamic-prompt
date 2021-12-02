# `vcsh` Segemnt

## Description

As I use [vcsh][vcsh] to manage my dotfiles, I need to know when I am in a vcsh
shell.

This segment is only shown when in a vcsh shell, i.e. when global variable
`VCSH_REPO_NAME` exists and is not empty. The content of the segment is the
value of variable `VCSH_REPO_NAME`.

## Requirements

Obviously, this segement requires `vcsh` to be installed.

## Variables

<center>

| Variables       | Default   | Description                                         |
| :-------------: | :-------: | :-------------------------------------------------- |
| `VCSH_CHAR`     | ` `      | Character to show before the segment content        |
| `VCSH_FG`       | white     | Foreground color of segment                         |
| `VCSH_BG`       | black     | Background color of segment, **only used by _v2_**  |

</center>

## Examples

<center>

|                       | Prompt _v1_                      | Prompt _v2_                      |
| :-:                   |:-----------                     :|:-----------                     :|
| Full Version          | ![!vcsh v1 full][vcsh_v1_full]   | ![!vcsh v2 full][vcsh_v2_full]   |
| Maximum Short Version | ![!vcsh v1 short][vcsh_v1_short] | ![!vcsh v2 short][vcsh_v2_short] |

</center>

[vcsh]: https://github.com/RichiH/vcsh

[vcsh_v1_full]: ../../assets/img/vcsh_segment_full_v1.png
[vcsh_v1_short]: ../../assets/img/vcsh_segment_short_v1.png
[vcsh_v2_full]: ../../assets/img/vcsh_segment_full_v2.png
[vcsh_v2_short]: ../../assets/img/vcsh_segment_short_v2.png
