#!/bin/bash

if [[ $(whoami) == "root" ]]; then
    echo "root - start elasticsearch"
    chown -R elasticsearch:elasticsearch /data
    chmod -R 775 /data
    su elasticsearch -c /usr/share/elasticsearch/bin/elasticsearch
    echo "run end"
else
    echo "elasticsearch - start elasticsearch"
    elasticsearch
    echo "run end"
fi
