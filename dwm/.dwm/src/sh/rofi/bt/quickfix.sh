#!/bin/sh

echo -e "Executing:\n> rfkill block bluetooth\n> rfkill unblock bluetooth\n> sudo systemctl restart bluetooth\n"
rfkill block bluetooth
rfkill unblock bluetooth
sudo systemctl restart bluetooth
