#!/bin/bash

# Author: MC.Naveen
# Shell Script for Monitoring GoogleBot Crawls via Nginx log file and Sending notification to Telegram
# Github: https://github.com/mcnaveen/GoogleBot-Nginx-Telegram-Notifier
# Note: Your server should be Nginx. Otherwise it won't work.

apiKey="PASTE_YOUR_TELEGRAM_API_KEY_HERE"
chatID="PASTE_YOUR_TELEGRAM_CHAT_ID_HERE"
headerIdentifier="UNIQUE_IDENTIFIER"
logFile="/var/log/nginx/access.log" # This is default nginx log path. You can replace the path according to your setup
notified_ips="127.0.0.1"

tail -fn0 $logFile | \
while read line ; do
        echo "$line" | grep "$headerIdentifier" | grep -vE "$notified_ips"
        if [ $? = 0 ]
        then
          incoming_ip=`echo "$line" | awk '{printf $1}'`
          redirector_host=`echo "$line" | awk '{printf $3}'`
          notified_ips="$notified_ips|$incoming_ip"
          curl --silent --output /dev/null \
          -X POST \
           "https://api.telegram.org/bot$apiKey/sendMessage" \
          -d text="Redirector $redirector_host hit from ip $incoming_ip" \
          -d chat_id=$chatID
        fi
done
