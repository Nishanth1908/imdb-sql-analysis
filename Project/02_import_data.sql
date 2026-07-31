-- ==========================================================
-- IMDb Dataset Import Script
-- Database: imdb
-- ==========================================================

SET GLOBAL local_infile = 1;

-- ==========================================================
-- Import title.basics.tsv
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\title.basics.tsv'
INTO TABLE title_basics
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    tconst,
    titleType,
    primaryTitle,
    originalTitle,
    isAdult,
    startYear,
    endYear,
    runtimeMinutes,
    genres
);

-- ==========================================================
-- Import title.ratings.tsv
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\title.ratings.tsv'
INTO TABLE title_ratings
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    tconst,
    averageRating,
    numVotes
);

-- ==========================================================
-- Import title.crew.tsv
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\title.crew.tsv'
INTO TABLE title_crew
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    tconst,
    directors,
    writers
);

-- ==========================================================
-- Import name.basics.tsv
-- ==========================================================

LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\name.basics.tsv'
INTO TABLE name_basics
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    nconst,
    primaryName,
    birthYear,
    deathYear,
    primaryProfession,
    knownForTitles
);