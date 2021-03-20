#!/bin/sh
# Screenshot helper for sway.
# Copyright 2017,2019,2021 Witalij Berdinskich.

if [[ -z $WAYLAND_DISPLAY ]]; then
	(>&2 echo Wayland is not running)
	exit 1
fi

## Put the path to your own screenshot folder
## to variable SWAYSHOT_SCREENSHOTS here: ~/.config/swayshot.sh
if [ -f ~/.config/swayshot.sh ]; then
	source ~/.config/swayshot.sh
fi

if [[ -z $SWAYSHOT_SCREENSHOTS ]]; then	
	SWAYSHOT_SCREENSHOTS=$(xdg-user-dir PICTURES)
fi

SCREENSHOT_TIMESTAMP=$(date "+${SWAYSHOT_DATEFMT:-%F_%H-%M-%S_%N}")
SCREENSHOT_FULLNAME="$SWAYSHOT_SCREENSHOTS"/screenshot_${SCREENSHOT_TIMESTAMP}.png

make_screenshot() {
	case "$1" in
		-h|--help)
			echo 'Usage: swayshot [display|window|region]'
			return 0
			;;
		region)
			grim -g "$(slurp -b '#AFAFAFAF' -c '#FF3F3FAF' -s '#00000000' -w 3 -d)" "$2"
			;;
		window)
			grim -g "$(swaymsg --type get_tree --raw | jq --raw-output "${filter}")" "$2"
			;;
		*)
			grim -o "$(swaymsg --type get_outputs --raw | jq --raw-output '.[] | select(.focused) | .name')" "$2"
			;;
	esac
}

copy_to_clipboard() {
	if type wl-copy >/dev/null  2>&1; then
		echo -n "$1" | wl-copy
	elif type xsel >/dev/null  2>&1; then
		echo -n "$1" | xsel --clipboard
	elif type xclip &>/dev/null; then
		echo -n "$1" | xclip -selection clipboard
	else
		echo -n "$1"
	fi
}

show_message() {
	if type notify-send >/dev/null  2>&1; then
		notify-send --expire-time=3000 --category=screenshot --icon="$2" "$3" "$1"
	fi
}

upload_screenshot() {
	if [ -f "$1" ]; then
		if type curl >/dev/null  2>&1; then
			curl -s -F "file=@\"$1\";filename=.png" 'https://x0.at'
		fi
	fi
}

make_screenshot "$1" "$SCREENSHOT_FULLNAME"

[[ ! -f "$SCREENSHOT_FULLNAME" ]] && return 1;

case "$2" in
	upload)
		SCREENSHOT_LOCATOR=$(upload_screenshot "$SCREENSHOT_FULLNAME")
		if [ -z "$SCREENSHOT_LOCATOR" ]; then
			copy_to_clipboard "$SCREENSHOT_FULLNAME"
			show_message "$SCREENSHOT_FULLNAME" document-save "Screenshot path"
		else
			copy_to_clipboard "$SCREENSHOT_LOCATOR"
			show_message "$SCREENSHOT_LOCATOR" document-send "Screenshot URL"
		fi
		;;
	*)
		copy_to_clipboard "$SCREENSHOT_FULLNAME"
		show_message "$SCREENSHOT_FULLNAME" document-save "Screenshot path"
esac
