#!/bin/bash

LOG_FILE="logs/output.log"

log_types=("INFO" "DEBUG" "WARN" "ERROR")
messages=(
  "User login successful user_id=%d"
  "Request processed request_id=%s duration=%dms"
  "Cache hit ratio: %.2f"
  "Database query executed in %dms"
  "Memory usage: %dMB"
  "CPU usage: %d%%"
  "Failed to connect to service: %s"
  "API request to /api/%s completed"
)

while true; do
  timestamp=$(date +"%Y-%m-%dT%H:%M:%S")
  log_type=${log_types[$RANDOM % ${#log_types[@]}]}
  message=${messages[$RANDOM % ${#messages[@]}]}
  
  # Generate random values for placeholders
  user_id=$((RANDOM % 1000))
  request_id=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)
  duration=$((RANDOM % 500))
  ratio=$(awk -v min=0.1 -v max=1.0 'BEGIN{srand(); print min+rand()*(max-min)}')
  memory=$((RANDOM % 1024))
  cpu=$((RANDOM % 100))
  service="service-$(( RANDOM % 5 + 1))"
  api_path="users/$(( RANDOM % 10 + 1))"
  
  # Format message with random values
  formatted_message=$(printf "$message" $user_id $request_id $duration $ratio $duration $memory $cpu $service $api_path)
  
  # Write to log file
  echo "$timestamp $log_type $formatted_message" >> $LOG_FILE
  
  # Print to console for debugging
  echo "Added log: $timestamp $log_type $formatted_message"
  
  # Random sleep between 0.5 and 3 seconds
  sleep $(awk 'BEGIN{srand(); print 0.5+rand()*2.5}')
done 