-- Q1: What are the standard ingredients for each pizza?
Select pizza_name, group_concat(topping_name separator ' , ') 
as Standard_Toppings from temp_pizza_recipes 
join pizza_toppings using(topping_id) 
join pizza_names using(pizza_id) group by pizza_name;

-- Q2: What was the most commonly added extra?
select topping_name, count(record_id) from temp_customer_orders_extras tcoe
join pizza_toppings on tcoe.extras = pizza_toppings.topping_id  group by topping_name;

-- Q3: What was the most common exclusion?
select topping_name,count(*) from temp_customer_orders_exclusions tcoex
join pizza_toppings on tcoex.exclusions = pizza_toppings.topping_id  group by topping_name;

-- Q4: Generate an order item for each record in the customers_orders table in the format of one of the following:
		-- Meat Lovers
 		-- Meat Lovers - Exclude Beef
 		-- Meat Lovers - Extra Bacon
		-- Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
Select order_id, customer_id, pizza_name, ec.exclusions, et.extras,
 case when ec.exclusions is null and et.extras is null then pizza_name
	when ec.exclusions is not null and et.extras is null then concat(pizza_name, '- Exclude ', pt.topping_name)
    when ec.exclusions is null and et.extras is not null then concat(pizza_name, '- Extra ', pt2.topping_name)
    when ec.exclusions is not null and et.extras is not null 
		then concat(pizza_name, '- Exclude ', pt.topping_name, ' - Extra ', pt2.topping_name)
    end as order_item from temp_customer_orders
join pizza_names using(pizza_id)
join temp_customer_orders_exclusions ec using (record_id)
join temp_customer_orders_extras et using (record_id)
left join pizza_toppings pt on pt.topping_id = ec.exclusions 
left join pizza_toppings pt2 on pt2.topping_id = et.extras;       
        
-- Q5: Generate an alphabetically ordered comma separated ingredient list for each pizza order from the 
		-- customer_orders table and add a 2x in front of any relevant ingredients
		-- For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"
-- Work in Progress        

-- Q6: What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
-- Work in Progress        