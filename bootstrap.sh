#!/usr/bin/env bash

# Get root up in here
sudo su

# Just a simple way of checking if we need to install everything
if [ ! -d "/var/www" ]
then
	# Intall Node.js
	curl -sL https://deb.nodesource.com/setup | sudo bash -
	sudo apt-get install -y nodejs
	
	# Install yoeman
	sudo npm install -g yo bower grunt-cli gulp
	
	# Install MongoDB
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
	echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
	sudo apt-get update
	sudo apt-get install -y mongodb-org
	
	# Install MySQL
	sudo apt-get install -y debconf-utils
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password password"
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password password"
	sudo apt-get update
	sudo apt-get install -y mysql-server
	
    # Symlink our host www to the guest /var/www folder
    ln -s /vagrant /var/www
fi