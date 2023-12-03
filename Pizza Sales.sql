--view the data
select *
from pizza_sales
--total revenue
select ceiling(sum(total_price)) as total_revenue
from pizza_sales
--Avg order value
select sum(total_price)/count(distinct(order_id)) avg_order_value
from pizza_sales
--total pizzas sold
select sum(quantity) as total_quantities_sold
from pizza_sales
--total orders
select count(distinct order_id) as total_orders
from pizza_sales
--Average pizza per order
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id)as decimal(10,2)) as decimal(10,2)) as avg_per_order
from pizza_sales


--visualizations
--hourly trend for total pizzas sold
select DATEPART(hour,order_time) as order_hours,sum(quantity) as total_pizzas_sold
from pizza_sales
group by DATEPART(hour,order_time)
order by DATEPART(hour,order_time) 

--weekly trend for total orders
select DATEPART(ISO_week,order_date) as week_number,year(order_date) as order_year,count(distinct order_id) as total_orders
from pizza_sales
group by DATEPART(ISO_week,order_date),year(order_date)
ORDER BY DATEPART(ISO_week,order_date),year(order_date)

--percentage of salesby category
select pizza_category , sum(total_price) as total_sales, sum(total_price)*100/(select sum(total_price) from pizza_sales) as PCT
from pizza_sales 
group by pizza_category 
--1st month
select pizza_category , sum(total_price) as total_sales, sum(total_price)*100/(select sum(total_price) from pizza_sales) as PCT
from pizza_sales 
where MONTH(order_date)=1 --january
group by pizza_category 