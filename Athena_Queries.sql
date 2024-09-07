1. SELECT * FROM stock_data LIMIT 10;

2. SELECT MAX(Volume) AS max_volume, MIN(Volume) AS min_volume FROM stock_data;

SELECT MAX(ABS((Close - LAG(Close, 1) OVER ()) / LAG(Close, 1) OVER ())) AS max_close_change
FROM stock_data;

SELECT CORR(High - Low, Volume) AS volatility_volume_correlation
FROM stock_data;

SELECT AVG(Close - Low) AS avg_close_low_diff,
       AVG(High - Close) AS avg_high_close_diff
FROM stock_data;

WITH avg_volume AS (
    SELECT AVG(Volume) AS avg_vol FROM stock_data
)
SELECT High - Low AS price_movement,
       Volume,
       Close - LAG(Close, 1) OVER () AS price_change,
       (Close - LAG(Close, 1) OVER ()) / LAG(Close, 1) OVER () * 100 AS price_change_pct
FROM stock_data, avg_volume
WHERE Volume > 1.5 * avg_vol
ORDER BY Volume DESC
LIMIT 10;

WITH volatility_brackets AS (
    SELECT High - Low AS price_range, 
           CASE 
               WHEN High - Low <= 0.5 THEN 'low_volatility'
               WHEN High - Low > 0.5 AND High - Low <= 1 THEN 'medium_volatility'
               ELSE 'high_volatility'
           END AS volatility_bracket,
           Volume, Close
    FROM stock_data
)
SELECT volatility_bracket,
       AVG(Close) AS avg_price,
       AVG(Volume) AS avg_volume
FROM volatility_brackets
GROUP BY volatility_bracket;


