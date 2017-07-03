#!/bin/bash

# This script is used to run the MongoDB instance on the
# Docker container with the given settings

# script based off of legacy tutum-docker-mongodb

set -m

mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE"
cmd="$mongodb_cmd --httpinterface --rest --master"
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
fi

$cmd &

# If the container already contains a password set file, then no need to
# initialize the Users/passwords again
if [ ! -f /data/db/.mongodb_password_set ]; then
    /set_mongodb_password.sh
fi

fg
