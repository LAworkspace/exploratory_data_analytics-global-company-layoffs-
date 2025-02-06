-- EXPLOARTORY DATA ANALYSIS 

SELECT*
FROM layoffs_staging2;


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;


SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR (`date`)
ORDER BY 1 DESC;

SELECT*
FROM layoffs_staging2;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`, 1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1,9) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
;

-- company based lay off(year wise)
WITH Rolling_total AS 
( 
SELECT SUBSTRING(`date`, 1,9) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1,9) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off,
 SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_total;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`) 
ORDER BY company ASC; 


SELECT company, YEAR(`date`), YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`) 
ORDER BY 3 DESC;


-- industry based lay off year wise 
WITH industry_year(industry, years, total_laid_off) AS 
(
SELECT industry, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry, YEAR(`date`) 
) , industry_Year_Rank AS
(SELECT *,
DENSE_RANK() over (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking 
FROM industry_year
WHERE years IS NOT NULL 
)
SELECT *
FROM industry_Year_Rank 
WHERE Ranking <= 5
;

-- COUNTRY BASED LAYOFF YEAR WISE 
WITH country_year(country, years, total_laid_off) AS 
(
SELECT country, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country, YEAR(`date`) 
) , Country_Year_Rank AS
(SELECT *,
DENSE_RANK() over (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking 
FROM Country_year
WHERE years IS NOT NULL 
)
SELECT *
FROM Country_Year_Rank 
WHERE Ranking <= 5
;

SELECT *
FROM layoff_staging2;







