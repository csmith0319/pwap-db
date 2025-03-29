FROM redgate/flyway

ARG RAILWAY_ENVIRONMENT
ARG RAILWAY_SERVICE_NAME
ARG DATABASE_URL

COPY sql /flyway/sql

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]