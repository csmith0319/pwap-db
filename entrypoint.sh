#!/bin/sh

if [ -n "$DATABASE_URL" ]; then
  # shellcheck disable=SC2153
  url_without_protocol=$(echo "$DATABASE_URL" | sed 's/^postgres:\/\///')
  
  user=$(echo "$url_without_protocol" | cut -d':' -f1)
  password=$(echo "$url_without_protocol" | cut -d':' -f2 | cut -d'@' -f1)
  host=$(echo "$url_without_protocol" | cut -d'@' -f2 | cut -d':' -f1)
  port=$(echo "$url_without_protocol" | cut -d':' -f3 | cut -d'/' -f1)
  db=$(echo "$url_without_protocol" | cut -d'/' -f2)
  
  export FLYWAY_URL="jdbc:postgresql://$host:$port/$db"
  export FLYWAY_USER="$user"
  export FLYWAY_PASSWORD="$password"
fi

exec flyway migrate