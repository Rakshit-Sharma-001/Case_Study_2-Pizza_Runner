-- Q1: If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has 
		# Pizza Runner made so far if there are no delivery fees?
        
select sum(case when pizza_id = 1 then 12 else 10 end)as Total_amount_made
from temp_runner_orders join temp_customer_orders using(order_id)  where cancellation = ' ';

-- Q2: What if there was an additional $1 charge for any pizza extras?   Add cheese is $1 extra

with cte1 as
(select sum(case when pizza_id = 1 then 12 else 10 end)as Total_amount
from temp_runner_orders join temp_customer_orders using(order_id) where cancellation = ' '),

cte2 as
(select sum(case when tcoe.extras = 0 then 0 when tcoe.extras =1 then 1  else 2 end ) as Extra_Tip
from temp_runner_orders join temp_customer_orders using(order_id)
join temp_customer_orders_extras tcoe using(record_id) where cancellation = ' ')
select Total_amount,Extra_Tip, (Total_amount+Extra_tip) as Grand_total from cte1 join cte2;

-- Q3: The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, 
	# how would you design an additional table for this new dataset - generate a schema for this new table and insert your 
    # own data for ratings for each successful customer order between 1 to 5.
create table ratings(order_id int, rating int);

insert into ratings values (1,3), (2,4), (3,5), (4,2), (5,1), (7,4), (8,1), (10,5); 

select * from ratings order by rating;

-- Q4: Using your newly generated table - can you join all of the information together to form a table which has the 
		# following information for successful deliveries?
		# customer_id
 		# order_id
 		# runner_id
 		# rating
		# order_time
 		# pickup_time
 		# Time between order and pickup
 		# Delivery duration
 		# Average speed
 		# Total number of pizzas

with cte1 as (select order_id, count(*) as Pizzas_ordered from temp_runner_orders join temp_customer_orders using(order_id) 
where cancellation = ' ' group by order_id)

SELECT distinct cte1.order_id,customer_id, runner_id,rating, order_time,pickup_time, 
timestampdiff(minute,order_time,pickup_time) as Time_difference,
duration, round((distance*60)/duration,2) as Avg_speed, Pizzas_ordered
FROM pizza_runner.temp_runner_orders join temp_customer_orders using(order_id)
join ratings using (order_id) join cte1 using(order_id) where cancellation = ' ' order by customer_id;

-- Q5: If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid 
		# $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

with cte1 as
(select sum(case when pizza_id = 1 then 12 else 10 end)as Total_amount
from temp_runner_orders join temp_customer_orders using(order_id) where cancellation = ' '),

cte2 as
(select round(sum(distance),1) as Total_distance 
from temp_runner_orders where cancellation = ' ' )
select Total_amount, Total_distance, round((Total_distance*0.3),2) as Revenue,
(Total_amount - (Total_distance*0.3)) as Money_left from cte1 join cte2;