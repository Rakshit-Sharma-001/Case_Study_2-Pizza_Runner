__ Part-B Runner and Customer Experience __ 

-- Q1: How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT weekofyear(registration_date+3) as 'week', count(runner_id) as Runners_singed_up FROM pizza_runner.runners group by week ;

-- Q2: What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
select runner_id, round(avg(timestampdiff(minute,order_time,pickup_time)),1) as Avg_Pickup_time from temp_customer_orders 
join temp_runner_orders using(order_id) where cancellation = ' ' group by runner_id order by runner_id;

-- Q3: Is there any relationship between the number of pizzas and how long the order takes to prepare?
select order_id,count(pizza_id) as 'Pizza_count',sum(timestampdiff(minute,order_time,pickup_time)) as 'Total_Time_Taken'
from temp_customer_orders join temp_runner_orders using(order_id) 
where cancellation = ' ' group by order_id order by Pizza_count desc;

-- Q4: What was the average distance travelled for each customer?
select customer_id, round(avg(distance),2) as Avg_Distance from temp_customer_orders join temp_runner_orders 
using (order_id) where cancellation = ' ' group by customer_id ;

-- Q5: What was the difference between the longest and shortest delivery times for all orders?
select max(duration)-min(duration) as diff_longest_shortest_order from temp_runner_orders; 

-- Q6: What was the average speed for each runner for each delivery and do you notice any trend for these values?
select runner_id, order_id, round((distance*60)/duration,2) as Avg_speed from temp_runner_orders 
where cancellation = ' ' order by runner_id, order_id;

-- Q7: What is the successful delivery percentage for each runner?
SELECT runner_id,round(count(distance)/count(order_id)*100) as Success_Delivery
FROM pizza_runner.temp_runner_orders group by runner_id;
