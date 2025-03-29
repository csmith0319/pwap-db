#!/bin/sh

# First check if Railway provides individual PostgreSQL variables
if [ -n "$PGUSER" ] && [ -n "$PGPASSWORD" ] && [ -n "$PGHOST" ]; then
  export FLYWAY_URL="jdbc:postgresql://$PGHOST:${PGPORT:-5432}/${PGDATABASE:-railway}"
  export FLYWAY_USER="$PGUSER"
  export FLYWAY_PASSWORD="$PGPASSWORD"
  echo "Using Railway PostgreSQL environment variables"
# Fall back to DATABASE_URL parsing if needed
elif [ -n "$DATABASE_URL" ]; then
  # Your existing parsing code...
  echo "Using parsed DATABASE_URL"
fi

# Add debug output before executing
echo "Connecting with:"
echo "URL: $FLYWAY_URL"
echo "User: $FLYWAY_USER"
echo "Password: [HIDDEN]"

exec flyway migrate