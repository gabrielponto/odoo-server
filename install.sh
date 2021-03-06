#/bin/bash
#############################################
# MINI SERVIDOR PARA CONTROLE ###############
# ARQUIVO DE INSTALAÇÃO #####################
# PARA UBUNTU ###############################
#############################################
# Init
FILE="/tmp/out.$$"
GREP="/bin/grep"
#....
# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#try add user if not exists
adduser --disabled-password --gecos "" odoo

apt-get --assume-yes install git
#install postgres
apt-get --assume-yes install postgresql
apt-get --assume-yes install python-dev
# for Pillow
apt-get --assume-yes install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
apt-get --assume-yes install python-pip
#psycopg2 and others with pip problems
apt-get --assume-yes install python-psycopg2
apt-get --assume-yes install python-ldap
#pyxmlsec for pysped
apt-get --assume-yes install openssl
apt-get --assume-yes install python-openssl
apt-get --assume-yes install python-libxml2
apt-get --assume-yes install libxmlsec1-dev
apt-get --assume-yes install libxml-security-c-dev
apt-get --assume-yes install xmlsec1
cd /tmp
wget labs.libre-entreprise.org/frs/download.php/897/pyxmlsec-0.3.1.tar.gz
tar -zxvf pyxmlsec-0.3.1.tar.gz
cd pyxmlsec-0.3.1/
python setup.py install
#specific version pysped
cd /tmp
git clone https://github.com/gabrielponto/PySPED --depth=1
cd PySPED/
python setup.py install
#End pysped
#install locales
apt-get --assume-yes install locales
#install locale pt-br
locale-gen pt_BR
locale-gen pt_BR.UTF-8

pip install -r /tmp/odoo-server/requiriments.txt
pip install git+https://github.com/gabrielponto/pyboleto.git

su odoo <<HERE
cd /home/odoo
#odoo get only latest release with --depth=1
git clone https://github.com/odoo/odoo.git --branch 8.0 --depth=1

#Localização brasileira
mkdir addons
mkdir pids
mkdir logs
mkdir conf
cd addons
git clone https://github.com/OCA/account-payment.git --branch 8.0 --depth=1
git clone https://github.com/OCA/l10n-brazil.git --branch 8.0 --depth=1
git clone https://github.com/gabrielponto/odoo-brazil-eletronic-documents --branch 8.0 --depth=1
git clone https://github.com/OCA/bank-payment.git --branch 8.0 --depth=1
git clone https://github.com/gabrielponto/odoo-brazil-banking.git --branch 8.0 --depth=1
git clone https://github.com/OCA/server-tools.git --branch 8.0 --depth=1
git clone https://github.com/OCA/account-fiscal-rule --branch 8.0 --depth=1
git clone https://github.com/OCA/bank-statement-reconcile.git --branch 8.0 --depth=1

#install odoo-server
cd /home/odoo
git clone https://github.com/gabrielponto/odoo-server.git --depth=1

HERE
echo 'SUCCESS! Create a database user and a config file'

