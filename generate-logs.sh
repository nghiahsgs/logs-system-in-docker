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
  "API request to /api/users/%d completed"
)

generate_request_id() {
  echo "req-$(( RANDOM % 1000 ))"
}

while true; do
  timestamp=$(date +"%Y-%m-%dT%H:%M:%S")
  log_type=${log_types[$RANDOM % ${#log_types[@]}]}
  message_index=$((RANDOM % ${#messages[@]}))
  message=${messages[$message_index]}
  
  # Generate random values for placeholders
  user_id=$((RANDOM % 1000))
  request_id=$(generate_request_id)
  duration=$((RANDOM % 500))
  ratio=$(awk -v min=0.1 -v max=1.0 'BEGIN{srand(); print min+rand()*(max-min)}')
  memory=$((RANDOM % 1024))
  cpu=$((RANDOM % 100))
  service="service-$(( RANDOM % 5 + 1))"
  api_path=$((RANDOM % 10 + 1))
  
  # Format message based on its type to avoid incorrect substitutions
  case $message_index in
    0) formatted_message=$(printf "$message" $user_id) ;;
    1) formatted_message=$(printf "$message" "$request_id" $duration) ;;
    2) formatted_message=$(printf "$message" $ratio) ;;
    3) formatted_message=$(printf "$message" $duration) ;;
    4) formatted_message=$(printf "$message" $memory) ;;
    5) formatted_message=$(printf "$message" $cpu) ;;
    6) formatted_message=$(printf "$message" "$service") ;;
    7) formatted_message=$(printf "$message" $api_path) ;;
    *) formatted_message=$message ;;
  esac
  
  # Write to log file with a newline
  echo "$timestamp $log_type $formatted_message" >> $LOG_FILE
  
  # Print to console for debugging
  echo "Added log: $timestamp $log_type $formatted_message"
  
  # Random sleep between 0.5 and 3 seconds
  sleep $(awk 'BEGIN{srand(); print 0.5+rand()*2.5}')
done 