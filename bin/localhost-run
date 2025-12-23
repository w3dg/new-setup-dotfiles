#!/usr/bin/env bash

port=$1

if [ -z $1 ]; then
    echo "No local port specified to forward"
    exit
fi

ssh -R 80:localhost:$port nokey@localhost.run
