#/path/to/script -r 
before_reboot(){
    # Do stuff
	sudo add-apt-repository ppa:oibaf/graphics-drivers
	sudo apt update
	sudo apt dist-upgrade
}

after_reboot(){
    # Do stuff
	sudo apt install va-driver-all
	sudo apt install vainfo
	sudo vainfo
	sudo apt install ffmpeg
	sudo apt install chromium
}

if [ -f /var/run/rebooting-for-updates ]; then
    after_reboot
    rm /var/run/rebooting-for-updates
    update-rc.d installreqs.sh remove
else
    before_reboot
    touch /var/run/rebooting-for-updates
    update-rc.d installreqs.sh defaults
    sudo reboot
fi