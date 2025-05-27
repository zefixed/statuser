cp -r etc /
cp -r usr /
chmod +x /usr/local/bin/check_containers_status.sh
chmod +x /usr/local/bin/check_http_status.sh
chmod +x /usr/local/bin/notify_telegram.sh
chmod +x /usr/local/bin/send_checks_to_telegram.sh

read -p "Enter the names of the containers you want to track, separated by spaces (e.g. cont1 cont2 cont3): " containers
prep_containers=$(echo "$containers" | sed 's/[^ ]\+/\"&\"/g')
sed -i "s|\"containers\"|$prep_containers|g" /usr/local/bin/check_containers_status.sh

read -p "Enter the url you want to track, separated by spaces (e.g. https://example1.com https://example2.com): " urls
prep_urls=$(echo "$urls" | sed 's/[^ ]\+/\"&\"/g')
safe_prep_urls=$(printf '%s' "$prep_urls" | sed 's/[&|\\/]/\\&/g')
sed -i "s|\"addresses\"|$safe_prep_urls|g" /usr/local/bin/check_http_status.sh

read -p "Enter the token of the bot that will send you notifications (you need to /start him by all accounts you specified in the last step): " bot_token
prep_bot_token=$(echo "$bot_token" | sed 's/[^ ]\+/\"&\"/g')
sed -i "s|\"bottoken\"|$prep_bot_token|g" /usr/local/bin/notify_telegram.sh

read -p "Enter the chat id (find out here t.me/getmyid_bot) you want to send notifications, separated by spaces (e.g. 1234567890 0987564321): " chat_ids
prep_chat_ids=$(echo "$chat_ids" | sed 's/[^ ]\+/\"&\"/g')
sed -i "s|\"chatids\"|$prep_chat_ids|g" /usr/local/bin/notify_telegram.sh

read -p "Enter the timeout after boot (e.g. 5m): " boot_timeout
sed -i "s|OnBootSec=5m|OnBootSec=$boot_timeout|g" /etc/systemd/system/statuser.timer

read -p "Enter the timeout between checks (e.g. 5m): " between_timeout
sed -i "s|OnUnitActiveSec=5m|OnUnitActiveSec=$between_timeout|g" /etc/systemd/system/statuser.timer

systemctl daemon-reload
systemctl start statuser.service
systemctl start statuser.timer
systemctl enable --now statuser.timer