![Header_Icon][Header_icon]
---
<p align="center">
  <a href="#Objective">Objective</a> •
  <a href="#Dataset">Dataset</a> •
  <a href="#Directories">Directories</a> •
  <a href="#Procedure">Procedure</a> •
  <a href="#Results">Results</a> •
  <a href="#License">License</a>
</p>

## Objective
- This report seeks to understand the severity of the housing crisis in the U.S. It uses income and home price data to derive insights and identify trends that showcase significant obsticles that many Americans face in their pursuit of homeownership.


## Dataset
- Two datasets were utilized for this analysis.
    1. County Income
       - This dataset was aquired from the U.S Beurau of Economic Analysis (BEA) webpage. It contains median incomes for the years 2019, 2020, and 2021 per county across the U.S.
       - Access the webpage [here.][income_data_link]
       - View the dataset [here.][income_fixed]
    3. County Sales
       - This dataset was aquired from the realter.com data library webpage. It contains various data points related to selling homes (including median listing price) for each U.S. county.
       - Access the webpage [here.][sales_data_link]
       - View the dataset [here.][sales_initial]

  
## Directories
#### INITIAL_DATA
- Contains the two datasets that were used for analysis in csv format: [county_income][income_fixed] and [county_sales][sales_initial].
- The county_income data set has two versions: the first is [county_income_OG.csv][income_OG], which is in its original form as directly downloaded from BEA. The Second is [county_income_fixed_cols.csv][income_fixed], which has the same data but the header has been edited to allow easier import into sql database.
  
#### DATA_CLEANING
- Contains two sql files:
  1. [incomecode.sql][incomecode]: Shows the SQL code used to clean and transform the [County Income][income_fixed] dataset.
  2. [countysalescode.sql][salescode]: Shows the SQL code used to clean and transform the [County Sales][sales_initial] dataset.
 
#### FINAL_DATA
  - Contains two data sets
    1. [piv_income.csv][piv_income]: Shows County Income dataset after being cleaned/transformed
    2. [sales.csv][sales_final]: Shows County Sales dataset after being cleaned/transformed
   
#### DATA_MINING
  - Contains two files:
    1. [Regression.py][regression]: Python file containing code used for grouped regression model.
    2. [predictions.csv][predictions]: CSV containing dataset that contains U.S. counties with their predictions from the regression model.

#### DATA_VISUALIZATION
  - Contains markdown file with screenshot and link to Power BI interactive dashboard


## Procedure
![Proj_steps][proj_steps]

#### Step 1: Identify Goal/ Question
  - Question: Is homeownership still a reasonable goal in the U.S?

#### Step 2: Obtain Data
  - Two datasets aquired from Realtor.com and BEA website.
  - Find in *INITIAL_DATA* directory

#### Step 3: Clean/ Transform Data
  - This was done using MySQL Workbench. I wrote queries to :
    - remove rows with missing data
    - generate new columns to derive insights(either by using mathematical formulas or manipulating strings)
    - reformat existing columns
  - Shown in *DATA_CLEANING* directory.

#### Step 4: Data Modeling
  - Virtual Studio Code was used to write python scripts that generate a grouped regression model that predicts the average percent difference between average income and the income required to afford a home bassed on the year for each U.S county. This model was used to create a table that contains a column indicating the year, another indicating the county, and a final column indicating the responce value from the regresion model. Each county is evaluated for the years 2022- 2030.
  - Shown in *DATA_MINING* directory.

#### Step 5: Data Visualization
  - Power BI was used to create an interactive dashboard to visualize and describe key insights and trends identified by step 3 and 4.
  - Aceess dashboard either from *DATA_VISUALIZATION* directory or from the 'Results' section below.


## Results
- The U.S. tends to be more affordable in terms of income vs. home price as you move further inland.
- As the years go on, more and more counties' incomes are not keeping up with the inflation of home sales prices.
- The percent difference between average income and the income needed to afford a home is beginning to trend towards negative values (average income < needed income). This is already the reality for most coastal and western counties.

Click on the screenshot below to access interactive version of dashboard:
[![dashboard_img]][dashboard_link]

## License
MIT - read license [here.][license]
  























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
[regression]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/DATA_MINING/Regression.py
[predictions]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/DATA_MINING/predictions.csv
[License]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/LICENSE
[sales_initial]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/INITIAL_DATA/county_sales.csv
[sales_final]: https://github.com/GabbyGuinard/Homeownership_Ability_Across_US/blob/main/FINAL_DATA/sales.csv
