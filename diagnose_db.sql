-- ============================================================
-- SQL Diagnostics for MovieWebApp
-- Run this in your MySQL console/Workbench to verify the table structure
-- ============================================================

USE filmeselir;

SELECT '-- DATABASE STRUCTURE --' AS 'info';

-- 1. Check if the 'film' table exists and see its structure
SHOW TABLES LIKE 'film';
DESCRIBE film;

-- 2. Check current movie count
SELECT COUNT(*) AS 'Movie Count' FROM film;

-- 3. Check for any constraints or indexes
SHOW INDEX FROM film;

-- 4. Check for existing data samples
SELECT * FROM film LIMIT 5;

-- 5. Check user roles to ensure 'AdminMovie' users exist
SELECT User_Username, User_Email, User_Role FROM user WHERE User_Role IN ('SuperAdmin', 'MovieAdmin', 'AdminMovie');
