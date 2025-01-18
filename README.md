# Retail Sales Analysis SQL Project
## Project Overview
This project explores and analyzes retail sales data using SQL, covering table creation, data exploration, and solving business problems. It includes transaction details, customer demographics, and product categories, providing insights into sales trends, customer behavior, and performance metrics through structured queries.

## Objectives

1. **Set up a Retail Sales Database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.


## Project Structure

### 1. **Database Setup**
- **Database Creation**: The project starts by creating a database named `Retail_Sales_Analysis`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for:
  - Transaction ID
  - Sale Date
  - Sale Time
  - Customer ID
  - Gender
  - Age
  - Product Category
  - Quantity Sold
  - Price per Unit
  - Cost of Goods Sold (COGS)
  - Total Sale Amount

```sql
CREATE DATABASE Retail_Sales_Analysis
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
```

### 2. **Data Exploration & Cleaning**
- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select count(*) as no_of_records from retail_sales;

select count(distinct customer_id) as unique_costomers from retail_sales;

select distinct(category) from retail_sales;

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
```
### 3. **Data Analysis & Findings**

The following SQL queries were developed to answer specific business questions:

#### **Q1: Retrieve All Columns for Sales Made on '2022-11-05'**
```sql
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';
```
#### **Q2: Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is atleast 4 in the month of Nov-2022**
```sql
select *
from retail_sales
where lower(category) = 'clothing'
 			and
	  (quantity >=4 and sale_date between '2022-11-01' and '2022-11-30');
```
#### **Q3: Write a SQL query to calculate the total sales for each category.**	  
```sql
select category
	   ,sum(total_sale) as Net_Sales
from retail_sales
group by category;
```
#### **Q4: Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
```sql
select round(avg(age),0) as average_age
from retail_sales
where lower(category) = 'beauty';
```

#### **Q5: Write a SQL query to find all transactions where the sale is greater than 1000.**
```sql
select *
from retail_sales
where total_sale>1000;
```

#### **Q6: Write a SQL query to find the total number of transactions made by each gender in each category.**
```sql
select category
	   ,gender
	   ,count(*) as no_of_transaction
from retail_sales
group by gender , category
order by category , gender;
```
#### **Q7: Write a SQL query to calculate the average sale for each month. **
```sql
select to_char(sale_date,'mm') as month
		,round(cast(avg(total_amount)as numeric),2) as avg_sale
from (select sale_date
	         ,sum(total_sale) as total_amount
	  from retail_sales
	  group by sale_date) as sub
group by 	to_char(sale_date,'mm')
order by 1;
```
#### **Q8: Write a SQL query to calculate the average sale for each month for every year.**
```sql
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
```
#### **Q9: Write a SQL query to find the top 5 customers based on the highest total sales.**
```sql
select customer_id
	   ,sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;
```
#### **Q10: Write a SQL query to find the number of unique customers who purchased items from each category.**
```sql
select  category
	    ,count(distinct customer_id) as no_of_unique_customer
from retail_sales
group by category;
```
#### **Q11: Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):**
```sql
select shift
	   ,count(*) as total_orders
from	   
		(select 
				case
					when sale_time<'12:00:00' then 'morning'
					when sale_time between '12:00:00' and '17:00:00' then 'afternoon'
					else 'evening'
					end as shift
		from retail_sales) as sub 
group by shift
order by total_orders
```

### Findings
- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis reveals variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

---

### Reports
1. **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
2. **Trend Analysis**: Insights into sales trends across different months and shifts.
3. **Customer Insights**: Reports on top customers and unique customer counts per category.

---

### Conclusion
This project demonstrates the power of SQL in analyzing retail sales data to uncover actionable insights. By exploring customer demographics, sales trends, and high-value transactions, businesses can make data-driven decisions to optimize performance and improve customer satisfaction.









