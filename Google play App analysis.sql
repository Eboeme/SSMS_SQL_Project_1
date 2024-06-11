
CREATE TABLE GooglePlayApps (
    App NVARCHAR(MAX) NULL,
    Category NVARCHAR(50) NULL,
    Rating NVARCHAR(50) NULL,
    Reviews INT NULL,
    Size NVARCHAR(50) NULL,
    Installs NVARCHAR(50) NULL,
    Type NVARCHAR(50) NULL,
    Price MONEY NULL,
    Content_Rating NVARCHAR(50) NULL,
    Genres NVARCHAR(50) NULL,
    Last_Updated DATE NULL,
    Current_Ver NVARCHAR(50) NULL,
    Android_Ver NVARCHAR(50) NULL
);

Select * from GooglePlayApps;

-- --------------------------------------------------------------
-- ----------------------Basic Analysis--------------------------
-- --------------------------------------------------------------


-- Apps with the most reviews
SELECT App, Reviews
FROM GooglePlayApps
ORDER BY Reviews DESC;

-- Apps with the largest number of installs
SELECT App, Installs
FROM GooglePlayApps
ORDER BY 
    CASE 
        WHEN ISNUMERIC(REPLACE(REPLACE(Installs, '+', ''), ',', '')) = 1 
        THEN CAST(REPLACE(REPLACE(Installs, '+', ''), ',', '') AS BIGINT)
        ELSE 0
    END DESC;

-- Average rating, size, and number of reviews of the apps
SELECT 
    AVG(CAST(Rating AS FLOAT)) AS AverageRating,
    AVG(CAST(REPLACE(Size, 'M', '') AS FLOAT)) AS AverageSize,
    AVG(CAST(TRY_CAST(Reviews AS BIGINT) AS FLOAT)) AS AverageReviews
FROM GooglePlayApps
WHERE 
    TRY_CAST(Rating AS FLOAT) IS NOT NULL AND 
    TRY_CAST(REPLACE(Size, 'M', '') AS FLOAT) IS NOT NULL AND 
    TRY_CAST(Reviews AS BIGINT) IS NOT NULL;

-- Maximum and minimum number of installs
SELECT 
	MAX(TRY_CAST(REPLACE(REPLACE(Installs, '+', ''), ',', '') AS BIGINT)) AS MaxInstalls,
    MIN(TRY_CAST(REPLACE(REPLACE(Installs, '+', ''), ',', '') AS BIGINT)) AS MinInstalls
FROM GooglePlayApps;

-- Count of apps by category
SELECT Category, COUNT(*) AS AppCount
FROM GooglePlayApps
GROUP BY Category;

-- Total count of apps by content rating
SELECT Content_Rating, COUNT(*) AS AppCount
FROM GooglePlayApps
GROUP BY Content_Rating;


-- --------------------------------------------------------------
-- ----------------------Specific Analysis-----------------------
-- --------------------------------------------------------------
-- Free apps with more than 1,000,000 installs
SELECT App, Installs
FROM GooglePlayApps
WHERE Type = 'Free' AND CAST(REPLACE(REPLACE(Installs, '+', ''), ',', '') AS BIGINT) > 1000000;

-- Details of apps in the "ART_AND_DESIGN" category
SELECT *
FROM GooglePlayApps
WHERE Category = 'ART_AND_DESIGN';


-- Top 5 apps with the most reviews in the "GAME" category
WITH ValidReviews AS (
    SELECT App, Reviews, Category,
           TRY_CAST(Reviews AS INT) AS CleanReviews
    FROM GooglePlayApps
    WHERE Category = 'GAME' AND Reviews LIKE '%[0-9]%'
)
SELECT TOP 5 App, Reviews
FROM ValidReviews
ORDER BY CleanReviews DESC;

-- Average rating of free vs. paid apps
SELECT Type, AVG(TRY_CONVERT(FLOAT, Rating)) AS AverageRating
FROM GooglePlayApps
GROUP BY Type;


-- Apps in the "FAMILY" category with the highest rating
SELECT TOP 10 App, Rating
FROM GooglePlayApps
WHERE Category = 'FAMILY'
ORDER BY Rating DESC;

-- Top 5 most recent apps by "Social" category
SELECT TOP 5 App, Last_Updated
FROM GooglePlayApps
WHERE Category = 'SOCIAL'
ORDER BY Last_Updated DESC;

