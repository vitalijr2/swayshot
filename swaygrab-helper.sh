#!/bin/sh

if [[ -z $WAYLAND_DISPLAY ]]; then
	(>&2 echo Wayland is not running)
	exit 1
fi

## Put the path to your own screenshot folder
## to variable SWAYGRAB_SCREENSHOTS here: ~/.config/swaygrab-helper.sh
if [ -f ~/.config/swaygrab-helper.sh ]; then
	source ~/.config/swaygrab-helper.sh
fi

if [[ -z $SWAYGRAB_SCREENSHOTS ]]; then	
	SWAYGRAB_SCREENSHOTS=$(xdg-user-dir PICTURES)
fi

SCREENSHOT_TIMESTAMP=$(date +%F_%H-%M-%S_%N)

SCREENSHOT_FULLNAME="$SWAYGRAB_SCREENSHOTS"/${SCREENSHOT_TIMESTAMP}_swaygrab.png

case "$1" in
	-f|--focused)
		swaygrab --focused "$SCREENSHOT_FULLNAME"
		;;
	*)
		swaygrab "$SCREENSHOT_FULLNAME"
		;;
esac

if type xsel >/dev/null  2>&1; then
	echo -n "$SCREENSHOT_FULLNAME" | xsel --clipboard
elif type xclip &>/dev/null; then
	echo -n "$SCREENSHOT_FULLNAME" | xclip -selection clipboard
else
	echo -n "$SCREENSHOT_FULLNAME"q
fi


