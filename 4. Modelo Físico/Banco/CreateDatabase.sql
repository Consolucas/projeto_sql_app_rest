CREATE DATABASE final_proj;

USE final_proj;

CREATE TABLE country(
id_country INT PRIMARY KEY AUTO_INCREMENT,
nm_country VARCHAR(25) NOT NULL
);

CREATE TABLE restaurant(
id_restaurant INT PRIMARY KEY AUTO_INCREMENT,
nm_restaurant VARCHAR(50) NOT NULL,
id_country INT NOT NULL,
rating_restaurant DEC(2,1),
FOREIGN KEY (id_country) REFERENCES country(id_country)
);

CREATE TABLE meals(
id_meals INT PRIMARY KEY AUTO_INCREMENT,
nm_meals VARCHAR(50) NOT NULL,
id_country INT NOT NULL,
FOREIGN KEY (id_country) REFERENCES country(id_country)
);

CREATE TABLE meals_restaurant(
id_meals INT NOT NULL,
id_restaurant INT NOT NULL,
rating_meals DEC(2,1),
FOREIGN KEY (id_meals) REFERENCES meals(id_meals),
FOREIGN KEY (id_restaurant) REFERENCES restaurant(id_restaurant)
);

CREATE TABLE rating(
id_rating INT PRIMARY KEY AUTO_INCREMENT,
id_meals INT NOT NULL,
rating_meals_consumer DEC(2,1) NOT NULL,
id_restaurant INT NOT NULL,
rating_restaurant_consumer DEC(2,1) NOT NULL,
FOREIGN KEY (id_meals) REFERENCES meals(id_meals),
FOREIGN KEY (id_restaurant) REFERENCES restaurant(id_restaurant)
);



-- Trigger para poder calcular as médias da avaliação de cada prato em um determinado restaurante
DELIMITER $$
CREATE TRIGGER tg_average_rating_meals
AFTER INSERT ON rating
FOR EACH ROW
UPDATE meals_restaurant SET rating_meals = (SELECT AVG(rating_meals_consumer) FROM rating
											WHERE id_meals = NEW.id_meals
											AND id_restaurant = NEW.id_restaurant)
WHERE id_meals = NEW.id_meals
  AND id_restaurant = NEW.id_restaurant;
END $$


-- Trigger para poder calcular a média das avaliações de cada restaurante
DELIMITER $$
CREATE TRIGGER tg_average_rating_restaurant
AFTER INSERT ON rating
FOR EACH ROW
UPDATE restaurant SET rating_restaurant = (SELECT AVG(rating_restaurant_consumer) FROM rating
											WHERE id_restaurant = NEW.id_restaurant)
  WHERE id_restaurant = NEW.id_restaurant;
END $$
































