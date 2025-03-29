#!/bin/sh

if [ -n "$DATABASE_URL" ]; then
  # Remove the postgres:// prefix
  url_without_protocol=$(echo "$DATABASE_URL" | sed 's/^postgres:\/\///')
  
  # Extract username (before the first :)
  user=$(echo "$url_without_protocol" | cut -d':' -f1)
  
  # Extract password (between first : and first @)
  password=$(echo "$url_without_protocol" | cut -d':' -f2- | cut -d'@' -f1)
  
  # Extract host and remaining parts
  host_port_db=$(echo "$url_without_protocol" | cut -d'@' -f2)
  
  # Extract host, port, and database
  if echo "$host_port_db" | grep -q ":"; then
    # If there's a colon, assume host:port/database format
    host=$(echo "$host_port_db" | cut -d':' -f1)
    port=$(echo "$host_port_db" | cut -d':' -f2 | cut -d'/' -f1)
    db=$(echo "$host_port_db" | cut -d'/' -f2-)
  else
    # If no colon, assume host/database format with default port
    host=$(echo "$host_port_db" | cut -d'/' -f1)
    port="5432"  # Default PostgreSQL port
    db=$(echo "$host_port_db" | cut -d'/' -f2-)
  fi
  
  # If database name is empty, use "railway" as default
  if [ -z "$db" ]; then
    db="railway"
  fi
  
  echo "Connecting to PostgreSQL at $host:$port/$db"
  
  export FLYWAY_URL="jdbc:postgresql://$host:$port/$db"
  export FLYWAY_USER="$user"
  export FLYWAY_PASSWORD="$password"
fi

exec flyway migrate