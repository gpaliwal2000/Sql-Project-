select * from artist;
#-easy

#1. Who is the senior most employee based on job title? write a sql qurey.
SELECT *
from employee 
order by levels  desc 
limit 1;

# Andrew Adams is senior most employee. 

#2. Which countries have the most Invoices?

SELECT * FROM music_store.invoice;
select billing_country, count(total) as total
from invoice 
group by billing_country
order by total desc;

#  Usa , Canada , Brazil are top 3 countries with most invoices.

#3.What are top 3 values of total invoice?

select billing_country, sum(total) as total
from invoice 
group by billing_country
order by total desc
limit 3;

# Usa , Canada , Brazil are top 3 countries with topn 3 invoice values.


#4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals

SELECT * FROM music_store.invoice;
select billing_city , sum(total) as total 
from music_store.invoice 
group by billing_city 
order by total desc;

# Prague has the highest sum of total.

#5. Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money

select * from customer;
select * from invoice;
select customer.customer_id, customer.first_name , customer.last_name, customer.city ,SUM(invoice.total) as total
from customer  
join invoice on invoice.customer_id = customer.customer_id 
group by customer.customer_id, first_name , last_name, city ,total  
order  by total desc limit 1;

# HELENA HolÃ½ is our best customer..

#– Moderate

#1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A

Select distinct customer.email , customer.first_name , customer.last_name
from customer 
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre .genre_id
where genre.name like 'Rock' order by email ;

# List of all rock music listeners alphabetically


#2. Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands

select artist.artist_id, artist.name , count(artist.artist_id) as no_of_songs
from track
join album2 on album2.album_id =  track.album_id 
join artist on artist.artist_id =  album2.artist_id 
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
group by artist.artist_id , artist.name
order by no_of_songs desc
limit 10;

# List of artist who have written the most rock song.

#3. Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first

select name, milliseconds 
from track
where milliseconds >(
select avg(milliseconds) as avg_track_length from track
)
order by milliseconds desc;

# List of all track names that have length longer than average song length . Ordered by the song length with the longest songs listed first.
