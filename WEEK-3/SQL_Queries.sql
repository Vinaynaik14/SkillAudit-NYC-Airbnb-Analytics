-- WEEK 3 — SQL Analysis
USE airbnb_analysis;

-- 1. Average Price by Neighbourhood Group
SELECT neighbourhood_group, ROUND(AVG(price), 2) AS average_price
FROM airbnb_listings
GROUP BY neighbourhood_group
ORDER BY average_price DESC;

-- 2. Number of Listings by Room Type
SELECT room_type, COUNT(*) AS listing_count
FROM airbnb_listings
GROUP BY room_type
ORDER BY listing_count DESC;

-- 3. Average Price by Room Type
SELECT room_type, ROUND(AVG(price), 2) AS average_price
FROM airbnb_listings
GROUP BY room_type
ORDER BY average_price DESC;

-- 4. Average Availability by Room Type
SELECT room_type, ROUND(AVG(availability_365), 2) AS average_availability_days
FROM airbnb_listings
GROUP BY room_type
ORDER BY average_availability_days DESC;

-- 5. Top 10 Neighbourhoods by Average Price
SELECT neighbourhood, COUNT(*) AS listing_count, ROUND(AVG(price), 2) AS average_price
FROM airbnb_listings
GROUP BY neighbourhood
HAVING COUNT(*) >= 10
ORDER BY average_price DESC
LIMIT 10;

-- 6. Listings Above the Overall Average Price
SELECT COUNT(*) AS listings_above_overall_average
FROM airbnb_listings
WHERE price > (SELECT AVG(price) FROM airbnb_listings);

-- 7. Hosts with More Than 10 Listings
SELECT host_id, COUNT(*) AS listing_count, ROUND(AVG(price), 2) AS average_price
FROM airbnb_listings
GROUP BY host_id
HAVING COUNT(*) > 10
ORDER BY listing_count DESC, average_price DESC;

-- 8. Neighbourhood Group Review Activity
SELECT neighbourhood_group, COUNT(*) AS listing_count,
       SUM(number_of_reviews) AS total_reviews,
       ROUND(AVG(number_of_reviews), 2) AS average_reviews_per_listing
FROM airbnb_listings
GROUP BY neighbourhood_group
ORDER BY total_reviews DESC;

-- 9. JOIN with Room-Type Summary
SELECT a.room_type, a.id, a.price,
       s.average_room_price,
       ROUND(a.price - s.average_room_price, 2) AS difference_from_room_average
FROM airbnb_listings AS a
JOIN (
    SELECT room_type, AVG(price) AS average_room_price
    FROM airbnb_listings
    GROUP BY room_type
) AS s ON a.room_type = s.room_type
ORDER BY difference_from_room_average DESC
LIMIT 10;

-- 10. Neighbourhoods Above the Overall Average
SELECT neighbourhood, COUNT(*) AS listing_count,
       ROUND(AVG(price), 2) AS average_price
FROM airbnb_listings
GROUP BY neighbourhood
HAVING AVG(price) > (SELECT AVG(price) FROM airbnb_listings)
ORDER BY average_price DESC
LIMIT 10;
