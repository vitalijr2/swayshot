#!/bin/sh
# Screenshot helper for sway.
# Copyright 2017,2019,2021 Witalij Berdinskich.

if [ -z "$WAYLAND_DISPLAY" ]; then
	(>&2 echo Wayland is not running)
	exit 1
fi

## Put the path to your own screenshot folder
## to variable SWAYSHOT_SCREENSHOTS here: ~/.config/swayshot.sh
if [ -f ~/.config/swayshot.sh ]; then
	. ~/.config/swayshot.sh
fi

if [ -z "$SWAYSHOT_SCREENSHOTS" ]; then
  # only assumes user has at least $HOME set. man xdg-user-dirs-update(1)
  XDG_USERS_FILE=${XDG_CONFIG_HOME:=$HOME/.config}/user-dirs.dirs
  if [ -f "$XDG_USERS_FILE" ]; then
    eval SWAYSHOT_SCREENSHOTS="$(grep '^XDG_PICTURES_DIR=' "$XDG_USERS_FILE" | cut -d '=' -f 2 | tr -d '"')"
  else
    SWAYSHOT_SCREENSHOTS="$HOME"
  fi
fi

SCREENSHOT_TIMESTAMP=$(date "+${SWAYSHOT_DATEFMT:-%F_%H-%M-%S_%N}")
SCREENSHOT_FULLNAME="$SWAYSHOT_SCREENSHOTS"/screenshot_${SCREENSHOT_TIMESTAMP}.png

readonly filter='recurse(.nodes[], .floating_nodes[]) | select(.focused and .pid).rect | "\(.x),\(.y) \(.width)x\(.height)"'

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
	if command -v wl-copy >/dev/null  2>&1; then
		if [ -z "$SWAYSHOT_WL_COPY_FILE" ]; then
			printf "%s" "$1" | wl-copy
		else
			wl-copy < "$SCREENSHOT_FULLNAME"
		fi
	elif command -v xsel >/dev/null  2>&1; then
		printf "%s" "$1" | xsel --clipboard
		unset SWAYSHOT_WL_COPY_FILE
	elif command -v xclip >/dev/null 2>&1; then
		printf "%s" "$1" | xclip -selection clipboard
		unset SWAYSHOT_WL_COPY_FILE
	else
		echo "$1"
	fi
}

show_message() {
	if [ -z $SWAYSHOT_HIDE_NOTIFICATION ]; then
		if command -v notify-send >/dev/null 2>&1; then
			notify-send --expire-time=3000 --category=screenshot --icon="$2" "$3" "$1"
		fi
	fi
}

upload_screenshot() {
	if [ -f "$1" ]; then
		if command -v curl >/dev/null  2>&1; then
			curl -s -F "file=@\"$1\"" https://0x0.st
		fi
	fi
}

make_screenshot "$1" "$SCREENSHOT_FULLNAME"

if [ ! -f "$SCREENSHOT_FULLNAME" ]; then
	exit;
fi

case "$2" in
	upload)
		SCREENSHOT_LOCATOR=$(upload_screenshot "$SCREENSHOT_FULLNAME")
		if [ -z "$SCREENSHOT_LOCATOR" ]; then
			copy_to_clipboard "$SCREENSHOT_FULLNAME"
			show_message "$SCREENSHOT_FULLNAME" document-save "Screenshot path"
			if [ -n "$SWAYSHOT_WL_COPY_FILE" ]; then
				show_message "Screenshot was copied to clipboard.\\nFeel free to paste it." "$SCREENSHOT_FULLNAME" "Screenshot image"
			fi
		else
			copy_to_clipboard "$SCREENSHOT_LOCATOR"
			show_message "$SCREENSHOT_LOCATOR" document-send "Screenshot URL"
			if [ -n "$SWAYSHOT_WL_COPY_FILE" ]; then
				show_message "Screenshot was copied to clipboard.\\nFeel free to paste it." "$SCREENSHOT_FULLNAME" "Screenshot image"
			fi
		fi
		;;
	*)
		copy_to_clipboard "$SCREENSHOT_FULLNAME"
		show_message "$SCREENSHOT_FULLNAME" document-save "Screenshot path"
		if [ -n "$SWAYSHOT_WL_COPY_FILE" ]; then
			show_message "Screenshot was copied to clipboard.\\nFeel free to paste it." "$SCREENSHOT_FULLNAME" "Screenshot image"
		fi
esac
