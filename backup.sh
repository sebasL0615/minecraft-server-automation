#!/bin/bash

SESSION="mc"
MC_DIR="/home/sebastian/minecraft"
BACKUP_DIR="/home/sebastian/backups/minecraft"
DATE=$(date +"%Y-%m-%d_%H-%M")
BACKUP_FILE="$BACKUP_DIR/minecraft_backup_$DATE.tar.gz"

WEBHOOK="your-discordapp"

mkdir -p "$BACKUP_DIR"

curl -H "Content-Type: application/json" \
-d "{\"content\":\"Backup completed successfully!"}" \
"$WEBHOOK"

# If server is running, safely save world first
if screen -list | grep -q "\.${SESSION}[[:space:]]"; then
    screen -S "$SESSION" -X stuff "Server backup starting. You may notice a small lag spike.\n"
    screen -S "$SESSION" -X stuff "save-off\n"
    screen -S "$SESSION" -X stuff "save-all flush\n"
    sleep 10
fi

# Create backup
tar -czf "$BACKUP_FILE" -C /home/sebastian minecraft

# Turn saving back on
if screen -list | grep -q "\.${SESSION}[[:space:]]"; then
    screen -S "$SESSION" -X stuff "save-on\n"
    screen -S "$SESSION" -X stuff "Server backup complete.\n"
fi

# Delete backups older than 14 days
find "$BACKUP_DIR" -type f -name "minecraft_backup_*.tar.gz" -mtime +14 -delete

echo "Backup created: $BACKUP_FILE"
