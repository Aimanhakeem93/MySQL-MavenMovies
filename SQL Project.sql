select *
from address;

select *
from store;

select *
from country;

select *
from city;

select *
from staff;

select *
from inventory;

select *
from film;

select *
from film_category;

select *
from category;

select *
from customer;

select *
from rental;

select *
from payment;

select *
from investor;

select *
from advisor;

select *
from actor;

select *
from actor_award;

/* 1- Retrieves information about the staff members, and location 
information.
*/
select staff.first_name, staff.last_name, address.address, address.district, city.city, country.country
from staff 
join store on store.store_id = staff.store_id
join address on address.address_id = store.address_id
join city on city.city_id = address.city_id
join country on country.country_id = city.country_id;

/* 2- Retrieves specific details of films present in the inventory table
*/
select i.store_id, i.inventory_id, f.title, f.rating, f.rental_rate, f.replacement_cost
from inventory as i
join film as f on f.film_id = i.film_id;

/* 3- Retrieve inventory and film ratings for each store. 
*/
select i.store_id, count(i.inventory_id) as inventory, count(distinct f.rating) as rating
from inventory as i
join film as f on f.film_id = i.film_id
group by i.store_id;

/* 4- Retrieve film counts, average replancement cost, and sum
replacement cost for each store. Then, divide it by category.
*/
select i.store_id, count(f.title) as total_film, avg(f.replacement_cost) as avg_replacement_cost, sum(f.replacement_cost) as sum_replacement_cost
from film as f
join inventory as i on i.film_id = f.film_id
group by i.store_id;
 
select c.name, count(f.title) as total_film, avg(f.replacement_cost) as avg_replacement_cost, sum(f.replacement_cost) as sum_replacement_cost
from film as f
join film_category as m on m.film_id = f.film_id
join category as c on c.category_id = m.category_id
group by c.name;

/* 5- Retrieve information about customers with their status, address
details, city, and country information.
*/
select c.first_name, c.last_name,
	case
		when c.active = 1 then 'active'
        else 'not active'
	end as status, a.address, i.city, o.country
from customer as c
join address as a on a.address_id = c.address_id
join city as i on i.city_id = a.city_id
join country as o on o.country_id = i.country_id;

/* 6- List each customer's first name and last name, along with the
total rental duration and the total payment amount.
*/
select distinct c.first_name, c.last_name, sum(f.rental_duration) as total_rental, sum(amount) as total_payment
from customer as c
join inventory as i on i.store_id = c.store_id
join film as f on f.film_id = i.film_id
join rental as r on r.customer_id = c.customer_id
join payment as p on p.rental_id = r.rental_id
group by c.first_name, c.last_name
order by total_rental desc;

/* 7- Combines the results of two SELECT queries using UNION operator
*/
select 'investor' as type, first_name, last_name
from investor
union
select 'advisor' as type, first_name, last_name
from advisor;