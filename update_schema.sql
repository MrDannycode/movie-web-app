USE filmeselir;

-- Add column for movie images (commented out if already successful)
-- ALTER TABLE film ADD COLUMN Film_Imagine VARCHAR(255) DEFAULT 'default.jpg';

-- Update existing films (already successful)
-- UPDATE film SET Film_Imagine = 'redemption.jpg' WHERE Film_Denumire = 'The Shawshank Redemption';
-- UPDATE film SET Film_Imagine = 'godfather.jpg'  WHERE Film_Denumire = 'The Godfather';
-- UPDATE film SET Film_Imagine = 'knight.jpg'     WHERE Film_Denumire = 'The Dark Knight';
-- UPDATE film SET Film_Imagine = 'inception.jpg'  WHERE Film_Denumire = 'Inception';

-- Insert more films (using IGNORE and NULL to safely retry and trigger AUTO_INCREMENT)
INSERT IGNORE INTO film (Film_ID, Film_Denumire, Film_Durata, Film_AnAparitie, Film_Imagine) VALUES
  (NULL, 'The Avengers',   143, 2012, 'avengers.jpg'),
  (NULL, 'The Departed',   151, 2006, 'departed.jpg'),
  (NULL, 'The Green Mile', 189, 1999, 'green.jpg'),
  (NULL, 'Interstellar',   169, 2014, 'interstellar.jpg'),
  (NULL, 'Jurassic Park',  127, 1993, 'jurassic.jpg'),
  (NULL, 'The Matrix',     136, 1999, 'matrix.jpg'),
  (NULL, 'Titanic',        194, 1997, 'titanic.jpg');
