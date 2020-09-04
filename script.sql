drop schema call_center;

CREATE DATABASE call_center CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE call_center;

CREATE TABLE city (
id int NOT NULL AUTO_INCREMENT,
city_name varchar(100)  NOT NULL,
country_id int  NOT NULL,
CONSTRAINT city_pk PRIMARY KEY  (id)
);

CREATE TABLE country (
id int  NOT NULL AUTO_INCREMENT,
country_name varchar(128)  NOT NULL,
country_code char(8)  NOT NULL,
CONSTRAINT country_ak_1 UNIQUE (country_name),
CONSTRAINT country_ak_2 UNIQUE (country_code),
CONSTRAINT country_pk PRIMARY KEY  (id)
);

ALTER TABLE city ADD CONSTRAINT city_country
FOREIGN KEY (country_id)
REFERENCES country (id);


INSERT INTO country (country_name, country_code)
VALUES ('Croatia', 'HRV'),
('Serbia', 'SRB'),
('Bosnia and Herzegovina', 'BIH'),
('Slovenia', 'SLO'),
('Hungary', 'HUN'),
('Austria', 'AUT'),
('Czech Republic', 'CZK'),
('France', 'FRA'),
('Germany', 'DEU'),
('Italy', 'ITA');


UPDATE country SET country_name = 'Bosnia' WHERE country.id = 3;

INSERT INTO city (city_name, country_id)
VALUES ('Zagreb', 1),
('Osijek', 1),
('Belgrade', 2),
('Sarajevo', 3),
('Ljubljana', 4),
('Budapest', 5),
('Vienna', 6),
('Prague', 7),
('Brno', 7),
('Paris', 8),
('Berlin', 9),
('Munich', 9),
('Frankfurt', 9),
('Rome', 10),
('Milan', 10);


UPDATE city SET city_name = 'Split' WHERE city.id = 2;
DELETE FROM city WHERE city_name = 'Split';

SELECT * FROM city;

SELECT * FROM country;

DELETE FROM city where city_name = 'Brno';

SELECT id, country_name FROM country WHERE id > 3;

SELECT * FROM country
INNER JOIN city ON city.country_id = country.id;

-- join 2 tables using inner join and foreign key as condition (city has country.id)
-- select city by id and give me city id and city name, select country id and give me country id and country name
-- where returns only specified country ids
SELECT city.id AS city_id, city.city_name, country.id AS country_id, country.country_name
FROM city
INNER JOIN country ON city.country_id = country.id
WHERE country.id IN (1,2,3);

INSERT INTO country (country_name, country_code) VALUES ('Spain', 'ESP');

-- left join also shows country without city (Spain)
SELECT * FROM country
LEFT JOIN city c on country.id = c.country_id;

CREATE TABLE employee (
id int  NOT NULL AUTO_INCREMENT,
first_name varchar(255) NOT NULL,
last_name varchar(255) NOT NULL,
age tinyint,
CONSTRAINT employee_pk PRIMARY KEY  (id)
);

UPDATE employee SET first_name = 'Pamela' WHERE employee.id = 1;
DELETE FROM employee WHERE last_name='Anderson';

CREATE TABLE customer (
id int  NOT NULL AUTO_INCREMENT,
customer_name varchar(255)  NOT NULL,
city_id int  NOT NULL,
ts_inserted datetime  NOT NULL,
CONSTRAINT customer_pk PRIMARY KEY  (id)
);

UPDATE customer SET customer_name = 'International Airport' WHERE customer.id = 5;
DELETE FROM customer WHERE customer_name='Piterija';

CREATE TABLE calls (
id int  NOT NULL AUTO_INCREMENT,
employee_id int  NOT NULL,
customer_id int  NOT NULL,
CONSTRAINT call_ak_1 UNIQUE (employee_id),
CONSTRAINT call_pk PRIMARY KEY  (id)
);


