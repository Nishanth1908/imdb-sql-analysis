-- ==========================================================
-- Create Analysis Table
-- ==========================================================

DROP TABLE IF EXISTS movies;

CREATE TABLE movies AS
SELECT
    b.tconst,
    b.primaryTitle,
    b.startYear,
    b.runtimeMinutes,
    b.genres,
    r.averageRating,
    r.numVotes
FROM title_basics b
JOIN title_ratings r
ON b.tconst = r.tconst;

-- ==========================================================
-- Create Indexes
-- ==========================================================

CREATE INDEX idx_movies_tconst
ON movies(tconst);

CREATE INDEX idx_movies_rating
ON movies(averageRating);

CREATE INDEX idx_movies_year
ON movies(startYear);

CREATE INDEX idx_movies_votes
ON movies(numVotes);

CREATE INDEX idx_movies_runtime
ON movies(runtimeMinutes);