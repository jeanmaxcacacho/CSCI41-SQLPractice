-- yes I copied the HOA setup creation script
drop database pubs;
create database pubs;
use pubs;

drop table publisher;
drop table book;

create table publisher(
    pub_id int auto_increment primary key,
    name varchar(255) not null,
    city varchar(255) default 'Quezon City',
    state varchar(255) default 'NCR',
    country varchar(255) default 'Philippines',
    pr_info text
);

create table author(
    author_id int auto_increment primary key,
    name varchar(255) not null,
    address varchar(255),
    contract varchar(255)
);

create table book(
    title_id int auto_increment primary key,
    title varchar(255) not null,
    author_name varchar(255) not null,
    author_address varchar(255),
    author_contract varchar(255),
    price float(2) not null,
    advance float(2),
    royalty float(2),
    notes text,
    pubdate date not null,
    pub_id int,
    author_id int,
    foreign key (pub_id) references publisher(pub_id) on delete restrict,
    foreign key (author_id) references author(author_id) on delete restrict
);

-- value insertion from original setup script
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

-- bonus challenge compounded insertion
insert into author(name, address, contract)
select distinct b.author_name, b.author_address, b.author_contract
from book b
where b.author_name is not null;