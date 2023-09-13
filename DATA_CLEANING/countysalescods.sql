
/* LOAD DATA */
CREATE TABLE sales(
	month_date_yyyymm varchar(255),
    county_fips varchar(255),
	county_name varchar(255),
	median_listing_price int,
	median_listing_price_mm decimal(5,4),
	median_listing_price_yy decimal(5,4),
	active_listing_count int,
	active_listing_count_mm decimal(5,4),
	active_listing_count_yy decimal(5,4),
	median_days_on_market int,
	median_days_on_market_mm decimal(5,4),
	median_days_on_market_yy decimal(5,4),
	new_listing_count int,
	new_listing_count_mm decimal(5,4),
 	new_listing_count_yy decimal(5,4),
	price_increased_count int,
	price_increased_count_mm decimal(5,4),
	price_increased_count_yy decimal(5,4),
	price_reduced_count int,
	price_reduced_count_mm decimal(5,4),
	price_reduced_count_yy decimal(5,4),
	pending_listing_count int,
	pending_listing_count_mm decimal(5,4),
	pending_listing_count_yy decimal(5,4),
	median_listing_price_per_square_foot int,
	median_listing_price_per_square_foot_mm decimal(5,4),
	median_listing_price_per_square_foot_yy decimal(5,4),
	median_square_feet int,
	median_square_feet_mm decimal(5,4),
	median_square_feet_yy decimal(5,4),
	average_listing_price int,
	average_listing_price_mm decimal(5,4),
	average_listing_price_yy decimal(5,4),
	total_listing_count int,
	total_listing_count_mm decimal(5,4),
	total_listing_count_yy decimal(5.4),
	pending_ratio decimal(5,4),
	pending_ratio_mm decimal(5,4),
	pending_ratio_yy decimal(5,4),
	quality_flag int
);

LOAD DATA LOCAL INFILE '/Users/gabby/Documents/daPortfolio/Housing2/county_history.csv'
	INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 LINES;

DELETE FROM sales WHERE county_fips = ' please contact economics@realtor.com for more details.';
DELETE FROM sales WHERE county_name IS NULL;

/* CREATING INITCAP FUNCTION */
DELIMITER $$

CREATE
   FUNCTION initcap (input VARCHAR(255))
   RETURNS VARCHAR(255) 
BEGIN
DECLARE len INT;
DECLARE i INT;

SET len   = CHAR_LENGTH(input);
SET input = LOWER(input);
SET i = 0;

WHILE (i < len) DO
    IF (MID(input,i,1) = ' ' OR i = 0) THEN
        IF (i < len) THEN
            SET input = CONCAT(
                LEFT(input,i),
                UPPER(MID(input,i + 1,1)),
                RIGHT(input,len - i - 1)
            );
        END IF;
    END IF;
    SET i = i + 1;
END WHILE;

RETURN input;
END$$

DELIMITER ;



/* CREATING YEAR, MONTH, STATE, AND COUNTY VARIABLES */
ALTER TABLE sales
ADD year varchar(255);
ALTER TABLE sales
ADD month varchar(255);
ALTER TABLE sales
ADD state varchar(255);
ALTER TABLE sales
ADD county varchar(255);

UPDATE sales
SET year = LEFT(month_date_yyyymm, 5);
UPDATE sales
SET month = RIGHT(month_date_yyyymm, 2);
UPDATE sales
SET state = UPPER(RIGHT(county_name, 2));
UPDATE sales
SET county = initcap(LEFT(county_name, LENGTH(county_name) -4));
UPDATE sales
SET county_name = CONCAT(county, ', ', state);


 /* CREATING QUARTER VARIABLE */
 ALTER TABLE sales
 add Quarter varchar(255);
 
 UPDATE sales
 SET Quarter = 'Q1'
 WHERE month in ('01', '02', '03');
 UPDATE sales
 SET Quarter = 'Q2'
 WHERE month in ('04', '05', '06');
 UPDATE sales
 SET Quarter = 'Q3'
 WHERE month in ('07', '08', '09');
 UPDATE sales
 SET Quarter = 'Q4'
 WHERE month in ('10', '11', '12');
 
 
/* MEAN BY QUARTER */
ALTER TABLE sales
ADD COLUMN Q_avg int;

UPDATE sales s
LEFT JOIN (
    SELECT 
        year,
        Quarter,
        county_name,
        AVG(median_listing_price) AS Q_avg
    FROM sales
    GROUP BY year, Quarter, county_name
) AS avg_table
ON s.year = avg_table.year
   AND s.Quarter = avg_table.Quarter
   AND s.county_name = avg_table.county_name
SET s.Q_avg = avg_table.Q_avg;


/* Q_avg estimated mortgage payment */

ALTER TABLE sales
ADD COLUMN est_mortgage int;

UPDATE sales
SET est_mortgage = ((Q_avg * 0.8) * (0.06/12))/(1- (POWER(1+(0.06/12),(-12*30))))








