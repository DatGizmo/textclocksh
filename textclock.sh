#!/bin/bash
#
hr=($(date '+%_H'))
min=10#$(date '+%M')
calcdot=$((min % 5))

HOUR_NAMES=(
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

MESSAGE=(
    "%s Uhr"
    "fünf nach %s"
    "zehn nach %s"
    "viertel %s"
    "zwanzig nach %s"
    "fünf vor halb %s"
    "halb %s"
    "fünf nach halb %s"
    "zwanzig vor %s"
    "dreiviertel %s"
    "zehn vor %s"
    "fünf vor %s"
)
PREF="es ist "

DOTS=0
MODE_CALC=3

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

if [[ $index -gt 4 || $index -eq 3 ]]; then
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

