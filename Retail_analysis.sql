---Create table
drop table if exists Retail_sales;
Create table Retail_Sales 
(
transactions_id INT PRIMARY KEY,
sale_date Date,
sale_time TIME,
customer_id	INT,
gender	VARCHAR(15),
age	INT,
category VARCHAR(15),
quantiy	INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

select * from Retail_sales;

select count (*) from retail_sales;

SELECT current_database();
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT COUNT(*) FROM public.retail_sales;

SELECT *
FROM public.retail_sales
LIMIT 10;

Select sum(cogs)
from retail_Sales;


select * from public.retail_sales
where transactions_id is null;

select * from public.retail_sales
where 
sale_time is null
or sale_date is null
or gender is null
or age is null
or quantiy is null
or category is null
or cogs is null
or total_Sale is null
or price_per_unit is null;

--- delete from retail_Sales

Delete from public.retail_sales
where 
sale_time is null
or sale_date is null
or gender is null
or age is null
or quantiy is null
or category is null
or cogs is null
or total_Sale is null
or price_per_unit is null;


-- data exploration

-- How many sales we have 
select count (*)
from retail_Sales;
-- hoe many customer we have
select count (Distinct customer_id)
from retail_Sales;

--how many unique category

select count (Distinct category)
from retail_Sales;

--
select Distinct category
from retail_Sales;

--Data Analysis (Business key problem and answers)
--My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05,

Select * from retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01';


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

Select category, sum(total_Sale) as net_sale,
count (*) as total_orders
from retail_Sales
group by category;

---Q. 4 Avg agae of customer who purchased from Beauty category?
select
Round(avg(age),2) as avg_age
from retail_Sales
where category= 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

Select * from retail_sales
where total_Sale > 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category, gender, count(*)
from retail_Sales
group by category, gender
order by category DESC;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
with cte as
(select 
extract (year from sale_date)as y2,
extract (month from sale_date) as month,
round (avg (total_Sale)::numeric, 2) as avg_sale,
rank() over (
partition by extract(year from sale_date) 
ORDER by avg(total_Sale) DESC
)as rank
from Retail_Sales
group by 1,2
order by 1,2
)
select
y2, month, avg_Sale
from cte
where rank = 1;



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id, 
sum(total_Sale)as sales
from retail_Sales
Group by customer_id
order by sales DESC
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category, count(distinct customer_id) as unique_customer
from retail_Sales
group by category;



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


select * from retail_Sales;

Select
case when extract(hour from sale_time)< 12 then 'Morning'
when extract(hour from sale_time) Between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift,
Count (transactions_id) as no_orders
from retail_Sales
Group by shift;

--- End of Project





