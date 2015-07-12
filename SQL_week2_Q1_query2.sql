copy(
SELECT concat(f.year,'-',f.month,'-',f.day) as timepoint,
       count(*) as num_flights,
       round(cast(sum(case when f.dep_delay >0 then 1 else 0 end ) as numeric) / count(*),2) as delay_rate,
       avg(case when f.dep_delay <0 then 0 when f.dep_delay >0 then f.dep_delay end) as delay_length, 
       avg(case when w.visib is not null then w.visib end) as avg_visibility, 
       avg(case when w.wind_gust is not null and w.wind_gust<1000 then w.wind_gust end) as avg_wind_gust, 
       avg(case when w.wind_speed is not null and w.wind_speed<1000 then w.wind_speed end) as avg_wind_speed,
       avg(case when w.wind_dir is not null then w.wind_dir end) as avg_wind_dir,
       avg(case when w.precip is not null then w.precip end) as avg_precipitation, 
       avg(case when w.temp is not null then w.temp end) as avg_temperature,
       avg(case when w.dewp is not null then w.dewp end) as avg_dew_point,
       avg(case when w.humid is not null then w.humid end) as avg_humidity,
       avg(case when w.pressure is not null then w.pressure end) as avg_pressure
FROM weather w join flights f on f.year=w.year and f.month=w.month and f.day=w.day and f.hour=w.hour
WHERE f.origin in ('EWR') and f.origin=w.origin
GROUP BY timepoint
ORDER BY delay_rate desc
)to '/tmp/weather_delay.csv' with CSV HEADER
