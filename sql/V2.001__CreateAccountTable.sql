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
    last_seen timestamp with time zone,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    created_by uuid DEFAULT '00000000-0000-0000-0000-000000000000',
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_by uuid DEFAULT '00000000-0000-0000-0000-000000000000'
);

-- Create system user
INSERT INTO account(username, password, email, phone_number, created_by, updated_by)
VALUES(
       'system',
       'e6e3173ec2c327e8d0a5017a7f5d4b9243441654f809eb6a28bfeaccb64f14bd',
       'system@pwap.com',
       null,
       '00000000-0000-0000-0000-000000000000',
       '00000000-0000-0000-0000-000000000000'
      )