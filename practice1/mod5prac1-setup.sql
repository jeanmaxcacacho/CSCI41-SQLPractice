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

create table book(
    title_id int auto_increment primary key,
    title varchar(255) not null,
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

create table author(
    author_id int auto_increment primary key,
    name varchar(255) not null,
    address varchar(255),
    contract varchar(255)
);