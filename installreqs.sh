#/path/to/script -r 
before_reboot(){
    # Do stuff
	sudo add-apt-repository ppa:oibaf/graphics-drivers
	sudo apt update
	sudo apt -y dist-upgrade
}

after_reboot(){
    # Do stuff
	sudo apt -y install va-driver-all
	sudo apt -y install vainfo
	sudo vainfo
	sudo apt -y install ffmpeg
	sudo apt -y install chromium
}

if [ -f /var/run/rebooting-for-updates ]; then
    after_reboot
    rm /var/run/rebooting-for-updates
    sudo update-rc.d installreqs.sh remove
else
    before_reboot
    sudo touch /var/run/rebooting-for-updates
    sudo update-rc.d installreqs.sh defaults
    sudo reboot
fi