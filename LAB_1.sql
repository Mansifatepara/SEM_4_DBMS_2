-----------LAB-1-----------

----------PART-A-----------


--1.Retrieve a unique genre of songs.
select distinct Genre
from Songs

--2.Find top 2 albums released before 2010.
select top 2 Album_title
from Albums
where Release_year<2010


--3.Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005) 
insert into Songs
values(1245,'Zaroor',2.55,'Feel Good',1005)

--4.Change the Genre of the song ‘Zaroor’ to ‘Happy’
update Songs
set Genre='Happy'
where song_title='Zaroor';

--5.Delete an Artist ‘Ed Sheeran’ 
delete from Artists
where Artist_name='Ed Sheeran'

--6.Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)]
alter table Songs
add Ratings decimal(3,2)

--7.Retrieve songs whose title starts with 'S'
select song_title
from Songs
where song_title like 'S%'

--8.Retrieve all songs whose title contains 'Everybody'.
select song_title
from Songs
where song_title like '%Everybody%'

--9.Display Artist Name in Uppercase.
select upper(Artist_name)
from Artists


--10.Find the Square Root of the Duration of a Song ‘Good Luck’ 
select sqrt(Duration)
from Songs
where song_title = 'Good Luck'

--11. Find Current Date. 
select getDate()

--12.Find the number of albums for each artist. 
select count(Albums.Album_id)
from Albums

--13.Retrieve the Album_id which has more than 5 songs in it.
select Albums.Album_id
from Albums
join Songs
on Albums.Album_id = Songs.Album_id
GROUP BY Albums.Album_id
HAVING COUNT(Songs.Song_id)>5

--14. Retrieve all songs from the album 'Album1'. (using Subquery) 
select *
from Songs
where Album_id = 
				(select Album_id
				from Albums
				where Album_title = 'Album1')

--15.Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery)
select Album_title
from Albums
where Artist_id = 
					(select Artist_id
					from Artists
					where Artist_name = 'Aparshakti Khurana')

--16.Retrieve all the song titles with its album title.
select Songs.Song_title,Albums.Album_title
from Songs
join Albums
on Songs.Album_id=Albums.Album_id

--17.Find all the songs which are released in 2020. 
select Songs.Song_title
from Songs
join Albums
on Songs.Album_id=Albums.Album_id
where Release_year = 2020

--18.Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.
create view VW_Fav_Songs
As
select Song_title
from Songs
where Song_id=101 or Song_id=105

				--19.Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view.
				update VW_Fav_Songs
				set Song_title='Jannat'
				where Song_id = 101

--20.Find all artists who have released an album in 2020.
select Artists.Artist_name
from Artists
join Albums
on Artists.Artist_id=Albums.Artist_id
where Release_year = 2020

--21.Retrieve all songs by Shreya Ghoshal and order them by duration.
select Song_title
from Songs
where Album_id = 
(select Albums.Album_id
from Artists
join Albums
on Artists.Artist_id=Albums.Artist_id
where Artist_name='Shreya Ghoshal')