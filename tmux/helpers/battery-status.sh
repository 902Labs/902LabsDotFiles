#!/bin/bash

STATE=$(pmset -g batt);

PCT=$(echo $STATE | grep [0-9]* | awk 'match($0, /[0-9]*\%/) {
    print substr($0, RSTART, RLENGTH)
}')

LEFT=$(echo $STATE | grep [0-9]* | awk 'match($0, /[0-9]*\:[0-9]*/) {
    print substr($0, RSTART, RLENGTH)
}')

NOESTIMATE=$(echo $STATE | grep [0-9]* | awk 'match($0, /no estimate/) {
    print substr($0, RSTART, RLENGTH)
}')

CHARGING=$(echo $STATE | grep [0-9]* | awk 'match($0, /\scharging$/) {
    print substr($0, RSTART, RLENGTH)
}')

POWER=$(echo $STATE | grep [0-9]* | awk 'match($0, /true$/) {
    print substr($0, RSTART, RLENGTH)
}')

if [ "$LEFT" == "0:00" ] || [ -n "$NOESTIMATE" ]; then
	echo "⚡︎ $PCT "
elif [ -z "$CHARGING" ]; then
	echo "⚡︎ $PCT, $LEFT Remaining "
else
	echo "⚡︎ $PCT, $LEFT To Charged "
fi
