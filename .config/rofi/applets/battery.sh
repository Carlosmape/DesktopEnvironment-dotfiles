#!/usr/bin/env bash
source $HOME/.config/rofi/applets/panel.sh

# Battery Info
battery="`acpi -b | cut -d',' -f1 | cut -d':' -f1`"
status="`acpi -b | cut -d',' -f1 | cut -d':' -f2 | tr -d ' '`"
percentage="`acpi -b | cut -d',' -f2 | tr -d ' ',\%`"
time="`acpi -b | cut -d',' -f3`"

if [[ -z "$time" ]]; then
	time=' Fully Charged'
fi

# Theme Elements
prompt="$status"
mesg="${battery}: ${percentage}%,${time}"

# Charging Status
active=""
urgent=""
if [[ $status = *"Charging"* ]]; then
    active="-a 1"
    ICON_CHRG=""
elif [[ $status = *"Full"* ]]; then
    active="-u 1"
    ICON_CHRG=""
else
    urgent="-u 1"
    ICON_CHRG=""
fi

# Discharging
if [[ $percentage -ge 5 ]] && [[ $percentage -le 19 ]]; then
    ICON_DISCHRG=""
elif [[ $percentage -ge 20 ]] && [[ $percentage -le 39 ]]; then
    ICON_DISCHRG=""
elif [[ $percentage -ge 40 ]] && [[ $percentage -le 59 ]]; then
    ICON_DISCHRG=""
elif [[ $percentage -ge 60 ]] && [[ $percentage -le 79 ]]; then
    ICON_DISCHRG=""
elif [[ $percentage -ge 80 ]] && [[ $percentage -le 100 ]]; then
    ICON_DISCHRG=""
fi

# Options
option_1="$ICON_DISCHRG"
option_2="$ICON_CHRG"
pw_manager=""
pw_top=""

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$pw_manager\n$pw_top" | rofi_cmd 4
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		notify-send -u low " Remaining : ${percentage}%"
        ;;
    $option_2)
		notify-send -u low "$ICON_CHRG Status : $status"
        ;;
    $pw_manager)
		slimbookbattery
        ;;
    $pw_top)
		urxvtc -e sudo powertop
        ;;
esac


