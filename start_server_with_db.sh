#!/bin/bash

# Kill any existing server process
if [ -f api.pid ]; then
    kill -9 `cat api.pid` > /dev/null 2>&1
    rm api.pid
fi

# Wait for the process to terminate
sleep 2

# Start the server and log output to api.log
HBNB_MYSQL_USER=hbnb_dev HBNB_MYSQL_PWD=hbnb_dev_pwd HBNB_MYSQL_HOST=localhost HBNB_MYSQL_DB=hbnb_dev_db HBNB_TYPE_STORAGE=db HBNB_API_HOST=0.0.0.0 HBNB_API_PORT=5050 python3 -m api.v1.app > api.log 2>&1 &
echo $! > api.pid

# Wait for the server to start
sleep 5

# Check if the server is running by attempting to connect to it
curl -s http://0.0.0.0:5050/api/v1/status > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Server started successfully."
else
    echo "Error starting the server. Check api.log for details."
fi

