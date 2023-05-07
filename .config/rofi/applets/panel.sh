#!/usr/bin/env bash

# Import Current Theme
theme=$HOME/.config/rofi/applets/panel.rasi

list_col='1'
list_row='5'
size_per_element=24
win_width='120px'

notification_id=5981

# Rofi CMD Expect to receive the number of options
rofi_cmd() {

	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $1;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}
