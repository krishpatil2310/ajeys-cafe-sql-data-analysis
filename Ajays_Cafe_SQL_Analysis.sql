

CREATE DATABASE ajeyscafes;
use ajeyscafes;

CREATE TABLE cafe_orders (
    order_id VARCHAR(50),
    outlet_name VARCHAR(100),
    city VARCHAR(50),
    order_datetime VARCHAR(50),
    item_name VARCHAR(100),
    quantity VARCHAR(50),
    price VARCHAR(50),
    payment_mode VARCHAR(50),
    customer_name VARCHAR(100),
    rating VARCHAR(50),
    franchise_owner VARCHAR(100)
);

SELECT * FROM cafe_orders;


CREATE TABLE cafe_orders_backup AS
SELECT *
FROM cafe_orders;    


SELECT COUNT(*) AS original_count
FROM cafe_orders;

SELECT COUNT(*) AS backup_count
FROM cafe_orders_backup;


DROP TABLE IF EXISTS cafe_orders_clean;


CREATE TABLE cafe_orders_clean AS
SELECT *
FROM cafe_orders;


SELECT COUNT(*) AS clean_count
FROM cafe_orders_clean;


SELECT 
    city,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY city
ORDER BY city;


SELECT 
    outlet_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY outlet_name
ORDER BY outlet_name;



SELECT 
    franchise_owner,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY franchise_owner
ORDER BY franchise_owner;


SELECT 
    customer_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY customer_name
ORDER BY customer_name;


-- STEP 1: BACKUP
CREATE TABLE cafe_orders_backup AS
SELECT *
FROM cafe_orders;


-- STEP 2: CLEANING COPY
DROP TABLE IF EXISTS cafe_orders_clean;

CREATE TABLE cafe_orders_clean AS
SELECT *
FROM cafe_orders;


-- STEP 3: CHECK CITY VARIANTS
SELECT 
    city,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY city
ORDER BY city;


-- OUTLET VARIANTS
SELECT 
    outlet_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY outlet_name
ORDER BY outlet_name;


-- FRANCHISE OWNER VARIANTS
SELECT 
    franchise_owner,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY franchise_owner
ORDER BY franchise_owner;


SELECT COUNT(*) AS total_rows
FROM cafe_orders_clean;



SELECT
    order_id,
    outlet_name,
    city,
    order_datetime,
    item_name,
    quantity,
    price,
    payment_mode,
    customer_name,
    rating,
    franchise_owner,
    COUNT(*) AS duplicate_count
FROM cafe_orders_clean
GROUP BY
    order_id,
    outlet_name,
    city,
    order_datetime,
    item_name,
    quantity,
    price,
    payment_mode,
    customer_name,
    rating,
    franchise_owner
HAVING COUNT(*) > 1;




SELECT 
    COUNT(*) AS duplicate_extra_rows
FROM (
    SELECT
        order_id,
        outlet_name,
        city,
        order_datetime,
        item_name,
        quantity,
        price,
        payment_mode,
        customer_name,
        rating,
        franchise_owner
    FROM cafe_orders_clean
    GROUP BY
        order_id,
        outlet_name,
        city,
        order_datetime,
        item_name,
        quantity,
        price,
        payment_mode,
        customer_name,
        rating,
        franchise_owner
    HAVING COUNT(*) > 1
) AS d;



CREATE TABLE cafe_orders_dedup AS
SELECT DISTINCT *
FROM cafe_orders_clean;


SELECT COUNT(*) AS before_count
FROM cafe_orders_clean;

SELECT COUNT(*) AS after_count
FROM cafe_orders_dedup;


DROP TABLE cafe_orders_clean;

RENAME TABLE cafe_orders_dedup 
TO cafe_orders_clean;

SELECT COUNT(*) AS final_clean_count
FROM cafe_orders_clean;




SELECT
    quantity,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY quantity
ORDER BY quantity;



SELECT
    price,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY price
ORDER BY price;



SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN quantity IS NULL
                 OR TRIM(quantity) = ''
                 OR CAST(quantity AS DECIMAL(10,2)) <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_quantity_rows
FROM cafe_orders_clean;


SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN price IS NULL
                 OR TRIM(price) = ''
                 OR CAST(price AS DECIMAL(10,2)) <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_price_rows
FROM cafe_orders_clean;


SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN price IS NULL
                 OR TRIM(price) = ''
                 OR CAST(price AS DECIMAL(10,2)) <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_price_rows
FROM cafe_orders_clean;

SELECT *
FROM cafe_orders_clean
WHERE quantity IS NULL
   OR TRIM(quantity) = ''
   OR CAST(quantity AS DECIMAL(10,2)) <= 0;
   
   
   SELECT *
FROM cafe_orders_clean
WHERE price IS NULL
   OR TRIM(price) = ''
   OR CAST(price AS DECIMAL(10,2)) <= 0;
   
   
   
   SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN quantity IS NULL
                 OR TRIM(quantity) = ''
                 OR CAST(quantity AS DECIMAL(10,2)) <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_quantity_rows
FROM cafe_orders_clean;


SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN price IS NULL
                 OR TRIM(price) = ''
                 OR CAST(price AS DECIMAL(10,2)) <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_price_rows
FROM cafe_orders_clean;



SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN quantity IS NULL
                 OR TRIM(quantity) = ''
                 OR CAST(quantity AS DECIMAL(10,2)) <= 0
            THEN 1
            ELSE 0
        END
    ) AS invalid_quantity_rows
FROM cafe_orders_clean;










SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN quantity IS NULL
              OR TRIM(quantity) = ''
              OR CAST(quantity AS DECIMAL(10,2)) <= 0
              OR price IS NULL
              OR TRIM(price) = ''
              OR CAST(price AS DECIMAL(10,2)) <= 0
            THEN 1
            ELSE 0
        END
    ) AS rows_to_remove
FROM cafe_orders_clean;




DELETE FROM cafe_orders_clean
WHERE quantity IS NULL
   OR TRIM(quantity) = ''
   OR CAST(quantity AS DECIMAL(10,2)) <= 0
   OR price IS NULL
   OR TRIM(price) = ''
   OR CAST(price AS DECIMAL(10,2)) <= 0;
   
 --      TASK :- 2 Duplicate rows dhundo aur remove karo
-- quantity aur price me invalid values (negative, zero, null) handle karo — decide karo drop karna hai ya impute
   
   SELECT COUNT(*) AS invalid_rows_remaining
FROM cafe_orders_clean
WHERE quantity IS NULL
   OR TRIM(quantity) = ''
   OR CAST(quantity AS DECIMAL(10,2)) <= 0
   OR price IS NULL
   OR TRIM(price) = ''
   OR CAST(price AS DECIMAL(10,2)) <= 0;




-- TASK :1 outlet_name aur city columns ko standardize karo (saari spelling variants ek jaisi karo — jaise "surat", "SURAT", "Ajey Cafe Surat " → "Surat") ab yeh task

SELECT 
    city,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY city
ORDER BY city;

SELECT 
    outlet_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY outlet_name
ORDER BY outlet_name;


UPDATE cafe_orders_clean
SET city = NULLIF(TRIM(city), '');

UPDATE cafe_orders_clean
SET city = CASE
    WHEN LOWER(TRIM(city)) = 'surat' THEN 'Surat'
    WHEN LOWER(TRIM(city)) = 'ahmedabad' THEN 'Ahmedabad'
    WHEN LOWER(TRIM(city)) IN ('bengaluru', 'bangalore') THEN 'Bengaluru'
    WHEN LOWER(TRIM(city)) = 'mumbai' THEN 'Mumbai'
    ELSE TRIM(city)
END;

UPDATE cafe_orders_clean
SET outlet_name = NULLIF(TRIM(outlet_name), '');

