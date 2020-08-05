 <h1><b>IMPORTANT</b></h1>
 
 <h2>vp8auto.sh is maintained rest are not for the time being</h2>
 
 <h3>This repository is about transcoding performance and chromium video decoder performance improvements</h3>
 
 <b>All scripts are configured properly. Hardware accelerated script has not been tested</b> 
 
 <b>Make sure vainfo does not output any errors and env_setup is set properly to enable hardware acceleration <i>skip if you do not have an external gpu</i></b>
 
 <h1>Must have</h1>
 
 <span><i>commands: ffmpeg and ffprobe</i></span>
 
 va_api driver *<i>(if you do not have an external gpu, exclude this when using env_setup)</i>
 
 <h1>Useful Stuff Below</h1>

$ less /var/log/Xorg.0.log

$ journalctl -b

$ dmesg | less

$ less ~/.xsession-errors

sudo cpupower frequency-set --governor=performance

sudo x86_energy_perf_policy -t 1 performance

 If you cannot enable hardware acceleration try using the following commands:
 
 chromium --minimal
 
 chromium --disable-gpu-driver-bug-workarounds
 
 chromium --disable-gpu

https://trac.ffmpeg.org/wiki/Encode/VP8

https://trac.ffmpeg.org/wiki/Encode/VP9

https://peter.sh/experiments/chromium-command-line-switches/

https://www.linuxuprising.com/2018/08/how-to-enable-hardware-accelerated.html

http://lifestyletransfer.com/how-to-install-gstreamer-vaapi-plugins-on-ubuntu/

https://developer.nvidia.com/nvidia-video-codec-sdk

https://www.binarytides.com/linux-get-gpu-information/

https://www.techpowerup.com/gpu-specs/


