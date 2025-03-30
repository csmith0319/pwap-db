-- V2.004__HandleMultiplePreferences.sql
-- Remove old preferences
DROP TABLE account_preferences CASCADE;

-- Create new preferences type
CREATE TABLE preference_types (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    code text UNIQUE NOT NULL,    
    label text,                   
    description text
);

CREATE TABLE preference_subtypes (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    type_id uuid NOT NULL REFERENCES preference_types(id) ON DELETE CASCADE,
    code text NOT NULL,
    label text,
    UNIQUE(type_id, code)
);

CREATE TABLE preferences (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id uuid NOT NULL REFERENCES account(id),
    type_id uuid NOT NULL REFERENCES preference_types(id),
    subtype_id uuid REFERENCES preference_subtypes(id),
    settings jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT clock_timestamp(),
    updated_at timestamp with time zone DEFAULT clock_timestamp(),
    UNIQUE(account_id, type_id, subtype_id)
);

-- Populate with some probable data
INSERT INTO preference_types (code, label, description)
VALUES
    ('account', 'Account Preferences', 'Preferences related to user account and UI'),
    ('budget', 'Budget Preferences', 'Preferences for budget configurations');

INSERT INTO preference_subtypes (type_id, code, label)
SELECT id, 'notifications', 'Notification Settings'
FROM preference_types WHERE code = 'account';