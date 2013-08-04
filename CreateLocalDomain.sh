#!/bin/bash 



# You need sudo for this stuff...
if [ "$(whoami)" != "root" ]; then
  echo "You should probably run this with sudo."
  exit 1
fi


echo Type in the name of the domain you would like to create \(without a TLD!\)
read domain

echo Type in the local path where this site will live \(ie /Users/Me/Sites/$domain\)
read DocumentRoot

echo Creating $domain.local...

echo Are you using MAMP? [y/n]
read usingMAMP

hosts="/private/etc/hosts"
vhostsConf=""

case $usingMAMP in
  y) 
    echo "Please try again" 
    vhostsConf="/Applications/MAMP/conf/apache/vhosts.conf" ;;
  n) 
    vhostsConf="/etc/apache2/extra/httpd-vhosts.conf" ;;
esac

# echo $hosts
# echo $vhostsConf
# Write to the hosts file

if [ hosts != "" ]; then
  
  echo 127.0.0.1 $domain.local >> $hosts

  echo \<VirtualHost *:80\> >> $vhostsConf
  echo -e "\t"DocumentRoot $DocumentRoot >> $vhostsConf
  echo -e "\t"ServerName $domain.local >> $vhostsConf
  echo \</VirtualHost\> >> $vhostsConf
else
  echo "Please try again"
fi

# Restart Apache
sudo apachectl restart

#/Applications/MAMP/bin/apache2/bin/apachectl restart
#
##edit httpd.conf foro MAMP
# /Applications/MAMP/conf/apache/httpd.conf
#NameVirtualHost *:8888
# Include /Applications/MAMP/conf/apache/vhosts.conf