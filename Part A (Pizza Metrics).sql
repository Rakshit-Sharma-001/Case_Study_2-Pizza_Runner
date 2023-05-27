***-- Part A : Pizza Metrics***

**-- q1**

select count(pizza_id) as Pizza_Order_Count from temp_customer_orders;

-- q2
select count(distinct order_id) as Unique_Orders from temp_customer_orders;

-- q3
select runner_id,count(*) as successful_orders from temp_runner_orders where cancellation= ' ' group by runner_id;

-- q4
select pn.pizza_name, count(ro.order_id) as 'Pieces_delivered' from temp_runner_orders ro 
join temp_customer_orders c on ro.order_id = c.order_id 
join pizza_names pn on pn.pizza_id = c.pizza_id
where cancellation= ' ' group by pn.pizza_name;

-- q5
select customer_id, pizza_name, count(order_id) as No_of_Orders from temp_customer_orders c 
 join pizza_names pn on pn.pizza_id = c.pizza_id  
 group by customer_id, pizza_name order by customer_id;

-- q6
with cte as (select order_id, pizza_id, row_number() over(partition by order_id order by pizza_id ) as rank_no 
from temp_customer_orders join temp_runner_orders ro using (order_id) where cancellation = ' ' )
select order_id,rank_no as Max_Pizza_delivered from cte where rank_no = (select max(rank_no) from cte) ;

-- q7
select customer_id,
count(case when exclusions <> '' or extras <> '' then 1 end) as 'Changed',
count(case when exclusions = '' and extras = '' then 1 end) as Unchanged
from temp_customer_orders join temp_runner_orders using (order_id) where cancellation = ' ' 
group by customer_id order by customer_id;

-- q8
SELECT * FROM pizza_runner.temp_customer_orders join temp_runner_orders using (order_id) 
where exclusions <> '' and extras <> '' and cancellation = ' ' ;

-- q9
SELECT hour(order_time) as hour_of_day,count(*) aspizza_count FROM pizza_runner.temp_customer_orders  
group by hour_of_day order by hour_of_day ;

-- q10
select dayname(order_time) as weekday, count(*) as pizza_count from temp_customer_orders group by weekday ;
