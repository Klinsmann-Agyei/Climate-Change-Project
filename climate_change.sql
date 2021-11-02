SELECT * FROM state_climate;


SELECT state, year, tempc,
AVG(tempc) OVER (
  PARTITION BY state
  ORDER BY year
) AS 'running_avg_temp'
FROM state_climate;


SELECT state, year, tempc,
FIRST_VALUE(tempc) OVER (
  PARTITION BY state
  ORDER BY tempc
) AS 'lowest_temp'
FROM state_climate;


SELECT state, year, tempc,
LAST_VALUE(tempc) OVER (
  PARTITION BY state
  ORDER BY tempc
  RANGE BETWEEN UNBOUNDED PRECEDING AND 
      UNBOUNDED FOLLOWING
) AS 'highest_temp'
FROM state_climate;


SELECT state, year, tempc,
tempc - LAG(tempc,1,0) OVER (
  PARTITION BY state
  ORDER BY year
  ) AS 'change_in_temp'
FROM state_climate
ORDER BY change_in_temp DESC;


SELECT 
RANK() OVER (
  ORDER BY tempc
  ) AS 'coldest_rank',
state, year, tempc
FROM state_climate;


SELECT 
RANK() OVER (
  PARTITION BY state
  ORDER BY tempc DESC
  ) AS 'warmest_rank',
state, year, tempc
FROM state_climate;


SELECT 
NTILE(4) OVER (
    PARTITION BY state
  ORDER BY tempc
  ) AS 'quartile',
state, year, tempc
FROM state_climate;


SELECT 
NTILE(5) OVER (
  ORDER BY tempc
  ) AS 'quintile',
state, year, tempc
FROM state_climate;