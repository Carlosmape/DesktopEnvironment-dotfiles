#!/usr/bin/env bash
source $HOME/.config/rofi/applets/panel.sh
# source $HOME/.config/rofi/applets/confirm.sh

# Theme Elements
prompt='Screenshot'
mesg="DIR: `xdg-user-dir PICTURES`/Screenshots"

# Options
fullscreen="󰹑"
select="󰆞"
window="󱃶"
short_delay="󰔝"
long_delay="󰔜"

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$fullscreen\n$select\n$window\n$short_delay\n$long_delay" | rofi_cmd 5
}

# Screenshot
time=`date +%Y-%m-%d-%H-%M-%S`
geometry=`xrandr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current'`
dir="`xdg-user-dir PICTURES`/Screenshots"
file="scr_${time}_${geometry}.png"

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# notify and view screenshot
notify_cmd_shot='notify-send -a '$prompt' -r '$notification_id
notify_view() { 
	${notify_cmd_shot} "Copied to clipboard."
	feh ${dir}/"$file"
	if [[ -e "$dir/$file" ]]; then
		${notify_cmd_shot} "Screenshot Saved. ${mesg}"
	else
		${notify_cmd_shot} "Screenshot Deleted."
	fi
	exit 0;
}

# Copy screenshot to clipboard
copy_shot () {
	tee "$file" | xclip -selection clipboard -t image/png
}

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		${notify_cmd_shot} "Taking shot in : $sec"
		sleep 1
	done
}

# take shots
shotnow () {
	cd ${dir} && sleep 0.5 && scrot - ${file} | copy_shot
	notify_view
}

shot3 () {
	countdown '3' && cd ${dir} && scrot - ${file} | copy_shot
	notify_view
}

shot10 () {
	countdown '10' && cd ${dir} && scrot - ${file} | copy_shot 
	notify_view
}

shotwin () {
	cd ${dir} && scrot -u - ${file} | copy_shot
	notify_view
}

shotarea () {
	cd ${dir} && scrot -s -d2 - ${file} | copy_shot
	notify_view
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $fullscreen)
		shotnow
        ;;
    $select)
		shotarea
        ;;
    $window)
		shotwin
        ;;
    $short_delay)
		shot3
        ;;
    $long_delay)
		shot10
        ;;
esac


