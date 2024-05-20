#Data Wrangling: This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.
# 1.Build a database
# 2.Create table and insert the data.
# 3.Select columns with null values in them. There are no null values in our database as in creating the tables, we set NOT NULL for each field, hence null values are filtered out.

CREATE table IF NOT EXISTS sales(
 invoice_id varchar (30) not null primary key,
 branch varchar (5) not null,
 city varchar (30) not null,
 customer_type varchar (30) not null,
 gender varchar (10) not null,
 product_line varchar (100) not null,
 unit_price decimal (10, 2) not null,
 quatity int not null,
 VAT float (6, 4) not null,
 total decimal (12, 4) not null,
 date datetime not null,
 time Time not null,
 payment_method varchar (15) not null,
 cogs decimal (10, 2) not null,
 gross_margin_pct float (11, 9),
 gross_income decimal (12, 4) not null,
 rating float (2,1)
 );
------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Add a new colum named time_of_day to give insight of sales in the morning,afternoon and evening. This will help answer the question on which part of the day most sales are made
-----------------------------------------------------------------------------------------------------------------------------------------------------------
Select time,
 ( Case
 when `time` between "00:00:00" and "12:00:00" then "Morning"
 when `time` between "12:01:00" and "16:00:00" then "Afternoon"
 else "Evening"
end 
 ) as time_of_day
 from sales;
 
 alter TABLE sales ADD column time_of_day varchar(20);
 
 update sales
 set time_of_day = ( 
 Case
	when `time` between "00:00:00" and "12:00:00" then "Morning"
	when `time` between "12:01:00" and "16:00:00" then "Afternoon"
	else "Evening"
end 
 );
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 #Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed,Thur,Fri). This will help answer the question on which week of the day each branch is busiest.

Select 
	date,
    dayname(DATE)
From sales;		

ALTER TABLE sale add column day_name varchar(10);

UPDATE sales
set day_name= dayname(date);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

Select 
	date,
    monthname(DATE)
    FROM sales;
alter table sales add column month_name varchar (10);
update sales
set month_name = monthname(date);

#Rename an existing column quatity to quantity

alter table sales
rename column quatity to quantity;

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#--------------------------GENERIC-----------------------------------------------

#How many unique cities does the data have
Select  count(distinct city) as number_of_cities
from sales;

#In which city is each branch?
Select distinct city, branch
from sales;

#*************************************************************************************************************************************************
#**************************************************Product******************************************************************************************

#How many unique product lines does the data have?

Select
	count(Distinct product_line)
    from sales;
    
#What is the most common payment method?
Select payment_method, count(*)as cnt from sales
group by payment_method
order by cnt desc;

#What is the most selling product line?
Select product_line, count(*)as cnt from sales
group by product_line
order by cnt desc;

#What is the total revenue by month?
select month_name as month, round(sum(total),2) as total_revenue from sales
group by month_name;

#What month had the largest COGS?
select month_name, sum(cogs) as total_cogs from sales
group by month_name
order by total_cogs desc;

#What product line had the largest revenue?
select product_line, round(sum(total),2) as total_revenue from sales
group by product_line
order by total_revenue desc;
 
#What is the city with the largest revenue?
select branch, city, round(sum(total),2) as total_revenue from sales
group by city, branch
order by total_revenue desc;
#What product line had the largest VAT?
select product_line, avg(VAT) as avg_tax from sales
group by product_line
order by avg_tax desc;

#Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

#Which branch sold more products than average product sold?
Select branch, sum(quantity) as qty from sales
group by branch
having sum(quantity) > (select avg(quantity) from sales);

#What is the most common product line by gender?
select gender, product_line, count(gender)  as total_cnt
from sales
group by gender, product_line
order by total_cnt desc;

#What is the average rating of each product line?
select round(AVG(rating),2) as avg_rating, product_line from sales
group by product_line
order by  avg_rating;

#---- --------------------------------------------------------------------------------------------------------------------------------------------------------
#---- -----------------------------------------------------------------------------Sales----------------------------------------------------------------------------

#Number of sales made in each time of the day per weekday
SELECT  time_of_day, count(*) as total_sales FROM sales
group by time_of_day
order by total_sales;
#Which of the customer types brings the most revenue?
select customer_type, round(sum(total),2) total_sales from sales
group by customer_type
order by total_sales desc;
#Which city has the largest tax percent/ VAT (Value Added Tax)?
select city, avg(vat) as VAT FROM sales
GROUP BY CITY 
ORDER BY VAT DESC;

#Which customer type pays the most in VAT?
select customer_type, avg(vat) as vat from sales
group by customer_type
order by vat desc;
#Answer: the gap between member and normal customers are quite insignificant

#-----------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------CUSTOMER--------------------------------------------------------------------------------------------------------------------
#How many unique customer types does the data have?
Select distinct customer_type, count(*) as count from sales
group by customer_type;


#Which customer type buys the most?
select customer_type, count(*);

#What is the gender of most of the customers?
select gender, count(*) gender_cnt from sales
group by gender;
#What is the gender distribution per branch?
select gender, count(*) as gender_cnt
from sales
where branch = "c"
group by gender
order by gender_cnt DESC;
#Which time of the day do customers give most ratings?
select time_of_day, avg(rating) as avg_rating from sales
group by time_of_day
order by avg_rating;
#Which time of the day do customers give most ratings per branch?
Select time_of_day, avg(rating) as avg_rating from sales
where branch = "A"
group by time_of_day
order by avg_rating desc;
#Which day fo the week has the best avg ratings?
select day_name, avg(rating) as avg_rating from sales
group by day_name
order by avg_rating desc;
#Which day of the week has the best average ratings per branch?
select day_name, avg(rating) as avg_rating 
from sales
where branch = 'b'
group by day_name
order by avg_rating desc;