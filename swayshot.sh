#!/bin/sh

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

SCREENSHOT_TIMESTAMP=$(date +%F_%H-%M-%S_%N)

SCREENSHOT_FULLNAME="$SWAYSHOT_SCREENSHOTS"/screenshot_${SCREENSHOT_TIMESTAMP}.png

declare -r filter='
# returns the focused node by recursively traversing the node tree
def find_focused_node:
    if .focused then . else (if .nodes then (.nodes | .[] | find_focused_node) else empty end) end;
# returns a string in the format that grim expects
def format_rect:
    "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)";
find_focused_node | format_rect
'

case "$1" in
	-h|--help)
		echo 'Usage: swayshot [display|window|region]'
		return 0
		;;
	region)
		grim -g "$(slurp -b '#AFAFAFAF' -c '#FF3F3FAF' -s '#00000000' -w 3 -d)" "$SCREENSHOT_FULLNAME"
		;;		
	window)
		grim -g "$(swaymsg --type get_tree --raw | jq --raw-output "${filter}")" "$SCREENSHOT_FULLNAME"
		;;
	*)
		grim -o "$(swaymsg --type get_outputs --raw | jq --raw-output '.[] | select(.focused) | .name')" "$SCREENSHOT_FULLNAME"
		;;
esac

if type wl-copy >/dev/null  2>&1; then
	echo -n "$SCREENSHOT_FULLNAME" | wl-copy
elif type xsel >/dev/null  2>&1; then
	echo -n "$SCREENSHOT_FULLNAME" | xsel --clipboard
elif type xclip &>/dev/null; then
	echo -n "$SCREENSHOT_FULLNAME" | xclip -selection clipboard
else
	echo -n "$SCREENSHOT_FULLNAME"
fi

