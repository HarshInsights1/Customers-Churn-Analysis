# Customer Churn Analysis

## Project Overview

This project analyzes customer churn through an end-to-end data analytics workflow using **Python, Microsoft SQL Server, and Power BI**.

**Dirty Excel Data → Python/Pandas → Data Cleaning → Feature Engineering → Cleaned Dataset → Microsoft SQL Server → SQL Analysis → Power BI Dashboard**

The objective is to transform raw customer data into a structured dataset, perform SQL-based analysis, and create an interactive Power BI dashboard to explore customer churn, customer value, revenue, tenure, contracts, subscription types, and other customer characteristics.

## Problem Statement

Customer churn is an important business problem because losing existing customers can affect revenue and long-term customer value.

Raw customer data can contain inconsistent text values, missing values, duplicate records, invalid numerical values, and formatting issues. This project demonstrates how such data can be cleaned, transformed, analyzed, and visualized.

> **Note:** The analysis is descriptive and identifies patterns in the dataset; it does not establish causal relationships.

## Objectives

- Clean and prepare the raw churn dataset using Python
- Handle missing, duplicate, inconsistent, and invalid records
- Standardize categorical and numerical data
- Perform feature engineering for customer-level analysis
- Store the cleaned data in Microsoft SQL Server
- Perform SQL-based customer and churn analysis
- Create KPIs and interactive visualizations in Power BI
- Analyze churn across customer and service-related dimensions

## Tools & Technologies

| Tool | Purpose |
|---|---|
| **Python** | Data cleaning and preprocessing |
| **Pandas** | Data manipulation and analysis |
| **NumPy** | Numerical operations and feature engineering |
| **Jupyter Notebook** | Python analysis workflow |
| **Microsoft SQL Server** | Database storage and SQL analysis |
| **SQL** | Business and customer churn analysis |
| **Power BI** | Dashboarding and visualization |
| **Excel / CSV** | Raw and cleaned datasets |

## Dataset

The project uses customer-level information including:

- Customer ID
- Customer Name
- Age
- State
- City
- Subscription Type
- Contract Type
- Internet Service
- Payment Method
- Monthly Charges
- Total Charges
- Tenure
- Technical Support
- Last Interaction Date
- Churn status

The original dataset was treated as an **unclean/dirty dataset** so that the complete data preparation workflow could be demonstrated.

# Project Workflow

```text
Dirty Excel Data
       ↓
Python / Pandas
       ↓
Data Cleaning
       ↓
Feature Engineering
       ↓
Cleaned Dataset
       ↓
Microsoft SQL Server
       ↓
SQL Analysis
       ↓
Power BI Dashboard
```

# Step 1 — Data Cleaning with Python

The raw Excel dataset was loaded into Python using Pandas.

### Initial Data Inspection

- `head()`
- `info()`
- `describe()`
- `shape`
- Missing-value analysis
- Duplicate-record analysis

### Duplicate Removal

```python
df.duplicated().sum()
df.drop_duplicates(inplace=True)
```

### Handling Dirty Values

Values such as `N/A`, `NULL`, blank strings, and spaces were converted into missing values.

```python
df.replace(["N/A", "NULL", "", " "], np.nan, inplace=True)
```

### Removing Extra Spaces

```python
df = df.apply(
    lambda x: x.str.strip() if x.dtype == "object" else x
)
```

### Standardizing Text

Title-case formatting was applied to:

- Customer Name
- State
- City
- Subscription Type
- Contract Type

### Standardizing Churn

Different representations such as `YES`, `Yes`, `yes`, `NO`, and `No` were standardized into `Yes` and `No`.

### Converting Numeric Columns

The following were converted to numeric values:

- Age
- Tenure Months
- Monthly Charges
- Total Charges

### Data Validation

Business rules were applied to remove:

- Ages below 18 or above 100
- Negative Monthly Charges
- Negative Total Charges

### Date Conversion

`Last_Interaction_Date` was converted to datetime format.

### Handling Missing Values

- Technical Support → `"No"`
- Payment Method → `"Unknown"`
- Monthly Charges → Mean value
- Tenure Months → Mean value
- Age → Mean value

# Step 2 — Feature Engineering

Additional features were created for analysis.

### Customer Value

```python
df["Customer_Value"] = (
    df["Monthly_Charges"] * df["Tenure_Months"]
)
```

### Monthly Revenue

```python
df["Monthly_Revenue"] = df["Monthly_Charges"]
```

### Tenure Group

| Tenure Group | Range |
|---|---|
| 0-12 | 0–12 months |
| 13-24 | 13–24 months |
| 25-48 | 25–48 months |
| 49-72 | 49–72 months |

### Senior Citizen Flag

Customers aged 60 or above were categorized as **Senior**, otherwise **Adult**.

### Churn Flag

```text
Yes → 1
No  → 0
```

# Step 3 — Microsoft SQL Server

The cleaned dataset was imported into **Microsoft SQL Server** for structured storage and SQL-based analysis.

The SQL analysis covers:

