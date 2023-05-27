# Pizza_Runner
 ## __Introduction__
  Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”

Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.
 ## __Dataset__
 Original <a href =https://github.com/Rakshit-Sharma-001/Case_Study_2-Pizza_Runner/blob/main/Schema.sql >schema</a> for this case study. A;; data is inserted after creating original tables in this schema.

- runners : The table shows the registration_date for each new runner
- customer_orders : Customer pizza orders are captured in the customer_orders table with 1 row for each individual pizza that is part of the order. The pizza_id relates to the type of pizza which was ordered whilst the exclusions are the ingredient_id values which should be removed from the pizza and the extras are the ingredient_id values which need to be added to the pizza.
- runner_orders : After each orders are received through the system - they are assigned to a runner - however not all orders are fully completed and can be cancelled by the restaurant or the customer. The pickup_time is the timestamp at which the runner arrives at the Pizza Runner headquarters to pick up the freshly cooked pizzas. The distance and duration fields are related to how far and long the runner had to travel to deliver the order to the respective customer.
- pizza_names : Pizza Runner only has 2 pizzas available the Meat Lovers or Vegetarian!
- pizza_recipes : Each pizza_id has a standard set of toppings which are used as part of the pizza recipe.
- pizza_toppings : The table contains all of the topping_name values with their corresponding topping_id value

# __ER Diagram__
 (https://github.com/Rakshit-Sharma-001/Case_Study_2-Pizza_Runner/assets/133633861/07c9ead3-a256-4331-bc21-07a8903af27e)
## __Data_Classification__
Data is formatted in <a href = https://github.com/Rakshit-Sharma-001/Case_Study_2-Pizza_Runner/blob/main/Formatting%20Initial%20Data.sql>This_file</a>. 
1. Table 'temp_customer_orders' is created from original 'customer_orders' to convert either null keyword or null values in columns 'exclusions' and 'extras' into '', because both columns are of varchar type. A new column 'record_id' is added at the end of this new table to keep record of every entry. 
2. Two new tables are created from 'temp_customer_orders' i.e. 'temp_customer_orders_extras' and 'temp_customer_orders_exclusions' to keep record of toppings added and removed to/from pizza. Now, columns(extras and exclusions) having values = '' are changed to NULL and then their datatypes are changed to Int through Alter Table statement.
3. A new table is created 'temp_runner_orders' from original table 'runner_orders' to change null keyword to NULL in pickup_time, dstance, duration and cancellation columns. Also, in create statement, keywords like (km, min, minute, minutes) are removed from numbers. Then datatype of  different columns are changed using Alter Table statement to match their column values.
4. A new table 'temp_pizza_recipes' is created from  'pizza_recipes' to convert comma-separated rows into different values. Then the datatype of Topping_id is changed to Int for better usage. 

At the end of both original and formatted SQL files, select statements are used to confirm whether are operations are doen correctly or not. 
# __SQL-Queries__
All Questions have been distributed into 4 sections, you can check them from here. Some code might be missing, as I am still working on them. Will update file once completed. Fell free to start any issue for any question ad suggestions. 