UPDATE cafe_orders_clean
SET outlet_name = CASE
    WHEN LOWER(TRIM(outlet_name)) IN (
        'ajeys cafe surat',
        'ajey''s cafe - surat',
        'ajey cafe surat'
    )
    THEN 'Ajey''s Cafe - Surat'

    WHEN LOWER(TRIM(outlet_name)) IN (
        'ajeys cafe ahmedabad',
        'ajey''s cafe - ahmedabad'
    )
    THEN 'Ajey''s Cafe - Ahmedabad'

    ELSE TRIM(outlet_name)
END;

SELECT DISTINCT city
FROM cafe_orders_clean
ORDER BY city;

SELECT DISTINCT outlet_name
FROM cafe_orders_clean
ORDER BY outlet_name;


SELECT 
    city,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY city
ORDER BY city;

SELECT 
    outlet_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY outlet_name
ORDER BY outlet_name;




UPDATE cafe_orders_clean
SET outlet_name = CASE


    -- Rajkot
    WHEN LOWER(TRIM(outlet_name)) IN (
        'ajey''s cafe - rajkot',
        'ajey''s cafe-rajkot',
        'ajeys cafe rajkot'
    )
    THEN 'Ajey''s Cafe - Rajkot'

    -- Delhi
    WHEN LOWER(TRIM(outlet_name)) IN (
        'ajey''s cafe - delhi',
        'ajey''s cafe-delhi',
        'ajeycafe-delhi',
        'ajeys cafe new delhi'
    )
    THEN 'Ajey''s Cafe - Delhi'

    -- Surat
    WHEN LOWER(TRIM(outlet_name)) IN (
        'ajey''s cafe - surat',
        'ajey''s cafe-surat',
        'ajeys cafe-surat'
    )
    THEN 'Ajey''s Cafe - Surat'

    ELSE TRIM(outlet_name)

END;

SELECT
    outlet_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY outlet_name
ORDER BY outlet_name;

SELECT
    LOWER(TRIM(city)) AS city_variant,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY LOWER(TRIM(city))
ORDER BY city_variant;


UPDATE cafe_orders_clean
SET outlet_name = CASE

    WHEN LOWER(TRIM(outlet_name)) IN (
        'ajey cafe bangalore',
        'ajey''s cafe - bangalore',
        'ajeys cafe bengaluru'
    )
    THEN 'Ajey''s Cafe - Bengaluru'

    WHEN LOWER(TRIM(outlet_name)) IN (
        'ajey cafe-ahmadabad',
        'ajey cafe- ahmadabad',
        'ajey''s cafe - ahmedabad'
    )
    THEN 'Ajey''s Cafe - Ahmedabad'

    WHEN LOWER(TRIM(outlet_name)) IN (
        'ajey''s cafe - rajkot',
        'ajey''s cafe-rajkot',
        'ajeys cafe rajkot'
    )
    THEN 'Ajey''s Cafe - Rajkot'

    WHEN LOWER(TRIM(outlet_name)) IN (
        'ajey''s cafe - surat',
        'ajey''s cafe-surat',
        'ajeys cafe-surat'
    )
    THEN 'Ajey''s Cafe - Surat'

    ELSE TRIM(outlet_name)

END;

SELECT
    outlet_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY outlet_name
ORDER BY outlet_name;

UPDATE cafe_orders_clean
SET outlet_name = 'Ajey''s Cafe - Bengaluru'
WHERE TRIM(outlet_name) = 'Ajey Cafe Bangalore';


UPDATE cafe_orders_clean
SET outlet_name = 'Ajey''s Cafe - Rajkot'
WHERE TRIM(outlet_name) = 'Ajey''s Cafe-Rajkot';


SELECT
    outlet_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY outlet_name
ORDER BY outlet_name;


UPDATE cafe_orders_clean
SET outlet_name = 'Ajey''s Cafe - Bengaluru'
WHERE LOWER(TRIM(outlet_name)) LIKE '%bangalore%';

UPDATE cafe_orders_clean
SET outlet_name = 'Ajey''s Cafe - Rajkot'
WHERE LOWER(TRIM(outlet_name)) LIKE '%rajkot%';


