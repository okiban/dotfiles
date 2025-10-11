#!/bin/bash

export PULSE_SERVER=tcp:192.168.1.230:4713
export PULSE_COOKIE=$HOME/.config/pulse/cookie

# Wait a few seconds to make sure the server is up
sleep 2

# Set the Razer mic as default
MIC=$(pactl list short sources | grep "alsa_input" | grep "Razer_Razer_Kraken_7.1_V2" | awk '{print $2}')
if [ -n "$MIC" ]; then
    pactl set-default-source "$MIC"
    echo "✅ Default mic set to $MIC"
else
    echo "❌ Razer mic not found. Make sure the host server is running."
fi
