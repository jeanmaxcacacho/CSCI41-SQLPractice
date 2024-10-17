-- rows for book titles containing the letter 'u'
select *
from book b
where b.title like '%u%';

-- name of author where book price < 600
select b.author_name
from book b
where b.price < 600;

-- titles and prices of books where price (x) 50 <= x <= 500
-- expected result is wrong............?
select b.title, b.price
from book b
where b.price between 50 and 500;

-- book id and title of 10 cheapest books
-- girl with dragon tattoo will not be here since
-- I will not do the insertion exercises
select b.book_id, b.title
from book b
order by b.price
limit 10;

-- book titles in LotR and ASoIaF series
select b.title
from book b
where b.title like 'Lord of the Rings%' or b.title like 'A Song of Ice and Fire%';

-- book titles sorted by publisher then author
-- again steig larsson will not be here because I did not insert them
select b.title "Title of Book", b.author_name "Name of Author", pub.name "Name of Publisher"
from book b
join publisher pub on b.pub_id = pub.pub_id
order by pub.name, b.author_name;

-- authors has name with T
-- again steig larsson will not be here because I did not insert them
select distinct b.author_name "Author has Name with T"
from book b
where b.author_name like '%T%' or b.author_name like '%t%';