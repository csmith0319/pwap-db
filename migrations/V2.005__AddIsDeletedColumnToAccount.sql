-- V2.005__AddIsDeletedColumnToAccount.sql
-- Add is_deleted column to 'account' table
ALTER TABLE account
ADD COLUMN is_deleted BOOL DEFAULT false