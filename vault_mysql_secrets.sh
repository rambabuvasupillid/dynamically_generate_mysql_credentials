##define following variables
## token for login
token=""
db_name=""
dbuser=""
dbpass=""
db_name=""
db_host=""
db_port=""
vault_active_node=""

## login to vault
vault login $token
## enable database secret
vault secrets enable database

##Configure Vault with the proper plugin and connection information
vault write database/config/devdb \
	plugin_name=mysql-database-plugin \
	connection_url="{{username}}:{{password}}@tcp($db_host:$db_port)/" \
	allowed_roles="devrole" \
	username=$dbuser \
	password=$dbpass
##Configure a role that maps a name in Vault to an SQL statement to execute to create the database credential
vault write database/roles/devrole \
    db_name=$db_name \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL PRIVILEGES ON $db_name.* TO '{{name}}'@'%';" \
    default_ttl="1h" \
    max_ttl="24h"

## Read Credentials
vault read database/creds/devrole

echo "
#############################################################################################################################################
We can use the above credentials and will get new credentials whenever we run following commands
-after login to vault
vault read database/creds/devrole
or
-using curl utility from anywhere
curl --header \"X-vault-token:$token\" "$vault_active_node"/v1/database/creds/devrole|jq
#############################################################################################################################################
"
