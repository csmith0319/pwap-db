-- V1__example.sql
-- Example Migration for pwap-db

CREATE TABLE IF NOT EXISTS example_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