SELECT
    outlet_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY outlet_name
ORDER BY outlet_name;

UPDATE cafe_orders_clean
SET outlet_name = 'Ajey''s Cafe - Bengaluru'
WHERE LOWER(TRIM(outlet_name)) = 'ajey cafe banglore';

SELECT
    outlet_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY outlet_name
ORDER BY outlet_name;

select * from cafe_orders_clean;

-- city standerlize

UPDATE cafe_orders_clean
SET city =
    CASE
        WHEN LOWER(TRIM(city)) = 'ahmedabad'
            THEN 'Ahmedabad'

        WHEN LOWER(TRIM(city)) = 'baroda'
            THEN 'Vadodara'

        WHEN LOWER(TRIM(city)) = 'bengaluru'
            THEN 'Bengaluru'

        WHEN LOWER(TRIM(city)) IN ('delhi', 'new delhi')
            THEN 'Delhi'

        WHEN LOWER(TRIM(city)) = 'mumbai'
            THEN 'Mumbai'

        WHEN LOWER(TRIM(city)) = 'pune'
            THEN 'Pune'

        WHEN LOWER(TRIM(city)) = 'rajkot'
            THEN 'Rajkot'

        WHEN LOWER(TRIM(city)) = 'surat'
            THEN 'Surat'

        WHEN LOWER(TRIM(city)) = 'vadodara'
            THEN 'Vadodara'

        ELSE NULL
    END;
    
    
    SELECT
    city,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY city
ORDER BY city;


select * from cafe_orders_clean;



-- Task :- 3 order_datetime ke teeno formats ko ek standard datetime format me convert karo, missing dates ka kya karna hai decide karo

SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN order_datetime IS NULL
                 OR TRIM(order_datetime) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_dates
FROM cafe_orders_clean;

SELECT
    order_datetime AS original_datetime,

    CASE
        WHEN TRIM(order_datetime) REGEXP '^[0-9]{2}-[A-Za-z]{3}-[0-9]{4}$'
            THEN STR_TO_DATE(TRIM(order_datetime), '%d-%b-%Y')

        WHEN TRIM(order_datetime) REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}$'
            THEN STR_TO_DATE(TRIM(order_datetime), '%Y-%m-%d %H:%i')

        WHEN TRIM(order_datetime) REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{2}:[0-9]{2}$'
            THEN STR_TO_DATE(TRIM(order_datetime), '%d/%m/%Y %H:%i')

        ELSE NULL
    END AS converted_datetime

FROM cafe_orders_clean
LIMIT 50;


ALTER TABLE cafe_orders_clean
ADD COLUMN order_datetime_new DATETIME;

UPDATE cafe_orders_clean
SET order_datetime_new =
    CASE
        WHEN TRIM(order_datetime) REGEXP '^[0-9]{2}-[A-Za-z]{3}-[0-9]{4}$'
            THEN STR_TO_DATE(TRIM(order_datetime), '%d-%b-%Y')

        WHEN TRIM(order_datetime) REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}$'
            THEN STR_TO_DATE(TRIM(order_datetime), '%Y-%m-%d %H:%i')

        WHEN TRIM(order_datetime) REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{2}:[0-9]{2}$'
            THEN STR_TO_DATE(TRIM(order_datetime), '%d/%m/%Y %H:%i')

        ELSE NULL
    END;
    
    
    SELECT
    COUNT(*) AS total_rows,
    COUNT(order_datetime_new) AS valid_dates,
    SUM(order_datetime_new IS NULL) AS missing_dates
FROM cafe_orders_clean;


ALTER TABLE cafe_orders_clean
CHANGE COLUMN order_datetime order_datetime_old VARCHAR(50);

ALTER TABLE cafe_orders_clean
CHANGE COLUMN order_datetime_new order_datetime DATETIME;

SELECT
    order_datetime_old,
    order_datetime
FROM cafe_orders_clean
LIMIT 20;

