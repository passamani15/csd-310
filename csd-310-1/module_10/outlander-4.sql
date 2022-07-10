/*
    Title: Outlander Init Script
    Authors: 	Chris Beatty
				Brian Gossett
				Larissa Passamani Lima
				Christeen Safar
				Michele Speidel

    Date: 10 July 2022
*/

-- drop test user if exists 
DROP USER IF EXISTS 'outlander_user'@'localhost';


-- create outlander_user and grant them all privileges to the outland_adventure database 
CREATE USER 'outlander_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'adventure';

-- grant all privileges to the outland_adventure database to user outlander_user on localhost 
GRANT ALL PRIVILEGES ON outland_adventures.* TO'outlander_user'@'localhost';


-- drop tables if they are present
DROP TABLE IF EXISTS employee_job;
DROP TABLE IF EXISTS employee_inoculation;
DROP TABLE IF EXISTS employee_visa;
DROP TABLE IF EXISTS customer_inoculation;
DROP TABLE IF EXISTS customer_visa;
DROP TABLE IF EXISTS destination_inoculation;
DROP TABLE IF EXISTS destination_visa;
DROP TABLE IF EXISTS employee_order;
DROP TABLE IF EXISTS customer_order;
DROP TABLE IF EXISTS trip_item;
DROP TABLE IF EXISTS trip_excursion;
DROP TABLE IF EXISTS employee_trip;
DROP TABLE IF EXISTS customer_trip;
DROP TABLE IF EXISTS job_responsibility;
DROP TABLE IF EXISTS visa;
DROP TABLE IF EXISTS inoculation;
DROP TABLE IF EXISTS excursion;
DROP TABLE IF EXISTS trip;
DROP TABLE IF EXISTS destination;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS item_type;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS employee;


-- create the employee table 
CREATE TABLE employee (
    employee_id     INT         	NOT NULL        AUTO_INCREMENT,
    first_name   	VARCHAR(75)     NOT NULL,
    last_name      	VARCHAR(75)     NOT NULL,
    nick_name     	VARCHAR(75),
    job_title      	VARCHAR(75)     NOT NULL,
    begin_date      DATE     		NOT NULL,
    end_date      	DATE,
    PRIMARY KEY(employee_id)
); 

-- create the job_responsibility table 
CREATE TABLE job_responsibility (
    job_responsibility_id 		INT         	NOT NULL        AUTO_INCREMENT,
    responsibility				VARCHAR(75)     NOT NULL,
    description			      	VARCHAR(100)    NOT NULL,
    PRIMARY KEY(job_responsibility_id)
); 

-- create the employee_job table 
CREATE TABLE employee_job (
    employee_job_id             INT         	NOT NULL        AUTO_INCREMENT,
    employee_id                 INT         	NOT NULL,
    job_responsibility_id 		INT         	NOT NULL,
    PRIMARY KEY(employee_job_id),
    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),
    FOREIGN KEY(job_responsibility_id)
        REFERENCES job_responsibility(job_responsibility_id)
); 

-- create the inoculationtable 
CREATE TABLE inoculation (
    inoculation_id      	INT         	NOT NULL        AUTO_INCREMENT,
    inoculation_type		VARCHAR(75)     NOT NULL,
    PRIMARY KEY(inoculation_id)
);  

-- create the visa table 
CREATE TABLE visa (
    visa_id 			    INT         	NOT NULL        AUTO_INCREMENT,
    country					VARCHAR(75)     NOT NULL,
    travel_purpose			VARCHAR(75)     NOT NULL,
    travel_requirements		VARCHAR(75)     NOT NULL,
    PRIMARY KEY(visa_id)
); 

-- create the employee_inoculation table 
CREATE TABLE employee_inoculation (
    employee_inoculation_id 	INT         	NOT NULL        AUTO_INCREMENT,
    employee_id                 INT         	NOT NULL,
    inoculation_id      	    INT         	NOT NULL,
    date_administered		    DATE		    NOT NULL,
    date_expires			    DATE,
    PRIMARY KEY(employee_inoculation_id),
    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),
    FOREIGN KEY(inoculation_id)
        REFERENCES inoculation(inoculation_id)
); 

-- create the employee_visa table 
CREATE TABLE employee_visa (
    employee_visa_id 			INT         	NOT NULL        AUTO_INCREMENT,
    employee_id                 INT         	NOT NULL,
    visa_id 		    	    INT         	NOT NULL,
    visa_number				    VARCHAR(75)     NOT NULL,
    PRIMARY KEY(employee_visa_id),
    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),
    FOREIGN KEY(visa_id)
        REFERENCES visa(visa_id)
); 

-- create the customer table 
CREATE TABLE customer (
    customer_id         INT         	NOT NULL        AUTO_INCREMENT,
    first_name   	    VARCHAR(75)     NOT NULL,
    last_name       	VARCHAR(75)     NOT NULL,
    card_number         INT             NOT NULL,
    emergency_contact   VARCHAR(20)     NOT NULL,
    PRIMARY KEY(customer_id)
); 

-- create the customer_inoculation table 
CREATE TABLE customer_inoculation (
    customer_inoculation_id 	INT         	NOT NULL        AUTO_INCREMENT,
    customer_id                 INT         	NOT NULL,
    inoculation_id      	    INT         	NOT NULL,
    date_administered		    DATE		    NOT NULL,
    date_expires			    DATE,
    PRIMARY KEY(customer_inoculation_id),
    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id),
    FOREIGN KEY(inoculation_id)
        REFERENCES inoculation(inoculation_id)
); 

