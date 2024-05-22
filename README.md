# 🔔 GoogleBot Nginx Telegram Notifier 

Get notification on Telegram if a beacon hits your redirector.

## 💡 How does it work?

Using `tail` and `grep` to monitor the nginx log file. Once it matches the indentification header it'll immediately send notification to your telegram


## 🔧 Script Setup

- Download the [RedirectorBot.sh](https://github.com/NoelAlgora/Redirector-Nginx-Telegram-Notifier/blob/main/RedirectorBot.sh) file on your linux server in `root` or `home` (Home Recommended)

- Open the file and add these values (Required) (Get Chat ID from here - <https://t.me/chatidx_bot>)

```sh
apiKey= Your Telegram Bot API Key
chatID= Your Chat ID
message="GoogleBot HIT" #You can customize this message
logFile=/var/log/nginx/access.log #Path to your Nginx access log file. (This one is default) 
```

- Now, Make it executable `chmod +x GoogleBot.sh`
- Next Setup `systemd` for Running this script continuously

```bash


# Navigate to this Directory
cd /etc/systemd/system

# Create New Service File
touch rbotnotify.service

# Create a Service file for systemd service
nano rbotnotify.service

```

- Now paste everything from <https://github.com/NoelAlgora/Redirector-Nginx-Telegram-Notifier/blob/main/rbotnotify.service> and save it.

- Reload the systemd and enable the rbotnotify service

```bash
systemctl daemon-reload
systemctl enable rbotnotify
systemctl start rbotnotify
```

- You can Check the service status with

```bash
systemctl status rbotnotify
```

## ☑ LICENSE 

MIT

----

### Shoutout

Similar useful bash scripts: 
- Get Isso Comments Notification on your Telegram by @mskian - <https://github.com/mskian/isso-telegram-notifier/>
