# =========================
# 1 Import Libraries
# =========================
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# =========================
# 2 Load Dataset
# =========================
df = pd.read_csv(r"C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\cleaned_data.csv")

# =========================
# 3 Basic Data Inspection
# =========================
print(df.head())
print(df.info())
print(df.describe())

# =========================
# 4 Missing Values Check
# =========================
df["WarehouseLocation"] = df["WarehouseLocation"].fillna("Unknown")
print(df.isnull().sum())

# =========================
# 5 Duplicate Rows Check
# =========================
print("Duplicate rows:", df.duplicated().sum())

# remove duplicates
df = df.drop_duplicates()

# =========================
# 6 Convert Date Column
# =========================
df["InvoiceDate"] = pd.to_datetime(df["InvoiceDate"])

# =========================
# 7 Sales by Country
# =========================

country_sales = df.groupby("Country")["TotalSales"].sum().sort_values(ascending=False)

print(country_sales.head(10))

plt.figure(figsize=(10,5))
country_sales.head(10).plot.bar()
plt.title("Top Countries by Total Sales")
plt.ylabel("Total Sales")
plt.xlabel("Country")
plt.show()

# =========================
# 8 Sales by Category
# =========================
category_sales = df.groupby("Category")["TotalSales"].sum()

plt.figure()
category_sales.plot(kind="bar")
plt.title("Sales by Category")
plt.ylabel("Total Sales")
plt.xlabel("Category")
plt.show()

# =========================
# 9 Monthly Sales Trend
# =========================
monthly_sales = df.groupby("Month")["TotalSales"].sum()

plt.figure()
monthly_sales.plot(kind="line")
plt.title("Monthly Sales Trend")
plt.ylabel("Sales")
plt.xlabel("Month")
plt.show()

# =========================
# 10 Payment Method Analysis
# =========================
payment_sales = df.groupby("PaymentMethod")["TotalSales"].sum()

plt.figure()
payment_sales.plot(kind="bar")
plt.title("Sales by Payment Method")
plt.ylabel("Sales")
plt.xlabel("Payment Method")
plt.show()

# =========================
# 11 Sales Channel Performance
# =========================
channel_sales = df.groupby("SalesChannel")["TotalSales"].sum()

plt.figure()
channel_sales.plot(kind="bar")
plt.title("Sales by Sales Channel")
plt.ylabel("Sales")
plt.xlabel("Sales Channel")
plt.show()

# =========================
# 12 Shipping Provider Performance
# =========================
shipping_sales = df.groupby("ShipmentProvider")["TotalSales"].sum()

plt.figure()
shipping_sales.plot(kind="bar")
plt.title("Shipping Provider Performance")
plt.ylabel("Sales")
plt.xlabel("Shipment Provider")
plt.show()

# =========================
# 13 Return Status Analysis
# =========================
returns = df["ReturnStatus"].value_counts()

plt.figure()
returns.plot(kind="bar")
plt.title("Return Status Distribution")
plt.xlabel("Return Status")
plt.ylabel("Count")
plt.show()

# =========================
# 14 Top 10 Products
# =========================
top_products = df.groupby("Description")["TotalSales"].sum().sort_values(ascending=False).head(10)

plt.figure()
top_products.plot(kind="bar")
plt.title("Top 10 Products by Sales")
plt.ylabel("Sales")
plt.xlabel("Product")
plt.show()

# =========================
# 15 Quantity Sold by Category
# =========================
quantity_category = df.groupby("Category")["Quantity"].sum()

plt.figure()
quantity_category.plot(kind="bar")
plt.title("Quantity Sold by Category")
plt.ylabel("Quantity")
plt.xlabel("Category")
plt.show()

# =========================
# 16 Discount Analysis
# =========================
discount_category = df.groupby("Category")["Discount"].mean()

plt.figure()
discount_category.plot(kind="bar")
plt.title("Average Discount by Category")
plt.ylabel("Average Discount")
plt.xlabel("Category")
plt.show()

# =========================
# 17 Warehouse Orders
# =========================
warehouse_orders = df["WarehouseLocation"].value_counts()

plt.figure()
warehouse_orders.plot(kind="bar")
plt.title("Orders by Warehouse")
plt.xlabel("Warehouse Location")
plt.ylabel("Orders")
plt.show()

# =========================
# 18 Order Priority Distribution
# =========================
priority_orders = df["OrderPriority"].value_counts()

plt.figure()
priority_orders.plot(kind="bar")
plt.title("Order Priority Distribution")
plt.xlabel("Priority")
plt.ylabel("Orders")
plt.show()