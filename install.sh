#/bin/bash
#############################################
# MINI SERVIDOR PARA CONTROLE ###############
# ARQUIVO DE INSTALAÇÃO #####################
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


#install postgres
apt-get install postgresql
apt-get install python-pip
#psycopg2 and others with pip problems
apt-get install python-psycopg2
apt-get install python-ldap
#install locales
apt-get install locales
#install locale pt-br
locale-gen pt_BR
locale-gen pt_BR.UTF-8

pip install -r requiriments.txt

su odoo <<HERE
cd /home/odoo
#odoo
git clone https://github.com/odoo/odoo --branch 8.0

#Localização brasileira
mkdir addons
mkdir pids
mkdir logs
cd addons
git clone https://github.com/OCA/account-payment.git --branch 8.0
git clone https://github.com/OCA/l10n-brazil.git --branch 8.0
git clone https://github.com/gabrielponto/odoo-brazil-eletronic-documents --branch 8.0
git clone https://github.com/OCA/bank-payment.git --branch 8.0
git clone https://github.com/odoo-brazil/odoo-brazil-banking.git --branch 8.0
git clone https://github.com/OCA/server-tools.git --branch 8.0
HERE
echo 'SUCCESS! Create a database user and a config file'

