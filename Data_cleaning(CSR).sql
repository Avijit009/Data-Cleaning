-- Data cleaning

SELECT *
FROM layoffs;

-- Creating another staging table from the layoffs table
CREATE TABLE layoff_staging
LIKE layoffs;
-- Inserting data from the layoffs table
INSERT layoff_staging 
SELECT *
FROM layoffs;

SELECT *
FROM layoff_staging;

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

SELECT *
FROM layoff_staging2;

INSERT INTO layoff_staging2
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location,
 industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoff_staging;

-- Remove Duplicates
	-- Checking Duplicates
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location,
 industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoff_staging;

	-- Using CTE's
WITH duplicate_cte AS 
(
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location,
 industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoff_staging
)
SELECT * FROM duplicate_cte
WHERE row_num>1;
	-- Removing duplicates
WITH duplicate_cte AS 
(
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location,
 industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoff_staging
)
SELECT * FROM duplicate_cte
WHERE row_num>1;


SELECT *
FROM layoff_staging2
WHERE row_num > 1;

DELETE
FROM layoff_staging2
WHERE row_num > 1;

SELECT *
FROM layoff_staging2
WHERE row_num > 1;

SELECT *
FROM layoff_staging2;

-- Standardize the data
SELECT DISTINCT (company)
FROM layoff_staging2;

SELECT company, (TRIM(company))
FROM layoff_staging2;

UPDATE layoff_staging2
SET company = TRIM(company);

SELECT *
FROM layoff_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoff_staging2
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING '.'FROM country)
FROM layoff_staging2
ORDER BY 1;

UPDATE layoff_staging2
SET country = TRIM(TRAILING '.'FROM country)
WHERE country LIKE 'United States%';

SELECT DISTINCT country
FROM layoff_staging2
ORDER BY 1;

	-- Changing date format
SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoff_staging2;

UPDATE layoff_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoff_staging2;

-- Null or Blank values
SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT DISTINCT (industry)
FROM layoff_staging2;

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND industry IS NULL
OR industry = '';

	-- Finding those with missing indystry name
SELECT t1.industry, t2.industry
FROM layoff_staging2 t1
JOIN layoff_staging2 t2
	ON t1.company=t2.company
    AND t1.location=t1.location
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

	-- Updating blank to NUll
UPDATE layoff_staging2
SET industry = NULL
WHERE industry = '';

	-- Updating Industry name
UPDATE layoff_staging2 t1
JOIN layoff_staging2 t2
	ON t1.company=t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT *
FROM layoff_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND industry IS NULL
OR industry = '';

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoff_staging2;

-- Remove unnecessary row/column
ALTER TABLE layoff_staging2
DROP COLUMN row_num;
