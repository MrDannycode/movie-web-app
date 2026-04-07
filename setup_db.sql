-- ============================================================
--  EasyWatch – Database Setup Script
--  Run this in MySQL Workbench or the mysql CLI:
--      mysql -u root -p < setup_db.sql
-- ============================================================

-- 1. Create the database (case-insensitive name used throughout)
CREATE DATABASE IF NOT EXISTS filmeselir
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE filmeselir;

-- ============================================================
-- 2. USER table
-- ============================================================
CREATE TABLE IF NOT EXISTS user (
  User_ID       INT          NOT NULL AUTO_INCREMENT,
  User_Username VARCHAR(60)  NOT NULL,
  User_Email    VARCHAR(120) NOT NULL UNIQUE,
  User_Parola   VARCHAR(255) NOT NULL,   -- store hashed passwords in production!
  PRIMARY KEY (User_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 3. FILM table
-- ============================================================
CREATE TABLE IF NOT EXISTS film (
  Film_ID          INT          NOT NULL AUTO_INCREMENT,
  Film_Denumire    VARCHAR(200) NOT NULL,
  Film_Durata      INT          NOT NULL COMMENT 'duration in minutes',
  Film_AnAparitie  INT          NOT NULL,
  PRIMARY KEY (Film_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 4. ACTOR table
-- ============================================================
CREATE TABLE IF NOT EXISTS actor (
  Actor_ID      INT          NOT NULL AUTO_INCREMENT,
  Actor_Nume    VARCHAR(100) NOT NULL,
  PRIMARY KEY (Actor_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 5. REGIZOR (Director) table
-- ============================================================
CREATE TABLE IF NOT EXISTS regizor (
  Regizor_ID    INT          NOT NULL AUTO_INCREMENT,
  Regizor_Nume  VARCHAR(100) NOT NULL,
  PRIMARY KEY (Regizor_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 6. Sample data – one test user (password: test123)
--    Change the password once the app is running!
-- ============================================================
INSERT IGNORE INTO user (User_Username, User_Email, User_Parola)
VALUES ('testuser', 'test@example.com', 'test123');

-- Sample films
INSERT IGNORE INTO film (Film_Denumire, Film_Durata, Film_AnAparitie) VALUES
  ('The Shawshank Redemption', 142, 1994),
  ('The Godfather',            175, 1972),
  ('The Dark Knight',          152, 2008),
  ('Pulp Fiction',             154, 1994),
  ('Inception',                148, 2010);

-- ============================================================
-- Done!  Connect your app to:
--   jdbc:mysql://localhost:3306/filmeselir
--   user: root   password: (your password)
-- ============================================================
