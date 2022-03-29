USE final_proj;


-- Select para ver restaurantes com as melhores avaliações
SELECT t1.nm_restaurant,
       t2.nm_country,
       t1.rating_restaurant
  FROM restaurant AS t1
  JOIN country AS t2
    ON t1.id_country = t2.id_country
 WHERE t1.rating_restaurant > 2.5
 ORDER BY t1.rating_restaurant DESC;
 

-- Select para ver os melhores pratos japoneses, e seus respectivos restaurantes
SELECT t2.nm_meals,
       t3.nm_restaurant,
       t1.rating_meals
  FROM meals_restaurant AS t1
  JOIN meals AS t2
    ON t1.id_meals = t2.id_meals
  JOIN restaurant AS t3
    ON t1.id_restaurant = t3.id_restaurant
 WHERE t3.id_country = 9
 ORDER BY t1.rating_meals DESC;
 


-- Select que traz os melhores restaurantes de cada país, e os seus melhores pratos
WITH best_restaurant_rating AS(
	SELECT MAX(rating_restaurant) AS best_rests,
		   id_country
      FROM restaurant
	 GROUP BY id_country
),

best_restaurant AS(
SELECT t1.nm_restaurant,
	   t1.id_country,
       t2.best_rests,
       t1.id_restaurant
  FROM restaurant AS t1
  JOIN best_restaurant_rating AS t2
    ON t1.id_country = t2.id_country
 WHERE t1.rating_restaurant = t2.best_rests
 GROUP BY t1.id_country
 ),
 
best_meals_rating AS (
SELECT MAX(t1.rating_meals) AS best_meals,
	   t1.id_restaurant,
       t1.id_meals
  FROM meals_restaurant AS t1
  JOIN best_restaurant AS t2
    ON t1.id_restaurant = t2.id_restaurant
 GROUP BY t2.nm_restaurant)
 
SELECT t3.nm_restaurant,
       t4.best_rests,
       t1.nm_meals,
       t2.best_meals
  FROM meals AS t1
  JOIN best_meals_rating AS t2
    ON t1.id_meals = t2.id_meals
  JOIN best_restaurant AS t3
    ON t2.id_restaurant = t3.id_restaurant
  JOIN best_restaurant_rating AS t4
    ON t3.id_country = t4.id_country
 GROUP BY t1.nm_meals
 ORDER BY t4.id_country ASC;
       




 
 