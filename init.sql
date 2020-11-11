--When creating tables we can specify a column as having a foreign key.

--FOREIGN KEYS NEW TABLE
-- create a table called movie wuth movie_id, title, media_type_id. 
-- make media_type_id a foreign key to the media_type_id column on the media_type tabe

CREATE TABLE movie (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(250),
    media_type_id INT REFERENCES media_type(media_type_id)
);

--add a new entry into the movie table with a title and media_type_id

INSERT INTO movie (
    title,
    media_type_id
)VALUES(
    'Shrek',
    3
)

--query the movie table to get your entry
SLECT * FROM movie

--FOREIGN KEYS EXISTING TABLE
--we can also add a foreign key to an existing table.
--add a new column to the movie table called genre_id that references genre_id on the genre table
ALTER TABLE movie
ADD COLUMN genre_id INT REFERENCES genre(genre_id)

--UPDATING ROWS
--we dont want to leave the genre_id equal to null so let's dd a value using the update command
--always use WHERE in an UPDATE command otherwise it will override data
--update the first entry in the movie table to a genre_id of 22
--first check the genre
SELECT * FROM genre

UPDATE TABLE movie
SET genre_id = 22
WHERE movie_id = 1;

--USING JOINS
--to use a foreign key through a join statement
--join the artist and album tables to list out the artist name and album name
--using aliases for album and artist 
--album has an album_id, title and artist_id
--artist has an artist_id and name
--JOINing will connect those two so you know who the artist is in the album table
--RELATIONSHIP between artist and album is a ONE to MANY
--each album only has one artist, but each artist can have multiple albums
SELECT al.title, ar.name FROM
album al
JOIN 
artist ar ON ar.artist.id = al.artist.id
--before we did this JOIN statement, if we did SELECT ALL we wouldnt have a list of any of the artists
--JOIN gives the artist_name from the artist table instead of the artist_id

--USING NESTED QUERIES/SUB-SELECTS
--this is effective when you have a foreign key link between two tables because not we can filter
--our main query by criteria on a referenced table
--use a sub select statement to get all tracks from the TRack table where the genre_id is either Jazz or Blues
--filter out all the genre_id's that aren't Jazz or Blues
SELECT * FROM track
WHERE genre_id IN (
    SELECT genre_id FROM genre
    WHERE name = 'Jazz' OR name = 'Blues'
)
--subquery to get the correct id's to filter from the track table 

--SETTING VALUES TO NULL
--update phone on the employee table to null where the Employee_id is 1

UPDATE employee
SET phone = null
WHERE employee_id = 1

--query the employee table to get the employee you just updated
SELECT * FROM employee

--QUERYING A NULL VALUE
--company table will be blank/ no entry/no value
SELECT * FROM customer
WHERE company IS NULL

--GROUP BY
--how many albums does each artist have? 
--group by allows us to do aggregate counts
--select all artist ids, artist names, and count how many albums they have
SELECT ar.artist_id, ar.name, COUNT(*)
FROM artist.ar
JOIN album al
ON al.artist_id = ar.artist_id
GROUP BY ar.artist_id
ORDER BY ar.artist_id;
--group by groups the number of albums for each artist
--order by will put it in asc artist_id order

--below will order the album count in DESC order 
--GROUP BY ar artist_id
--ORDER BY album_count DESC

--DISTINCT
--distinct is great if you want to get a dataset with no duplicates 
--get all countries from the customer table with no duplciates
SELECT DISTINCT country FROM customer

--DELETE ROWS
--select all records from the customer table where fax is null
SELECT * FROM customer WHERE fax IS NULL;
--delete all records from the customer table where fax is null
DELETE FROM customer WHERE fax IS NULL;