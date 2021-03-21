# swayshot #

Screenshot helper for [sway][].

It adds keyboard shortcuts to take screenshot:

-   **Print Scr** made screenshot for whole screen
-   **Alt + Print Scr** made screenshot for a focused window
-   **Shift + Print Scr** made screenshot for a selected region
-   **Super + Print Scr** made screenshot for whole screen then upload it to [x0.at][]
-   **Super + Alt + Print Scr** made screenshot for a focused window then upload it to [x0.at][]
-   **Super + Shift + Print Scr** made screenshot for a selected region then upload it to [x0.at][]

## Customization ##

It saves screenshots to **XDG_PICTURES_DIR** (usually `$HOME/Pictures`), see more details on [XDG user directories][].

Default template of screenshot filename is _screenshot_YYYY-MM-DD_HH24-MI-SS_SSS.png_. But you can change path and timestamp format

User variables in **~/.config/swayshot.sh**.

-   **SWAYSHOT_SCREENSHOTS** defines your own screenshot folder;
-   **SWAYSHOT_DATEFMT** defines timestamp format (see `man date`), thanks [Ranieri Althoff](https://gitlab.com/ranisalt) for help.

## Path to last screenshot ##

If **wl-clipboard** (wl-copy), **xsel** or **xclip** exist it copies full path to clipboard. Otherwise just prints it to **stdout**.

## How do I get set up?

### Archlinux

Just install the AUR package [swayshot][swayshot-AUR] ☺

### Other Linux distributions

Requires:
-   grim
-   jq
-   slurp
-   sway (certainly)

Optional dependencies:
-   xsel
-   xclip
-   wl-clipboard

You need to copy files:

-   **swayshot.conf** copy to **/etc/sway/config.d**;
-   **swayshot.sh** copy to **/usr/bin** as **swayshot** and make it executable.

Then just reload Sway's configuration file (usually it's **$mod + Shift + c**).

## Contributing

Please read [Contributing](contributing.md).

## History

See [Changelog](changelog.md)

## License

Copyright 2017-2021 Witalij Berdinskich

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[Apache License v2.0](license)  
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg?style=flat)](http://www.apache.org/licenses/LICENSE-2.0.html)

## Acknowledgements

I would like to say thanks to people who point something wrong in my code or propose improvements:

-   [Jonas Meurer](https://gitlab.com/mejo-)
-   [Ranieri Althoff](https://gitlab.com/ranisalt)
-   [Chris Chamberlain](https://gitlab.com/neon64)
-   [Alpha](https://gitlab.com/AlphaShadows)
-   [Kishan Gupta](https://gitlab.com/kishangupta)

[sway]: http://swaywm.org/ "Sway is a drop-in replacement for the i3 window manager, but for Wayland instead of X11"
[x0.at]: https://x0.at "x0.at Filehost. Files are kept for a minimum of 10, and a maximum of 360 Days."
[XDG user directories]: https://wiki.archlinux.org/index.php/XDG_user_directories
[swayshot-AUR]: https://aur.archlinux.org/packages/swayshot/