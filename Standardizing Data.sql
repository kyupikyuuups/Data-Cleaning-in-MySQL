-- Standardize the data

SELECT company, TRIM(company) 
FROM layoffs_staging2; 

UPDATE layoffs_staging2
SET company = TRIM(company) ;

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1; 

SELECT industry
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%' ; 

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%' ; 

SELECT *
FROM layoffs_staging2; 

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1; 


UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%' ; 

SELECT `date`, 
str_to_date(`date`,'%m/%d/%Y')
FROM layoffs_staging2; 

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`,'%m/%d/%Y') ; 

SELECT `date`
FROM layoffs_staging2; 
