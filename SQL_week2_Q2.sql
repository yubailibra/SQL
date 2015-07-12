DROP VIEW IF EXISTS plane_delay;
CREATE VIEW plane_delay AS
(SELECT p.tailnum as tailnum, (2015-p.year) as plane_age ,
       count(*) as num_flights,
       round(cast(sum(case when f.dep_delay >0 then 1 else 0 end ) as numeric) / count(*), 2) as delay_rate,
       avg(case when f.dep_delay <0 then 0 when f.dep_delay >0 then f.dep_delay end) as delay_length
FROM flights f join planes p on f.tailnum=p.tailnum
WHERE f.origin in ('LGA','JFK','EWR') and f.dep_delay is not null and p.year is not null
GROUP BY p.tailnum, (2015-p.year)
ORDER BY plane_age desc
)

COPY(
SELECT plane_age, count(*) as num_planes,
	   avg(delay_rate) as delay_rate, avg(delay_length) as delay_length
FROM plane_delay
GROUP BY plane_age
ORDER BY plane_age desc
)to '/tmp/plane_delay.csv' with CSV HEADER
