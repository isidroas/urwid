#!/bin/bash -e

# args: scripts to capture

DISPLAYNUM=5
SCREENSHOTS=`dirname $0`/screenshots.sh

# TODO: move this to a function which can be easily commented
XVFB=$(which Xvfb)
if [ -n $XVFB ]; then
	Xvfb :$DISPLAYNUM -screen 0 1024x768x24 &
	XVFBPID=$!

	# uncomment this if you want hide the spawned urxvt windows and only want to
	# see the results in pngs

	# also avoid issues with tiling window managers like i3.
	# The spawned windows will be probally maximized.

	# This will display a lot of errors in xdotool when trying to focus the
	# window, but it works. In particular, the error is:
	#    XGetInputFocus returned the focused window of 1. This is likely a bug in the X server.
	export DISPLAY=:$DISPLAYNUM

	trap "kill $XVFBPID" EXIT
fi
# else exit error?
for script in $@; do
	echo "doing $script"
	if [ -f "${script}.xdotool" ]; then
		"$SCREENSHOTS" "$script" < "${script}.xdotool"
	fi
done