ALTER TABLE cafe_orders_clean
DROP COLUMN order_datetime_old;

select * from  cafe_orders_clean;




-- TASK : - 5 customer_name clean karo — extra spaces, case inconsistency, blank strings ko proper NaN banao


-- STEP 1 — Customer names ka current status check karo
SELECT
    customer_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY customer_name
ORDER BY customer_name
LIMIT 100;

-- STEP 2 — Blank / NULL names count karo
SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE
            WHEN customer_name IS NULL
                 OR TRIM(customer_name) = ''
            THEN 1
            ELSE 0
        END
    ) AS blank_or_null_names,

    SUM(
        CASE
            WHEN customer_name IS NOT NULL
                 AND TRIM(customer_name) <> ''
            THEN 1
            ELSE 0
        END
    ) AS valid_names

FROM cafe_orders_clean;


-- STEP 3 — Extra spaces identify karo
SELECT customer_name
FROM cafe_orders_clean
WHERE customer_name IS NOT NULL
  AND (
      customer_name <> TRIM(customer_name)
      OR customer_name REGEXP '  +'
  )
LIMIT 50;



UPDATE cafe_orders_clean
SET customer_name =
    CASE
        WHEN customer_name IS NULL
             OR TRIM(customer_name) = ''
        THEN NULL

        ELSE LOWER(
            REGEXP_REPLACE(TRIM(customer_name), '[[:space:]]+', ' ')
        )
    END;
    
    
    
    SELECT
    customer_name,
    COUNT(*) AS records
FROM cafe_orders_clean
WHERE customer_name IS NOT NULL
GROUP BY customer_name
ORDER BY records DESC
LIMIT 20;


SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE
            WHEN customer_name IS NULL
            THEN 1
            ELSE 0
        END
    ) AS null_customers,

    COUNT(DISTINCT customer_name) AS unique_customers

FROM cafe_orders_clean;

UPDATE cafe_orders_clean
SET customer_name =
    CASE
        WHEN customer_name IS NULL
             OR TRIM(customer_name) = ''
        THEN NULL
        ELSE LOWER(
            REGEXP_REPLACE(
                TRIM(customer_name),
                '[[:space:]]+',
                ' '
            )
        )
    END;
    
    
    SELECT
    customer_name,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY customer_name
ORDER BY customer_name
LIMIT 50;

SELECT COUNT(*) AS blank_customers
FROM cafe_orders_clean
WHERE customer_name IS NOT NULL
  AND TRIM(customer_name) = '';
  
  
  SELECT
    COUNT(*) AS total_rows,
    SUM(customer_name IS NULL) AS null_customers,
    COUNT(DISTINCT customer_name) AS unique_customers
FROM cafe_orders_clean;


SELECT
    customer_name,
    COUNT(*) AS order_count
FROM cafe_orders_clean
WHERE customer_name IS NOT NULL
GROUP BY customer_name
HAVING COUNT(*) > 1
ORDER BY order_count DESC
LIMIT 50;



-- TASK 6 rating column me out-of-range values (0, 6) ko invalid mark karo

SELECT
    COUNT(*) AS invalid_ratings
FROM cafe_orders_clean
WHERE rating IS NOT NULL
  AND (rating < 1 OR rating > 5);
  
  SELECT
    rating,
    COUNT(*) AS records
FROM cafe_orders_clean
WHERE rating IS NOT NULL
  AND (rating < 1 OR rating > 5)
GROUP BY rating
ORDER BY rating;

UPDATE cafe_orders_clean
SET rating = NULL
WHERE rating IS NOT NULL
  AND (rating < 1 OR rating > 5);
  
  SELECT
    COUNT(*) AS invalid_ratings
FROM cafe_orders_clean
WHERE rating IS NOT NULL
  AND (rating < 1 OR rating > 5);
  
  
  SELECT
    rating,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY rating
ORDER BY rating;



-- TASK 7 — franchise_owner spelling variants merge karna


