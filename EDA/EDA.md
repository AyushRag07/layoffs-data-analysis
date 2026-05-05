# 📊 Exploratory Data Analysis (EDA)

## Overview

In this phase, we explore the dataset to identify trends, patterns, and any interesting insights such as outliers.

Typically, EDA starts with a clear objective, but in this case, we perform an open-ended exploration to understand the data better and uncover potential insights.


## Initial Data Exploration

```sql
SELECT * 
FROM world_layoffs.layoff_staging2;
```
**Output:**

| company            | location         | industry    | total_laid_off | percentage_laid_off | Date       | Stage     | country        | funds_raised_millions |
|--------------------|------------------|-------------|----------------|----------------------|------------|-----------|----------------|------------------------|
| Included Health    | SF Bay Area      | Healthcare  | NULL           | 0.06                 | 7/25/2022  | Series E  | United States  | 272                    |
| &Open              | Dublin           | Marketing   | 9              | 0.09                 | 11/17/2022 | Series A  | Ireland        | 35                     |
| #Paid              | Toronto          | Marketing   | 19             | 0.17                 | 1/27/2023  | Series B  | Canada         | 21                     |
| 100 Thieves        | Los Angeles      | Consumer    | 12             | NULL                 | 7/13/2022  | Series C  | United States  | 120                    |
| 10X Genomics       | SF Bay Area      | Healthcare  | 100            | 0.08                 | 8/4/2022   | Post-IPO  | United States  | 242                    |
| 1stdibs            | New York City    | Retail      | 70             | 0.17                 | 4/2/2020   | Series D  | United States  | 253                    |
| 2TM                | Sao Paulo        | Crypto      | 90             | 0.12                 | 6/1/2022   | Unknown   | Brazil         | 250                    |
| 2TM                | Sao Paulo        | Crypto      | 100            | 0.15                 | 9/1/2022   | Unknown   | Brazil         | 250                    |
| 2U                 | Washington D.C.  | Education   | NULL           | 0.2                  | 7/28/2022  | Post-IPO  | United States  | 426                    |

## Maximum Layoffs

```sql
SELECT MAX(total_laid_off)
FROM world_layoffs.layoff_staging2;
```
**Output:**

| MAX(percentage_laid_off) |
|--------------------------|
| 12000                    |

## Layoff Percentage Analysis

```sql
-- Looking at percentage to understand how severe layoffs were
SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM world_layoffs.layoff_staging2
WHERE percentage_laid_off IS NOT NULL;
```

**Output:**

| MAX(percentage_laid_off) | MIN(percentage_laid_off) |
|--------------------------|--------------------------|
| 1                        | 0                        |

## Companies with 100% Layoffs

```sql
SELECT *
FROM world_layoffs.layoff_staging2
WHERE percentage_laid_off = 1;
```
**Output:**

| company        | location        | industry        | total_laid_off | percentage_laid_off | Date       | Stage     | country        | funds_raised_millions   |
|----------------|-----------------|-----------------|----------------|----------------------|------------|-----------|----------------|------------------------|
| Ahead          | SF Bay Area     | Healthcare      | 44             | 1                    | 4/14/2022  | Unknown   | United States  | 9                      |
| Airlift        | Lahore          | Logistics       | NULL           | 1                    | 7/12/2022  | Series B  | Pakistan       | 109                    |
| Airy Rooms     | Jakarta         | Travel          | NULL           | 1                    | 5/7/2020   | Unknown   | Indonesia      | NULL                   |
| Amplero        | Seattle         | Marketing       | 17             | 1                    | 3/29/2020  | Series B  | United States  | 25                     |
| Arch Oncology  | Brisbane        | Healthcare      | NULL           | 1                    | 1/13/2023  | Series C  | United States  | 155                    |
| Assure         | Salt Lake City  | Finance         | NULL           | 1                    | 11/23/2022 | Seed      | United States  | 2                      |
| Atsu           | Seattle         | Infrastructure  | 6              | 1                    | 4/10/2020  | Unknown   | United States  | 1                      |

## Companies with 100% Layoffs (Sorted by Funding)

```sql
-- Sorting by funds raised to understand company size
SELECT *
FROM world_layoffs.layoff_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
```
**Output:**

| company               | location       | industry        | total_laid_off | percentage_laid_off  | Date       | Stage            | country         | funds_raised_millions  |
|----------------------|-----------------|-----------------|----------------|----------------------|------------|------------------|-----------------|------------------------|
| Britishvolt          | London          | Transportation  | 206            | 1                    | 1/17/2023  | Unknown          | United Kingdom  | 2400                   |
| Quibi                | Los Angeles     | Media           | NULL           | 1                    | 10/21/2020 | Private Equity   | United States   | 1800                   |
| Deliveroo Australia  | Melbourne       | Food            | 120            | 1                    | 11/15/2022 | Post-IPO         | Australia       | 1700                   |
| Katerra              | SF Bay Area     | Construction    | 2434           | 1                    | 6/1/2021   | Unknown          | United States   | 1600                   |
| BlockFi              | New York City   | Crypto          | NULL           | 1                    | 11/28/2022 | Series E         | United States   | 1000                   |
| Aura Financial       | SF Bay Area     | Finance         | NULL           | 1                    | 1/11/2021  | Unknown          | United States   | 584                    |
| Openpay              | Melbourne       | Finance         | 83             | 1                    | 2/7/2023   | Post-IPO         | Australia       | 299                    |