-- create the customer_visa table 
CREATE TABLE customer_visa (
    customer_visa_id 			INT         	NOT NULL        AUTO_INCREMENT,
    customer_id                 INT         	NOT NULL,
    visa_id 		    	    INT         	NOT NULL,
    visa_number				    VARCHAR(75)     NOT NULL,
    PRIMARY KEY(customer_visa_id),
    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id),
    FOREIGN KEY(visa_id)
        REFERENCES visa(visa_id)
); 


-- create the item_type table 
CREATE TABLE item_type (
    item_type_id 		    INT             NOT NULL        AUTO_INCREMENT,
    description             VARCHAR(75)     NOT NULL,
    PRIMARY KEY(item_type_id)
); 

-- create the item table 
CREATE TABLE item (
    item_id 		        INT             NOT NULL        AUTO_INCREMENT,
    item_type_id 		    INT             NOT NULL,
    date_aquired		    DATE            NOT NULL,
    date_expires		    DATE,
    last_maintenance		DATE,
    is_available    		BOOLEAN         NOT NULL,
    PRIMARY KEY(item_id),
    FOREIGN KEY(item_type_id)
        REFERENCES item_type(item_type_id)
); 

-- create the employee_order table 
CREATE TABLE employee_order (
    employee_order_id 		INT             NOT NULL        AUTO_INCREMENT,
    employee_id		        INT             NOT NULL,
    item_id		            INT             NOT NULL,
    out_date                DATE            NOT NULL,
    in_date                 DATE,
    PRIMARY KEY(employee_order_id),
    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),
    FOREIGN KEY(item_id)
        REFERENCES item(item_id)
); 

-- create the customer_order table 
CREATE TABLE customer_order (
    customer_order_id 		INT             NOT NULL        AUTO_INCREMENT,
    customer_id		        INT             NOT NULL,
    item_id		            INT             NOT NULL,
    out_date                DATE            NOT NULL,
    in_date                 DATE,
    is_rental               BOOLEAN         NOT NULL,
    PRIMARY KEY(customer_order_id),
    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id),
    FOREIGN KEY(item_id)
        REFERENCES item(item_id)
);  

-- create the destination table 
CREATE TABLE destination (
    destination_id 		INT             NOT NULL        AUTO_INCREMENT,
    region  		    VARCHAR(50)     NOT NULL,
    airfare_fee		    VARCHAR(50)     NOT NULL,
    PRIMARY KEY(destination_id)
);    

-- create the destination_inoculation table 
CREATE TABLE destination_inoculation (
    destination_inoculation_id 	INT         	NOT NULL        AUTO_INCREMENT,
    destination_id                  INT         	NOT NULL,
    inoculation_id      	        INT         	NOT NULL,
    PRIMARY KEY(destination_inoculation_id),
    FOREIGN KEY(destination_id)
        REFERENCES destination(destination_id),
    FOREIGN KEY(inoculation_id)
        REFERENCES inoculation(inoculation_id)
); 

-- create the destination_visa table 
CREATE TABLE destination_visa (
    destination_visa_id 			INT         	NOT NULL        AUTO_INCREMENT,
    destination_id                  INT         	NOT NULL,
    visa_id 		    	        INT         	NOT NULL,
    PRIMARY KEY(destination_visa_id),
    FOREIGN KEY(destination_id)
        REFERENCES destination(destination_id),
    FOREIGN KEY(visa_id)
        REFERENCES visa(visa_id)
);

-- create the trip table 
CREATE TABLE trip (
    trip_id 		    INT         NOT NULL        AUTO_INCREMENT,
    destination_id 		INT         NOT NULL,
    begin_date          DATE        NOT NULL,
    end_date            DATE        NOT NULL,
    PRIMARY KEY(trip_id),
    FOREIGN KEY(destination_id)
        REFERENCES destination(destination_id)
);  

-- create the excursion table 
CREATE TABLE excursion (
    excursion_id            INT             NOT NULL        AUTO_INCREMENT,
    excursion_description   VARCHAR(100)    NOT NULL,
    PRIMARY KEY(excursion_id)
); 

-- create the trip_excursion table 
CREATE TABLE trip_excursion (
    trip_excursion_id       INT         	NOT NULL        AUTO_INCREMENT,
    trip_id                 INT         	NOT NULL,
    excursion_id            INT         	NOT NULL,
    date         DATE        NOT NULL,
    PRIMARY KEY(trip_excursion_id),
    FOREIGN KEY(trip_id)
        REFERENCES trip(trip_id),
    FOREIGN KEY(excursion_id)
        REFERENCES excursion(excursion_id)
); 

-- create the trip_item table 
CREATE TABLE trip_item (
    trip_item_id            INT         	NOT NULL        AUTO_INCREMENT,
    trip_id                 INT         	NOT NULL,
    item_type_id            INT         	NOT NULL,
    PRIMARY KEY(trip_item_id),
    FOREIGN KEY(trip_id)
        REFERENCES trip(trip_id),
    FOREIGN KEY(item_type_id)
        REFERENCES item_type(item_type_id)
); 

-- create the employee_trip table 
CREATE TABLE employee_trip (
    employee_trip_id        INT         	NOT NULL        AUTO_INCREMENT,
    employee_id             INT         	NOT NULL,
    trip_id                 INT         	NOT NULL,
    PRIMARY KEY(employee_trip_id),
    FOREIGN KEY(employee_id)
        REFERENCES employee(employee_id),
    FOREIGN KEY(trip_id)
        REFERENCES trip(trip_id)
);  

