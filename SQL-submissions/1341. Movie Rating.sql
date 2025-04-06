-- BEATS 91.11%


WITH most_active_user AS (
    SELECT u.name
    FROM Users u 
    LEFT JOIN (SELECT
            user_id, 
            COUNT(DISTINCT movie_id) AS number_of_rated_movies
        FROM MovieRating
        GROUP BY user_id) AS t
    ON u.user_id = t.user_id
    ORDER BY t.number_of_rated_movies DESC, u.name
    LIMIT 1
),
top_movie AS (
    SELECT m.title
    FROM Movies m
    LEFT JOIN (SELECT 
            movie_id, AVG(rating) AS average_rating
        FROM MovieRating
        WHERE YEAR(created_at) = 2020 AND MONTH(created_at) = 2
        GROUP BY movie_id) AS t
    ON m.movie_id = t.movie_id
    ORDER BY t.average_rating DESC, m.title
    LIMIT 1
)

SELECT name AS results FROM most_active_user 
UNION ALL 
SELECT title FROM top_movie

