#1 Show the total number of flights.
SELECT count(*) AS total_num_flights FROM flights

#2 Show the total number of flights by airline (carrier).
SELECT carrier,count(*) AS total_num_flights_by_airline FROM flights GROUP BY carrier 

#3 Show all of the airlines, ordered by number of flights in descending order.
SELECT carrier,count(*) AS total_num_flights_by_airline FROM flights GROUP BY carrier ORDER BY total_num_flights_by_airline DESC

#4 Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order.
SELECT carrier,count(*) AS total_num_flights_by_airline FROM flights GROUP BY carrier ORDER BY total_num_flights_by_airline DESC LIMIT 5

#5 Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of flights in descending order.
SELECT carrier,count(*) AS num_long_flights FROM flights WHERE distance>=1000 GROUP BY carrier ORDER BY num_long_flights DESC LIMIT 5

#6 Q: find top 5 airlines at LGA airport that are most on time (one average the least away from scheduled time for arrival and departure)
select carrier, round(avg(case when origin='LGA' then abs(dep_delay) when dest='LGA' then abs(arr_delay) end),3) as offschedule_at_LGA from flights where origin='LGA' or dest='LGA' group by carrier order by offschedule_at_LGA asc limit 5

