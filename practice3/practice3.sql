-- orders of customers living in florida sorted by order date (then name)
select 
    c.customerno 'Customer Number',
    concat(c.firstname, ' ', c.lastname) 'Customer Name',
    o.orderno 'Order Number',
    o.orderdate 'Date of Order',
    o.shipdate 'Date of Shipping'
from
    orders o
join customer c on o.customerno = c.customerno
where c.state = 'FL'
order by o.orderdate, concat(c.firstname, ' ', c.lastname);

-- who should be contacted when children's books are needed?
select
    pub.contact 'Contact Name',
    pub.name 'Publisher Name',
    pub.phone 'Phone'
from publisher pub
join book b on pub.pubID = b.pubID
where b.category = 'Children';

-- who are the authors on family books
select
    b.title 'Book Title',
    concat(a.fname, ' ', a.lname)
from book b
join bookauthor ba on b.ISBN = ba.ISBN
join author a on ba.authorid = a.authorID
where b.category = 'Family Life';

-- how many different items were ordered by jake lucas on March 31, 2003?
select
    o.orderno,
    count(oi.itemno) 'Number of Items'
from orders o
join customer c on o.customerno = c.customerno
join orderitem oi on o.orderno = oi.orderno
where o.orderdate = '2003-03-31' and concat(c.firstname, ' ', c.lastname) = 'JAKE LUCAS';

-- customers referred by other customers ordered by customerno referred customer
select
    concat(c1.firstname, ' ', c1.lastname) 'Customer Name',
    concat(c2.firstname, ' ', c2.lastname) 'Referred By'
from customer c1
join customer c2 on c1.referredby = c2.customerno
where c1.referredby is not null
order by c1.customerno;

-- match customers with their orders, show customers also with no orer
select
    c.customerno 'Customer Number',
    concat(c.firstname, ' ', c.lastname) 'Customer Name',
    o.orderno 'Order Number',
    o.orderdate 'Order Date'
-- we're gonna do a left join to show empty orders
-- if orders as base table then use right join????????
from customer c 
left join orders o on c.customerno = o.customerno;

-- books ordered by Leila Smith
select distinct
    b.title,
    b.category
from book b
join orderitem oi on b.ISBN = oi.ISBN
join orders o on oi.orderno = o.orderno
join customer c on o.customerno = c.customerno
where concat(c.firstname, ' ', c.lastname) = 'LEILA SMITH'
order by b.category;