## Largest Single Layoffs

```sql
SELECT company, total_laid_off
FROM world_layoffs.layoff_staging
ORDER BY total_laid_off DESC
LIMIT 5;
```
**Output:**

| company    | total_laid_off |
|------------|----------------|
| Google     | 12000          |
| Google     | 12000          |
| Meta       | 11000          |
| Meta       | 11000          |
| Microsoft  | 10000          |

## Companies with Highest Total Layoffs

```sql
SELECT company, SUM(total_laid_off)
FROM world_layoffs.layoff_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;
```
**Output:**

| company      | SUM(total_laid_off) |
|--------------|---------------------|
| Amazon       | 18150               |
| Google       | 12000               |
| Meta         | 11000               |
| Salesforce   | 10090               |
| Microsoft    | 10000               |
| Philips      | 10000               |
| Ericsson     | 8500                |
| Uber         | 7585                |
| Dell         | 6650                |
| Booking.com  | 4601                |

## Layoffs by Location

```sql
SELECT location, SUM(total_laid_off)
FROM world_layoffs.layoff_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;
```
**Output:**

| location        | SUM(total_laid_off) |
|-----------------|---------------------|
| SF Bay Area     | 125631              |
| Seattle         | 34743               |
| New York City   | 29364               |
| Bengaluru       | 21787               |
| Amsterdam       | 17140               |
| Stockholm       | 11217               |
| Boston          | 10785               |
| Sao Paulo       | 9081                |
| Austin          | 8980                |
| Chicago         | 6419                |

## Layoffs by Country

```sql
-- Total layoffs across the dataset
SELECT country, SUM(total_laid_off)
FROM world_layoffs.layoff_staging2
GROUP BY country
ORDER BY 2 DESC;
```
**Output:**

| country          | SUM(total_laid_off) |
|------------------|---------------------|
| United States    | 256559              |
| India            | 35993               |
| Netherlands      | 17220               |
| Sweden           | 11264               |
| Brazil           | 10391               |
| Germany          | 8701                |
| United Kingdom   | 6398                |

## Year-wise Layoffs

```sql
SELECT YEAR(date), SUM(total_laid_off)
FROM world_layoffs.layoff_staging2
GROUP BY YEAR(date)
ORDER BY 1 ASC;
```

**Output:**

| YEAR(date) | SUM(total_laid_off) |
|------------|---------------------|
| 2020       | 80998               |
| 2021       | 15823               |
| 2022       | 160661              |
| 2023       | 125677              |

## Layoffs by Industry

```sql
SELECT industry, SUM(total_laid_off)
FROM world_layoffs.layoff_staging2
GROUP BY industry
ORDER BY 2 DESC;
```
**Output:**

| industry        | SUM(total_laid_off) |
|-----------------|---------------------|
| Consumer        | 45182               |
| Retail          | 43613               |
| Other           | 36289               |
| Transportation  | 33748               |
| Finance         | 28344               |
| Healthcare      | 25953               |
| Food            | 22855               |

## Layoffs by Company Stage

```sql
SELECT stage, SUM(total_laid_off)
FROM world_layoffs.layoff_staging2
GROUP BY stage
ORDER BY 2 DESC;
```
**Output:**

| stage      | SUM(total_laid_off) |
|------------|---------------------|
| Post-IPO   | 204132              |
| Unknown    | 40716               |
| Acquired   | 27576               |
| Series C   | 20017               |
| Series D   | 19225               |
| Series B   | 15311               |
| Series E   | 12697               |

## Top Companies per Year

```sql
-- Identify top 3 companies with highest layoffs each year
WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoff_staging2
  GROUP BY company, YEAR(date)
),
Company_Year_Rank AS 
(
  SELECT company, years, total_laid_off,
  DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;
```
**Output:**

| company      | years | total_laid_off | ranking |
|--------------|-------|----------------|---------|
| Uber         | 2020  | 7525           | 1       |
| Booking.com  | 2020  | 4375           | 2       |
| Groupon      | 2020  | 2800           | 3       |
| Bytedance    | 2021  | 3600           | 1       |
| Katerra      | 2021  | 2434           | 2       |
| Zillow       | 2021  | 2000           | 3       |
| Meta         | 2022  | 11000          | 1       |


## Rolling Monthly Layoffs

```sql
-- Using CTE to calculate cumulative layoffs over time
WITH DATE_CTE AS 
(
  SELECT SUBSTRING(date,1,7) AS dates, 
         SUM(total_laid_off) AS total_laid_off
  FROM layoff_staging2
  GROUP BY dates
)
SELECT dates, 
       SUM(total_laid_off) OVER (ORDER BY dates ASC) AS rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;
```

**Output:**

| dates   | rolling_total_layoffs |
|---------|------------------------|
| 2020-03 | 9628                   |
| 2020-04 | 36338                  |
| 2020-05 | 62142                  |
| 2020-06 | 69769                  |
| 2020-07 | 76881                  |
| 2020-08 | 78850                  |
| 2020-09 | 79459                  |

## Conclusion

This exploratory analysis helps in identifying:

* Companies with the highest layoffs
* Industries and regions most affected
* Yearly and monthly layoff trends
* Extreme cases such as 100% workforce layoffs


