#!/bin/bash

# if [[ $# -eq 0 ]] ; then
if [[ $(xrandr | grep "1366 x 768") ]] ; then
  # echo "crandr start"
  xrandr --newmode "1440x900_60.00"  106.50  1440 1528 1672 1904  900 903 909 934 -hsync +vsync
  xrandr --addmode HDMI1 "1440x900_60.00"
  xrandr --output LVDS1 --mode 1366x768
  xrandr --output HDMI1 --mode 1440x900_60.00 --right-of LVDS1
else
  # echo "crandr stop"
  xrandr --output HDMI1 --off
fi

# for arg in "$@"
# do
  # case $arg in
    # stop)
      # shift
      # ;;
    # start)
            # shift
      # ;;
  # esac
# done