SELECT
    LOWER(TRIM(franchise_owner)) AS owner_variant,
    COUNT(*) AS records
FROM cafe_orders_clean
GROUP BY LOWER(TRIM(franchise_owner))
ORDER BY owner_variant;

SELECT DISTINCT
    franchise_owner
FROM cafe_orders_clean
ORDER BY franchise_owner;


select count(*) from cafe_orders_clean;
-- 📊 Exploratory Analysis

-- TASK :-8 Har outlet (city-wise) ka total revenue nikaalo
-- Step 1️⃣ — Overall Total Revenue
select round(sum(quantity*price),2) As Total_Revenue
from cafe_orders_clean
where quantity > 0 
and price > 0;

-- Step 2️⃣ — Outlet-wise Revenue
select outlet_name,
round(sum(quantity*price),2) As outlet_Totalrevenue
from cafe_orders_clean
where quantity > 0
and price > 0
group by outlet_name
order by outlet_Totalrevenue;


-- TASK :- 9 Sabse zyada bikne wala item kaun sa hai (overall aur outlet-wise)
-- Overall sabse zyada bikne wala item
select item_name,
sum(quantity) As Total_quantity_sold
from cafe_orders_clean
where quantity > 0
group by item_name
order by  Total_quantity_sold desc
limit 1;

-- Outlet-wise sabse zyada bikne wala item
with item_sales AS (
select outlet_name,item_name,
sum(quantity) As total_quantity_sold
from cafe_orders_clean
where quantity > 0
group by outlet_name,item_name
),
ranked_items AS (
select outlet_name,
item_name,
total_quantity_sold,
rank() over(partition by outlet_name
order by total_quantity_sold desc ) As Item_Rank
from item_sales
)
select outlet_name,
       item_name,
       total_quantity_sold
from ranked_items
where item_rank = 1
order by outlet_name desc
limit 10;



-- TASK :- 10 Month-wise / year-wise sales trend dikhao

select 
      year(order_datetime) AS sales_year,
      round(sum(quantity*price),2) AS total_sales
from cafe_orders_clean
where order_datetime is not null 
and quantity > 0 
and price > 0
group by  year(order_datetime)
order by sales_year;

SELECT
    YEAR(order_datetime) AS sales_year,
    MONTH(order_datetime) AS month_number,
    MONTHNAME(order_datetime) AS month_name,
    ROUND(SUM(quantity * price), 2) AS total_sales
FROM cafe_orders_clean
WHERE order_datetime IS NOT NULL
  AND quantity > 0
  AND price > 0
GROUP BY
    YEAR(order_datetime),
    MONTH(order_datetime),
    MONTHNAME(order_datetime)
ORDER BY
    sales_year,
    month_number;
    
    
-- TASK :-11 Payment mode ka distribution (UPI vs Cash vs Card) nikaalo
select payment_mode,
count(*) As Total_transactions
from cafe_orders_clean
where payment_mode is not null
and trim(payment_mode) <> ''
group by payment_mode
order by total_transactions desc;



-- TASK :- 12 Average order value (AOV) per outlet calculate karo

select outlet_name,
round(sum(quantity* price),2) As total_revenue,
count(distinct order_id) As total_orders,
round(
sum(quantity*price)/count(distinct order_id),2)
as AOV 
from cafe_orders_clean
where quantity >0
and price >0
and order_id is not null
group by outlet_name
order by AOV Desc;


-- TASK 13 :- Rating aur sales ke beech koi correlation hai kya, check karo

SELECT
    ROUND(
        (
            COUNT(*) * SUM(rating * (quantity * price))
            - SUM(rating) * SUM(quantity * price)
        )
        /
        SQRT(
            (
                COUNT(*) * SUM(rating * rating)
                - POW(SUM(rating), 2)
            )
            *
            (
                COUNT(*) * SUM((quantity * price) * (quantity * price))
                - POW(SUM(quantity * price), 2)
            )
        ),
        4
    ) AS rating_sales_correlation
