SQL Data Cleaning Project – Layoffs Dataset

Overview

This project demonstrates end-to-end data cleaning using SQL on a
real-world layoffs dataset. The goal is to transform raw, inconsistent
data into a clean and analysis-ready format.

Dataset



* Source: Kaggle – Layoffs Dataset
* Description: Contains company-wise layoff data including industry,
location, total layoffs, funding, and dates.



Tech Stack

* SQL (MySQL)



Data Cleaning Process

1. Removing Duplicates
* Identified duplicates using ROW\_NUMBER() with PARTITION BY
* Removed duplicates via CTEs and staging tables



2. Standardizing Data
* Trimmed whitespace from company names
* Standardized categorical values (e.g., industry names like Crypto)
* Fixed inconsistent country naming
* Converted date columns to proper DATE format
3. Handling Missing Values
* Detected NULL and blank entries
* Filled missing industry values using self-joins
* Removed rows with insufficient or irrelevant layoff data
4. Data Transformation
* Converted text-based dates into SQL DATE format
* Renamed columns for clarity and consistency

Outcome

* Cleaned and structured dataset ready for exploratory data analysis
(EDA)
* Improved data consistency, accuracy, and usability

Usage

1. Import the raw dataset into your SQL environment
2. Execute data_cleaning.sql
3. Use the cleaned dataset for further analysis or visualization

Author
Ayush Rag

