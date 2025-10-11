#!/bin/bash

COOKIE_PATH="$HOME/.config/pulse/cookie"
PORT=4713

# Check if the cookie exists
if [ ! -f "$COOKIE_PATH" ]; then
    echo "❌ Cookie not found: $COOKIE_PATH"
    exit 1
fi

echo "🔄 Activating PipeWire network server on port $PORT..."
pactl load-module module-native-protocol-tcp auth-cookie="$COOKIE_PATH" port=$PORT

echo "✅ Network server activated"
