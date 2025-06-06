#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10
## style-11    style-12    style-13    style-14    style-15

theme='style-2'
dir="$HOME/.config/rofi/styles/"
## Run
                                       


rofi \
	  -run-command "/bin/bash -ic '${HOME}/.config/rofi/hooks/hook.sh {cmd}'" \
	  -modes "run,ssh,drun" \
    -show drun \
    -theme ${dir}/${theme}.rasi
