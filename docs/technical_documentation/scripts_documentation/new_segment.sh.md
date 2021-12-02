# `new_segment.sh` script

The script is here to help you start developping your own segment. By default,
if no options are provided, it will enter an interactive mode to ask you the
name of your segment and a short description of the segment.

As shown below:

  * Asking segment name<br>
    ![!new_segment.sh Asking segment name][new_segment.sh_ask_segment_name]

  * Asking segment short description<br>
    ![!new_segment.sh Asking segment desc][new_segment.sh_ask_segment_desc]


This information can be directly provided to the script as show in its manual
below:

??? "Usage of the script `new_segment.sh` (click to reveal)"
    ```
        TODO
    ```


From the provided name and description, the script will use following template
files to generate basic segment and basic documentation :

   * `segments/segment.sh.tpl`
   * `docs/configuration/segments/segment.md.tpl`

It will also automatically add the segment in the files that provided link to
supported segments, i.e. in following files:

  * `README.md`
  * `docs/README.md`
  * `docs/configuration/all_supported_segment.md`

To use the script, see [Add your own segment][add_your_own_segment].

[add_your_own_segment]: ../../adding-features/add_segment.md

[new_segment.sh_ask_segment_name]: TODO
[new_segment.sh_ask_segment_desc]: TODO
