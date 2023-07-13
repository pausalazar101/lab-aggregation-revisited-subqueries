USE sakila;

-- Select the first name, last name, and email address of all the customers who have rented a movie.

SELECT
  c.first_name,
  c.last_name,
  c.email
FROM
  sakila.customer c
JOIN
  sakila.rental r ON c.customer_id = r.customer_id;
  
-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  AVG(p.amount) AS average_payment
FROM
  sakila.customer c
JOIN
  sakila.payment p ON c.customer_id = p.customer_id
JOIN
  sakila.rental r ON c.customer_id = r.customer_id
GROUP BY
  c.customer_id,
  customer_name;
--   Select the name and email address of all the customers who have rented the "Action" movies.
-- Write the query using multiple join statements

  
SELECT
  c.first_name,
  c.last_name,
  c.email
FROM
  sakila.customer c
JOIN
  sakila.rental r ON c.customer_id = r.customer_id
JOIN
  sakila.inventory i ON r.inventory_id = i.inventory_id
JOIN
  sakila.film f ON i.film_id = f.film_id
JOIN
  sakila.film_category fc ON f.film_id = fc.film_id
JOIN
  sakila.category cat ON fc.category_id = cat.category_id
WHERE
  cat.name = 'Action';

--   Write the query using sub queries with multiple WHERE clause and IN condition
  
SELECT
  c.first_name,
  c.last_name,
  c.email
FROM
  sakila.customer c
WHERE
  c.customer_id IN (
    SELECT
      r.customer_id
    FROM
      sakila.rental r
    WHERE
      r.inventory_id IN (
        SELECT
          i.inventory_id
        FROM
          sakila.inventory i
        WHERE
          i.film_id IN (
            SELECT
              f.film_id
            FROM
              sakila.film f
            WHERE
              f.film_id IN (
                SELECT
                  fc.film_id
                FROM
                  sakila.film_category fc
                  JOIN
                  sakila.category cat ON fc.category_id = cat.category_id
                WHERE
                  cat.name = 'Action'
              )
          )
      )
  );
  
--   Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
SELECT
  payment_id,
  amount,
  CASE
    WHEN amount BETWEEN 0 AND 2 THEN 'low'
    WHEN amount BETWEEN 2 AND 4 THEN 'medium'
    WHEN amount > 4 THEN 'high'
    ELSE 'unknown'
  END AS label
FROM
  sakila.payment;
