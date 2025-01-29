-- Removing Duplicates

SELECT * 
FROM layoffs_staging; 

-- using row_number to determine the duplicates in the data

SELECT *, 
ROW_NUMBER () OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date` , stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging; 

-- creating common table expression (CTE) to filter the row_num > 1 to determin the duplicates

WITH duplicate_cte AS
(
SELECT *, 
ROW_NUMBER () OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date` , stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
) 
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- adding row_num column to filter the duplicate (row_num>1) 
-- create a new table and adding another row for row_num 

CREATE TABLE `layoffs_staging2` (
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
FROM layoffs_staging2; 

INSERT INTO layoffs_staging2 
SELECT *, 
ROW_NUMBER () OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date` , stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging; 

SELECT *
FROM layoffs_staging2 
WHERE row_num >1 ; 

-- Deleting the rows with row_num > 1


SET SQL_SAFE_UPDATES = 0;

DELETE 
FROM layoffs_staging2
WHERE row_num > 1; 

SELECT *
FROM layoffs_staging2 
WHERE row_num >1 ; 

-- Duplicates are removed. 
