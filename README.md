# Minecraft Server Automation

## Overview 
THis project showcases a fully automated Minecraft server running on Linux.
It includes backup systems, restart scheduling, monitoring, and startup automation.

---

## Features
- Daily automated backups (cron)
- Weekly restart system
- Safe backup process (save-off / save-all)
- Smart startup script with error detection
- Discord webhook notifications
- Automatic cleanup (old backups removed after 14 days)

---

## Tech Stack
- Linux (Ubuntu)
- Bash Scripting
- Screen (process management)
- Cron jobs
- Discord Webhooks

---

## Scripts

### 'backup.sh'
- Creates compressed backups
- Prevents data corruption
- Sends Discord alerts

### 'restart.sh'
- Warns players before restart
- Safely shuts down server

### 'start.sh'
- Startsserver in screen session
- Detects startup success/failure
- Sends Discord notification only on success

---

## What I Learned
- Managing live server environments
- Automating tasks with Bash + cron
- Debugging real-world issues (mods, startup failure) 
- Implementing backup & recovery stratgies

---

### Author
Sebastian Lopez
Linux | Cloud | Web Development
