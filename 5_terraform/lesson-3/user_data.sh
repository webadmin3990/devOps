#!/bin/bash
apt -y update
apt -y install apache2
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform using External Script" > /var/www/html/index.html
sudo service apache2 start
update-rc.d apache2 on
