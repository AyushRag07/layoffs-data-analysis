# Data Cleaning Process

## Overview

This project focuses on cleaning the **World Layoffs Dataset** to make it analysis-ready.
The raw dataset contained duplicates, inconsistent formatting, null values, and incorrect data types.

---

## Step 1: Creating a Staging Table

A staging table was created to avoid modifying the original dataset.

```sql
CREATE TABLE layoff_staging LIKE layoffs;

INSERT INTO layoff_staging
SELECT * FROM layoffs;
```

---

## Step 2: Removing Duplicates

Duplicates were identified using `ROW_NUMBER()` and removed.

```sql
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions
) AS row_num
FROM layoff_staging;
```

A new table was created to safely remove duplicates:

```sql
CREATE TABLE layoff_staging2 (...);

INSERT INTO layoff_staging2
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
) AS row_num
FROM layoff_staging;
```

```sql
DELETE FROM layoff_staging2
WHERE row_num > 1;
```

---

## Step 3: Standardizing Data

### Removing Extra Spaces

```sql
UPDATE layoff_staging2
SET company = TRIM(company);
```

### Fixing Industry Values

```sql
UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';
```

### Fixing Country Names

```sql
UPDATE layoff_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';
```

---

## Step 4: Fixing Date Format

Converted date from text to proper DATE format.

```sql
UPDATE layoff_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;
```

Renamed columns for consistency:

```sql
ALTER TABLE layoff_staging2
RENAME COLUMN `date` TO `Date`,
RENAME COLUMN stage TO Stage;
```

---

## Step 5: Handling Null Values

### Identifying Nulls

```sql
SELECT *
FROM layoff_staging2
WHERE industry IS NULL OR industry = '';
```

### Replacing Blank Values with NULL

```sql
UPDATE layoff_staging2
SET industry = NULL
WHERE industry = '';
```

### Filling Missing Values Using Self Join

```sql
UPDATE layoff_staging2 t1
JOIN layoff_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;
```

---

## Step 6: Removing Irrelevant Data

Rows with no meaningful layoff data were removed.

```sql
DELETE FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;
```

---

## Step 7: Dropping Helper Columns

Temporary columns used for cleaning were removed.

```sql
ALTER TABLE layoff_staging2
DROP COLUMN row_num;
```

---

## Final Result

The dataset is now:

* Free of duplicates
* Standardized and consistent
* Properly formatted (especially dates)
* Cleaned of null and irrelevant values

---

## Conclusion

This cleaning process ensures the dataset is reliable and ready for exploratory data analysis (EDA) or visualization.
