-- ============================================================
-- Fix Schema and Normalize Roles
-- Run: mysql -u root -p filmeselir < fix_schema_and_roles.sql
-- ============================================================

USE filmeselir;

-- 1. Ensure Film_Imagine column exists
-- This column is required by the updated Java code for movie posters.
ALTER TABLE film 
  ADD COLUMN IF NOT EXISTS Film_Imagine VARCHAR(255) DEFAULT 'default.jpg' AFTER Film_AnAparitie;

-- 2. Optional: Normalize roles
-- If you have users with 'AdminMovie', they will now be recognized by the code.
-- This part is just a reminder of the names supported: 'SuperAdmin', 'MovieAdmin', 'AdminMovie'.

-- To check current roles, you can run:
-- SELECT User_Username, User_Role FROM user;

-- To manually set a user to AdminMovie:
-- UPDATE user SET User_Role = 'AdminMovie' WHERE User_Username = 'your_username';

-- 3. Verify the 'film' table structure
-- DESCRIBE film;
