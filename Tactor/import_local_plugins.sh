#!/bin/bash

LOCAL_PLUGINS="$HOME/Library/Application Support/Tactor/PlugIns"

for DD in `find . -name '*.pl' -or -name '*.scpt' -or -name '*.png'` ;do
	NAME=`basename $DD`
	if [ -f "$LOCAL_PLUGINS/$NAME" ];then
		echo "importing $NAME"
		cp "$LOCAL_PLUGINS/$NAME" "$DD"
	fi
done
