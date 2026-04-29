#!/bin/bash

SESSION="mc"
MC_DIR="/home/sebastian/minecraft"
JAR="fabric-server-mc.1.21.1-loader.0.19.2-launcher.1.1.1.jar"
WEBHOOK="your-discordapp"

# If Minecraft Java process is already running, don't start another one
if pgrep -f "$JAR" > /dev/null; then
    echo "Minecraft server is already running."
    exit 0
fi

# If old/stuck screen session exists, remove it
if screen -list | grep -q "\.${SESSION}[[:space:]]"; then
    echo "Old screen session found. Cleaning it up..."
    screen -S "$SESSION" -X quit
    sleep 2
fi

cd "$MC_DIR" || exit 1

screen -dmS "$SESSION" java -Xms3G -Xmx3G -jar "$JAR" nogui

curl -H "Content-Type: application/json" \
-d '{"content":"Minecraft server is starting up!"}' \
"$WEBHOOK"

echo "Minecraft server is starting in screen session: $SESSION"
