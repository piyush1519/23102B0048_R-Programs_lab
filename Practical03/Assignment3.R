# ============================================================
# ASSIGNMENT 3
# RETAIL SALES DATA INTEGRATION AND ANALYSIS
# ============================================================


# ============================================================
# 0. LOAD REQUIRED LIBRARIES
# ============================================================

library(tidyverse)
library(readxl)
library(jsonlite)
library(RSQLite)


# ============================================================
# 1. IMPORT DATA
# ============================================================

# Change this path if your Excel file has a different name
retail_data <- read_excel("Online Retail.xlsx")

# Inspect data
head(retail_data)
dim(retail_data)
names(retail_data)
str(retail_data)


# ============================================================
# 2. DATA QUALITY CHECKS
# ============================================================

# Check missing values
colSums(is.na(retail_data))

# Check duplicate rows
sum(duplicated(retail_data))

# Check invalid quantities
sum(retail_data$Quantity <= 0)

# Check invalid unit prices
sum(retail_data$UnitPrice <= 0)

# Percentage of missing CustomerID
mean(is.na(retail_data$CustomerID)) * 100


# ============================================================
# 3. DATA CLEANING
# ============================================================

retail_clean <- retail_data %>%
  filter(
    !is.na(CustomerID),
    Quantity > 0,
    UnitPrice > 0
  ) %>%
  distinct()

# Calculate Revenue
retail_clean <- retail_clean %>%
  mutate(
    Revenue = Quantity * UnitPrice
  )

# Verify cleaned dataset
dim(retail_clean)

colSums(is.na(retail_clean))

sum(duplicated(retail_clean))

head(retail_clean)

# Revenue checks
sum(retail_clean$Revenue <= 0)

sum(is.na(retail_clean$Revenue))


# ============================================================
# 4. CREATE TRANSACTIONS DATASET
# ============================================================

transactions <- retail_clean %>%
  select(
    InvoiceNo,
    StockCode,
    CustomerID,
    Quantity,
    InvoiceDate
  )

write.csv(
  transactions,
  "transactions.csv",
  row.names = FALSE
)

# Verify
head(transactions)
dim(transactions)
names(transactions)


# ============================================================
# 5. CREATE PRODUCTS DATASET
# ============================================================

products <- retail_clean %>%
  select(
    StockCode,
    Description,
    UnitPrice
  ) %>%
  distinct()

# Check product duplicates
products %>%
  count(StockCode) %>%
  filter(n > 1) %>%
  arrange(desc(n))

# Number of StockCodes with multiple records
products %>%
  count(StockCode) %>%
  filter(n > 1) %>%
  nrow()

# Check example
products %>%
  filter(StockCode == "85123A")

# Export products as JSON
write_json(
  products,
  "products.json",
  pretty = TRUE,
  auto_unbox = TRUE
)


# ============================================================
# 6. CREATE CUSTOMERS DATASET
# ============================================================

customers <- retail_clean %>%
  select(
    CustomerID,
    Country
  ) %>%
  distinct()

# Check duplicate customers
customers %>%
  count(CustomerID) %>%
  filter(n > 1)

# Check conflicting countries
customers %>%
  group_by(CustomerID) %>%
  summarise(
    countries = n_distinct(Country)
  ) %>%
  filter(countries > 1)


# ============================================================
# 7. RESOLVE CONFLICTING CUSTOMER COUNTRIES
# ============================================================

# Use the country with the largest number
# of transactions for each CustomerID

customers_final <- retail_clean %>%
  count(
    CustomerID,
    Country,
    name = "transaction_count"
  ) %>%
  group_by(CustomerID) %>%
  slice_max(
    transaction_count,
    n = 1,
    with_ties = FALSE
  ) %>%
  ungroup() %>%
  select(
    CustomerID,
    Country
  )

# Verify
dim(customers_final)

customers_final %>%
  count(CustomerID) %>%
  filter(n > 1)

# Check the previously conflicting customers
customers_final %>%
  filter(
    CustomerID %in% c(
      12370,
      12394,
      12417,
      12422,
      12429,
      12431,
      12455,
      12457
    )
  )


# ============================================================
# 8. EXPORT CUSTOMERS
# ============================================================

# Export to CSV temporarily
write.csv(
  customers_final,
  "customers_temp.csv",
  row.names = FALSE
)

# NOTE:
# customers.xlsx can be generated using Python/openpyxl
# if writexl/openxlsx are unavailable in R.


# ============================================================
# 9. READ CUSTOMERS EXCEL IF AVAILABLE
# ============================================================

# If customers.xlsx already exists:
if (file.exists("customers.xlsx")) {
  
  customers_excel <- read_excel(
    "customers.xlsx"
  )
  
  print(head(customers_excel))
  print(dim(customers_excel))
  print(names(customers_excel))
  
}


# ============================================================
# 10. TRANSACTION + CUSTOMER INTEGRATION
# ============================================================