-- create the customer_trip table 
CREATE TABLE customer_trip (
    customer_trip_id        INT         	NOT NULL        AUTO_INCREMENT,
    customer_id             INT         	NOT NULL,
    trip_id                 INT         	NOT NULL,
    PRIMARY KEY(customer_trip_id),
    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id),
    FOREIGN KEY(trip_id)
        REFERENCES trip(trip_id)
); 


-- Employee insert statements
INSERT INTO employee(first_name, last_name, nick_name, job_title, begin_date, end_date )
    VALUES('Blythe', 'Timmerson', NULL, 'CEO', '20220101', NULL),
    	('Jim', 'Ford', NULL, 'CEO', '20220101', NULL),
    	('John', 'MacNell', 'Mac', 'Tour Guide', '20220201', NULL),
    	('D.B.', 'Marland', 'Duke', 'Tour Guide', '20220201', NULL),
    	('Anita', 'Gallegos', NULL, 'Marketing', '20220201', NULL),
    	('Dimitrios', 'Stravopolous', NULL, 'Inventory', '20220201', NULL),
    	('Mei', 'Wong ', NULL, 'E-Commerce', '20220601', NULL);


-- job_responsibility insert statements
INSERT INTO job_responsibility(responsibility, description)
    VALUES('CEO', 'In charge of the company'),
        ('Administration', 'General office administration'),
        ('Office Operations', 'Data analytics'),
    	('Marketing Geniouse', 'Markets the companys services'),
    	('Guides', 'Takes people on path'),
    	('Trip Planning', 'Plans trip'),
    	('Visa Checking', 'Validates visa'),
   	    ('Inoculation Checking', 'Validates shots'),
   	    ('Airfares', 'Plane ride price checker'),
   	    ('Inventory', 'Orders products'),
   	    ('E-commerce', 'E-Commerce');


