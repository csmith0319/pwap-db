-- V2.001__CreateAccountTable.sql

-- Create Account Preferences Table
CREATE TABLE AccountPreferences(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid()
);

-- Create Account Table
CREATE TABLE account (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    username varchar NOT NULL,
    password varchar NOT NULL,
    email varchar(255) NOT NULL UNIQUE,
    phone_number varchar,
    preferences_id uuid REFERENCES AccountPreferences(id),
    last_seen timestampz,
    created_at timestampz DEFAULT clock_timestamp(),
    created_by uuid DEFAULT uuid_nil(),
    updated_at timestampz DEFAULT clock_timestamp(),
    updated_by uuid DEFAULT uuid_nil()
);

-- Create system user
INSERT INTO account(username, password, email, phone_number, created_by, updated_by)
VALUES(
       'system',
       'e6e3173ec2c327e8d0a5017a7f5d4b9243441654f809eb6a28bfeaccb64f14bd',
       'system@pwap.com',
       null,
       uuid_nil(),
       uuid_nil()
      )