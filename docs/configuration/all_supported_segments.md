# All supported segments

## Color values

For variables having `FG` or `BG`, i.e. defining respectively foreground or
background colors, when setting colors variables, you do not need to write the
full color syntax, just enter the color code corresponding of the color your
want. The surrounded of the color code will be set by dynamic prompt depending
on your terminal. Example of value are shown below:

<center>

| Color            | 8 colors   | 256 colors   | True colors      |
| ---------------- |:----------:|:------------:|:----------------:|
| Red              | 1          | 196          | 255;0;0          |
| Green            | 2          | 046          | 0;255;0          |
| Blue             | 4          | 021          | 0;0;255          |

</center>

Set of 256 colors supported by 256 colors terminal are shown at the end of the
file `common.exemple.sh` and in the image below. The number on the left of
hexadecimal colors value is the code of this color in 256 colors support.

<center>

![!256_colors][256_colors]

</center>

## Segment lists

Currently, all supported segments are in folder `segments/`.

Following table give short description of each of them as well as link to their
respective documentation.

<center>

| Name                                 | Short Description                       |
| :-------------------------           | :-------------------------------------- |
| [hfill](segments/hfill.md)           | Special segment to fill terminal line   |
| [pwd](segments/pwd.md)               | Current path                            |
| [bgjobs](segments/bgjobs.md)         | Number of background jobs               |
| [hostname](segments/hostname.md)     | Hostname of the computer                |
| [keepass](segments/keepass.md)       | Keepass variables loaded                |
| [kube](segments/kube.md)             | Kubernetes context                      |
| [openstack](segments/openstack.md)   | OpenStack context                       |
| [tmux](segments/tmux.md)             | Tmux windows and pane                   |
| [username](segments/username.md)     | Current username                        |
| [vcsh](segments/vcsh.md)             | Name of the vcsh repo                   |
| [vcs](segments/vcs.md)               | Version control informations            |
| [virtualenv](segments/virtualenv.md) | Virtual environment informations        |

<!-- TPL_NEW_SEGMENT (Comment for the script `new_segment.sh` DO NOT DELETE !!!-->
</center>

[256_colors]: ../assets/img/256_colors.png