-- employee_job insert statements
INSERT INTO employee_job(employee_id, job_responsibility_id)
    VALUES((SELECT employee_id FROM employee WHERE first_name = 'Blythe'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'CEO')),
    ((SELECT employee_id FROM employee WHERE first_name = 'Blythe'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Administration')),
    ((SELECT employee_id FROM employee WHERE first_name = 'Blythe'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Office Operations')),
    ((SELECT employee_id FROM employee WHERE first_name = 'Jim'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Administration')),
    ((SELECT employee_id FROM employee WHERE first_name = 'Jim'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Office Operations')),
    ((SELECT employee_id FROM employee WHERE first_name = 'Jim'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'CEO')),
    ((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Guides')),    
    ((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Trip Planning')),   
    ((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Visa Checking')),    
    ((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Inoculation Checking')),
    ((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Airfares')),  
    ((SELECT employee_id FROM employee WHERE first_name = 'Anita'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Marketing Geniouse')), 
    ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Guides')),    
    ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Trip Planning')),    
    ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Visa Checking')),    
    ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Inoculation Checking')),
    ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Airfares')),
    ((SELECT employee_id FROM employee WHERE first_name = 'Dimitrios'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'Inventory')),
    ((SELECT employee_id FROM employee WHERE first_name = 'Mei'), (SELECT job_responsibility_id FROM job_responsibility WHERE responsibility = 'E-Commerce'));


-- inoculation insert statements
INSERT INTO inoculation(inoculation_type)
    VALUES('Covid-19'),
    ('Chickenpox'),
    ('Cholera'),
    ('Diphtheria'),
    ('Hepatitis A'),
    ('Hepatitis B'),
    ('Hib');


-- visa insert statements
INSERT INTO visa(country, travel_purpose, travel_requirements )
    VALUES('China', 'Tourism', 'Money bring docs'),
    ('Italy', 'Tourism', 'Money bring docs'),
    ('South Africa', 'Tourism', 'Money bring docs'),
    ('Greece', 'Tourism', 'Money bring docs'),
    ('Colombia', 'Tourism', 'Money bring docs'),
    ('Brazil', 'Tourism', 'Money bring docs'),
    ('Norway', 'Tourism', 'Money bring docs'),
    ('Denmark', 'Tourism', 'Money bring docs'),
    ('China', 'Work', 'A Job Money bring docs'),
    ('Italy', 'Work', 'A Job Money bring docs'),
    ('South Africa', 'Work', 'A Job Money bring docs'),
    ('Greece', 'Work', 'A Job Money bring docs'),
    ('Colombia', 'Work', 'A Job Money bring docs'),
    ('Brazil', 'Work', 'A Job Money bring docs'),
    ('Norway', 'Work', 'A Job Money bring docs'),
    ('Denmark', 'Work', 'A Job Money bring docs');



-- employee_inoculation insert statements
INSERT INTO employee_inoculation(employee_id, inoculation_id, date_administered, date_expires)
    VALUES((SELECT employee_id FROM employee WHERE first_name = 'Blythe'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
    	((SELECT employee_id FROM employee WHERE first_name = 'Jim'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'Anita'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
    	((SELECT employee_id FROM employee WHERE first_name = 'Dimitrios'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
   	    ((SELECT employee_id FROM employee WHERE first_name = 'Mei'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
        
    	((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
    	((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
        
    	((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Cholera'), '20210801', '20330801' ),
    	((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Cholera'), '20210801', '20330801' ),
        
    	((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Diphtheria'), '20210621', '20250621' ),
    	((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Diphtheria'), '20210621', '20250621' );


-- employee_visa insert statements
INSERT INTO employee_visa(employee_id, visa_id, visa_number)
    VALUES((SELECT employee_id FROM employee WHERE first_name = 'Blythe'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 5373430233),
    	((SELECT employee_id FROM employee WHERE first_name = 'Jim'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 5653427288),
    	((SELECT employee_id FROM employee WHERE first_name = 'Anita'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 7604961991),
    	((SELECT employee_id FROM employee WHERE first_name = 'Dimitrios'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 3921735321),
    	((SELECT employee_id FROM employee WHERE first_name = 'Mei'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 6569881033),

        ((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'South Africa'), 3421590256),        
    	((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 3070696915),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Greece'), 4465333391),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Italy'), 7747874395),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Brazil'), 7452186245),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Colombia'), 6521489652),
        
    	((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 9689705174),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'South Africa'), 6750511082),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Greece'), 0892417636),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Italy'), 0222592611),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Norway'), 4845612325),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Denmark'), 4587564582);


-- customer insert statements
INSERT INTO customer(first_name, last_name, card_number, emergency_contact)
    VALUES('Zack', 'Petisso', 77772323, '626-666-6661'),
    	('Mary', 'Louis', 33332421, '999-919-9922'),
    	('Fabricio', 'Pontic', 45453377, '888-878-8989'),
    	('Fernanda', 'Clark', 80089773, '797-096-5645'),
    	('Pickle', 'Rick', 69583232, '531-452-7895'),
    	('Pepe', 'Yee', 47851236, '485-253-4236'),
    	('John', 'Smith', 63985265, '987-789-7894'),
    	('Jimmy', 'Newtron', 74586589, '321-356-6431'),
        ('Rick', 'Roll', 51532445, 'dQw4w9WgXcQ');


-- customer insert statements
INSERT INTO customer_inoculation(customer_id, inoculation_id, date_administered, date_expires)
    VALUES((SELECT customer_id FROM customer WHERE first_name = 'Zack'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Diphtheria'), '20211001', '20251001' ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Hib'), '20211001', '20261001' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'Mary'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'Mary'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Diphtheria'), '20211001', '20251001' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Diphtheria'), '20211001', '20251001' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Cholera'), '20210801', '20330801' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Diphtheria'), '20211001', '20251001' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Hib'), '20211001', '20261001' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'Pickle'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'Pepe'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'John'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' ),
    	((SELECT customer_id FROM customer WHERE first_name = 'Jimmy'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'), '20220201', '20230201' );


-- customer_visa insert statements
INSERT INTO customer_visa(customer_id, visa_id, visa_number)
    VALUES((SELECT customer_id FROM customer WHERE first_name = 'Zack'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 0978061948),
        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'South Africa'), 3178154381),
        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Norway'), 4747581263),
        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Italy'), 4512365845),

        ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'South Africa'), 8054617431),
    	((SELECT customer_id FROM customer WHERE first_name = 'Mary'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Italy'), 3502991909),
        ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Norway'), 4845127854),
        ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Greece'), 5421596325),

    	((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 6089625897),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'South Africa'), 8417167036),
    	((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Greece'), 4582154632),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Denmark'), 1547854258),
        
    	((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 1721492707),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'South Africa'), 4245774308),
    	((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Greece'), 1548456325),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Denmark'), 4521484578),

    	((SELECT customer_id FROM customer WHERE first_name = 'Pickle'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Denmark'), 5667576025),
        ((SELECT customer_id FROM customer WHERE first_name = 'Pickle'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Norway'), 8866525930),

    	((SELECT customer_id FROM customer WHERE first_name = 'Pepe'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 8587366102),
        ((SELECT customer_id FROM customer WHERE first_name = 'Pepe'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Norway'), 464700712222),

    	((SELECT customer_id FROM customer WHERE first_name = 'John'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Norway'), 2319572272),
        ((SELECT customer_id FROM customer WHERE first_name = 'John'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Greece'), 9407205279),

    	((SELECT customer_id FROM customer WHERE first_name = 'Jimmy'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'), 6576895802),
        ((SELECT customer_id FROM customer WHERE first_name = 'Jimmy'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Norway'), 6196161183);


-- item_type insert statements
INSERT INTO item_type(description)
    VALUES('Trekking poles'),
        ('Sunscreen'),
        ('First aid kit'),
        ('Rain coat'),
        ('Flashlight'),
        ('Water bottle'),
        ('Tent'),
        ('Lighter'),
        ('Fishing Tools'),
        ('Scuba Gear'),
        ('Small Knife'),
        ('Shovel'),
        ('Bug Spray'),
        ('Food'),
        ('Hula hoop'),
        ('Mystery Box'),
        ('Diving Tools');


-- item insert statements
INSERT INTO item(date_aquired, date_expires, item_type_id, last_maintenance, is_available)
    VALUES('20180423', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Trekking poles'), '20220115', TRUE),
        ('20180423', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Trekking poles'), '20220115', TRUE),
        ('20180423', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Trekking poles'), '20220115', TRUE),
        ('20180608', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Trekking poles'), NULL, TRUE),
        ('20180608', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Trekking poles'), NULL, TRUE),
        ('20180608', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Trekking poles'), NULL, TRUE),
        ('20220222', '20230215', (SELECT item_type_id FROM item_type WHERE description = 'Sunscreen'), NULL, TRUE),
        ('20220222', '20230215', (SELECT item_type_id FROM item_type WHERE description = 'Sunscreen'), NULL, TRUE),
        ('20220222', '20230215', (SELECT item_type_id FROM item_type WHERE description = 'Sunscreen'), NULL, TRUE),
        ('20220222', '20230215', (SELECT item_type_id FROM item_type WHERE description = 'Sunscreen'), NULL, TRUE),
        ('20190324', NULL, (SELECT item_type_id FROM item_type WHERE description = 'First aid kit'), NULL, TRUE),
        ('20190324', NULL, (SELECT item_type_id FROM item_type WHERE description = 'First aid kit'), NULL, TRUE),
        ('20200405', NULL, (SELECT item_type_id FROM item_type WHERE description = 'First aid kit'), NULL, TRUE),
        ('20200405', NULL, (SELECT item_type_id FROM item_type WHERE description = 'First aid kit'), NULL, TRUE),
        ('20210501', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Rain coat'), NULL, TRUE),
        ('20210501', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Rain coat'), NULL, TRUE),
        ('20210501', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Rain coat'), NULL, TRUE),
        ('20220211', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Flashlight'), '20220516', TRUE),
        ('20220211', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Flashlight'), '20220516', TRUE),
        ('20220211', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Flashlight'), '20220516', TRUE),
        ('20220211', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Flashlight'), '20220516', TRUE),
        ('20201121', '20231121', (SELECT item_type_id FROM item_type WHERE description = 'Water bottle'), NULL, TRUE),
        ('20201121', '20231121', (SELECT item_type_id FROM item_type WHERE description = 'Water bottle'), NULL, TRUE),
        ('20201121', '20231121', (SELECT item_type_id FROM item_type WHERE description = 'Water bottle'), NULL, TRUE),
        ('20201121', '20231121', (SELECT item_type_id FROM item_type WHERE description = 'Water bottle'), NULL, TRUE),
        ('20200905', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Tent'), NULL, TRUE),
        ('20200905', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Tent'), NULL, TRUE),
        ('20200905', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Tent'), NULL, TRUE),
        ('20200905', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Tent'), NULL, TRUE),
        ('20210418', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Tent'), NULL, TRUE),
        ('20210418', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Tent'), NULL, TRUE),
        ('20210213', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Lighter'), NULL, TRUE),
        ('20210213', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Lighter'), NULL, TRUE),
        ('20210213', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Lighter'), NULL, TRUE),
        ('20210213', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Lighter'), NULL, TRUE),
        ('20210104', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Fishing Tools'), '20210708', TRUE),
        ('20210104', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Fishing Tools'), '20210708', TRUE),
        ('20210104', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Fishing Tools'), '20210708', TRUE),
        ('20210104', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Fishing Tools'), '20210708', TRUE),
        ('20210104', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Fishing Tools'), '20210708', TRUE),
        ('20210104', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Fishing Tools'), '20210708', TRUE),
        ('20210115', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Scuba Gear'), '20210506', TRUE),
        ('20210115', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Scuba Gear'), '20210506', TRUE),
        ('20210115', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Scuba Gear'), '20210506', TRUE),
        ('20210115', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Scuba Gear'), '20210506', TRUE),
        ('20210115', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Scuba Gear'), '20210506', TRUE),
        ('20210115', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Scuba Gear'), '20210506', TRUE),
        ('20210120', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Small Knife'), NULL, TRUE),
        ('20210120', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Small Knife'), NULL, TRUE),
        ('20210120', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Small Knife'), NULL, TRUE),
        ('20210120', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Small Knife'), NULL, TRUE),
        ('20210120', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Small Knife'), NULL, TRUE),
        ('20210120', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Small Knife'), NULL, TRUE),
        ('20210202', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Shovel'), NULL, TRUE),
        ('20210202', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Shovel'), NULL, TRUE),
        ('20210202', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Shovel'), NULL, TRUE),
        ('20210202', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Shovel'), NULL, TRUE),
        ('20210202', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Shovel'), NULL, TRUE),
        ('20210202', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Shovel'), NULL, TRUE),
        ('20201121', '20221121', (SELECT item_type_id FROM item_type WHERE description = 'Bug Spray'), NULL, TRUE),
        ('20201121', '20221121', (SELECT item_type_id FROM item_type WHERE description = 'Bug Spray'), NULL, TRUE),
        ('20201121', '20221121', (SELECT item_type_id FROM item_type WHERE description = 'Bug Spray'), NULL, TRUE),
        ('20201121', '20221121', (SELECT item_type_id FROM item_type WHERE description = 'Bug Spray'), NULL, TRUE),
        ('20201121', '20221121', (SELECT item_type_id FROM item_type WHERE description = 'Bug Spray'), NULL, TRUE),
        ('20201121', '20221121', (SELECT item_type_id FROM item_type WHERE description = 'Bug Spray'), NULL, TRUE),
        ('20210110', '20220110', (SELECT item_type_id FROM item_type WHERE description = 'Food'), NULL, TRUE),
        ('20210110', '20220110', (SELECT item_type_id FROM item_type WHERE description = 'Food'), NULL, TRUE),
        ('20210110', '20220110', (SELECT item_type_id FROM item_type WHERE description = 'Food'), NULL, TRUE),
        ('20210110', '20220110', (SELECT item_type_id FROM item_type WHERE description = 'Food'), NULL, TRUE),
        ('20210110', '20220110', (SELECT item_type_id FROM item_type WHERE description = 'Food'), NULL, TRUE),
        ('20210110', '20220110', (SELECT item_type_id FROM item_type WHERE description = 'Food'), NULL, TRUE),
        ('20211016', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Hula Hoop'), NULL, TRUE),
        ('20211016', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Hula Hoop'), NULL, TRUE),
        ('20211016', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Hula Hoop'), NULL, TRUE),
        ('20211016', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Hula Hoop'), NULL, TRUE),
        ('20211016', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Hula Hoop'), NULL, TRUE),
        ('20211016', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Hula Hoop'), NULL, TRUE),
        ('20220103', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Mystery Box'), NULL, TRUE),
        ('20220103', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Mystery Box'), NULL, TRUE),
        ('20220103', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Mystery Box'), NULL, TRUE),
        ('20220103', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Mystery Box'), NULL, TRUE),
        ('20220103', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Mystery Box'), NULL, TRUE),
        ('20220103', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Mystery Box'), NULL, TRUE),
        ('20220201', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Diving Tools'), '20220506', TRUE),
        ('20220201', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Diving Tools'), '20220506', TRUE),
        ('20220201', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Diving Tools'), '20220506', TRUE),
        ('20220201', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Diving Tools'), NULL, TRUE),
        ('20220201', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Diving Tools'), NULL, TRUE),
        ('20220201', NULL, (SELECT item_type_id FROM item_type WHERE description = 'Diving Tools'), NULL, TRUE);


-- employee_order insert statements
INSERT INTO employee_order(employee_id, item_id, out_date, in_date)
    VALUES((SELECT employee_id FROM employee WHERE first_name = 'John'), 1, '20220610', '20220620' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 7, '20220610', '20220620' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 11, '20220610', '20220620' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 22, '20220610', '20220620' ),

        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 1, '20220712', '20220718' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 7, '20220712', '20220718' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 11, '20220712', '20220718' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 22, '20220712', '20220718' ),

        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 1, '20220723', '20220806' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 2, '20220723', '20220806' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 7, '20220723', '20220806' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 8, '20220723', '20220806' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 13, '20220723', '20220806' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 14, '20220723', '20220806' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 23, '20220723', '20220806' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 24, '20220723', '20220806' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 26, '20220723', '20220806' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 27, '20220723', '20220806' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 32, '20220723', '20220806' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 33, '20220723', '20220806' ),
        
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 1, '20220813', '20220827' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 7, '20220813', '20220827' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 11, '20220813', '20220827' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 22, '20220813', '20220827' ),

        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 2, '20220903', '20220918' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 9, '20220903', '20220918' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 13, '20220903', '20220918' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 24, '20220903', '20220918' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 36, '20220903', '20220918' ),

        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 2, '20221020', '20221030' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 9, '20221020', '20221030' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 13, '20221020', '20221030' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 24, '20221020', '20221030' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 84, '20221020', '20221030' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 36, '20221020', '20221030' ),
        
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 1, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 2, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 7, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 8, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 13, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 14, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 23, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 24, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 26, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 27, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 60, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 62, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 68, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 69, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 36, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 37, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 72, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 73, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 79, '20220901', '20220925' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 80, '20220901', '20220925' ),

        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 1, '20230707', '20230714' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 8, '20230707', '20230714' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 12, '20230707', '20230714' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 23, '20230707', '20230714' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 43, '20230707', '20230714' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 48, '20230707', '20230714' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'John'), 37, '20230707', '20230714' ),

        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 2, '20230105', '20230110' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 8, '20230105', '20230110' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 12, '20230105', '20230110' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 23, '20230105', '20230110' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 62, '20230105', '20230110' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 28, '20230105', '20230110' ),
        ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 67, '20230105', '20230110' );


-- customer_order insert statements
INSERT INTO customer_order(customer_id, item_id, out_date, in_date, is_rental)
    VALUES((SELECT customer_id FROM customer WHERE first_name = 'Zack'), 3, '20220610', '20220620', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 4, '20220610', '20220620', TRUE ),

        ((SELECT customer_id FROM customer WHERE first_name = 'Pickle'), 3, '20220712', '20220718', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 4, '20220712', '20220718', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Pepe'), 24, '20220712', '20220718', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), 25, '20220712', '20220718', TRUE ),

        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), 3, '20220723', '20220806', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 4, '20220723', '20220806', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Pepe'), 34, '20220723', '20220806', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Jimmy'), 35, '20220723', '20220806', TRUE ),

        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), 3, '20220813', '20220827', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 4, '20220813', '20220827', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), 24, '20220813', '20220827', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 25, '20220813', '20220827', TRUE ),
        
        ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 3, '20220903', '20220918', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 4, '20220903', '20220918', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 38, '20220903', '20220918', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 39, '20220903', '20220918', TRUE ),
        
        ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 3, '20221020', '20221030', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 4, '20221020', '20221030', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 86, '20221020', '20221030', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 87, '20221020', '20221030', TRUE ),
    
        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), 3, '20220901', '20220925', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 4, '20220901', '20220925', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 9, '20220901', '20220925', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), 10, '20220901', '20220925', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Pickle'), 40, '20220901', '20220925', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Pepe'), 41, '20220901', '20220925', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'John'), 82, '20220901', '20220925', FALSE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Jimmy'), 83, '20220901', '20220925', FALSE ),

        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'),  5, '20230707', '20230714', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'),  6, '20230707', '20230714', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'),  24, '20230707', '20230714', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'),  25, '20230707', '20230714', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Zack'),  51, '20230707', '20230714', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'),  52, '20230707', '20230714', TRUE ),

        ((SELECT customer_id FROM customer WHERE first_name = 'Rick'), 3, '20230105', '20230110', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 4, '20230105', '20230110', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'John'), 5, '20230105', '20230110', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Jimmy'), 6, '20230105', '20230110', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Rick'), 63, '20230105', '20230110', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 64, '20230105', '20230110', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'John'), 9, '20230105', '20230110', TRUE ),
        ((SELECT customer_id FROM customer WHERE first_name = 'Jimmy'), 10, '20230105', '20230110', TRUE );


-- destination insert statements
INSERT INTO destination(region, airfare_fee)
    VALUES('South America', '3500'),
    	('Africa', '5000'),
    	('North America', '200'),
    	('Southern Europe', '7452'),
    	('Northern Europe', '6874'),
    	('Asia', '8639');


-- destination_inoculation insert statements
INSERT INTO destination_inoculation(destination_id, inoculation_id)
    VALUES((SELECT destination_id FROM destination WHERE region = 'South America'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19')),
    	((SELECT destination_id FROM destination WHERE region = 'Africa'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19')),
    	((SELECT destination_id FROM destination WHERE region = 'North America'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19')),
    	((SELECT destination_id FROM destination WHERE region = 'Southern Europe'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19')),
    	((SELECT destination_id FROM destination WHERE region = 'Northern Europe'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19')),
    	((SELECT destination_id FROM destination WHERE region = 'Asia'), (SELECT inoculation_id FROM inoculation WHERE inoculation_type = 'Covid-19'));


-- destination_visa insert statements
INSERT INTO destination_visa(destination_id, visa_id)
    VALUES((SELECT destination_id FROM destination WHERE region = 'South America'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Brazil')),
    	((SELECT destination_id FROM destination WHERE region = 'Africa'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'South Africa')),
    	((SELECT destination_id FROM destination WHERE region = 'North America'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Colombia')),
    	((SELECT destination_id FROM destination WHERE region = 'Southern Europe'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Italy')),
    	((SELECT destination_id FROM destination WHERE region = 'Northern Europe'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'Greece')),
    	((SELECT destination_id FROM destination WHERE region = 'Asia'), (SELECT visa_id FROM visa WHERE travel_purpose = 'Tourism' AND country= 'China'));


-- trip insert statements
INSERT INTO trip(destination_id, begin_date, end_date)
    VALUES((SELECT destination_id FROM destination WHERE region = 'Asia'), '20220601', '20220615'),
        ((SELECT destination_id FROM destination WHERE region = 'North America'), '20220712', '20220718'),
        ((SELECT destination_id FROM destination WHERE region = 'Asia'), '20220723', '20220806'),
        ((SELECT destination_id FROM destination WHERE region = 'Southern Europe'), '20220813', '20220827'),
        ((SELECT destination_id FROM destination WHERE region = 'Africa'), '20220903', '20220918'),
        ((SELECT destination_id FROM destination WHERE region = 'Northern Europe'), '20221020', '20221030'),
        ((SELECT destination_id FROM destination WHERE region = 'Northern Europe'), '20221101', '20221125'),
        ((SELECT destination_id FROM destination WHERE region = 'Africa'), '20221207', '20221214'),
        ((SELECT destination_id FROM destination WHERE region = 'North America'), '20230105', '20230110');


-- excursion insert statements
INSERT INTO excursion(excursion_description)
    VALUES('Rock Climbing'),
    	('Swimming'),
    	('Tea Time'),
    	('Camp Games'),
    	('Outdoor Cooking Class'),
    	('The Big Event'),
        ('Hiking'),
        ('Fishing'),
        ('Diving'),
        ('Deep Sea Fishing'),
        ('Scuba Diving'),
        ('Lion Fighting'),
        ('CampFire Singing Lessons'),
        ('Karaoke'),
        ('Concert');


-- trip_excursion insert statements
INSERT INTO trip_excursion(trip_id, excursion_id, date)
    VALUES(1, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20220610'),
    	(1, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20220611'),
    	(2, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20220712'),
    	(2, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20220713'),
    	(2, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Tea Time'), '20220714'),
    	(2, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20220716'),
    	(2, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20220717'),
    	(2, (SELECT excursion_id FROM excursion WHERE excursion_description = 'The Big Event'), '20220718'),
    	(3, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20220725'),
    	(3, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20220726'),
    	(3, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Outdoor Cooking Class'), '20220727'),
    	(3, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Hiking'), '20220728'),
    	(3, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Hiking'), '20220729'),
    	(3, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Outdoor Cooking Class'), '20220730'),
    	(3, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20220731'),
    	(3, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20220801'),
    	(3, (SELECT excursion_id FROM excursion WHERE excursion_description = 'The Big Event'), '20220802'),
    	(3, (SELECT excursion_id FROM excursion WHERE excursion_description = 'The Big Event'), '20220803'),
    	(3, (SELECT excursion_id FROM excursion WHERE excursion_description = 'The Big Event'), '20220804'),
    	(4, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20220815'),
    	(4, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Hiking'), '20220816'),
    	(4, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Hiking'), '20220817'),
    	(4, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Outdoor Cooking Class'), '20220818'),
    	(4, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20220819'),
    	(4, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20220820'),
    	(4, (SELECT excursion_id FROM excursion WHERE excursion_description = 'The Big Event'), '20220821'),
    	(4, (SELECT excursion_id FROM excursion WHERE excursion_description = 'The Big Event'), '20220822'),
    	(4, (SELECT excursion_id FROM excursion WHERE excursion_description = 'The Big Event'), '20220824'),
    	(4, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Swimming'), '20220824'),
    	(4, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Swimming'), '20220825'),
    	(5, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20220905'),
    	(5, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20220906'),
    	(5, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20220907'),
    	(5, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20220908'),
    	(5, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20220909'),
    	(5, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Fishing'), '20220910'),
    	(5, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Fishing'), '20220911'),
    	(6, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20221022'),
    	(6, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20221023'),
    	(6, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20221024'),
    	(6, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20221025'),
    	(6, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20221026'),
    	(6, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20221027'),
    	(6, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Diving'), '20221028'),
    	(6, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Diving'), '20221029'),
    	(7, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Swimming'), '20221102'),
    	(7, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Camp Games'), '20221104'),
    	(7, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Deep Sea Fishing'), '20221107'),
    	(7, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Tea Time'), '20221112'),
    	(7, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Rock Climbing'), '20221118'),
    	(7, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Outdoor Cooking Class'), '20221120'),
    	(7, (SELECT excursion_id FROM excursion WHERE excursion_description = 'The Big Event'), '20221122'),
    	(7, (SELECT excursion_id FROM excursion WHERE excursion_description = 'The Big Event'), '20221123'),
    	(7, (SELECT excursion_id FROM excursion WHERE excursion_description = 'The Big Event'), '20221124'),
        (8, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Deep Sea Fishing'), '20221208'),
        (8, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Scuba Diving'), '20221210'),
        (8, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Lion Fighting'), '20221212'),
        (9, (SELECT excursion_id FROM excursion WHERE excursion_description = 'CampFire Singing Lessons'), '20230106'),
        (9, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Karaoke'), '20230107'),
        (9, (SELECT excursion_id FROM excursion WHERE excursion_description = 'Concert'), '20230109');


-- trip_item insert statements
INSERT INTO trip_item(trip_id, item_type_id)
    VALUES(1, 1),
        (1, 2),
        (1, 3),
        (1, 6),
        (2, 1),
        (2, 2),
        (2, 3),
        (2, 6),
        (3, 1),
        (3, 2),
        (3, 3),
        (3, 6),
        (3, 7),
        (3, 8),
        (4, 1),
        (4, 2),
        (4, 3),
        (4, 6),
        (5, 1),
        (5, 2),
        (5, 3),
        (5, 6),
        (5, 9),
        (6, 1),
        (6, 2),
        (6, 3),
        (6, 7),
        (6, 6),
        (7, 1),
        (7, 2),
        (7, 3),
        (7, 6),
        (7, 12),
        (7, 13),
        (7, 7),
        (7, 14),
        (7, 9),
        (7, 15),
        (7, 16),
        (8, 1),
        (8, 2),
        (8, 3),
        (8, 6),
        (8, 9),
        (8, 10),
        (8, 11),
        (9, 1),
        (9, 2),
        (9, 3),
        (9, 6),
        (9, 7),
        (9, 13),
        (9, 14);


-- employee_trip insert statements
INSERT INTO employee_trip(employee_id, trip_id)
    VALUES((SELECT employee_id FROM employee WHERE first_name = 'John'), 1),
    ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 2),
    ((SELECT employee_id FROM employee WHERE first_name = 'John'), 3),
    ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 3),
    ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 4),
    ((SELECT employee_id FROM employee WHERE first_name = 'John'), 5),
    ((SELECT employee_id FROM employee WHERE first_name = 'John'), 6),
    ((SELECT employee_id FROM employee WHERE first_name = 'John'), 7),
    ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 7),
    ((SELECT employee_id FROM employee WHERE first_name = 'John'), 8),
    ((SELECT employee_id FROM employee WHERE first_name = 'D.B.'), 9);


-- customer_trip insert statements
INSERT INTO customer_trip(customer_id, trip_id)
    VALUES((SELECT customer_id FROM customer WHERE first_name = 'Zack'), 1),
    ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 1),
    ((SELECT customer_id FROM customer WHERE first_name = 'Pickle'), 2),
    ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 2),
    ((SELECT customer_id FROM customer WHERE first_name = 'Pepe'), 2),
    ((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), 2),
    ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), 3),
    ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 3),
    ((SELECT customer_id FROM customer WHERE first_name = 'Pepe'), 3),
    ((SELECT customer_id FROM customer WHERE first_name = 'Jimmy'), 3),
    ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), 4),
    ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 4),
    ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 4),
    ((SELECT customer_id FROM customer WHERE first_name = 'John'), 4),
    ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 5),
    ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 5),
    ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 6),
    ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 6),
    ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), 7),
    ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 7),
    ((SELECT customer_id FROM customer WHERE first_name = 'Fabricio'), 7),
    ((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), 7),
    ((SELECT customer_id FROM customer WHERE first_name = 'Pickle'), 7),
    ((SELECT customer_id FROM customer WHERE first_name = 'Pepe'), 7),
    ((SELECT customer_id FROM customer WHERE first_name = 'John'), 7),
    ((SELECT customer_id FROM customer WHERE first_name = 'Jimmy'), 7),
    ((SELECT customer_id FROM customer WHERE first_name = 'Zack'), 8),
    ((SELECT customer_id FROM customer WHERE first_name = 'Fernanda'), 8),
    ((SELECT customer_id FROM customer WHERE first_name = 'Rick'), 9),
    ((SELECT customer_id FROM customer WHERE first_name = 'Mary'), 9),
    ((SELECT customer_id FROM customer WHERE first_name = 'John'), 9),
    ((SELECT customer_id FROM customer WHERE first_name = 'Jimmy'), 9);



SELECT * FROM  employee_job;
SELECT * FROM  employee_inoculation;
SELECT * FROM  employee_visa;
SELECT * FROM  customer_inoculation;
SELECT * FROM  customer_visa;
SELECT * FROM  destination_inoculation;
SELECT * FROM  destination_visa;
SELECT * FROM  employee_order;
SELECT * FROM  customer_order;
SELECT * FROM  trip_item;
SELECT * FROM  trip_excursion;
SELECT * FROM  employee_trip;
SELECT * FROM  customer_trip;
SELECT * FROM  job_responsibility;
SELECT * FROM  visa;
SELECT * FROM  inoculation;
SELECT * FROM  excursion;
SELECT * FROM  trip;
SELECT * FROM  destination;
SELECT * FROM  item;
SELECT * FROM  item_type;
SELECT * FROM  customer;
SELECT * FROM  employee;