sales_customers <- transactions %>%
  left_join(
    customers_final,
    by = "CustomerID"
  )

# Verify dimensions
dim(sales_customers)

# Check unmatched customers
sum(is.na(sales_customers$Country))

# Inspect
head(sales_customers)


# ============================================================
# 11. FINAL INTEGRATED DATASET
# ============================================================

# IMPORTANT:
# We use retail_clean as the authoritative transaction-level
# source for UnitPrice, Description and Revenue.
#
# We DO NOT perform a direct StockCode -> products join because
# StockCode is not unique in products and would create a
# many-to-many relationship and duplicate transactions.

sales_integrated <- retail_clean %>%
  select(
    InvoiceNo,
    StockCode,
    CustomerID,
    Quantity,
    InvoiceDate,
    UnitPrice,
    Description,
    Revenue
  ) %>%
  left_join(
    customers_final,
    by = "CustomerID"
  )


# ============================================================
# 12. FINAL INTEGRATION VERIFICATION
# ============================================================

# Dimensions
dim(sales_integrated)

# Missing values
colSums(is.na(sales_integrated))

# Duplicate rows
sum(duplicated(sales_integrated))

# Check unmatched products
unmatched_products <- sales_integrated %>%
  anti_join(
    products,
    by = "StockCode"
  )

nrow(unmatched_products)

# Check missing product information
sum(is.na(sales_integrated$Description))

sum(is.na(sales_integrated$UnitPrice))

# Inspect
head(sales_integrated)


# ============================================================
# 13. TOTAL SALES REVENUE
# ============================================================

total_revenue <- sales_integrated %>%
  summarise(
    Total_Revenue = sum(Revenue)
  )

total_revenue


# ============================================================
# 14. TOP 5 PRODUCTS BY REVENUE
# ============================================================

top5_products <- sales_integrated %>%
  group_by(
    StockCode,
    Description
  ) %>%
  summarise(
    Total_Revenue = sum(Revenue),
    .groups = "drop"
  ) %>%
  arrange(
    desc(Total_Revenue)
  ) %>%
  slice_head(n = 5)

top5_products


# ============================================================
# 15. TOP 5 COUNTRIES BY REVENUE
# ============================================================

top5_countries <- sales_integrated %>%
  group_by(Country) %>%
  summarise(
    Total_Revenue = sum(Revenue),
    .groups = "drop"
  ) %>%
  arrange(
    desc(Total_Revenue)
  ) %>%
  slice_head(n = 5)

top5_countries


# ============================================================
# 16. TOP 5 CUSTOMERS BY PURCHASE VALUE
# ============================================================

top5_customers <- sales_integrated %>%
  group_by(CustomerID) %>%
  summarise(
    Total_Purchase_Value = sum(Revenue),
    .groups = "drop"
  ) %>%
  arrange(
    desc(Total_Purchase_Value)
  ) %>%
  slice_head(n = 5)

top5_customers


# ============================================================
# 17. CUSTOMER VALUE CLASSIFICATION
# ============================================================

customer_value <- sales_integrated %>%
  group_by(CustomerID) %>%
  summarise(
    Total_Purchase_Value = sum(Revenue),
    .groups = "drop"
  )

# Calculate quartile thresholds
customer_quantiles <- quantile(
  customer_value$Total_Purchase_Value,
  probs = c(
    0.25,
    0.50,
    0.75
  )
)

customer_quantiles


# Classify customers using case_when()
customer_value <- customer_value %>%
  mutate(
    Customer_Value = case_when(
      
      Total_Purchase_Value <= customer_quantiles[1] ~
        "Low Value",
      
      Total_Purchase_Value <= customer_quantiles[2] ~
        "Medium Value",
      
      Total_Purchase_Value <= customer_quantiles[3] ~
        "High Value",
      
      TRUE ~
        "Premium"
    )
  )

# Inspect
head(customer_value)

# Count each category
customer_value %>%
  count(Customer_Value)


# ============================================================
# 18. ADD CUSTOMER CLASSIFICATION
# ============================================================

sales_integrated <- sales_integrated %>%
  left_join(
    customer_value,
    by = "CustomerID"
  )

# Final dimensions
dim(sales_integrated)

# Final columns
names(sales_integrated)


# ============================================================
# 19. CUSTOMER CLASSIFICATION VALIDATION
# ============================================================

sum(is.na(sales_integrated$Customer_Value))

sum(is.na(sales_integrated$Total_Purchase_Value))


# ============================================================
# 20. COUNTRY / MARKET PERFORMANCE
# ============================================================

country_performance <- sales_integrated %>%
  group_by(Country) %>%
  summarise(
    Total_Revenue = sum(Revenue),
    Number_of_Customers = n_distinct(CustomerID),
    Number_of_Transactions = n(),
    .groups = "drop"
  ) %>%
  arrange(
    desc(Total_Revenue)
  )

country_performance


# ============================================================
# 21. HIGH-PERFORMING MARKET
# ============================================================

