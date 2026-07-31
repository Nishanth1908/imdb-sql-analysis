-- ==========================================
-- Understanding Audience Reception
-- ==========================================


-- ==========================================
-- 1. Which characterstics are associated with highly rated movies?
-- ==========================================

-- 1.1 Top rated movies (minimum vote treshold)

SELECT
    primaryTitle,
    startYear,
    genres,
    runtimeMinutes,
    averageRating,
    numVotes
FROM movies
WHERE numVotes >= 50000
ORDER BY averageRating DESC, numVotes DESC
LIMIT 20;

/*
Summary:
- Drama-based movies appear frequently among highly rated titles.
- Runtime and release period require further comparison using aggregated results.
*/

-- 1.2 Average rating by runtime bucket 

SELECT
    CASE
        WHEN runtimeMinutes < 60 THEN 'Under 60 mins'
        WHEN runtimeMinutes BETWEEN 60 AND 89 THEN '60-89 mins'
        WHEN runtimeMinutes BETWEEN 90 AND 119 THEN '90-119 mins'
        WHEN runtimeMinutes BETWEEN 120 AND 149 THEN '120-149 mins'
        WHEN runtimeMinutes BETWEEN 150 AND 179 THEN '150-179 mins'
        ELSE '180+ mins'
    END AS runtime_bucket,
    COUNT(*) AS movie_count,
    ROUND(AVG(averageRating), 2) AS avg_rating,
    ROUND(AVG(numVotes), 0) AS avg_votes
FROM movies
WHERE runtimeMinutes IS NOT NULL
GROUP BY runtime_bucket
ORDER BY MIN(runtimeMinutes);

/*
Summary:
Longer movies generally receive higher IMDb ratings and attract greater audience engagement.
Movies between 120 and 179 minutes combine strong ratings with high vote counts across a substantial number of titles, making this runtime range consistently associated with positive audience reception.
*/

-- 1.3 Average Rating by Release Decade

SELECT
    FLOOR(startYear / 10) * 10 AS decade,
    COUNT(*) AS movie_count,
    ROUND(AVG(averageRating),2) AS avg_rating,
    ROUND(AVG(numVotes),0) AS avg_votes
FROM movies
WHERE startYear IS NOT NULL
GROUP BY decade
ORDER BY decade;

/*
Summary:
Audience reception remains fairly consistent across decades, while movies from the 2000s 
attract the highest average audience engagement.
*/

-- Query 1.4 Genre combination Analysis

SELECT
    genres,
    COUNT(*) AS movie_count,
    ROUND(AVG(averageRating), 2) AS avg_rating,
    ROUND(AVG(numVotes), 0) AS avg_votes
FROM movies
WHERE genres IS NOT NULL
GROUP BY genres
HAVING COUNT(*) >= 100
ORDER BY avg_rating DESC, avg_votes DESC;

/*
Summary:
Documentary and drama based genre combinations generally receive the highest IMDb ratings,
while horror based combinations tend to receive lower ratings. Highly rated combinations are not 
always the most popular, highlighting the difference between ratings and audience engagement.
*/

-- ==========================================
-- 2. Does runtime influence audience ratings or engagement?
-- ==========================================

SELECT
    CASE
        WHEN runtimeMinutes < 60 THEN 'Under 60 mins'
        WHEN runtimeMinutes BETWEEN 60 AND 89 THEN '60-89 mins'
        WHEN runtimeMinutes BETWEEN 90 AND 119 THEN '90-119 mins'
        WHEN runtimeMinutes BETWEEN 120 AND 149 THEN '120-149 mins'
        WHEN runtimeMinutes BETWEEN 150 AND 179 THEN '150-179 mins'
        ELSE '180+ mins'
    END AS runtime_group,
    COUNT(*) AS total_movies,
    SUM(CASE WHEN averageRating >= 8 THEN 1 ELSE 0 END) AS highly_rated_movies,
    ROUND(
        SUM(CASE WHEN averageRating >= 8 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS pct_highly_rated
FROM movies
WHERE runtimeMinutes IS NOT NULL
GROUP BY runtime_group
ORDER BY
    CASE runtime_group
        WHEN 'Under 60 mins' THEN 1
        WHEN '60-89 mins' THEN 2
        WHEN '90-119 mins' THEN 3
        WHEN '120-149 mins' THEN 4
        WHEN '150-179 mins' THEN 5
        ELSE 6
    END;
    
/*
Summary:
Longer movies are more likely to achieve IMDb ratings of 8 or above, although the 180+ minute category represents a relatively small number of titles.
*/

-- ==========================================
-- 3. Which genres consistently perform well
-- ==========================================

-- 3.1 Performance of Individual Genres

SELECT
    genre,
    COUNT(*) AS movie_count,
    ROUND(AVG(averageRating), 2) AS avg_rating,
    ROUND(AVG(numVotes), 0) AS avg_votes
FROM (
    SELECT averageRating, numVotes,
           TRIM(SUBSTRING_INDEX(genres, ',', 1)) AS genre
    FROM movies
    WHERE genres IS NOT NULL

    UNION ALL

    SELECT averageRating, numVotes,
           TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(genres, ',', 2), ',', -1))
    FROM movies
    WHERE genres LIKE '%,%'

    UNION ALL

    SELECT averageRating, numVotes,
           TRIM(SUBSTRING_INDEX(genres, ',', -1))
    FROM movies
    WHERE genres LIKE '%,%,%'
) AS genre_data
WHERE genre <> ''
GROUP BY genre
HAVING COUNT(*) >= 100
ORDER BY avg_rating DESC, avg_votes DESC;

