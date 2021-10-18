# dmenukey - dmenu, press key to select
====================
## Usage
dmenu is an efficient dynamic menu for X. However, for little scripts such as a
power menu or music menu it would be usefull to do the following (for the power menu script): 
```
press p to poweroff
press r to reboot
press l to lock
...
```
instead of searching the default option. This is done with dmenu key. Just pass the key chars
to the first item. For example, for the power script:
```bash
printf "prl\npower\nreboot\nlock" | dmenukey
```
will set p for poweroff, r for reboot, ... This keys can be displayed in a hint
setting the option in `config.h` or `-H 0/1` to enable/disable this option.

Allowed keys are these one that doesn't require another key to put them. For example, % symbol
is not a valid key but SPC yes. Btw, you can set a character to replace SPC in the hint to
this character to visualiza that is a space

## Patches
I include many patches in the `patches/` folder. There are not applied in the code, so if you
want to apply them, just run
```bash
patch -p1 < patches/dmenukey-___.diff
```


Requirements
------------
In order to build dmenu you need the Xlib header files.


Installation
------------
Edit config.mk to match your local setup (dmenu is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install dmenukey
(if necessary as root):

    make clean install


Running dmenu
-------------
See the man page for details.
