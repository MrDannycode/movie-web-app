-- ============================================================
--  Fix existing 'user' table if User_Username column is missing
--  Run this in MySQL Workbench or CLI:
--      mysql -u root -p filmeselir < fix_user_table.sql
-- ============================================================

USE filmeselir;

-- Add User_Username if the column doesn't already exist
ALTER TABLE user
  ADD COLUMN IF NOT EXISTS User_Username VARCHAR(60) NOT NULL DEFAULT 'user';

-- Optional: remove any leftover test data so you start fresh
-- DELETE FROM user;

-- ============================================================
-- Done! Now re-deploy to Tomcat and try registering again.
-- ============================================================
