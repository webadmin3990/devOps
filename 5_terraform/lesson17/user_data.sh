#!/bin/bash
apt -y update
apt -y install apache2


myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h2>Build by Power of Terraform <font color="red"> v0.12</font></h2><br>
<font color="green">Server PrivateIP: <font color="aqua">$myip<br><br>

<font color="magenta"
<b>Version 1.0</b>
</body>
</html>
EOF

sudo service apache2 start
update-rc.d apache2 on
