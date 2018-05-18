#!/bin/bash

set -x

# set the postgres database host, port, user and password according to the environment
# and pass them as arguments to the odoo process if not present in the config file
: ${HOST:=${DB_PORT_5432_TCP_ADDR:='db'}}
: ${PORT:=${DB_PORT_5432_TCP_PORT:=5432}}
: ${USER:=${DB_ENV_POSTGRES_USER:=${POSTGRES_USER:='odoo'}}}
: ${PASSWORD:=${DB_ENV_POSTGRES_PASSWORD:=${POSTGRES_PASSWORD:='odoo'}}}
 
export DB_HOST=$HOST
export DB_PORT=$PORT
export DB_USER=$USER
export DB_PASSWORD=$PASSWORD

cat /etc/odoo/odoo.conf.template \
    | envsubst '$DB_HOST' \
    | envsubst '$DB_PORT' \
    | envsubst '$DB_USER' \
    | envsubst '$DB_PASSWORD' > /etc/odoo/odoo.conf


DB_NAME=${DB_NAME:-wongnai}

case "$1" in
    -- | migrate)
        exec ./odoo-bin --update=all --database=$DB_NAME --config=/etc/odoo/odoo.conf --stop-after-init --no-xmlrpc
        ;;
    *)
        exec "$@"
esac

exit 1
