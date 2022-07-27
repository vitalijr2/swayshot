# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) 
and this project adheres to [Semantic Versioning](http://semver.org/).

## [2.7.0] - 2022-07-27
- Replace [x0.at](https://x0.at) with [0x0.st](https://0x0.st)

## [2.6.1] - 2021-10-04
### Fixed
-   It does not exit after taking a screenshop: wl-copy still works in background.

## [2.6.0] - 2021-03-26
### Added
-   Copy an image file itself to clipboard.

## [2.5.1] - 2021-03-21
### Fixed
-   Make script POSIX shell compatible.

## [2.5.0] - 2021-03-20
### Fixed
-   Bashisms.

## [2.4.1] - 2021-03-20
### Fixed
-   Swap titles of upload message.

## [2.4.0] - 2021-03-20
### Added
-   Add title to message.
-   Make curl silent.

## [2.3.0] - 2021-03-19
### Added
-   Three new command that upload a screenshot to x0.at.

## [2.2.0] - 2019-05-29
### Added
-   User can define timestamp format.

## [2.1.0] - 2019-03-22
### Added
-   Use `wl-clipboard` to copy screenshot path to clipboard.

## [2.0.1] - 2019-03-20
### Changed
-   Fix issue of region screenshot, use anoter bindkeys: Shift + Print Scr.

## [2.0.0] - 2019-03-20
### Added
-   Use slurp for regions.
### Changed
-   As [swaygrab was deprecated in sway 1.0](https://github.com/swaywm/sway/releases/tag/1.0) now it use grim.
-   Rename to swayshot, was swaygrab-helper.

## 1.1.0 - 2017-07-22
### Added
-   Now it can copy full path to clipboard with xsel or xclip.

## 1.0.1 - 2017-07-20
### Fixed
-   Remove the file extensions `.sh` in the config.


## 1.0.0 - 2017-07-20
### Initial release
-   Keyboard shortcuts for whole screen and focused window.

[2.7.0]: https://gitlab.com/racy/swayshot/compare/2.6.1...2.7.0
[2.6.1]: https://gitlab.com/racy/swayshot/compare/2.6.0...2.6.1
[2.6.0]: https://gitlab.com/racy/swayshot/compare/2.5.1...2.6.0
[2.5.1]: https://gitlab.com/racy/swayshot/compare/2.5.0...2.5.1
[2.5.0]: https://gitlab.com/racy/swayshot/compare/2.4.1...2.5.0
[2.4.1]: https://gitlab.com/racy/swayshot/compare/2.4.0...2.4.1
[2.4.0]: https://gitlab.com/racy/swayshot/compare/2.3.0...2.4.0
[2.3.0]: https://gitlab.com/racy/swayshot/compare/2.2.0...2.3.0
[2.2.0]: https://gitlab.com/racy/swayshot/compare/2.1.0...2.2.0
[2.1.0]: https://gitlab.com/racy/swayshot/compare/2.0.1...2.1.0
[2.0.1]: https://gitlab.com/racy/swayshot/compare/2.0.0...2.0.1
[2.0.0]: https://gitlab.com/racy/swayshot/compare/1.1.0...2.0.0