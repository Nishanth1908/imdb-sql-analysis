-- =============================================
-- Who directed the highest-rated movies?
-- =============================================

SELECT 
	n.primaryName AS Director,
    m.primaryTitle AS Title,
    m.averageRating AS rating
FROM movies m
JOIN title_crew c
	ON m.tconst = c.tconst
JOIN name_basics n
	ON c.directors = n.nconst
WHERE m.averageRating =
	( SELECT MAX(averageRating)
		FROM movies)
;
        
-- =============================================
-- Which movies do not have a listed director?
-- =============================================

SELECT m.primaryTitle, m.startYear
FROM movies m
LEFT JOIN title_crew c
	ON m.tconst = c.tconst
WHERE c.directors IS NULL
;

-- =============================================
-- Which directors have directed the most movies?
-- =============================================

SELECT 
	n.primaryName AS Director,
    COUNT(c.tconst) AS total_movies
FROM title_crew c
JOIN name_basics n
	ON c.directors = n.nconst
GROUP BY n.nconst, n.primaryName
ORDER BY COUNT(c.tconst) DESC, n.primaryName ASC
LIMIT 10
;

-- =============================================
-- Which directors have an average IMDb rating above 8? (Minimum 5 movies)
-- =============================================

SELECT n.primaryName AS Director,
	   AVG(m.averageRating) AS Average_rating,
       COUNT(c.tconst) AS Movie_count
FROM movies m
JOIN title_crew c
	ON m.tconst = c.tconst
JOIN name_basics n
	ON c.directors = n.nconst
GROUP BY n.nconst, n.primaryName
HAVING AVG(m.averageRating) > 8
	AND COUNT(c.tconst) >= 5
ORDER BY Average_rating DESC, Movie_count DESC
;

-- =============================================
-- TOP 10 directors with the longest careers
-- =============================================

SELECT n.primaryName AS Director,
	   MAX(m.startYear) - MIN(m.startYear) AS Career_Span
FROM movies m
JOIN title_crew c
	ON m.tconst = c.tconst
JOIN name_basics n
	ON c.directors = n.nconst
WHERE startYear IS NOT NULL
GROUP BY n.nconst, n.primaryName
ORDER BY Career_Span DESC, n.primaryName ASC
LIMIT 10
;
