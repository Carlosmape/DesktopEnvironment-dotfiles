#!/usr/bin/env bash
source $HOME/.config/rofi/applets/confirm.sh

# Import Current Theme
theme=$HOME/.config/rofi/applets/full_screen_menu.rasi

# Theme Elements
prompt="`hostname`"
mesg="Uptime : `uptime -p | sed -e 's/up //g'`"
list_col='5'
list_row='1'

# Options
shutdown=''
reboot=''
lock=''
suspend=''
logout=''

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		confirm_run && systemctl poweroff
        ;;
    $reboot)
		confirm_run && systemctl reboot
        ;;
    $lock)
		if [[ -x '/usr/bin/betterlockscreen' ]]; then
			betterlockscreen -l
		elif [[ -x '/usr/bin/i3lock' ]]; then
			i3lock
		fi
        ;;
    $suspend)
		confirm_run && mpc -q pause &&\
			amixer set Master mute &&\
			systemctl suspend
        ;;
    $logout)
		confirm_run && bspc quit
        ;;
esac
