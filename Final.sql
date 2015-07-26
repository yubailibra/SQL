-- Construct movielens database
DROP TABLE IF EXISTS UserMovieReviews;
DROP TABLE IF EXISTS MovieGenreLinks;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Genres;


CREATE TABLE Users(
id 	integer	PRIMARY KEY,
age 	integer,
gender 	varchar(10) CHECK (gender in ('M', 'F')),
occupation varchar(40),
zip	varchar(5)
);

CREATE TABLE Movies(
id 		integer PRIMARY KEY,
title		varchar(100),
release_date 	date,
url 		varchar(200)
);

CREATE TABLE Genres(
id 	integer PRIMARY KEY,
genre	varchar(20)
);

CREATE TABLE MovieGenreLinks(
movieid integer REFERENCES Movies (id) ON UPDATE CASCADE ON DELETE CASCADE,
genreid integer REFERENCES Genres (id) ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY (movieid, genreid)
);

CREATE TABLE UserMovieReviews(
userid 	integer REFERENCES Users (id) ON UPDATE CASCADE ON DELETE CASCADE,
movieid integer	REFERENCES Movies (id) ON UPDATE CASCADE ON DELETE CASCADE,
rating 	integer CHECK (rating >=1 AND rating<=5),
unixtime integer,
PRIMARY KEY (userid, movieid)
);

--- populate data
COPY Movies (id, title, release_date, url)
FROM '/tmp/u.item.csv'
DELIMITER ',' CSV;

COPY Users (id, age, gender, occupation, zip)
FROM '/tmp/u.user.csv'
DELIMITER ',' CSV;

COPY Genres (genre, id)
FROM '/tmp/u.genre.csv'
DELIMITER ',' CSV;

COPY UserMovieReviews (userid, movieid, rating, unixtime)
FROM '/tmp/u.data.csv'
DELIMITER ',' CSV;

COPY MovieGenreLinks (movieid, genreid)
FROM '/tmp/u.genre.movie.link.csv'
DELIMITER ',' CSV;

-- output data for R analysis; note we use LEFT JOIN to make sure all users information is captured. 
-- Nevertheless, this special database doesn't have users with no movie rating so the results are the same as INNER JOIN.
COPY (
SELECT u.id as userID, 
       u.age as userAge, 
       u.gender as userGender, 
       u.occupation as userJob,
       u.zip as userLocation, 
       m.id as movieID, 
       m.title as movieName, 
       m.release_date as movieDate, 
       r.rating as rating, 
       r.unixtime as rating_time
FROM Users u LEFT JOIN UserMovieReviews r ON u.id=r.userid
	     LEFT JOIN Movies m on r.movieid=m.id
) TO '/tmp/final.csv' with CSV HEADER

