# swayshot #

Print screen helper for [sway][] adds keyboard shortcuts for screenshots:

* **Print Scr** for whole screen
* **Alt + Print Scr** for a focused window
* **Shift + Print Scr** for a selected region

It saves screenshots to `XDG_PICTURES_DIR`, see more details on [XDG user directories][]

You can define your own screenshot folder: set **SWAYSHOT_SCREENSHOTS** in `~/.config/swayshot.sh`.

If `xsel` or `xclip` exist it copies full path to clipboard. Otherwise just prints it to `stdout`.

## How do I get set up?

### Archlinux

Just install the AUR package [swayshot][swayshot-AUR] ☺

### Other Linux distributions

You need to copy files:

* `swayshot.config` copy to `/etc/sway/config.d` as `swayshot`;
* `swayshot.sh` copy to `/usr/bin` as `swayshot` and make it executable.

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