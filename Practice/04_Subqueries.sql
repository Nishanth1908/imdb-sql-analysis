-- =================================================
-- Which movies have a rating higher than the average IMDb rating?
-- =================================================

SELECT primaryTitle, startYear, averageRating
FROM movies
WHERE averageRating > (
	SELECT AVG(averageRating)
    FROM movies
) AND startYear IS NOT NULL
ORDER BY averageRating DESC, startYear DESC
;

-- =================================================
-- Which movies have the second longest runtime?
-- =================================================

SELECT primaryTitle, startYear, runtimeMinutes
FROM movies
WHERE runtimeMinutes = 
(
	SELECT MAX(runtimeMinutes)
    FROM movies
    WHERE runtimeMinutes <
		(
		SELECT MAX(runtimeMinutes)
        FROM movies
		) 
    )
    AND runtimeMinutes IS NOT NULL

-- =================================================
-- Which movies have a runtime longer than the average runtime of movies 
-- released in the same year?
-- =================================================

SELECT
    m1.primaryTitle,
    m1.startYear,
    m1.runtimeMinutes
FROM movies m1
WHERE m1.runtimeMinutes >
(
    SELECT AVG(m2.runtimeMinutes)
    FROM movies m2
    WHERE m2.startYear = m1.startYear
);

-- =================================================
-- Which directors have never directed a movie below the overall average IMDb rating?
-- =================================================

SELECT DISTINCT n.primaryName AS Director
FROM name_basics n
JOIN title_crew c
	ON n.nconst = c.directors
WHERE NOT EXISTS
( 
	SELECT *
    FROM movies m
    JOIN title_crew c2
		ON m.tconst = c2.tconst
	WHERE c2.directors = n.nconst
	AND m.averageRating <
	(
	SELECT AVG(averageRating)
    FROM movies
	)
)
;

-- =================================================
-- Which directors have directed at least 3 movies with over 1 million IMDb votes?
-- =================================================

SELECT
    n.primaryName AS Director
FROM name_basics n
WHERE n.nconst IN
(
    SELECT c.directors
    FROM title_crew c
    JOIN movies m
        ON c.tconst = m.tconst
    WHERE m.numVotes > 1e6
    GROUP BY c.directors
    HAVING COUNT(*) >= 3
)
ORDER BY Director;

