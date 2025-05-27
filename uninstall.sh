sudo systemctl stop statuser.{timer,service}
sudo systemctl disable statuser.{timer,service}
sudo rm /etc/systemd/system/statuser.{timer,service}
sudo rm /usr/local/bin/{check_containers_status.sh,check_http_status.sh,notify_telegram.sh,send_checks_to_telegram.sh}
sudo systemctl daemon-reload
