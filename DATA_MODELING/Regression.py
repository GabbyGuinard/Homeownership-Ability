
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm

# LOAD DATA
joined = pd.read_csv('joined.csv', delimiter = ';')
joined.sort_values('county_name')

# EXPLORING DATA
joined.info()
joined.shape
joined.describe()

# CREATING PERCENT DIFFERENCE COLUMN
joined['income_needed_actual_perc_diff'] = round(((joined['income']-joined['income_needed'])/ joined['income_needed']) * 100, 2)
joined = joined.sort_values(['county_name', 'year', 'Quarter'])

# EXTRACTING COLUMNS REQUIRED FOR GROUPED REGRESSION AND DROP DUPLICATE ROWS
df = joined[['year', 'county_name', 'income_needed_actual_perc_diff']]
df.drop_duplicates(subset=None, keep="first", inplace=True)

# REMOVE Nan / INF
df.replace([np.inf, -np.inf], np.nan, inplace=True)
df = df.dropna()

# GROUPING DATA SET AND IDENTIFYING RESPONCE/ PREDICTOR VARIABLES
grouped = df.groupby(['county_name'])
x_col = 'year'
y_col = 'income_needed_actual_perc_diff'

# CREATE REGRESSION MODEL FUNCTION
def fit_linear_model(df):
    X = sm.add_constant(df[x_col])
    y = df[y_col]
    model = sm.OLS(y, X).fit()
    return model

# CREATE SERIES CONTAINING EACH GROUP(COUNTY) AND ITS CORRESPONDING REGRESSION MODEL
models = grouped.apply(fit_linear_model)

# PREPARING FOR PREDICTION TABLE
pred_yr = np.array(([2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030]))
model_df = pd.DataFrame(columns= ['year', 'location', 'pred'])
X = sm.add_constant(pred_yr)

# LOOP GOES THROUGH EACH COUNTY IN 'MODELS' AND APPLIES ITS MODEL TO PREDICT 'PERCENT DIFFERENCE' FROM YEARS 2022 - 2030
# AND DOCUMENTS IN A TABLE
for a in range(2987):
    if len(models[a].params) == 2:
        for y in range(0,9):
            model_df.loc[len(model_df.index)] = [pred_yr[y], models.index[a], models[a].predict(X)[y]]
    elif len(models[a].params) == 1:
         for y in range(0,9):
            model_df.loc[len(model_df.index)] = [pred_yr[y], models.index[a], models[a].predict(pred_yr)[y]]


# APEENDS YEARS 2019-2021 INFORMATION
df = df.rename(columns= {'county_name': 'location', 'income_needed_actual_perc_diff': 'pred'})
final_df = df._append(model_df)

# EXPORTS PREDICTIONS AS CSV
final_df.to_csv('predictions', index=False, encoding='utf-8', sep= ';')