high_performing_market <- country_performance %>%
  slice_head(n = 1)

high_performing_market


# ============================================================
# 22. UNDERPERFORMING MARKET
# ============================================================

underperforming_market <- country_performance %>%
  slice_tail(n = 1)

underperforming_market


# ============================================================
# 23. SAVE FINAL INTEGRATED DATASET
# ============================================================

write.csv(
  sales_integrated,
  "sales_integrated.csv",
  row.names = FALSE
)


# ============================================================
# 24. SQLITE DATABASE
# ============================================================

library(RSQLite)

# Create database
con <- dbConnect(
  SQLite(),
  "retail_sales.db"
)

# Remove existing table if present
if ("retail_sales" %in% dbListTables(con)) {
  
  dbRemoveTable(
    con,
    "retail_sales"
  )
  
}

# Store final dataset
dbWriteTable(
  con,
  "retail_sales",
  sales_integrated
)

# Check database tables
dbListTables(con)


# ============================================================
# 25. SQL QUERY 1
# TOP 5 CUSTOMERS BY REVENUE
# ============================================================

sql_top_customers <- "
SELECT
    CustomerID,
    SUM(Revenue) AS Total_Revenue
FROM retail_sales
GROUP BY CustomerID
ORDER BY Total_Revenue DESC
LIMIT 5;
"

top5_customers_sql <- dbGetQuery(
  con,
  sql_top_customers
)

top5_customers_sql


# ============================================================
# 26. SQL QUERY 2
# TOTAL REVENUE BY COUNTRY
# ============================================================

sql_country_revenue <- "
SELECT
    Country,
    SUM(Revenue) AS Total_Revenue
FROM retail_sales
GROUP BY Country
ORDER BY Total_Revenue DESC;
"

country_revenue_sql <- dbGetQuery(
  con,
  sql_country_revenue
)

country_revenue_sql


# ============================================================
# 27. OPTIONAL SQL QUERY
# TOP 5 COUNTRIES
# ============================================================

sql_top_countries <- "
SELECT
    Country,
    SUM(Revenue) AS Total_Revenue
FROM retail_sales
GROUP BY Country
ORDER BY Total_Revenue DESC
LIMIT 5;
"

top5_countries_sql <- dbGetQuery(
  con,
  sql_top_countries
)

top5_countries_sql


# ============================================================
# 28. DATABASE VERIFICATION
# ============================================================

# Number of rows
dbGetQuery(
  con,
  "SELECT COUNT(*) AS Total_Rows
   FROM retail_sales;"
)

# Database columns
dbListFields(
  con,
  "retail_sales"
)


# ============================================================
# 29. EXPORT ANALYSIS RESULTS
# ============================================================

write.csv(
  top5_products,
  "top5_products.csv",
  row.names = FALSE
)

write.csv(
  top5_countries,
  "top5_countries.csv",
  row.names = FALSE
)

write.csv(
  top5_customers,
  "top5_customers.csv",
  row.names = FALSE
)

write.csv(
  customer_value,
  "customer_value_classification.csv",
  row.names = FALSE
)

write.csv(
  country_performance,
  "country_performance.csv",
  row.names = FALSE
)


# ============================================================
# 30. BUSINESS INSIGHTS
# ============================================================

cat(
  "\n============================================================\n"
)

cat(
  "BUSINESS INSIGHTS\n"
)

cat(
  "============================================================\n"
)


# Insight 1
cat(
  "\n1. Highest Revenue Product:\n",
  top5_products$Description[1],
  "\nRevenue:",
  top5_products$Total_Revenue[1],
  "\n"
)


# Insight 2
cat(
  "\n2. Highest Revenue Country:\n",
  top5_countries$Country[1],
  "\nRevenue:",
  top5_countries$Total_Revenue[1],
  "\n"
)


# Insight 3
cat(
  "\n3. Highest Value Customer:\n",
  top5_customers$CustomerID[1],
  "\nPurchase Value:",
  top5_customers$Total_Purchase_Value[1],
  "\n"
)


# High-performing market
cat(
  "\nHigh-performing Market:\n",
  high_performing_market$Country[1],
  "\nRevenue:",
  high_performing_market$Total_Revenue[1],
  "\nCustomers:",
  high_performing_market$Number_of_Customers[1],
  "\nTransactions:",
  high_performing_market$Number_of_Transactions[1],
  "\n"
)


# Underperforming market
cat(
  "\nLowest Revenue Market:\n",
  underperforming_market$Country[1],
  "\nRevenue:",
  underperforming_market$Total_Revenue[1],
  "\nCustomers:",
  underperforming_market$Number_of_Customers[1],
  "\nTransactions:",
  underperforming_market$Number_of_Transactions[1],
  "\n"
)


# ============================================================
# 31. CLOSE DATABASE
# ============================================================

dbDisconnect(con)

cat(
  "\nSQLite database connection closed successfully.\n"
)

