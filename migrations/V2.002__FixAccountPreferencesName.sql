-- V2.002__FixAccountPreferencesName.sql
-- Rename AccountPreferences table to account_preferences
ALTER TABLE accountpreferences RENAME TO account_preferences;

-- Update the foreign key in account table to reference the new table name
-- First, drop the existing foreign key constraint
ALTER TABLE account DROP CONSTRAINT IF EXISTS account_preferences_id_fkey;

-- Then, add the correct foreign key constraint
ALTER TABLE account
    ADD CONSTRAINT account_preferences_id_fkey
        FOREIGN KEY (preferences_id) REFERENCES account_preferences(id);

