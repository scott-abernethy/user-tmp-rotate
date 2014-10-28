#!/bin/bash

# This script should not be run directly,
# instead you need to source it from your .bashrc or .zshrc
# by adding this line:
# $ . ~/bin/user-tmp-rotate.sh
# and then execute via:
# $ user-tmp-rotate

function user-tmp-rotate() {
	local YEAR=$(date "+%Y")
	local MONTH=$(date "+%m")
	local TMP=tmp
	local DIR=$TMP/$YEAR/$MONTH

	if [ ! -d $HOME/$DIR ]; then
		local CURRENT=$TMP/current
		local CURRENT_SHORT=$TMP/0

		echo Creating user temporary directory '~/'$DIR '('shortcuts '~/'$CURRENT and '~/'$CURRENT_SHORT')'

		mkdir -p $HOME/$DIR

		# create shortcut links
		if [ -h $HOME/$CURRENT ]; then
			rm $HOME/$CURRENT
		fi
		ln -s $HOME/$DIR $HOME/$CURRENT
		if [ -h $HOME/$CURRENT_SHORT ]; then
			rm $HOME/$CURRENT_SHORT
		fi
		ln -s $HOME/$DIR $HOME/$CURRENT_SHORT

		# find previous month dir
		COUNTER=1
		while [ "$COUNTER" -lt "25" ]; do
			local PYEAR=$(date -v -${COUNTER}m "+%Y")
			local PMONTH=$(date -v -${COUNTER}m "+%m")
			if [ -d $HOME/$TMP/$PYEAR/$PMONTH ]; then
				local PREVDIR=$TMP/$PYEAR/$PMONTH
				local PREVIOUS=$TMP/previous
				local PREVIOUS_SHORT=$TMP/1

				echo Previous user temporary directory '~/'$PREVDIR '('shortcuts '~/'$PREVIOUS and '~/'$PREVIOUS_SHORT')'

				# create shortcut links
				if [ -h $HOME/$PREVIOUS ]; then
					rm $HOME/$PREVIOUS
				fi
				ln -s $HOME/$PREVDIR $HOME/$PREVIOUS

				if [ -h $HOME/$PREVIOUS_SHORT ]; then
					rm $HOME/$PREVIOUS_SHORT
				fi
				ln -s $HOME/$PREVDIR $HOME/$PREVIOUS_SHORT

				# break loop
				COUNTER=99
			fi

			# else try next
			COUNTER=$((COUNTER + 1))
		done

	fi

	# change to the dir
	cd $HOME/$DIR
}
