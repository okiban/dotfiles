#!/bin/bash

# Find the tcp module ID
MODULE_ID=$(pactl list short modules | grep module-native-protocol-tcp | awk '{print $1}')

if [ -n "$MODULE_ID" ]; then
    pactl unload-module "$MODULE_ID"
    echo "✅ PipeWire network server stopped"
else
    echo "ℹ️ No network server module found"
fi
