#!/bin/bash

SESSION="mc"
MC_DIR="/home/sebastian/minecraft"
BACKUP_DIR="/home/sebastian/backups/minecraft"
DATE=$(date +"%Y-%m-%d_%H-%M")
BACKUP_FILE="$BACKUP_DIR/minecraft_backup_$DATE.tar.gz"

WEBHOOK="https://discordapp.com/api/webhooks/1498535266116178092/TSskNNJ_3Z_VqJWkQk_nUBTbYmf7NLT98nw_-LRP4DVVkBDxKKs9hpOxr8wIm_Sb3HDf"

mkdir -p "$BACKUP_DIR"

curl -H "Content-Type: application/json" \
-d '{"content":"💾 Backup starting..."}' \
"$WEBHOOK"

if screen -list | grep -q "\.${SESSION}[[:space:]]"; then
    screen -S "$SESSION" -X stuff "say 💾 Server backup starting. You may notice a small lag spike.\n"
    screen -S "$SESSION" -X stuff "save-off\n"
    screen -S "$SESSION" -X stuff "save-all flush\n"
    sleep 10
fi

tar -czf "$BACKUP_FILE" -C /home/sebastian minecraft

if screen -list | grep -q "\.${SESSION}[[:space:]]"; then
    screen -S "$SESSION" -X stuff "save-on\n"
    screen -S "$SESSION" -X stuff "say ✅ Server backup complete.\n"
fi

curl -H "Content-Type: application/json" \
-d '{"content":"✅ Backup completed successfully!"}' \
"$WEBHOOK"

find "$BACKUP_DIR" -type f -name "minecraft_backup_*.tar.gz" -mtime +14 -delete

echo "Backup created: $BACKUP_FILE"
