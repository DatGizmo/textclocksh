#!/bin/bash
#
hr=($(date '+%_H'))
min=10#$(date '+%M')
calcdot=$((min % 5))

HOUR_NAMES_DE=(
    "eins"
    "zwei"
    "drei"
    "vier"
    "fünf"
    "sechs"
    "sieben"
    "acht"
    "neun"
    "zehn"
    "elf"
    "zwölf"
    "ein"
)

HOUR_NAMES_NO=(
    "ett"
    "to"
    "tre"
    "fire"
    "fem"
    "seks"
    "sju"
    "åtte"
    "ni"
    "ti"
    "eleve"
    "tolv"
    "ett"
)

MESSAGE_DE=(
    "%s Uhr"
    "fünf nach %s"
    "zehn nach %s"
    "viertel %s"
    "zehn vor halb %s"
    "fünf vor halb %s"
    "halb %s"
    "fünf nach halb %s"
    "zehn nach halb %s"
    "dreiviertel %s"
    "zehn vor %s"
    "fünf vor %s"
)

MESSAGE_NO=(
    "Klokka er %s"
    "fem over %s"
    "ti over %s"
    "kvart over %s"
    "ti på halv %s"
    "fem på halv %s"
    "halv %s"
    "fem over halv %s"
    "ti over halv %s"
    "kvart på %s"
    "ti på %s"
    "fem på %s"
)

PREF="es ist "

HOUR_NAMES=("${HOUR_NAMES_DE[@]}")
MESSAGE=("${MESSAGE_DE[@]}")

DOTS=0
MODE_CALC=3
ADD_HR_INDEX=2

while [ "$1" != "" ]; do
    case $1 in
        -c)
            DOTS=1
            ;;
        -q)
            MODE_CALC=5
            ;;
        -f)
            MODE_CALC=3
            ;;
		-n)
			HOUR_NAMES=("${HOUR_NAMES_NO[@]}")
			MESSAGE=("${MESSAGE_NO[@]}")
			DE_TIME=0
			ADD_HR_INDEX=3
			;;
    esac
    shift
done

if [[ $DOTS == 1 ]]; then
    case "$calcdot" in
        "1")
        dots=" ."
        ;;
        "2")
        dots=" :"
        ;;
        "3")
        dots=" :."
        ;;
        "4")
        dots=" ::"
        ;;
        *)
        ;;
    esac
fi

index=0

if [[ $min -ge $MODE_CALC ]]; then
    index=$(( (min - $MODE_CALC) / 5 + 1))
    if [[ $index -gt 11 ]]; then
        index=0
        hr=$((hr + 1))
    fi
fi

if [[ $index -gt $ADD_HR_INDEX ]]; then
    hr=$((hr + 1))
fi
timestr=${MESSAGE[index]}

index=0
if [[ $hr -lt 1 ]]; then
    index=11
elif [[ ($hr -eq 1 || $hr -eq 13) && $min -lt 5 ]]; then
    index=12
else
    index=$(((hr - 1) % 12))
fi
hrname=${HOUR_NAMES[index]}

printf "$timestr$dots\n" "$hrname"

