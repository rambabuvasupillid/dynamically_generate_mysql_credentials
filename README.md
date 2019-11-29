# dynamically_generate_mysql_credentials
This is test code to dynamically generate credentials for a mariadb database server

Prequsites
1. You need vault server setup
2. have another server running mariadb
3. Create an user vault with super user priviledge

What does it do
1. It will enable database secret engine on vault
2. Configure vault with mysql-database-plugin and connection information to database server
3. Configure a role that maps a name in Vault to an SQL statement to execute to create the database credentials
4. Access database credentials

How to use this script
1. Copy this script to server running vault
2. update following variables
> token to login to vault
token=""
> database server name
db_host=""
> username with superuser priviledge
dbuser=""
> password for db username
dbpass=""
> Database name
db_name=""
> Port Number to connect database services
db_port=""
> Active node of your vault cluster - Get it by running #vault status
vault_active_node=""
3. Execute script
./vault_mysql_secrets.sh

