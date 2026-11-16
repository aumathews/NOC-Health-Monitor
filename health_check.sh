#!/bin/bash

# LCCC Cybersecurity NOC - System Health Monitor
# Author: Austin Mathews

LOG_FILE="system_health.log"

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

CPU_LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | awk '{print $1}')

RAM_FREE=$(free -m | awk 'NR==2 {print $7}')

THRESHOLD=80

if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
    STATUS="[WARNING] Disk usage is critically high at ${DISK_USAGE}%!"
else
    STATUS="[OK] Disk usage is stable at ${DISK_USAGE}%."
fi

echo "----------------------------------------" >> "$LOG_FILE"
echo "NOC Health Report - $TIMESTAMP" >> "$LOG_FILE"
echo "CPU Load (1m) : $CPU_LOAD" >> "$LOG_FILE"
echo "Free RAM      : ${RAM_FREE}MB" >> "$LOG_FILE"
echo "Disk Status   : $STATUS" >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

echo "Health check executed. Results securely logged to $LOG_FILE"
