![Header_Icon][Header_icon]
---
<p align="center">
  <a href="#Objective">Objective</a> •
  <a href="#About the Dataset">About the Dataset</a> •
  <a href="#Repository Directories">Repository Directories</a> •
  <a href="#Analysis Steps">Analysis Steps</a> •
  <a href="#Results">Results</a> •
  <a href="#License">License</a>
</p>

## Objective

## About the Datasets
Two datasets were utilized for this analysis.
  1. County Income
     - This dataset was aquired from the U.S Beurau of Economic Analysis (BEA) webpage. It contains median incomes for the years 2019, 2020, and 2021 per county across the U.S.
     - Access the webpage [here.](income_data_link)
     - View the dataset [here.](income_fixed)
  3. County Sales
     - This dataset was aquired from the realter.com data library webpage.
     - Access the webpage [here.](sales_data_link)
     - View the dataset here.
    
## Repository Directories

#### [INITIAL_DATA](Initial_data)
- Contains the two datasets that were used for analysis in csv format: [county_income](income.fixed) and county_sales
- The county_income data set has two versions: the first is [county_income_OG.csv](income.OG), which is in its original form as directly downloaded from BEA. The Second is [county_income_fixed_cols.csv](income_fixed), which has the same data but the header has been edited to allow easier import into sql database.
  
#### [DATA_CLEANING](DATA_CLEANING)
- Contains two sql files:
  1. [incomecode.sql](incomecode): Shows the SQL code used to clean and transform the [County Income](income_fixed)) dataset.
  2. [countysalescode.sql](salescode): Shows the SQL code used to clean and transform the County Sales dataset.
 
#### [FINAL_DATA](final_data)
  - Contains two data sets
    1. [piv_income.csv](piv_income): Shows final County Income dataset after being cleaned/transformed
    2. [final_sales.csv](final_csv): Shows final County Sales dataset after being cleaned/transformed
   
#### [DATA_MODELING](DATA_MODELING)
  - Contains two files:
    1. [Regression.py](regression): Python file containing code that is used to create grouped regression model to predict housing affordability up to 2030.
    2. [predictions.csv](predictions): CSV containing dataset that contains U.S. counties with their predictions from the regression model.

#### DATA VISUALIZATION
  - Contains markdown file with screenshot and link to Power BI interactive dashboard


## Analysis Steps
![Proj_steps][proj_steps]

#### Step 1: Identify Goal
  -

#### Step 2: Obtain Data
  - Two datasets aquired from Realtor.com and BEA website.

#### Step 3: Clean/ Transform Data
  - This was done using MySQL Workbench. I wrote queries to :
    - remove missing data
    - generate new columns (either by using mathematical formulas or manipulating strings)
    - reformat existing columns

#### Step 4: Data Modeling
  - I wrote python scripts in Virtual Studio Code to generate a grouped regression model that predicts the average percent difference between average income and the income required to afford a home for each county by year up to the year 2030.

#### Step 5: Data Visualization
  - Power BI was used to create an interactive dashboard to visualize and describe key insights and trends identified by step 3 and 4.


## Results
- The U.S. tends to be more affordable in terms of income vs. home price as you move further inland.
- As the years go on, more and more counties' incomes are not keeping up with the inflation of home sales prices.
- The percent difference between average income and the income needed to afford a home is beginning to trend towards negative values (average income < needed income). This is already the reality for most coastal and western counties.
- As of 2021, the average income for the whole country was enough to buy a home. However, this varies widely across counties in the U.S.

Click on the screenshot below to access interactive version of dashboard:
[![dashboard_img]][dashboard_link]

## License
MIT - read license [here.](license)
  























  <!-- Image Links -->
[Header_icon]: RESOURCES/readmee_icon.jpg
[proj_steps]: RESOURCES/analysis_steps.jpg
[dashboard_img]: RESOURCES/powerBI_screenshot.jpg

<!-- External Links -->
[dashboard_link]: https://app.powerbi.com/view?r=eyJrIjoiNGY1MGI1MGUtMTEwZC00ZTI2LWIyYjctMGFmODRmZjc2ZDljIiwidCI6ImI1ZWI4OTAyLWRlNTctNGUyZS05YTUxLTI0MWNhZmFiYTE0NCJ9
[income_data_link]: https://www.bea.gov/data/income-saving/personal-income-county-metro-and-other-areas
[sales_data_link]: https://www.realtor.com/research/data/

<!-- Github Links -->
[Initial_data]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/tree/main/INITIAL_DATA
[income_OG]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/INITIAL_DATA/county_income_OG.csv
[income_fixed]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/INITIAL_DATA/county_income_fixed_cols.csv
[DATA_CLEANING]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/tree/main/DATA_CLEANING
[incomecode]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/DATA_CLEANING/incomecode.sql
[salescode]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/DATA_CLEANING/countysalescods.sql
[FINAL_DATA]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/tree/main/FINAL_DATA
[piv_income]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/FINAL_DATA/piv_income.csv
[DATA_MODELING]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/tree/main/DATA_MODELING
[regression]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/DATA_MODELING/Regression.py
[predictions]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/DATA_MODELING/predictions.csv
[License]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/LICENSE
