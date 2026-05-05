# 🧹 SQL Data Cleaning – Layoffs Dataset  

## 📌 Project Overview  

This project demonstrates a structured **data cleaning pipeline using SQL** on a real-world layoffs dataset. The objective is to transform raw, inconsistent data into a **clean, reliable, and analysis-ready dataset**.

The process focuses on improving **data quality, consistency, and integrity**, ensuring it can be effectively used for downstream **EDA, visualization, and modeling**.


## 📂 Dataset  

- **Source:** Kaggle – Layoffs Dataset  
- **Data State:** Raw, uncleaned dataset with inconsistencies and missing values  
- **Scope:** Company-level layoff data including industry, location, funding, and dates  


## 🛠 Tech Stack  

- **SQL (MySQL):** Data cleaning, transformation, and validation  
- **GitHub:** Version control and project documentation  


## 🔧 Data Cleaning Workflow  

The cleaning pipeline follows a systematic approach to ensure high-quality output:

### 1. Duplicate Removal  
- Identified duplicate records using `ROW_NUMBER()` with `PARTITION BY`  
- Removed duplicates using CTEs and staging tables  

### 2. Data Standardization  
- Trimmed whitespace from company names  
- Standardized categorical fields (e.g., industry names like *Crypto*)  
- Corrected inconsistent country naming  
- Converted date fields into proper `DATE` format  

### 3. Handling Missing Values  
- Identified NULL and blank entries  
- Imputed missing industry values using self-joins  
- Removed records with insufficient or irrelevant data  

### 4. Data Transformation  
- Converted text-based dates into SQL-compatible format  
- Renamed columns for clarity and consistency  


## 📊 Outcome  

- Produced a **clean, structured dataset** ready for analysis  
- Improved **data consistency, accuracy, and completeness**  
- Established a reusable **data cleaning workflow in SQL**  


## 🚀 Usage  

1. Import the raw dataset into your SQL environment  
2. Run `data_cleaning.sql`  
3. Use the cleaned dataset for EDA, dashboards, or further analysis  


## 💡 Business Value  

This project enables:  

- Reliable foundation for **data-driven decision-making**  
- Improved accuracy in **trend analysis and reporting**  
- Reduction of noise and inconsistencies in datasets  
- Scalable cleaning approach for **real-world data pipelines**  


## 👤 Author  

**Ayush Rag**  
