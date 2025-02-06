# exploratory_data_analytics-global-company-layoffs-
# 📊 Global Company Layoffs - SQL Data Analytics

## 📌 Project Overview
This project focuses on analyzing **global company layoffs data** using **SQL**. The primary objectives include:  
- **Data Cleaning**: Handling missing values, duplicates, and ensuring consistency in the dataset.  
- **Exploratory Data Analysis (EDA)**: Gaining insights into **layoff trends**, **industry impacts**, and **regional variations** over time.  

By leveraging **SQL queries**, we extract meaningful patterns and present data-driven insights.  


---

## 📂 Dataset
- The dataset contains records of **company layoffs worldwide**, including:  
  - `company_name` (Company that conducted layoffs)  
  - `industry` (Sector the company belongs to)  
  - `location` (Country of the company)  
  - `date` (Month/Year of layoffs)  
  - `total_laid_off` (Number of employees affected)  
  - `percentage_laid_off` (Proportion of workforce laid off)  

---

## 🔧 Data Cleaning Process
Key data cleaning steps performed:
1. **Handling Missing Values** – Filling or removing missing `total_laid_off` and `industry` fields.  
2. **Removing Duplicates** – Identifying and eliminating redundant records.  
3. **Standardizing Formats** – Ensuring consistent date formats (`YYYY-MM`), uniform industry categories, and country names.  
4. **Outlier Detection** – Checking extreme layoff cases that may distort analysis.  

SQL Queries for Cleaning:
```sql
-- Removing duplicates
DELETE FROM layoffs_data
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM layoffs_data
    GROUP BY company_name, date, total_laid_off
);

-- Handling missing values in 'industry' by replacing NULLs with 'Unknown'
UPDATE layoffs_data
SET industry = 'Unknown'
WHERE industry IS NULL;
