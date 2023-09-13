
/* IMPORTING INCOME FILE */
CREATE TABLE income (
	location varchar(255),
    2019_income int,
    2020_income int,
    2021_income int,
    2021_rank_in_state_price int,
    2020_perc_change int,
    2021_perc_change int,
    2021_rank_in_state_change int
);

show global variables like 'local_infile';
set global local_infile=true;

LOAD DATA LOCAL INFILE '/Users/gabby/Documents/daPortfolio/Housing2/county_income_fixed_cols.csv'
	INTO TABLE income
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


/* ADD ROW NUMBER COLUMN */
SET @row_number = 0; 

ALTER TABLE income
ADD COLUMN rowNumber int;

UPDATE income
SET rowNumber = (@row_number:=@row_number + 1);


/* CREATING STATE VARIABLE*/
ALTER TABLE  income
ADD COLUMN state varchar(255);

Update income
SET state = 'AL'
where rowNumber between 3 and 69;

Update income
SET state = 'AK'
where rowNumber between 72 and 102;

Update income
SET state = 'AZ'
where rowNumber between 105 and 119;

Update income
SET state = 'AR'
where rowNumber between 122 and 196;

Update income
SET state = 'CA'
where rowNumber between 199 and 256;

Update income
SET state = 'CO'
where rowNumber between 259 and 322;

Update income
SET state = 'CT'
where rowNumber between 325 and 332;

Update income
SET state = 'DE'
where rowNumber between 335 and 337;

Update income
SET state = 'DC'
where rowNumber = 339;

Update income
SET state = 'FL'
where rowNumber between 342 and 408;

Update income
SET state = 'GA'
where rowNumber between 411 and 569;

Update income
SET state = 'HI'
where rowNumber between 572 and 575;

Update income
SET state = 'ID'
where rowNumber between 578 and 621;

Update income
SET state = 'IL'
where rowNumber between 624 and 725;

Update income
SET state = 'IN'
where rowNumber between 728 and 819;

Update income
SET state = 'IA'
where rowNumber between 822 and 920;

Update income
SET state = 'KS'
where rowNumber between 923 and 1027;

Update income
SET state = 'KY'
where rowNumber between 1030 and 1149;

Update income
SET state = 'LA'
where rowNumber between 1152 and 1215;

Update income
SET state = 'ME'
where rowNumber between 1218 and 1233;

Update income
SET state = 'MD'
where rowNumber between 1236 and 1259;

Update income
SET state = 'MA'
where rowNumber between 1262 and 1275;

Update income
SET state = 'MI'
where rowNumber between  1278 and 1360;

Update income
SET state = 'MN'
where rowNumber between 1363 and 1449;

Update income
SET state = 'MS'
where rowNumber between 1452 and 1533;

Update income
SET state = 'MO'
where rowNumber between 1536 and 1650;

Update income
SET state = 'MT'
where rowNumber between 1653 and 1708;

Update income
SET state = 'NE'
where rowNumber between 1711 and 1803;

Update income
SET state = 'NV'
where rowNumber between 1806 and 1822;

Update income
SET state = 'NH'
where rowNumber between 1825 and 1834;

Update income
SET state = 'NJ'
where rowNumber between 1837 and 1857;

Update income
SET state = 'NM'
where rowNumber between 1860 and 1892;

Update income
SET state = 'NY'
where rowNumber between 1895 and 1956;

Update income
SET state = 'NC'
where rowNumber between 1959 and 2058;

Update income
SET state = 'ND'
where rowNumber between 2061 and 2113;

Update income
SET state = 'OH'
where rowNumber between 2116 and 2203;

Update income
SET state = 'OK'
where rowNumber between 2206 and 2282;

Update income
SET state = 'OR'
where rowNumber between 2285 and 2320;

Update income
SET state = 'PA'
where rowNumber between 2323 and 2389;

Update income
SET state = 'RI'
where rowNumber between 2392 and 2396;

Update income
SET state = 'SC'
where rowNumber between 2399 and 2444;

Update income
SET state = 'SD'
where rowNumber between 2447 and 2512;

Update income
SET state = 'TN'
where rowNumber between 2515 and 2609;

Update income
SET state = 'TX'
where rowNumber between 2612 and 2865;

Update income
SET state = 'UT'
where rowNumber between 2868 and 2896;

Update income
SET state = 'VT'
where rowNumber between 2899 and 2912;

Update income
SET state = 'VA'
where rowNumber between 2915 and 3021;

Update income
SET state = 'WA'
where rowNumber between 3024 and 3062;

Update income
SET state = 'WV'
where rowNumber between 3065 and 3119;

Update income
SET state = 'WI'
where rowNumber between 3122 and 3193;

Update income
SET state = 'WY'
where rowNumber between 3196 and 3218;


/* REMOVING EMPTY ROWS AND ROWS WHERE THERE IS A STATE INSTEAD OF COUNTY IN LOCATION COLUMN */
DELETE FROM income 
WHERE state IS NULL;


/* Removing words from location that is not part of the county */
UPDATE income
SET location = REPLACE(location, 'Area2' , '');

UPDATE income
SET location = REPLACE(location, 'Area' , '');

UPDATE income
SET location = REPLACE(location, 'Borough' , '');

UPDATE income
SET location = REPLACE(location, 'Census' , '');

UPDATE income
SET location = REPLACE(location, 'Municipality' , '');

UPDATE income
SET location = REPLACE(location, 'and' , '');

UPDATE income
SET location = TRIM(location);


/* ADD 'CS' COLUMNS */
ALTER TABLE income
ADD COLUMN cs varchar(255);

UPDATE income
SET cs = CONCAT(location, ', ', state);


/* CREATE PIV_INCOME */
DROP TABLE IF EXISTS piv_income;
CREATE TABLE piv_income
SELECT 
	s.year,
    s.county,
    s.state,
    s.county_name,
    p.income, 
    p.perc_change,
    s.est_mortgage
FROM
(SELECT 
	2019 AS year,
	cs,
    2019_income AS income,
    NULL AS perc_change
FROM income
UNION
SELECT 
	2020 AS year,
	cs,
    2020_income AS income,
    2020_perc_change AS perc_change
FROM income
UNION
SELECT 
	2021 AS year,
	cs,
    2021_income AS income,
    2021_perc_change AS perc_change
FROM income) p
LEFT JOIN sales s
ON p.cs = s.county_name
AND p.year = s.year
WHERE s.year in (2019, 2020, 2021)
GROUP BY county_name, year
ORDER BY county_name, year;

/* CREATE INCOME NEEDED*/
ALTER TABLE piv_income
ADD COLUMN income_needed int;

UPDATE piv_income
SET income_needed = (est_mortgage/.28) * 12;

/* CREATE INCOME DIFF */
ALTER TABLE piv_income
ADD COLUMN actual_needed_diff int;

UPDATE piv_income
SET actual_needed_diff = income - income_needed;


    
