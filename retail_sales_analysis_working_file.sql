
-- Retail Sales Analysis Project -- 

-- Create Table
--drop table if exists retail_sales;
/*
create table retail_sales
						(
							transaction_id int primary key,
							sale_date date, 
							sale_time time,
							customer_id int,
							gender varchar(15),
							age int,
							category varchar(15),
							quantity int,
							price_per_unit float,
							cogs float,
							total_sale float
						);

*/
/*
select * from retail_sales
limit 10;

select count(*) from retail_sales;

select count(distinct customer_id) from retail_sales;

select * from retail_sales 
where 
		transaction_id is null
		or
		sale_date is null
		or 
		sale_time is null
		or
		customer_id is null
		or
		gender is null
		or 
		age is null
		or
		category is null
		or
		quantity is null
		or 
		price_per_unit is null
		or
		cogs is null
		or 
		total_sale is null;

		
delete from retail_sales
where 
		transaction_id is null
		or
		sale_date is null
		or 
		sale_time is null
		or
		customer_id is null
		or
		gender is null
		or 
		age is null
		or
		category is null
		or
		quantity is null
		or 
		price_per_unit is null
		or
		cogs is null
		or 
		total_sale is null;

*/


-- Data Exploration --

-- No of Unique Customer
select count(distinct customer_id) as unique_costomers from retail_sales;

-- No of Transaction Occurred 
select count(*) as no_of_transactions from retail_sales;

-- Unique Categories
select distinct(category) from retail_sales;

-- No of Customers by Gender
select gender
	  ,count(*)
from retail_sales
group by gender;

-- Age Demographics by Customer
select min(age) as minimum_age
	   ,max(age) as maximum_age
from retail_sales;


-- Data Analysis & Business Key Problems & Answers --

-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * 
from retail_sales
where sale_date = '2022-11-05';

-- Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is atleast 4 in the month of Nov-2022:
select *
from retail_sales
where lower(category) = 'clothing'
 			and
	  (quantity >=4 and sale_date between '2022-11-01' and '2022-11-30');

-- Q3 Write a SQL query to calculate the total sales for each category.:	  
select category
	   ,sum(total_sale) as Net_Sales
from retail_sales
group by category;

-- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select round(avg(age),0) as average_age
from retail_sales
where lower(category) = 'beauty';

-- Q5 Write a SQL query to find all transactions where the sale is greater than 1000.:
select *
from retail_sales
where total_sale>1000;

-- Q6 Write a SQL query to find the total number of transactions made by each gender in each category.:
select category
	   ,gender
	   ,count(*) as no_of_transaction
from retail_sales
group by gender , category
order by category , gender;

-- Q7 Write a SQL query to calculate the average sale for each month. 
select to_char(sale_date,'mm') as month
		,round(cast(avg(total_amount)as numeric),2) as avg_sale
from (select sale_date
	         ,sum(total_sale) as total_amount
	  from retail_sales
	  group by sale_date) as sub
group by 	to_char(sale_date,'mm')
order by 1;

-- Q8 Write a SQL query to calculate the average sale for each month for every year.
select to_char(sale_date,'yyyy')
	   ,to_char(sale_date,'mm')
	   ,round(cast(avg(total_sales) as numeric),2)
from	   
		(select sale_date
			   ,sum(total_sale) as total_sales
		from retail_sales
		group by sale_date
		) as sub
group by  to_char(sale_date,'yyyy'),to_char(sale_date,'mm')	
order by 1,2;


-- Q9 Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id
	   ,sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;

-- Q10 Write a SQL query to find the number of unique customers who purchased items from each category.
select  category
	    ,count(distinct customer_id) as no_of_unique_customer
from retail_sales
group by category;

-- Q11 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
select shift
	   ,count(*) as total_orders
from	(select 
			   case
			   when sale_time<'12:00:00' then 'morning'
			   when sale_time between '12:00:00' and '17:00:00' then 'afternoon'
			   else 'evening'
			   end as shift
		 from retail_sales) as sub 
group by shift
order by total_orders;

-- END OF PROJECT--