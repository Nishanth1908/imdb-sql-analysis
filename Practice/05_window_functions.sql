-- ==========================================
-- Rank movies by IMDb rating
-- ==========================================

SELECT 
	Rank () OVER (ORDER BY averageRating DESC, numVotes DESC) AS movie_rank,
	primaryTitle,
    startYear, 
    averageRating
FROM movies;

-- ==========================================
-- Find the Top 5 highest-rated movies in each decade
-- ==========================================

SELECT *
FROM (
	SELECT 
		RANK() OVER( 
			PARTITION BY Decade
			ORDER BY averageRating DESC, numVotes DESC
		) AS movie_rank,
			Decade,
            primaryTitle,
            averageRating
		FROM (
			SELECT FLOOR(startYear / 10) * 10 AS Decade,
			averageRating,
			numVotes,
			primaryTitle,
			startYear
	FROM movies 
    WHERE startYear IS NOT NULL 
) AS t
) AS ranked_movies
WHERE movie_rank <= 5
ORDER BY Decade, movie_rank
;

-- ==========================================
-- Assign a row number to movies within each release year
-- ==========================================

SELECT
	ROW_NUMBER () OVER (
		PARTITION BY startYear 
        ORDER BY startYear DESC) AS rowNumber,
    startYear,
    primaryTitle
FROM movies
WHERE startYear IS NOT NULL;

-- ==========================================
-- Show cumulative IMDb votes by release year
-- ==========================================

SELECT
	startYear,
    SUM(yearly_votes) OVER (
		ORDER BY startYear
        ) AS cumulative_votes
FROM (
	SELECT
		startYear,
		SUM(numVotes) AS yearly_Votes
	FROM movies
	WHERE startYear IS NOT NULL
	GROUP BY startYear 
    ) AS yearly_totals
ORDER BY startYear;

-- ==========================================
-- Rank directors by total IMDb votes
-- ==========================================

SELECT 
	RANK () OVER (
		ORDER BY SUM(numVotes) DESC) AS directorRank,
    n.primaryName,
    SUM(numVotes)
FROM movies m
JOIN title_crew c
	ON m.tconst = c.tconst
JOIN name_basics n
	ON c.directors = n.nconst
GROUP BY n.nconst, n.primaryName
;
