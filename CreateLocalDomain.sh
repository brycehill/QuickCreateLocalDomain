#!/bin/bash 
echo Type in the name of the domain you would like to create
read domain
echo Creating $domain.local...

echo Are you using MAMP? [y/n]
read usingMAMP

hosts=""
vhostsConf=""

case $usingMAMP in
  y) 
    echo "Please try again" ;;
  n) 
    hosts="/etc/hosts"
    vhostsConf="/etc/apache2/extra/httpd-vhosts.conf" ;;
esac

# echo $hosts
# echo $vhostsConf
# Write to the hosts file

if [ hosts != "" ]; then
  
  echo 127.0.0.1 $domain.local >> $hosts

  echo \<VirtualHost *:80\> >> $vhostsConf
  echo -e "\t"DocumentRoot "/Users/Bryce/Sites/Metafuse/$domain" >> $vhostsConf
  echo -e "\t"ServerName $domain.local >> $vhostsConf
  echo \</VirtualHost\> >> $vhostsConf

  sudo apachectl restart

else
  echo "Please try again"
fi

# # Restart apache2
# sudo apachectl restart