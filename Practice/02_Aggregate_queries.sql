-- ============================================
-- How many movies released each year
-- ============================================

SELECT startYear AS Year, COUNT(*) AS Count
FROM movies
WHERE startYear IS NOT NULL
GROUP BY startYear
ORDER BY startYear ASC;

-- =========================================================
-- What is the average runtime of movies released in each decade?
-- =========================================================

SELECT decade,
	ROUND(avg(runtimeMinutes), 2) AS avg_runtime
FROM (
	SELECT 
		FLOOR(startYear / 10) * 10 AS decade,
		runtimeMinutes
	FROM movies
	WHERE startYear IS NOT NULL
		AND runtimeMinutes IS NOT NULL
) AS decade_data
GROUP BY decade
ORDER BY decade;

-- =========================================================
-- Which release years produced at least 100 highly-rated movies (rating ≥ 8)?
-- =========================================================

SELECT startYear, 
	COUNT(*)
FROM movies
WHERE 
	averageRating >= 8 AND 
	startYear IS NOT NULL
GROUP BY startYear
HAVING Count(*) >= 100
ORDER BY startYear ASC, COUNT(*) DESC;

-- =========================================================
-- The longest and shortest movie in the dataset
-- =========================================================

(
SELECT primaryTitle, startYear, runtimeMinutes
FROM movies
WHERE runtimeMinutes IS NOT NULL
ORDER BY runtimeMinutes ASC, averageRating DESC
LIMIT 1
)
UNION
(
SELECT primaryTitle, startYear, runtimeMinutes
FROM movies
WHERE runtimeMinutes IS NOT NULL
ORDER BY runtimeMinutes DESC, averageRating DESC
LIMIT 1
);

-- ============================================
-- What are the minimum, maximum, and average IMDb ratings in the dataset?
-- ============================================

SELECT 
	MIN(averageRating) AS minRating,
    MAX(averageRating) AS maxRating,
    ROUND(AVG(averageRating), 2) AS AvgRating
FROM movies
WHERE averageRating IS NOT NULL;

-- ============================================
-- Which release years have an average IMDb rating above 7.5?
-- ============================================

SELECT
    startYear,
    ROUND(AVG(averageRating), 2) AS avg_rating,
    COUNT(*) AS total_movies
FROM movies
WHERE startYear IS NOT NULL
GROUP BY startYear
HAVING AVG(averageRating) > 7.5
   AND COUNT(*) >= 10
ORDER BY avg_rating DESC;