-- Apps with a size greater than 50MB and more than 1,000,000 installs
WITH ValidSizeInstalls AS (
    SELECT App, Size, Installs,
           TRY_CAST(REPLACE(Size, 'M', '') AS FLOAT) AS CleanSize,
           REPLACE(REPLACE(Installs, '+', ''), ',', '') AS CleanInstalls
    FROM GooglePlayApps
    WHERE Size LIKE '%M%' AND Installs LIKE '%[0-9]%'
)
SELECT App, Size, Installs
FROM ValidSizeInstalls
WHERE CleanSize > 50
AND TRY_CAST(CleanInstalls AS BIGINT) > 1000000;


-- Apps with more than 50,000 reviews and a rating above 4.5
SELECT App, Reviews, Rating
FROM GooglePlayApps
WHERE CAST(Reviews AS INT) > 50000 AND Rating > 4.5;

-- Apps that are not free and have a rating above 4.0
SELECT App, Rating, Price
FROM GooglePlayApps
WHERE Type = 'Paid' AND Rating > 4.0;

-- Count of apps by Android version requirements
SELECT Android_Ver, COUNT(*) AS AppCount
FROM GooglePlayApps
GROUP BY Android_Ver;

-- Apps with the most recent updates
SELECT TOP 10 App, Last_Updated
FROM GooglePlayApps
ORDER BY Last_Updated DESC;


-- Apps with "Pretend Play" in their genres
SELECT App, Genres
FROM GooglePlayApps
WHERE Genres LIKE '%Pretend Play%';



-- -------------------------------------------------------------------------------
-- ------------------------------Advanced Analysis--------------------------------
-- -------------------------------------------------------------------------------

-- Top 10 apps with the highest rating and their corresponding number of reviews
SELECT TOP 10 App, Rating, Reviews
FROM GooglePlayApps
WHERE Rating IS NOT NULL  -- Exclude rows where Rating is NULL
  AND Rating <> 'NaN'     -- Exclude rows where Rating is 'NaN'
ORDER BY Rating DESC;

-- Apps that are paid
SELECT App, Price
FROM GooglePlayApps
WHERE Type = 'Paid';

-- Apps with size between 20MB and 50MB and rating above 4.0
SELECT App, Size, Rating
FROM GooglePlayApps
WHERE TRY_CAST(REPLACE(REPLACE(Size, 'M', ''), ',', '') AS FLOAT) BETWEEN 20.0 AND 50.0
  AND TRY_CAST(Rating AS FLOAT) > 4.0;


-- Apps sorted by their number of reviews (descending order)
SELECT App, Reviews
FROM GooglePlayApps
ORDER BY CAST(Reviews AS INT) DESC;

-- Count of apps by their rating ranges
SELECT CASE 
           WHEN TRY_CAST(Rating AS DECIMAL(3,1)) >= 4.5 THEN '4.5 - 5'
           WHEN TRY_CAST(Rating AS DECIMAL(3,1)) >= 4.0 THEN '4 - 4.49'
           WHEN TRY_CAST(Rating AS DECIMAL(3,1)) >= 3.5 THEN '3.5 - 3.99'
           ELSE 'Below 3.5'
       END AS RatingRange,
       COUNT(*) AS AppCount
FROM GooglePlayApps
GROUP BY CASE 
           WHEN TRY_CAST(Rating AS DECIMAL(3,1)) >= 4.5 THEN '4.5 - 5'
           WHEN TRY_CAST(Rating AS DECIMAL(3,1)) >= 4.0 THEN '4 - 4.49'
           WHEN TRY_CAST(Rating AS DECIMAL(3,1)) >= 3.5 THEN '3.5 - 3.99'
           ELSE 'Below 3.5'
       END;

-- Comparison of the average rating, size, and number of reviews between different content ratings
SELECT DISTINCT Size
FROM GooglePlayApps
WHERE TRY_CAST(REPLACE(Size, 'M', '') AS FLOAT) IS NULL;


-- Comparing the number of installs of apps by category
SELECT DISTINCT Installs
FROM GooglePlayApps
WHERE TRY_CAST(REPLACE(REPLACE(Installs, '+', ''), ',', '') AS BIGINT) IS NULL;
