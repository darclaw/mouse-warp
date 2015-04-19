#!/bin/bash
active_window=-1
while true
do
	if [ "$active_window" -ne `xdotool getactivewindow` ]
	then
		active_window=$(xdotool getactivewindow)
		echo `xdotool getactivewindow`
		WINDOW_GEOMETRY= xdotool getwindowgeometry `echo $ACTIVE_WINDOW`
		mkdir /tmp/mouse-warp
		xdotool getwindowgeometry `xdotool getactivewindow` | grep -o -P '(?<=: ).*(?=x)' > /tmp/mouse-warp/window-geometry-x
		xdotool getwindowgeometry `xdotool getactivewindow` | grep -o -P '(?<=x).*' > /tmp/mouse-warp/window-geometry-y
		MIDDLE_X=$(expr `cat /tmp/mouse-warp/window-geometry-x` / 2)
		MIDDLE_Y=$(expr `cat /tmp/mouse-warp/window-geometry-y` / 2)
		echo $MIDDLE_X
		echo $MIDDLE_Y
		echo $active_window
		xdotool getactivewindow  mousemove --window %1 $MIDDLE_X $MIDDLE_Y
	else
		echo active window is the active window
	fi
	sleep .2
done
