-- Formatting Tables and Data

Create table temp_customer_orders as 
	Select order_id, customer_id,pizza_id,
	case when exclusions is null or exclusions = 'null' then '' else exclusions end as exclusions,
	case when extras is null or extras = 'null' then '' else extras end as extras,
	order_time from customer_orders;

alter table temp_customer_orders add column record_id int Not null primary key auto_increment;

Create table temp_customer_orders_extras as
select record_id, trim(substring_index(substring_index(extras, ',', n), ',', -1)) as extras
from temp_customer_orders
cross join ( select 1 as n union all select 2 union all select 3) as numbers
where n<=1 + length(extras)-length(replace(extras, ',', ''));

update temp_customer_orders_extras set extras = 0 where extras = '';
alter table temp_customer_orders_extras modify column extras int;
update temp_customer_orders_extras set extras = NULL where extras = 0;

Create table temp_customer_orders_exclusions as
select record_id, trim( substring_index(substring_index(exclusions, ',',   n), ',', -1)) as exclusions
from temp_customer_orders 
cross join ( select 1 as n union all select 2 union all select 3) as numbers
where n<=1 + length(exclusions)-length(replace(exclusions, ',', ''));

update temp_customer_orders_exclusions set exclusions = 0 where exclusions = '';
alter table temp_customer_orders_exclusions modify column exclusions int;
update temp_customer_orders_exclusions set exclusions = null where exclusions = 0;


CREATE TABLE temp_runner_orders AS
SELECT order_id, runner_id, 
	CASE WHEN pickup_time = 'null' THEN NULL ELSE pickup_time END AS pickup_time,
	CASE WHEN distance = 'null' THEN NULL
     WHEN distance LIKE '%km' THEN TRIM('km' from distance)
     ELSE distance END AS distance,
	CASE WHEN duration = 'null' THEN NULL
     WHEN duration LIKE '%mins' THEN TRIM('mins' from duration)
     WHEN duration LIKE '%minute' THEN TRIM('minute' from duration)
     WHEN duration LIKE '%minutes' THEN TRIM('minutes' from duration)
     ELSE duration END AS duration,
	CASE WHEN cancellation IS NULL or cancellation = 'null' THEN ' ' ELSE cancellation END AS cancellation
FROM runner_orders;

alter table temp_runner_orders modify pickup_time datetime;

alter table temp_runner_orders modify distance float;

alter table temp_runner_orders modify duration int;

update temp_runner_orders set cancellation = ' ' where runner_id =1;

create table temp_pizza_recipes as select pizza_id, substring_index(substring_index(toppings, ',',n), ',',-1) 
as topping_id from pizza_recipes
cross join (select 1 as n union all select 2 union all select 3 union all select 4 union all select 5
	union all select 6 union all select 7 union all select 8 ) as numbers
where n <= 1+ length(toppings)- length(replace(toppings,',','' )) order by pizza_id;

alter table temp_pizza_recipes modify topping_id int;

-- Verifying Entered Data

select * from temp_customer_orders;

select * from temp_runner_orders;

select * from temp_pizza_recipes;

select * from temp_customer_orders_exclusions;

select * from temp_customer_orders_extras;
