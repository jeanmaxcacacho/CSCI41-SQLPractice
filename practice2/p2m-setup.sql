-- Creating the Database
DROP DATABASE pubs;
CREATE DATABASE pubs;
USE pubs;
DROP TABLE book;
DROP TABLE publisher;

-- Creating Tables
CREATE TABLE publisher(
  pub_id      INT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
  name        VARCHAR(255) NOT NULL,
  city        VARCHAR(255) DEFAULT 'Quezon City',
  state       VARCHAR(255) DEFAULT 'NCR',
  country     VARCHAR(255) DEFAULT 'Philippines',
  pr_info     TEXT
);

CREATE TABLE book(
  book_id        INT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
  title           VARCHAR(255) NOT NULL,
  author_name     VARCHAR(255) NOT NULL,
  author_address  VARCHAR(255),
  author_contract VARCHAR(255),
  price           FLOAT(2) NOT NULL,
  advance         FLOAT(2),
  royalty         FLOAT(2),
  notes           TEXT,
  pubdate         DATE NOT NULL,
  pub_id          INT NOT NULL,
  FOREIGN KEY (pub_id) REFERENCES publisher(pub_id) ON DELETE RESTRICT
);

-- Inserting Data into Tables
INSERT INTO publisher(name) VALUES('Mania Books Ltd');
INSERT INTO publisher(name) VALUES('Prentice Hall');

INSERT INTO book(title,author_name,author_address,author_contract,price,advance,royalty,pubdate,pub_id)
VALUES 
('Modern Database Management','Jeffrey A. Hoffer','Makati City','1 year',499.50,1000000,0.15,CURDATE(),2),
('Hubad na Uhaw','Rodrigo Rodriguez','Mexico City','1 year',25.00,6000,0.10,CURDATE(),1),
('Asupreng Alapaap','Rodrigo Rodriguez','Mexico City','1 year',250.00,1000,0.10,CURDATE(),1),
('Musmos sa Buwan','Rodrigo Rodriguez','Mexico City','1 year',250.00,1000,0.10,CURDATE(),1),
('Gora in Keribels Land','Rodrigo Rodriguez','Mexico City','1 year',250.00,1000,0.10,CURDATE(),1),
('Lord of the Rings: Fellowship of the Ring','John Lloyd Tolkien','London City','1 year',600.00,1000,0.10,CURDATE(),2),
('Lord of the Rings: The Two Towers','John Lloyd Tolkien','London City','1 year',600.00,1000,0.10,CURDATE(),2),
('Lord of the Rings: Return of the King','John Lloyd Tolkien','London City','1 year',600.00,1000,0.10,CURDATE(),2),
('A Song of Ice and Fire: A Game of Thrones','George Rogelio Reyes Martin','Utah City','1 year',900.00,6000,0.10,'1996-08-01',2),
('A Song of Ice and Fire: A Storm of Swords','George Rogelio Reyes Martin','Utah City','1 year',900.00,90000,0.10,'1998-08-01',2),
('A Song of Ice and Fire: A Clash of Kings','George Rogelio Reyes Martin','Utah City','1 year',900.00,90000,0.10,'2000-08-01',2),
('A Song of Ice and Fire: A Feast of Crows','George Rogelio Reyes Martin','Utah City','1 year',900.00,90000,0.10,'2005-08-015',2),
('A Song of Ice and Fire: A Dance with Dragons','George Rogelio Reyes Martin','Utah City','1 year',900.00,90000,0.10,'2006-08-01',2),
('A Song of Ice and Fire: The Winds of Winter','George Rogelio Reyes Martin','Utah City','1 year',900.00,90000,0.10,'2007-08-01',2),
('A Song of Ice and Fire: A Dream of Spring','George Rogelio Reyes Martin','Utah City','1 year',900.00,90000,0.10,CURDATE(),2);