INSERT INTO employee (first_name, last_name) VALUES ('Sam', 'Anderson'),
('Brad', 'Pitt'),
('Tom', 'Cruise'),
('Sandra', 'Bullock'),
('Will', 'Smith'),
('Tina', 'Fey');

UPDATE employee SET age = 20 WHERE employee.id = 1;
UPDATE employee SET age = 22 WHERE employee.id = 2;
UPDATE employee SET age = 25 WHERE employee.id = 3;
UPDATE employee SET age = 33 WHERE employee.id = 4;
UPDATE employee SET age = 30 WHERE employee.id = 5;
UPDATE employee SET age = 25 WHERE employee.id = 6;

DELETE FROM employee WHERE employee.age = 33;

INSERT INTO customer (customer_name, city_id, ts_inserted) VALUES ('Bakery', 1, '2020/1/9 10:50:15'),
('Café', 1, '2020/1/10 8:2:40'),
('City Market', 2, '2020/1/9 14:1:20'),
('Piterija', 4, '2020/1/10 13:20:30'),
('Airport', 6, '2020/1/11 17:22:15'),
('Schnitzel Place', 7, '2020/1/11 12:00:00'),
('Beer place', 8, '2020/1/12 15:10:55'),
('Bakery', 10, '2020/1/9 9:19:00'),
('BMW', 13, '2020/1/10 10:30:30'),
('Fashion Boutique', 15, '2020/1/13 15:20:15');

INSERT INTO calls (employee_id, customer_id ) VALUES (1, 4),
(2, 3),
(3, 1),
(4, 3),
(5, 2),
(6, 4);


-- We created a relation from the city.id to customer.city_id.
-- the customer can be only in one city and the city could have many different customers located in it.
-- ONE TO MANY RELATIONSHIP
SELECT * FROM city;

SELECT * FROM customer;

SELECT * FROM customer
INNER JOIN city ON customer.city_id = city.id;

SELECT * FROM customer
LEFT JOIN city ON customer.city_id = city.id;

SELECT * FROM city
LEFT JOIN customer ON customer.city_id = city.id;


-- We need to store calls between employees and customers.
-- One employee, during the time, could call many customers.
-- Also, one customer, during the time, could receive calls from many employees.
-- MANY TO MANY RELATIONSHIP

SELECT * FROM employee;

SELECT * FROM calls;

SELECT * FROM customer;

-- Each of customers is related to its city and the city is related to the country.
-- INNER JOIN eliminated all countries and cities without customers.
SELECT country.country_name, city.city_name, customer.customer_name
FROM country
INNER JOIN city ON city.country_id = country.id
INNER JOIN customer ON customer.city_id = city.id;

-- We get the countries and cities without customers with LEFT JOIN on same query
SELECT country.country_name, city.city_name, customer.customer_name
FROM country
LEFT JOIN city ON city.country_id = country.id
LEFT JOIN customer ON customer.city_id = city.id;

-- We get only countries with related cities, regardless if they have a customer or not
SELECT country.country_name, city.city_name, customer.customer_name
FROM country
INNER JOIN city ON city.country_id = country.id
LEFT JOIN customer ON customer.city_id = city.id;


SELECT COUNT(*) AS number_of_countries FROM country;

SELECT AVG(employee.age) AS avg_age FROM employee;

SELECT SUM(employee.age) AS sum_age FROM employee;

SELECT MIN(employee.age) AS min_age FROM employee;

SELECT MAX(employee.age) AS max_age FROM employee;

-- create trigger that makes last name all capitals before inserting it to the table
DROP TRIGGER IF EXISTS tr_insert_employee;

CREATE TRIGGER tr_insert_employee
BEFORE INSERT ON employee
FOR EACH ROW
SET NEW.last_name = UPPER(NEW.last_name);

INSERT INTO employee (first_name, last_name, age) VALUES ('Irena', 'Jurasek', 35);

SELECT * FROM employee;