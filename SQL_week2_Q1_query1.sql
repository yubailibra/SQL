SELECT avg(wind_speed) as avg_wind_speed,
       stddev(wind_speed) as std_wind_speed,
       min(wind_speed) as min_wind_speed,
       max(wind_speed) as max_wind_speed
FROM weather
WHERE wind_speed is not null and origin='EWR'


SELECT avg(wind_gust ) as avg_wind_gust,
       stddev(wind_gust) as std_wind_gust,
       min(wind_gust) as min_wind_gust,
       max(wind_gust) as max_wind_gust
FROM weather
WHERE wind_gust is not null and origin='EWR'
