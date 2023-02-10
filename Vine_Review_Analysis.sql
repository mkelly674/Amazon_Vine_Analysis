--check if original table went through
select * from vine_table;
--filter the data and create new table >=20
Select review_id,star_rating,total_votes, helpful_votes, vine,verified_purchase
Into total_vote_table
from vine_table
where total_votes >= 20
order by total_votes;
--check if all data went through
Select * from total_vote_table;
--filter the data and create new table with helpful_votes divided by total_votes >= 50%
Select review_id,star_rating,total_votes, helpful_votes, vine,verified_purchase
Into more_positive_review_table
from total_vote_table
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5
order by total_votes;
--check if all data went through
SELECT * FROM more_positive_review_table;
--filter the data and create new table that has a yes in the paid program
select review_id,star_rating,total_votes, helpful_votes, vine,verified_purchase
INTO paid_program_table
FROM more_positive_review_table
WHERE vine = 'Y'
order by total_votes;
--check if all data went through
select * FROM paid_program_table;
--filter the data and create new table that has a no in the paid program
select review_id,star_rating,total_votes, helpful_votes, vine,verified_purchase
INTO no_paid_program_table
FROM more_positive_review_table
WHERE vine = 'N'
order by total_votes;
--check if all data went through
SELECT * FROM no_paid_program_table;
--making the table to extract the count of star_rating
select review_id,star_rating,total_votes, helpful_votes, vine,verified_purchase
INTO getting_five_star_table
FROM vine_table
WHERE star_rating = 5
order by total_votes;
--check if all the data is there
SELECT * FROM getting_five_star_table;
--Determine the number of 5-star reviews by the vine program
select count(star_rating), vine
INTO five_star_review_table
FROM getting_five_star_table
group by vine
order by vine;
--check if all data went through
SELECT * FROM five_star_review_table;
--getting the total number of reviews
SELECT COUNT(total_votes),vine
INTO total_vote_count_table
FROM vine_table
group by vine;
--check if all data went through
SELECT * FROM total_vote_count_table;
--the table comparing 5 star reviews
SELECT count(total_votes),vine, star_rating
INTO Compare_star_rating_to_non_vine_reviews
From vine_table
where vine = 'N'
group by vine, star_rating;

SELECT count(total_votes),vine, star_rating
INTO Compare_star_rating_vine_reviews
From vine_table
where vine = 'Y'
group by vine, star_rating;
--check if all data went through
select * From Compare_star_rating_to_non_vine_reviews;
select * from Compare_star_rating_vine_reviews;