FROM cafe_orders_clean
WHERE rating IS NOT NULL
  AND quantity > 0
  AND price > 0;
  
 -- Business-Level Questions
 
  -- TASK:-14 Kaunsa outlet sabse zyada profitable/growing hai (year-over-year)?
  
  -- Outlet + Year Revenue
  
select outlet_name,
       year(order_datetime) As Sales_year,
       round(sum(quantity*price),2) as yearly_revenue
       from cafe_orders_clean
where order_datetime is not null
and quantity > 0 
and  price > 0
group by 
  outlet_name,
  year(order_datetime)
order by 
outlet_name,
sales_year;  

-- YearOverYear Growth % — Main Query


with yearly_sales as (
select outlet_name,
year(order_datetime) as sales_year,
sum(quantity*price) as yearly_revenue
from cafe_orders_clean
where order_datetime is not null
and quantity > 0
and price > 0
group by 
outlet_name,
year(order_datetime)
),

yoy_sales As (
select outlet_name,
sales_year,
yearly_revenue,
lag(yearly_revenue) over (partition by outlet_name
order by sales_year
)AS previous_year_revenue
from yearly_sales
)

select 
  outlet_name,
    sales_year,
    ROUND(yearly_revenue, 2) AS yearly_revenue,
    ROUND(previous_year_revenue, 2) AS previous_year_revenue,
    ROUND(
        ((yearly_revenue - previous_year_revenue)
        / previous_year_revenue) * 100,
        2
    ) AS yoy_growth_percent
FROM yoy_sales
WHERE previous_year_revenue IS NOT NULL
ORDER BY
    sales_year,
    yoy_growth_percent DESC;
    
    
 --  TASK :- 15 Weekday vs weekend sales pattern kaisa hai?  
 
 select 
 case 
 when dayofweek(order_datetime) in (1,7)
 then 'weekend'
 else 'weekday'
 end as day_type,
 round(sum(quantity*price),2) As total_sales,
 count(distinct order_id) As total_orders
 from cafe_orders_clean
 where order_datetime is not null
 and quantity > 0
 and price > 0
 group by
 case when dayofweek(order_datetime) in (1,7)
 then 'Weekend'
 else 'Weekday'
 end
 order by total_sales DESC;
 

-- TASK :- 16 Kaunse items low-rated hain but high-selling — improvement chahiye?

with item_analysis as (
select item_name,
sum(quantity) As total_quantity_sold,
round(avg(rating),2) As avg_rating
from cafe_orders_clean
where quantity > 0
and rating is not null
group by item_name
),

item_average As (
select avg(total_quantity_sold) As avg_item_sales
from item_analysis
)

select 
     ia.item_name,
	 ia.total_quantity_sold,
     ia.avg_rating,
     round(ia.total_quantity_sold-av.avg_item_sales,0) As sales_above_average
from item_analysis ia
cross join item_average av
where ia.avg_rating < 3.0 
and ia.total_quantity_sold > av.avg_item_sales
order by 
ia.total_quantity_sold desc;

-- TASK :-17 Customer repeat-purchase pattern nikaalo (agar naam clean ho jaye)
  
  WITH customer_orders AS (
    SELECT
        customer_name,
        COUNT(DISTINCT order_id) AS total_orders
    FROM cafe_orders_clean
    WHERE customer_name IS NOT NULL
      AND order_id IS NOT NULL
    GROUP BY customer_name
)
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customers,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS customer_percentage
FROM customer_orders
GROUP BY
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;
    
    
    -- TASK 18:- Window functions use karo — har outlet ka rank by revenue (RANK() OVER (PARTITION BY ... ORDER BY ...))
    
    with outlet_revenue as (
    select city,
          outlet_name,
          sum(quantity*price) As revenue
    from cafe_orders_clean
    where quantity > 0
    and price > 0
    and city is not null
    group by city,outlet_name
    )
    
    select city,
    outlet_name,
    round(revenue, 2) as total_revenue,
    rank() over(
    partition by city 
    order by revenue desc
    ) as revenue_rank
    from outlet_revenue
    order by city, revenue_rank;
 
 
