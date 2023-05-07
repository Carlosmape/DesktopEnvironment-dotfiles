#!/usr/bin/env bash
source $HOME/.config/rofi/applets/panel.sh

# Brightness Info
backlight="$(brightnessctl %g | tail -3 | awk '{print $4}' | sed 's/[^0-9]*//g')"
echo $brightness

# Options
option_1=""
option_2=""
option_3=""
pw_manager=""

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$pw_manager" | rofi_cmd 4
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		sh ~/.config/dunst/changeBright 70%
        ;;
    $option_2)
		sh ~/.config/dunst/changeBright 100%
        ;;
    $option_3)
		sh ~/.config/dunst/changeBright 30%
        ;;
    $pw_manager)
		slimbookbattery
        ;;
esac
