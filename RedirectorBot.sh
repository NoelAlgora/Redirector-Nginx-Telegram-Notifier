#!/bin/bash

# Author: MC.Naveen
# Shell Script for Monitoring GoogleBot Crawls via Nginx log file and Sending notification to Telegram
# Github: https://github.com/mcnaveen/GoogleBot-Nginx-Telegram-Notifier
# Note: Your server should be Nginx. Otherwise it won't work.

apiKey= PASTE YOUR TELEGRAM API KEY HERE
chatID= PASTE YOUR TELEGRAM CHAT ID HERE

headerIdentifier="cd9452d3-9540-492d-b57b-7be28c4d2d29"

message="Redirector HIT" # You can set your custom message here

logFile=/var/log/nginx/access.log # This is default nginx log path. You can replace the path according to your setup

tail -fn0 $logFile | \
while read line ; do
        echo "$line" | grep "Googlebot"
        if [ $? = 0 ]
        then
          incoming_ip=`echo "$line" | awk '{printf $1}'`
          redirector_host=`echo "$line" | awk '{printf $3}'`
          curl --silent --output /dev/null \
          -X POST \
           "https://api.telegram.org/bot$apiKey/sendMessage" \
          -d text="Redirector $redirector_host hit from ip $incoming_ip" \
          -d chat_id=$chatID
        fi
done