- Total number of customers
- Total churned customers
- Overall churn rate
- Average monthly charges
- Average customer tenure
- Customers by contract type
- Customers by internet service
- Churned customers by state
- Customers by payment method
- Customers by subscription type
- Revenue by state
- Average charges by contract type
- Senior-citizen churn
- Top 10 high-value customers
- Customers without technical support

# Step 4 — Power BI Dashboard

The cleaned customer data was used to build an interactive Power BI dashboard.

## Key Performance Indicators

- **Total Customers**
- **Churn Customers**
- **Retained Customers**
- **Churn Rate %**
- **Total Revenue**
- **Average Monthly Charges**
- **Average Tenure**

### Example DAX Measures

```DAX
Total Customers =
COUNT(Clean_Churn_Data[Customer_ID])
```

```DAX
Churn Customers =
CALCULATE(
    COUNT(Clean_Churn_Data[Customer_ID]),
    Clean_Churn_Data[Churn] = "Yes"
)
```

```DAX
Retained Customers =
CALCULATE(
    COUNT(Clean_Churn_Data[Customer_ID]),
    Clean_Churn_Data[Churn] = "No"
)
```

```DAX
Churn Rate =
DIVIDE(
    [Churn Customers],
    [Total Customers]
)
```

## Dashboard Visualizations

- Churn by Contract Type
- Churn by Subscription Type
- Churn by State
- Monthly Charges vs Churn
- Revenue by State
- Internet Service Distribution
- Payment Method Distribution
- Senior Citizen vs Churn
- Tenure Group vs Churn
- Customer Value by Subscription

### Interactive Slicers

- State
- City
- Contract Type
- Subscription Type
- Internet Service
- Payment Method
- Senior Citizen
- Churn
- Tenure Group
- Last Interaction Date

# Dashboard Preview:
<img width="1417" height="797" alt="Image" src="https://github.com/user-attachments/assets/ff0c3ab4-256c-4a97-991e-ca6c66c0bd8c" />

# Analysis Areas

### Customer Profile
- Age
- Senior citizen status
- Location
- Subscription type

### Customer Relationship
- Tenure
- Contract type
- Technical support
- Last interaction

### Financial Analysis
- Monthly charges
- Total charges
- Customer value
- Revenue by state

### Churn Analysis
- Overall churn
- Churn by contract
- Churn by subscription
- Churn by tenure
- Churn by location
- Senior citizen churn



# How to Run the Project

### 1. Clone the Repository

```bash
git clone YOUR_REPOSITORY_URL
cd Customer-Churn-Analysis
```

### 2. Install Python Dependencies

```bash
pip install -r requirements.txt
```

### 3. Run the Jupyter Notebook

Open:

```text
notebooks/Churn_Dataset_Analysis.ipynb
```

Make sure the required Excel dataset is available before running the notebook.

### 4. Microsoft SQL Server

Import the cleaned dataset into Microsoft SQL Server and run:

```text
sql/Churn_Analysis.sql
```

Update database/table references if your local SQL Server setup uses different names.

### 5. Power BI

Open:

```text
powerbi/Churn_Dashboard.pbix
```

Update the data source connection if required and refresh the dataset.

# Security Note

Do not upload real database passwords, credentials, API keys, or other sensitive information to GitHub.

Use local configuration or environment variables for database credentials.

# Skills Demonstrated

- Data Cleaning
- Data Preprocessing
- Exploratory Data Analysis
- Feature Engineering
- Missing Value Handling
- Data Validation
- Python
- Pandas
- NumPy
- SQL
- Microsoft SQL Server
- Power BI
- DAX
- Data Visualization
- Business Analysis
- Customer Churn Analysis
- End-to-End Analytics Workflow

#  Conclusion

The analysis of 492 customer records showed an overall churn rate of approximately **23.6%**, with 116 customers classified as churned. Churn was relatively higher among **Standard and Premium subscribers** compared with Basic subscribers, while customers in the **13–48 month tenure range** showed higher churn than long-term customers with 49–72 months of tenure.

Among internet service types, **Cable customers had the highest churn rate at approximately 29.9%**, while customers using DSL had the lowest at approximately 16.8%. The analysis also identified **Delhi, Gujarat, Uttar Pradesh, and Karnataka** among the states with the highest numbers of churned customers.

Overall, the project demonstrates how data cleaning, feature engineering, SQL analysis, and Power BI visualization can be combined to identify customer segments and patterns that may help businesses focus their customer-retention efforts.

# Project Outcome

This project demonstrates an end-to-end Data Analytics workflow, starting from a messy Excel dataset and progressing through **Python-based data preparation, feature engineering, Microsoft SQL Server analysis, and Power BI dashboard development**.

The project transforms raw customer data into a structured analytical dataset and an interactive dashboard for exploring churn, revenue, tenure, customer value, and service-related patterns.

##  Author

**Harsh Negi**

 Aspiring Data Analyst

**SQL • Python • Power BI • Tableau • Excel**

> Curious about data. Driven by insights. Focused on better decisions.
