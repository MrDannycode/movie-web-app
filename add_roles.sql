-- ============================================================
-- Add Role-Based Access to User Table
-- Run: mysql -u root -p filmeselir < add_roles.sql
-- ============================================================

USE filmeselir;

-- Add the User_Role column
ALTER TABLE user
  ADD COLUMN IF NOT EXISTS User_Role VARCHAR(20) NOT NULL DEFAULT 'USER';

-- Optional: Automatically upgrade the 'testuser' to SuperAdmin
UPDATE user SET User_Role = 'SuperAdmin' WHERE User_Username = 'testuser' OR User_Email = 'test@example.com';
