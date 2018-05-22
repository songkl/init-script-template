# This is an example of how to use xtables / xt_geoip to block requests
# based on their source/destination country. 
#
# It can be computationally expensive to have tons of iptables rules. 
# According to the bottom of the following page, this xt_geoip is probably 
# about as efficient as can be for doing this kind of thing:
# http://xtables-addons.sourceforge.net/geoip.php

# Install packages
apt-get install xtables-addons-common libtext-csv-xs-perl unzip

#raspberry >>  raspberrypi-kernel-headers
#rpi-source  https://www.raspberrypi.org/forums/viewtopic.php?t=143531

# Create the directory where the country data should live
mkdir /usr/share/xt_geoip

# Download and install the latest country data
mkdir /tmp/xt_geoip_dl
cd /tmp/xt_geoip_dl
/usr/lib/xtables-addons/xt_geoip_dl
/usr/lib/xtables-addons/xt_geoip_build -D /usr/share/xt_geoip *.csv

# Test it out. Singapore should get blocked, but anywhere else should get 
# through. Test it on your VPS provider by firing up a couple machines in 
# different countries.
iptables -I INPUT 1 -m geoip --src-cc SG -j DROP