/*
Summary:
Documentary-related genres achieve the highest average IMDb ratings, 
while Sci-Fi attracts the greatest audience engagement. 
Drama combines strong ratings with the largest number of titles, 
whereas Horror records the lowest average audience ratings.
*/

-- ==========================================
-- 4. How have audience preferences changed across different decades?
-- ==========================================

-- 4.1 Most Common genre produced by decade

WITH genre_counts AS (
    SELECT
        FLOOR(startYear / 10) * 10 AS decade,
        genre,
        COUNT(*) AS movie_count,
        RANK() OVER (
            PARTITION BY FLOOR(startYear / 10) * 10
            ORDER BY COUNT(*) DESC
        ) AS genre_rank
    FROM (
        SELECT
            startYear,
            TRIM(SUBSTRING_INDEX(genres, ',', 1)) AS genre
        FROM movies
        WHERE genres IS NOT NULL

        UNION ALL

        SELECT
            startYear,
            TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(genres, ',', 2), ',', -1))
        FROM movies
        WHERE genres LIKE '%,%'

        UNION ALL

        SELECT
            startYear,
            TRIM(SUBSTRING_INDEX(genres, ',', -1))
        FROM movies
        WHERE genres LIKE '%,%,%'
    ) g
    WHERE genre <> ''
    AND startYear IS NOT NULL
    GROUP BY decade, genre
)
SELECT
    decade,
    genre,
    movie_count
FROM genre_counts
WHERE genre_rank = 1
ORDER BY decade;

/*
Summary:
Drama has remained the dominant genre since the 1910s, while Documentary was most common during 
the earliest decades. No major shift in the leading genre is observed over time.
*/

-- 4.2 Highest rated genre in each decade

WITH genre_ratings AS (
    SELECT
        FLOOR(startYear / 10) * 10 AS decade,
        genre,
        COUNT(*) AS movie_count,
        ROUND(AVG(averageRating), 2) AS avg_rating,
        RANK() OVER (
            PARTITION BY FLOOR(startYear / 10) * 10
            ORDER BY AVG(averageRating) DESC
        ) AS genre_rank
    FROM (
        SELECT
            startYear,
            averageRating,
            TRIM(SUBSTRING_INDEX(genres, ',', 1)) AS genre
        FROM movies
        WHERE genres IS NOT NULL
          AND startYear IS NOT NULL
          AND numVotes >= 1000

        UNION ALL

        SELECT
            startYear,
            averageRating,
            TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(genres, ',', 2), ',', -1))
        FROM movies
        WHERE genres LIKE '%,%'
          AND startYear IS NOT NULL
          AND numVotes >= 1000

        UNION ALL

        SELECT
            startYear,
            averageRating,
            TRIM(SUBSTRING_INDEX(genres, ',', -1))
        FROM movies
        WHERE genres LIKE '%,%,%'
          AND startYear IS NOT NULL
          AND numVotes >= 1000
    ) g
    WHERE genre <> ''
    GROUP BY decade, genre
    HAVING COUNT(*) >= 20
)
SELECT
    decade,
    genre,
    movie_count,
    avg_rating
FROM genre_ratings
WHERE genre_rank = 1
ORDER BY decade;

/*
Summary:
The highest-rated genre varies across decades, indicating shifts in audience preferences over time. 
Documentary has consistently achieved the highest average IMDb ratings from the 1960s onward,
while Drama, Horror, Thriller, Family, and War led earlier decades.
*/

-- ==========================================
-- Which directors consistently produce highly rated movies?
-- ==========================================

WITH director_stats AS (
    SELECT
        n.primaryName AS director,
        COUNT(*) AS total_movies,
        ROUND(AVG(m.averageRating), 2) AS avg_rating,
        SUM(m.numVotes) AS total_votes,
        RANK() OVER (
            ORDER BY AVG(m.averageRating) DESC,
                     SUM(m.numVotes) DESC
        ) AS director_rank
    FROM movies m
    JOIN title_crew c
        ON m.tconst = c.tconst
    JOIN name_basics n
        ON c.directors = n.nconst
    WHERE m.numVotes >= 1000
    GROUP BY n.primaryName
    HAVING COUNT(*) >= 5
)

SELECT
    director_rank,
    director,
    total_movies,
    avg_rating,
    total_votes
FROM director_stats
ORDER BY director_rank
LIMIT 20;

/*
Summary:
Several directors consistently maintain high IMDb ratings across multiple films. 
While some directors achieve the highest average ratings, others combine consistently 
strong ratings with significantly greater audience engagement, highlighting the importance 
of considering both quality and popularity.
*/

