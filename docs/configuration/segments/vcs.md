# `vcs` Segment

## Description

This segment is a "meta-segment" to show version control system information.

For now, only `git` is supported. as it is the only one I use. If you want to
add support of another version control system, like mercurial or svn, feel free
to contribute, I'll be glad to help as much as I can.

This idea of this segment is to propose an global content without worrying about
the version control system behind, doing so avoid having one segment entry for
each possible version control system. Content of the segment is outputed from
the version control system specific script (for now only git in
`segment/vcs/git.sh`) which use variable from this segment.

As it only support `git` for now, this segment is only shown when in a git repo.

## Requirements

Obviously, this segment requires `git` to be installed.

## Variables

<center>

| Variables               | Default     | Description                                                                                                |
| :---------------------: | ::-------:  | ---------------------------------------------------------------------------------------------------------- |
| `VCS_CHAR`              | `$GIT_CHAR` | Character to show before the segment content                                                               |
| `VCS_COMPRESSED`        | `false`     | Boolean, show vcs segment content compressed,<br> show less informations when set to `true`                |
| `VCS_COLORED`           | `false`     | Boolean, show vcs section with colors                                                                      |
| `VCS_FG`                | white       | Default foreground color of the segment                                                                    |
| `VCS_BG`                | black       | Default background color of the segment                                                                    |
| `VCS_PROMPT_DIRTY_FG`   | white       | Foreground color of the char indicating <br>repo is dirty                                                  |
| `VCS_PROMPT_CLEAN_FG`   | white       | Foreground color of the char indicating <br>repo is clean                                                  |
| `VCS_BRANCH_FG`         | white       | Foreground color of the branch name                                                                        |
| `VCS_TAG_FG`            | white       | Foreground color of the tag when repo is at <br>a tagged commit                                            |
| `VCS_DETACHED_FG`       | white       | Foreground color of the commit when the repo is<br> detached from HEAD                                     |
| `VCS_COMMIT_FG`         | white       | Foreground color of the current commit of the repo                                                         |
| `VCS_AHEAD_FG`          | white       | Foreground color when the current repo is ahead <br>of the correspond branch on remote `origin`            |
| `VCS_BEHIND_FG`         | white       | Foreground color when the current repo is behind <br>of the correspond branch on remote `origin`           |
| `VCS_UNTRACKED_FG`      | white       | Foreground color of the number of untracked files                                                          |
| `VCS_STAGED_FG`         | white       | Foreground color of the number of staged files                                                             |
| `VCS_UNSTAGED_FG`       | white       | Foreground color of the number of unstaged files                                                           |
| `VCS_STASH_FG`          | white       | Foreground color when there ara stashed changes                                                            |

</center>

## Git Specific variables

This variables are specific to `vcs` segment when in folder versionned using git

<center>

| Variables                 | Default   | Description                                                                                                 |
| :-----------------------: | :-------: | -----------------------------------------------------------------------------------------------------       |
| `GIT_CHAR`                | ``       | Character to show before the segment content <br>when in git repo                                           |
| `GIT_IGNORE_UNTRACKED `   | `false`   | Boolean, to show number untracked files                                                                     |
| `GIT_PROMPT_DIRTY`        | `✗`       | Character to indicate that repo is dirty                                                                    |
| `GIT_PROMPT_CLEAN`        | `✓`       | Character to indicate that repo is clean                                                                    |
| `GIT_BRANCH_PREFIX`       | ``       | Character shown before the branch name                                                                      |
| `GIT_TAG_PREFIX`          | `笠[`     | Characters prefix around tag when repo is <br>at a tagged commit                                            |
| `GIT_TAG_SUFFIX`          | `]`       | Characters suffix around tag when repo is <br>at a tagged commit                                            |
| `GIT_DETACHED_PREFIX`     | ``       | Characters prefix around commit when repo <br>is detached from HEAD                                         |
| `GIT_DETACHED_SUFFIX`     | `]`       | Characters suffix around commit when repo <br>is detached from HEAD                                         |
| `GIT_AHEAD_CHAR`          | `ﰵ`       | Character to show when repo is ahead of <br>the corresponding branch on remote `origin`                     |
| `GIT_BEHIND_CHAR`         | `ﰬ`       | Character to show when repo is behind of <br>the corresponding branch on remote `origin`                    |
| `GIT_UNTRACKED_CHAR`      | ``       | Charater to show before the number of untracked files,<br>will be followed by the number of untracked files |
| `GIT_UNSTAGED_CHAR`       | ``       | Charater to show before the number of unstaged files, <br>will be followed by the number of unstaged files  |
| `GIT_STAGED_CHAR`         | ``       | Charater to show before the number of stages files,<br>will be followed by the number of untracked files    |
| `GIT_STASH_CHAR_PREFIX`   | `{`       | Charaters prefix when there ara stashed changes                                                             |
| `GIT_STASH_CHAR_SUFFIX`   | `}`       | Charaters suffix when there ara stashed changes                                                             |

</center>

## Examples

<center>

|                       | Prompt _v1_                    | Prompt _v2_                    |
| :-:                   |:-----------                   :|:-----------                   :|
| Full Version          | ![!vcs v1 full][vcs_v1_full]   | ![!vcs v2 full][vcs_v2_full]   |
| Maximum Short Version | ![!vcs v1 short][vcs_v1_short] | ![!vcs v2 short][vcs_v2_short] |

</center>

[vcs_v1_full]: ../../assets/img/git_segment_full_v1.png
[vcs_v1_short]: ../../assets/img/git_segment_short_v1.png
[vcs_v2_full]: ../../assets/img/git_segment_full_v2.png
[vcs_v2_short]: ../../assets/img/git_segment_short_v2.png
