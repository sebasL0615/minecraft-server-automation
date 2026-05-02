#!/bin/bash

SESSION="mc"
MC_DIR="/home/sebastian/minecraft"
JAR="fabric-server-mc.1.21.1-loader.0.19.2-launcher.1.1.1.jar"
WEBHOOK="YOUR_DISCORD_WEBHOOK_URL_HERE"

echo "=== Starting Minecraft Server ==="

# Check if already running
if pgrep -f "$JAR" > /dev/null; then
    echo "Minecraft server is already running."
    exit 0
fi

# Clean old screen
if screen -list | grep -q "\.${SESSION}[[:space:]]"; then
    echo "Old screen session found. Cleaning it up..."
    screen -S "$SESSION" -X quit
    sleep 2
fi

cd "$MC_DIR" || {
    echo "ERROR: Cannot enter $MC_DIR"
    exit 1
}

if [ ! -f "$JAR" ]; then
    echo "ERROR: $JAR not found!"
    exit 1
fi

# Start server
echo "Launching server..."
screen -dmS "$SESSION" java -Xms3G -Xmx3G -jar "$JAR" nogui

sleep 5

# Check if started
if screen -list | grep -q "\.${SESSION}[[:space:]]"; then
    echo "Server started successfully."

    curl -H "Content-Type: application/json" \
    -d '{"content":"🟢 Minecraft server is starting up!"}' \
    "$WEBHOOK"

else
    echo "ERROR: Server failed to start."
    echo "Run: tail -f ~/minecraft/logs/latest.log"
fi
