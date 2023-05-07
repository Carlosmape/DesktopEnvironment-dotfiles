#!/usr/bin/env bash
confirm_theme=$HOME/.config/rofi/applets/confirm.rasi
#Options
yes=''
no=''

# Confirmation CMD
confirm_cmd() {
	rofi -dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${confirm_theme}
}
#
# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Confirm and execute
confirm_run() {	
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
    	return 0
    else
        exit
    fi	
}


