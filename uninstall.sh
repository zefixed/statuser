sudo systemctl stop statuser.timer
sudo systemctl stop statuser.service
sudo systemctl disable statuser.timer
sudo systemctl disable statuser.service
sudo rm /etc/systemd/system/statuser.timer
sudo rm /etc/systemd/system/statuser.service
sudo rm /usr/local/bin/check_containers_status.sh
sudo rm /usr/local/bin/check_http_status.sh
sudo rm /usr/local/bin/notify_telegram.sh
sudo rm /usr/local/bin/send_checks_to_telegram.sh
sudo systemctl daemon-reload
