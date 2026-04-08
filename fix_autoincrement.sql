-- ============================================================
-- Robust Fix for AUTO_INCREMENT (Handles Duplicate Entry '1')
-- ============================================================

USE filmeselir;

-- 1. Check for any Film_ID = 0 (which causes conflicts with AUTO_INCREMENT)
-- We'll update any '0' ID to a unique high number to resolve clashing.
SET @max_id = (SELECT IFNULL(MAX(Film_ID), 0) FROM film);
UPDATE film SET Film_ID = (@max_id := @max_id + 1) WHERE Film_ID = 0;

-- 2. Apply AUTO_INCREMENT
-- Now that '0' values are gone, the sequence should apply cleanly.
ALTER TABLE film MODIFY Film_ID INT NOT NULL AUTO_INCREMENT;

-- 3. Ensure the next AUTO_INCREMENT value is correct
SET @next_id = (SELECT IFNULL(MAX(Film_ID), 0) + 1 FROM film);
SET @sql = CONCAT('ALTER TABLE film AUTO_INCREMENT = ', @next_id);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Verify
DESCRIBE film;
SELECT * FROM film;
