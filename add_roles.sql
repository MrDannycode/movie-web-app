-- ============================================================
-- Add Role-Based Access to User Table
-- Run: mysql -u root -p filmeselir < add_roles.sql
-- ============================================================

USE filmeselir;

-- Ensure User_Username exists (in case fix_user_table.sql was not run)
ALTER TABLE user
  ADD COLUMN IF NOT EXISTS User_Username VARCHAR(60) NOT NULL DEFAULT 'user';

-- Ensure User_Email exists (in case the table was created without it)
ALTER TABLE user
  ADD COLUMN IF NOT EXISTS User_Email VARCHAR(120) NOT NULL DEFAULT '';

-- Add the User_Role column
ALTER TABLE user
  ADD COLUMN IF NOT EXISTS User_Role VARCHAR(20) NOT NULL DEFAULT 'USER';

-- Optional: Automatically upgrade the 'testuser' to SuperAdmin
UPDATE user SET User_Role = 'SuperAdmin' WHERE User_Username = 'testuser' OR User_Email = 'test@example.com';