--  TASK :- 19 Month-over-month growth % nikaalo (LAG() window function)

with monthly_sales as (
select date_format(order_datetime,'%Y-%m') AS sales_month,
sum(quantity*price) AS monthly_revenue
from cafe_orders_clean
where order_datetime is not null
and quantity > 0
and price > 0
group by date_format(order_datetime,'%Y-%m') 
),

sales_with_previous as (
select sales_month,
monthly_revenue,
lag(monthly_revenue) over (
order by sales_month)
 as previous_month_revenue

from monthly_sales
)
SELECT
    sales_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,

    ROUND(
        (
            (monthly_revenue - previous_month_revenue)
            / previous_month_revenue
        ) * 100,
        2
    ) AS mom_growth_percent

FROM sales_with_previous
WHERE previous_month_revenue IS NOT NULL
ORDER BY sales_month;

-- TASK :-20 Subquery/CTE se "outlets jinka revenue average se kam hai" nikaalo
#CTE METHOD 

with outlet_revenue AS (
select 
outlet_name,
sum(quantity*price) AS total_revenue
from cafe_orders_clean
where quantity > 0
and price > 0
group by outlet_name
),

average_revenue As (
select avg(total_revenue) As avg_revenue
from outlet_revenue
)

select o.outlet_name,
round(o.total_revenue,2) As total_revenue,
round(a.avg_revenue,2) As average_revenue
from outlet_revenue o 
cross join average_revenue a
where o.total_revenue < a.avg_revenue
order by o.total_revenue ASC;

# using SubQuery

SELECT
    outlet_name,
    ROUND(SUM(quantity * price), 2) AS total_revenue
FROM cafe_orders_clean
WHERE quantity > 0
  AND price > 0
GROUP BY outlet_name
HAVING SUM(quantity * price) < (
    SELECT AVG(outlet_revenue)
    FROM (
        SELECT
            SUM(quantity * price) AS outlet_revenue
        FROM cafe_orders_clean
        WHERE quantity > 0
          AND price > 0
        GROUP BY outlet_name
    ) AS revenue_data
)
ORDER BY total_revenue ASC;


#TASK :- 21 Self-join ya EXISTS use karke repeat customers dhundo

select distinct 
c1.customer_name
from cafe_orders_clean c1
where c1.customer_name is not null
and c1.order_id is not null 
and exists (
select 1
from cafe_orders_clean c2
where c2.customer_name = c1.customer_name
and c2.order_id is not null
and c2.order_id <> c1.order_id
)
order by c1.customer_name;

-- TASK :-22 Stored procedure banao jo kisi bhi outlet ka monthly report generate kare

DELIMITER //

CREATE PROCEDURE sp_outlet_monthly_report(
    IN p_outlet_name VARCHAR(100),
    IN p_year INT,
    IN p_month INT
)
BEGIN

    SELECT
        p_outlet_name AS outlet_name,
        p_year AS report_year,
        p_month AS report_month,

        COUNT(DISTINCT order_id) AS total_orders,

        SUM(quantity) AS total_quantity_sold,

        ROUND(SUM(quantity * price), 2) AS total_revenue,

        ROUND(
            SUM(quantity * price) /
            NULLIF(COUNT(DISTINCT order_id), 0),
            2
        ) AS average_order_value,

        ROUND(AVG(rating), 2) AS average_rating

    FROM cafe_orders_clean

    WHERE outlet_name = p_outlet_name
      AND order_datetime IS NOT NULL
      AND YEAR(order_datetime) = p_year
      AND MONTH(order_datetime) = p_month
      AND quantity > 0
      AND price > 0;

END //

DELIMITER ;


CALL sp_outlet_monthly_report(
    "Ajey's Cafe - Surat",
    2025,
    3
);


CALL sp_outlet_monthly_report(
    "Ajey's Cafe - Ahmedabad",
    2025,
    3
);


select * from cafe_orders_clean;
