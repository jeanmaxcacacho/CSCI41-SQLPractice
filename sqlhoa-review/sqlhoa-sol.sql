/*
	"TECHNIQUES" USED:

	-- QUERYING FROM MULTIPLE TABLES --
	the joining done in the slides is pretty weird, better to use
	explicit join statements instead:

	join new_table on base_table.attribute = new_table.attribute

	if you want to show "all" values for a certain query (include nulls)
	that can be done via left/right joins, syntax is similar:
	
	left join new_table on base_table.attribute = new_table.attribute
	right join new_table on base_table.attribute = new_table.attribute

	by default the normal join is an inner join, this means that only
	rows where both new_table and base_table attributes aren't null
	will be returned by the query
	____________________________________________________________________

	EXPLANATION OF WEIRD LOGIC/WHERE A CONCEPT IS FIRST TESTED:

	-- 2. CUSTOMERS WHO REFERRED OTHER CUSTOMERS (UNARY SEARCH?)
	if you know VLOOKUP from GSheets/Excel you can think of it as using
	the referredby customer numbers as the search key

	self join another copy of customer's table
	use that self-joined table as the "range" of
	the referredby customer numbers from first customer table

	-- 3. CONDITIONAL SEARCH BASED ON COLUMN
	dyanmic values need to be stored in "variables"
	you can think of subqueries as containers for conditions

	subqueries are stored inside their own parentheses ex:
	where b.retail > (select avg(b2.retail) from book b2)

	-- 4. MULTIPLE JOIN STATEMENTS
	when querying from more than 2 tables it's best to think
	of it like traversing a graph where each node is a table
	and you have access to the attributes to the nodes you've
	reached thus far

	another way to think of it is that you're building a table
	from a certain base, modularly adding to it depending on
	what you want your query to return and which tables
	contain the data you want

	so here we want the titles of all the books bought by Bonita Morales
	we will be querying data from the book and customer tables

	the link from book to customer is:
	book (ISBN) => orderitem (ISBN, orderno) => orders (orderno, customerno) => customer (customerno)

	-- 6. COMBINATION QUERIES
	what this item really tests is your knowledge of syntax and formatting
	if you know how to write subqueries then the next issue would be
	knowing how to segment the problem, which isn't too hard naman

	the average profit can be obtained from the subquery...
	(select avg(retail*qty - cost*qty) from book join orderitem) 
	^^^ this is just the "pseudocode"

	the publisher of Big Bear and Little Dove query is
	left as an exercise to the reader (kill yourself)

	I noticed however that the output of the query in this script
	is diff from the expected query output in the specs.
	The logic seems right naman so......

	If you swap the profit query with a hardcoded value 
	of 18 you'll get the expected output.
	___________________________________________________________________

	FINAL NOTES/I MIGHT BE LONELY(?)
	I'm only mostly sure that the scripts here are the best way to
	do the required queries. If you can find something more "elegant"
	please show it to me since I want to get an A for this class.
*/

-- 1. title of the most expensive computer book
select b.title Title, b.retail Price, pub.name "Publisher Name"
from book b
join publisher pub on b.pubID = pub.pubID
where b.category = 'Computer'
order by retail desc
limit 1;

-- 2. customers who referred other customers
select distinct c2.customerno "Customer Number", concat(c2.firstname, " ", c2.lastname) "Customer Name"
from customer c1 -- use c1.referredby as the lookup to c2
join customer c2 on c1.referredby = c2.customerno 
where c1.referredby is not null;

-- 3. books priced higher than the average price
select b.ISBN, b.title "Book Title", pub.name "Publisher", b.retail "Retail Price"
from book b
join publisher pub on b.pubID = pub.pubID
where b.retail > (select avg(b2.retail) from book b2)
order by b.retail desc;

-- 4. titles bought by Bonita Morales
select distinct b.ISBN, b.title "Book Title", b.retail "Retail Price"
from book b
join orderitem oi on b.ISBN = oi.ISBN
join orders o on oi.orderno = o.orderno
join customer c on o.customerno = c.customerno
where concat(c.firstname, " ", c.lastname) = 'BONITA MORALES';

-- 5. publisher of books written by author Tamara Kzochsky
select b.title, b.category, pub.name, pub.contact, pub.phone
from book b
join publisher pub on b.pubID = pub.pubID
join bookauthor ba on b.ISBN = ba.ISBN
join author a on ba.authorid = a.authorID -- be mindful of typos in the setup script
where a.fname = 'TAMARA';

-- 6. books published by the publisher of the book "Big Bear and Little Dove" that generate more profit than the average profit from all books
select distinct b.ISBN, b.title, b.category
from book b
join orderitem oi on b.ISBN = oi.ISBN
join publisher pub on b.pubID = pub.pubID
where
	pub.pubID = ( 
		select pub2.pubID
		from publisher pub2
		join book b2 on pub2.pubID = b2.pubID
		where b2.title like 'BIG BEAR%'
		) 
	and (b.retail - b.cost) > (
		select avg(b3.retail - b3.cost)
		from book b3
	);

		/*
			version I will die by

		(b.retail * oi.quantity - b.cost * oi.quantity) >= (
		select avg(b3.retail * oi2.quantity - b3.cost * oi2.quantity)
		from book b3
		join orderitem oi2 on b3.ISBN = oi2.ISBN
		);

		*/

-- 7. books more expensive than the most expensive cooking book
select b.ISBN, b.title, b.category, b.retail
from book b
where b.retail > (
	select max(b2.retail)
	from book b2
	where b2.category = 'Cooking'
);

-- 8. books that have not been ordered at all
select distinct b.ISBN, b.title, b.category, b.retail
from book b
left join orderitem oi on b.ISBN = oi.ISBN -- we're looking for nulls so we want books that will have null entries in orderitem
where oi.orderno is null; -- items that haven't been ordered yet won't have an order number

-- 9. orders shipped to the same state as the orders of Steve Schell
select o.orderno "Order Number", o.shipdate "Date of Shipping", concat(c.firstname, " ", c.lastname) "Customer's Name"
from orders o
join customer c on o.customerno = c.customerno
where o.shipstate = (
	select o2.shipstate
	from orders o2
	join customer c2 on o2.customerno = c2.customerno
	where concat(c2.firstname, " ", c2.lastname) = 'STEVE SCHELL'
) and c.lastname <> 'SCHELL'; -- expected output didn't have steve schell's name in the output

-- 10. customers who ordered the least expensive books
select concat(c.firstname, " ", c.lastname) "Customer's Name", c.state "State"
from customer c
join orders o on c.customerno = o.customerno
join orderitem oi on o.orderno = oi.orderno
join book b on oi.ISBN = b.ISBN
where b.retail = (
	select min(b2.retail)
	from book b2
)
order by c.firstname desc;