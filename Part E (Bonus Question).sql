-- Q: If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an INSERT statement 
	# to demonstrate what would happen if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?

insert into pizza_names value(3,'Supreme');
select * from pizza_names;

insert into temp_pizza_recipes values(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,10),(3,11),(3,12);
select * from temp_pizza_recipes;
