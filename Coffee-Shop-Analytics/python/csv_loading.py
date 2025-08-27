import pandas as pd
from sqlalchemy import create_engine

# Read the CSV
df = pd.read_csv('C:\\Users\\USER\\Documents\\Portfolio\\Coffee-shop-analytics\\data\\Coffee-Shop-Sales-AllColumns.csv')

# Create connection to MySQL
engine = create_engine("mysql+mysqlconnector://USER:PASSWORD@localhost:3306/coffee_shop")

# Automatically create table and load data
df.to_sql('coffee_shop_sales', con=engine, if_exists='replace', index=False)

print("Table created and data loaded!")