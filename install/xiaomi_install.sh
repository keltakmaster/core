#!/bin/bash
echo "Début de l'installation"

echo "Installation des dépendances apt"
 apt-get -y install python-pip libffi-dev libssl-dev python-cryptography

if [ $(pip list | grep pyudev | wc -l) -eq 0 ]; then
    echo "Installation du module pyudev pour python"
     pip install pyudev
fi

if [ $(pip list | grep requests | wc -l) -eq 0 ]; then
    echo "Installation du module requests pour python"
     pip install requests
fi

if [ $(pip list | grep pyserial | wc -l) -eq 0 ]; then
    echo "Installation du module pyserial pour python"
     pip install pyserial
fi

if [ $(pip list | grep future | wc -l) -eq 0 ]; then
    echo "Installation du module future pour python"
     pip install future
fi

if [ $(pip list | grep pycrypto | wc -l) -eq 0 ]; then
    echo "Installation du module pycrypto pour python"
     pip install pycrypto
fi
if [ $(pip list | grep construct | wc -l) -eq 0 ]; then
    echo "Installation du module construct pour python"
     pip install construct
fi

DIRECTORY="/var/www"
if [ ! -d "$DIRECTORY" ]; then
  echo "CrÃ©ation du home www-data pour npm"
   mkdir $DIRECTORY
fi
 chown -R www-data $DIRECTORY
actual=`nodejs -v`;
echo "Version actuelle : ${actual}"

if [[ $actual == *"6."* || $actual == *"5."* ]]
then
  echo "Ok, version suffisante";
else
  echo "KO, version obsolÃ¨te Ã  upgrader";
  echo "Suppression du Nodejs existant et installation du paquet recommandÃ©"
   apt-get -y --purge autoremove nodejs npm
  arch=`arch`;
  if [[ $arch == "armv6l" ]]
  then
    echo "Raspberry 1 dÃ©tectÃ©, utilisation du paquet pour armv6"
     rm /etc/apt/sources.list.d/nodesource.list
    wget http://node-arm.herokuapp.com/node_latest_armhf.deb
     dpkg -i node_latest_armhf.deb
     ln -s /usr/local/bin/node /usr/local/bin/nodejs
    rm node_latest_armhf.deb
  fi

  if [[ $arch == "aarch64" ]]
  then
    wget http://dietpi.com/downloads/binaries/c2/nodejs_5-1_arm64.deb
     dpkg -i nodejs_5-1_arm64.deb
     ln -s /usr/local/bin/node /usr/local/bin/nodejs
    rm nodejs_5-1_arm64.deb
  fi

  if [[ $arch != "aarch64" && $arch != "armv6l" ]]
  then
    echo "Utilisation du dÃ©pot officiel"
    curl -sL https://deb.nodesource.com/setup_5.x | bash -
     apt-get install -y nodejs
  fi

  new=`nodejs -v`;
  echo "Version actuelle : ${new}"
fi

 apt-get -y install python-pip python3-pip libffi-dev libssl-dev
 pip install yeecli
 pip install mihome
 pip install future
 pip3 install python-mirobo

npm install dgram
npm install crypto

echo "Fin de l'installation"
