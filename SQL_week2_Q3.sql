DROP VIEW IF EXISTS size_distance;
CREATE VIEW size_distance AS
(SELECT p.tailnum as tailnum, p.seats as plane_size,
       count(*) as num_flights,
       avg(case when f.distance>0 then f.distance end) as travel_distance
FROM flights f join planes p on f.tailnum=p.tailnum
WHERE f.origin in ('LGA','JFK','EWR') and p.seats is not null
GROUP BY p.tailnum, p.seats
ORDER BY p.seats desc
)

COPY(
SELECT plane_size, count(*) as num_planes,
        avg(travel_distance) as travel_distance
FROM size_distance
GROUP BY plane_size
ORDER BY plane_size desc
)to '/tmp/size_distance.csv' with CSV HEADER
