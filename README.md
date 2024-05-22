Tools and scripts to parse Animal Well binary save  data

# Templates

## 010 Editor
`AW_SaveData.bt` is the binary template file for [010 Editor](https://www.sweetscape.com/010editor/)
Install the editor, run it, open `AnimalWell.sav` as a binary file, then go `Templates -> Open Template`
and open the `AW_SaveData.bt`. Press F5 to run/parse the savegame.
You can change data and values in the output/results window at the bottom (it pops-up when template is processed).
After you done making changes, enter **any** value into `GlobalState -> SaveHash` field, press enter, it will calculate save hash. Re-save the file. If you forget this step... well, you will see.


## ImHex
AW_SaveData.hexpat is a port of the 010 template to open-source [ImHex](https://imhex.werwolv.net/)
It lacks some of the features of the base 010 template like previews for some data, but otherwise indentical.


# Tools
In progress


# Contributing
If you plan to contribute to template tables, make sure to ALWAYS explictly pad any of the bitfields (structs). This is because ImHex does no padding by default so the conversion can't be straightfoward. Inline declarations of structs 010 allwos also cannot be used for the same reasons.
