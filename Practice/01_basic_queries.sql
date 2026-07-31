=========================================================
-- TOP 10 Highest rated movies with atleast 100,000 votes
=========================================================

SELECT primaryTitle, startYear, averagerating, numvotes
FROM movies
WHERE numvotes >= 100000
ORDER BY averagerating DESC, numvotes DESC
LIMIT 10;

=========================================================
-- Which movies were released after 2020?
=========================================================
SELECT primaryTitle, startYear
FROM movies
WHERE startYear > 2020
ORDER BY startYear ASC, primaryTitle ASC;

=========================================================
-- Which movies belong to the Drama genre?
=========================================================

SELECT primaryTitle, startYear, genres
FROM movies
WHERE LOWER(genres) LIKE '%drama%';

=========================================================
-- Which Action or Adventure movies have an IMDb rating above 8?
=========================================================

SELECT primaryTitle, startYear, genres, averageRating
FROM movies
WHERE averageRating > 8 AND 
	(genres LIKE '%Action%' OR 
    genres LIKE '%Adventure%')
ORDER BY averageRating DESC;

=========================================================
-- Which movies were released between 2000 and 2010?
=========================================================

SELECT primaryTitle, startYear
FROM movies
WHERE startYear BETWEEN 2000 AND 2010
ORDER BY startYear DESC;

=========================================================
-- Which movie titles begin with "The"?
=========================================================

SELECT primaryTitle, startYear
FROM movies
WHERE primaryTitle LIKE 'THE %' AND
	startYear IS NOT NULL
ORDER BY primaryTitle ASC;

=========================================================
-- Display the first 20 movies ordered by release year
=========================================================

SELECT primaryTitle, startYear
FROM movies
WHERE startYear IS NOT NULL
ORDER BY startYear ASC
LIMIT 20;

 