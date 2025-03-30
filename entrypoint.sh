#!/bin/sh

# First check if Railway provides individual PostgreSQL variables
if [ -n "$PGUSER" ] && [ -n "$PGPASSWORD" ] && [ -n "$PGHOST" ]; then
  export FLYWAY_URL="jdbc:postgresql://$PGHOST:${PGPORT:-5432}/${PGDATABASE:-railway}"
  export FLYWAY_USER="$PGUSER"
  export FLYWAY_PASSWORD="$PGPASSWORD"
  echo "Using Railway PostgreSQL environment variables"
elif [ -n "$DATABASE_USER" ] && [ -n "$DATABASE_PASSWORD" ]; then
  export FLYWAY_URL="jdbc:postgresql://host.docker.internal:5432/postgres"
  export FLYWAY_USER="$DATABASE_USER"
  export FLYWAY_PASSWORD="$DATABASE_PASSWORD"
fi

export FLYWAY_LOCATIONS="filesystem:migrations"

# Add debug output before executing
echo "Connecting with:"
echo "URL: $FLYWAY_URL"
echo "User: $FLYWAY_USER"
echo "Password: [HIDDEN]"

exec flyway -n migrate