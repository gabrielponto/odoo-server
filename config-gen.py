#-*- coding: utf-8 -*-
from subprocess import call
print '########## ODOO Config Generator ###############'
base_path = '/home/odoo/'
base = open('{}{}'.format(base_path, 'odoo-server/base_config.conf'))
base_content = base.read()
base.close()
input_name = raw_input(u'Informe o nome base. Eg: Sera usado para chamar o script run e stop: ')
input_database = raw_input(u'Informe o nome do usuario da base de dados: ')
input_password = raw_input(u'Informe a senha para o banco de dados: ')
input_admin_password = raw_input(u'Informe a senha de administracao da gerencia de banco de dados do Odoo: ')
input_port = raw_input(u'Informe a porta em que o Odoo rodara: ')
input_port_s = raw_input(u'Porta Segura. Dica: Acrescente apenas 1 ao numero da porta que escolheu anteriormente: ')

content = base_content.replace('input_name', input_name).replace('input_database', input_database).replace('input_password', input_password)
content = content.replace('input_admin_password', input_admin_password).replace('input_port_s', input_port_s).replace('input_port', input_port)
f = open('{}{}{}.conf'.format(base_path, 'conf/', input_name), 'w+')
f.write(content)
f.close()