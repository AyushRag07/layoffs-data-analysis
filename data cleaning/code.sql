-- 1. Check for duplicates and remove any duplicates
-- 2. standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. remove any columns and rows that are not necessary - a few ways


select *
from layoffs;

Create table layoff_staging    
like layoffs; -- same as layoffs, but just the structure, not actual data 

select *
from layoff_staging;

Insert layoff_staging 
select*
from layoffs; -- insert all the data in staging

-- assigning row number
select*,
ROW_NUMBER() OVER
(PARTITION BY company, industry, total_laid_off,`date`) AS row_num
FROM layoff_staging;

-- finding and removing duplicates use CTE
with duplicate_cte as
(select*,
ROW_NUMBER() OVER
(
PARTITION BY company,location, industry, total_laid_off,`date`, stage,country, funds_raised_millions) AS row_num
FROM layoff_staging
)
delete 
from duplicate_cte
where row_num>1;

-- creating another staging database2 (copy from clipboard--create table)

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoff_staging2;

-- Inserting data into that table including row number to delete it 

INSERT INTO `world_layoffs`.`layoff_staging2`
(`company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
`row_num`)
SELECT `company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		world_layoffs.layoff_staging;

-- now that we have this we can delete rows were row_num is greater than 2

DELETE FROM world_layoffs.layoff_staging2
WHERE row_num > 1;

-- Standardizing Data = finding issues in the data and fixing it

select *
from layoff_staging2;
-- 
select distinct trim(company)
from layoff_staging2;
-- to remove the extra white space
select company, trim(company) 
from layoff_staging2;
-- we need to update the table as we trim 
Update layoff_staging2
Set company = trim(company);

select industry
from layoff_staging2
where industry like 'Crypto%';

Update layoff_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select *
from layoff_staging2;
-- correcting things in location
select country
from layoff_staging2
where country like 'United States.%';
-- updating it correctly
Update layoff_staging2
set country = 'United States'
where country like 'United States%';

select Distinct country, trim(trailing '.' from country) -- for any specific character trim  
from layoff_staging2;

-- correcting date
select `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') -- to convert text into date column exactly as written
from layoff_staging2;

Update layoff_staging2
set `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;  -- modifying datatype to DATE

ALTER TABLE layoff_staging2
RENAME COLUMN `date` TO `Date`,
RENAME COLUMN stage TO Stage;  -- Renaming column name

-- Managing null values
Select*
from layoff_staging2;

Select*
from layoff_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

Select company, industry -- finding nulls and blank spaces
from layoff_staging2
where industry is NUll
or industry = '';

-- trying to populate row
Select*
from layoff_staging2 t1
join layoff_staging2 t2
	ON t1.company = t2.company
where 
t1.industry is null 
and t2.industry is not null;

update layoff_staging2 
set industry = NULL
where industry = '';

Select*
from layoff_staging2
where company like 'Airbn%';


update layoff_staging2 t1
join layoff_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where 
t1.industry is null
and t2.industry is not null;

Select*
from layoff_staging2
where company like 'Airbn%';

-- deleting data with no use
Select*
from layoff_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

delete
from layoff_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

alter table
layoff_staging2
drop column row_num


