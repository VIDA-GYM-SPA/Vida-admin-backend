#!/bin/bash

# Check if the Redis server is running
if pgrep redis-server > /dev/null; then
  echo "check_redis: Redis daemon is active"
  echo "+------------------------------------------+"
  echo "|                                          |"
  echo "|         Redis server is running.         |"
  echo "|                                          |"
  echo "+------------------------------------------+"
  exit 0
else
  echo "check_redis: Redis daemon is dead"
  echo "+---------------------------------------------------+"
  echo "|                                                   |"
  echo "|           Redis server is not running.            |"
  echo "|             Starting Redis server...              |"
  echo "|                                                   |"
  echo "+---------------------------------------------------+"
  redis-server
  exit 0
fi
