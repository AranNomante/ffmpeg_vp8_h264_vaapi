#/path/to/script -r 
if [ "x$AFTER_REBOOT" = "xyes" ]; then
    # After reboot
	sudo apt install va-driver-all
	sudo apt install vainfo
	sudo vainfo
	sudo apt install ffmpeg
	sudo apt install chromium
else
    # Before reboot
	sudo add-apt-repository ppa:oibaf/graphics-drivers
	sudo apt update
	sudo apt dist-upgrade
	sudo reboot
fi