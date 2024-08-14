-- Exploratory Analysis
SELECT *
FROM layoff_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoff_staging2;

SELECT *
FROM layoff_staging2
WHERE percentage_laid_off=1
ORDER BY funds_raised_millions DESC;
	
    -- Checking laid off by company
SELECT company, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;

	-- Checking laid off by country
SELECT country, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY country
ORDER BY 2 DESC;

	-- Checking laid off by industry
SELECT industry, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT `date`, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY `date`
ORDER BY 1 DESC;

	-- Checking laid off by date
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

	-- Checking laid off by stage
SELECT stage, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY stage
ORDER BY 2 DESC;

	-- Checking laid off by year and month
SELECT stage, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY stage
ORDER BY 2 DESC;

	-- Checking laid off by year and month without null date
SELECT SUBSTRING(`date`,1,7) AS `Month`, SUM(total_laid_off)
FROM layoff_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC;

	-- Using CTE's checking rolling total
WITH Rolling_Total AS
(
	SELECT SUBSTRING(`date`,1,7) AS `Month`, SUM(total_laid_off) AS total_laid
	FROM layoff_staging2
	WHERE SUBSTRING(`date`,1,7) IS NOT NULL
	GROUP BY `Month`
	ORDER BY 1 ASC
)
SELECT `Month`, total_laid,
SUM(total_laid) OVER (ORDER BY `Month`) AS rolling_total
FROM Rolling_Total;

	-- 
SELECT company, YEAR(`date`) AS `Date`, SUM(total_laid_off) AS Total_Laid
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

	-- Ranking based on laid off by year
WITH Company_Year (company, years, total_laid_off)  AS
(
	SELECT company, YEAR(`date`), SUM(total_laid_off)
	FROM layoff_staging2
	GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <=5
;