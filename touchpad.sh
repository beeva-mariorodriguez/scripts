#!/bin/bash
id=$(xinput list --id-only "SynPS/2 Synaptics TouchPad")
case "$1" in
    disable)
        xinput --disable "$id"
        ;;
    enable)
        xinput --enable "$id"
        ;;
    *)
        echo "$0 enable|disable"
        ;;
esac

