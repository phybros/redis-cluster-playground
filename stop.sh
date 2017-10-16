#!/bin/bash

pids=$(pgrep 'redis-server')

echo "Stopping PIDs:"
echo $pids
echo $pids | xargs kill
