-- V2.003__EnhancePreferences.sql
-- Add account_id to account_preferences
ALTER TABLE account_preferences
    ADD COLUMN account_id uuid;

-- Populate account_id using existing account -> preferences_id mapping
UPDATE account_preferences ap
SET account_id = a.id
FROM account a
WHERE a.preferences_id = ap.id;

-- Add NOT NULL and UNIQUE constraints if this is a 1-to-1 relationship
ALTER TABLE account_preferences
    ALTER COLUMN account_id SET NOT NULL;

ALTER TABLE account_preferences
    ADD CONSTRAINT account_preferences_account_id_unique UNIQUE(account_id);

-- Add foreign key constraint
ALTER TABLE account_preferences
    ADD CONSTRAINT account_preferences_account_id_fkey
        FOREIGN KEY (account_id) REFERENCES account(id);

-- Remove preferences_id from account table
ALTER TABLE account DROP CONSTRAINT IF EXISTS account_preferences_id_fkey;
ALTER TABLE account DROP COLUMN preferences_id;