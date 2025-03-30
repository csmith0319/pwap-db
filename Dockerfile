FROM flyway/flyway

ARG RAILWAY_ENVIRONMENT
ARG RAILWAY_SERVICE_NAME

COPY migrations /flyway/migrations

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]