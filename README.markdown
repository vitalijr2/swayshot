# swayshot #

Print screen helper for [sway][] adds keyboard shortcuts for screenshots:

* **Print Scr** for whole screen
* **Alt + Print Scr** for a focused window
* **Shift + Print Scr** for a selected region

## Customization ##

It saves screenshots to **XDG_PICTURES_DIR**, see more details on [XDG user directories][].
Default filename is _screenshot_YYYY-MM-DD_HH24-MI-SS_SSS.png_

But you can change path and timestamp format

User variables in **~/.config/swayshot.sh**.

* **SWAYSHOT_SCREENSHOTS** defines your own screenshot folder;
* **SWAYSHOT_DATEFMT** defines timestamp format (see `man date`), thanks [Ranieri Althoff](https://gitlab.com/ranisalt) for help.

## Path to last screenshot ##

If **wl-clipboard** (wl-copy), **xsel** or **xclip** exist it copies full path to clipboard. Otherwise just prints it to **stdout**.

## How do I get set up?

### Archlinux

Just install the AUR package [swayshot][swayshot-AUR] ☺

### Other Linux distributions

Requires:
* grim
* jq
* slurp
* sway (certainly)

Optional dependencies:
* xsel
* xclip
* wl-clipboard

You need to copy files:

* **swayshot.config** copy to **/etc/sway/config.d** as **swayshot**;
* **swayshot.sh** copy to **/usr/bin** as **swayshot** and make it executable.

Then just reload Sway's configuration file (usually it's **$mod + Shift + c**).

## Contribution guidelines

Please read [CONTRIBUTING](CONTRIBUTING.markdown) for details on our code of conduct, and the process for submitting pull requests to us.

## History

See [CHANGELOG](CHANGELOG.markdown)

## License

[Apache License v2.0](LICENSE)  
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg?style=flat)](http://www.apache.org/licenses/LICENSE-2.0.html)

[sway]: http://swaywm.org/ "Sway is a drop-in replacement for the i3 window manager, but for Wayland instead of X11"
[XDG user directories]: https://wiki.archlinux.org/index.php/XDG_user_directories
[swayshot-AUR]: https://aur.archlinux.org/packages/swayshot/