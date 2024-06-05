Tools and scripts to parse Animal Well binary save  data

# Templates

## 010 Editor
`AW_SaveData.bt` is the binary template file for [010 Editor](https://www.sweetscape.com/010editor/)
To edit your savedata:
 1. Install the editor, run it, open your `AnimalWell.sav` as a binary/hex file
 2. Go to `Templates -> Open Template` and open the downloaded `AW_SaveData.bt`.
 3. Press F5 to run the template or use the menu to run it.
 4. You should see the Template Results window output down below. If you dont see it, press Alt+4
 5. ONLY modify the savefile values though Template Results! Ignore Inspector.
 6. After you are done making the changes, enter **999**  into `GlobalState -> SaveHash` field, press Enter - it will calculate save hash. **Re-save** the file. If you forget this step... well, you will see.

 If you want to use the template at runtime, to edit live game state, in-game - open the Animal Well process, run search for hex bytes `41 57 41 56 56 57 53 48 83 EC 60 48 8B 1D` and then just run the template.


## ImHex
`AW_SaveData.hexpat` is a port of the 010 template to open-source [ImHex](https://imhex.werwolv.net/)
It lacks some of the features of the base 010 template like previews for some data, but otherwise indentical.


# Tools
Known save editors:

- Apocalyptech's Python-based CLI [animalwellsave](https://github.com/apocalyptech/animalwellsave/)


# Documentation
The [project wiki](https://github.com/Kein/awsgtools/wiki) contains some documentation
on the save format which might be useful for human eyes, including various points
which might be useful for tool authors.


# Contributing
If you plan to contribute to template tables, make sure to ALWAYS explictly pad any of the bitfields (structs). This is because ImHex does no padding by default so the conversion can't be straightfoward. Inline declarations of structs 010 allwos also cannot be used for the same reasons.


# Contributors
* **Kein** - initial save format structure research, template maintenance  
* **apocalyptech** - initial save format structure research, tooling  
* **ero** - runtime save format structure research, lots of it  
* **lipsum** - runtime save format structure research  