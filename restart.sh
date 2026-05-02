#!/bin/bash

SESSION="mc"
WEBHOOK="https://discordapp.com/api/webhooks/1498535266116178092/TSskNNJ_3Z_VqJWkQk_nUBTbYmf7NLT98nw_-LRP4DVVkBDxKKs9hpOxr8wIm_Sb3HDf"

curl -H "Content-Type: application/json" \
-d '{"content":"⚠️ Minecraft server restarting in 5 minutes!"}' \
"$WEBHOOK"

screen -S "$SESSION" -X stuff "say ⚠️ Server restarting in 5 minutes!\n"
sleep 240

curl -H "Content-Type: application/json" \
-d '{"content":"⚠️ Minecraft server restarting in 1 minute!"}' \
"$WEBHOOK"

screen -S "$SESSION" -X stuff "say ⚠️ Server restarting in 1 minute!\n"
sleep 50

screen -S "$SESSION" -X stuff "say ⚠️ Server restarting in 10 seconds!\n"
sleep 10

curl -H "Content-Type: application/json" \
-d '{"content":"🔴 Minecraft server shutting down for maintenance."}' \
"$WEBHOOK"

screen -S "$SESSION" -X stuff "say ⚠️ Restarting now!\n"
sleep 2
screen -S "$SESSION" -X stuff "stop\n"
