#!/bin/bash

# This script is used to initialize the admin and app users
# for the MongoDB Docker
# script based off of legacy tutum-docker-mongodb

# Database name for MongoDB
APP_DATABASE=${DATABASE:-"admin"}

# Administrator User
ADMIN_USER=${ADMIN_USER:-"admin"}
ADMIN_PASS=${ADMIN_PASS:-$(pwgen -s 12 1)}

# Application User
APP_USER=${APP_USER:-"appuser"}
APP_PASS=${APP_PASS:-$(pwgen -s 12 1)}

_word=$( [ ${ADMIN_PASS} ] && echo "given" || echo "random" )

echo "=> Initialize MongoDB for ${APP_DATABASE}"

# Confirm MongoDB is up and running before we initialize any Users
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

# Create the Admin User
echo "=> Creating an ${ADMIN_USER} user with a ${_word} password in MongoDB"
mongo admin --eval "db.createUser({user: '$ADMIN_USER', pwd: '$ADMIN_PASS', roles:[{role:'root',db:'admin'}]});"

# Create the App User if needed
if [ "$APP_DATABASE" != "admin" ]; then
    _word=$( [ ${APP_PASS} ] && echo "given" || echo "random" )
    echo "=> Creating an ${APP_USER} user with a ${_word} password in MongoDB"
    mongo admin -u $ADMIN_USER -p $ADMIN_PASS << EOF
use $APP_DATABASE
db.createUser({user: '$APP_USER', pwd: '$APP_PASS', roles:[{role:'dbOwner',db:'$APP_DATABASE'}]})
EOF
fi

# All done, initialize the password set file we need to indicate this container
# does not require password/user initialization again
echo "=> Done!"
touch /data/db/.mongodb_password_set

echo "========================================================================"
echo "You can now connect to this MongoDB server using:"
echo ""
echo "    mongo $APP_DATABASE -u $ADMIN_USER -p $ADMIN_PASS --host <host> --port <port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
