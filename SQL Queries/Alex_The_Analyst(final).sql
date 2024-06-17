USE Youtube_Analysis;

-- Delete unwanted columns
ALTER TABLE Alex_The_Analyst_YT_Data
DROP COLUMN [Column 0];

-- Changed the tablename
EXEC sp_rename 'dbo.Alex_The_Analyst_YT_Data', 'Alex_The_Analyst';

-- Get information schema of the table
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'Alex_The_Analyst';

-- Renaming colmn names
EXEC sp_rename 'dbo.ALEX_THE_ANALYST.Hour Of Day', 'Hour of Day', 'COLUMN';
EXEC sp_rename 'dbo.ALEX_THE_ANALYST.Month Of Year', 'Month of Year', 'COLUMN';
EXEC sp_rename 'dbo.ALEX_THE_ANALYST.YearPublished', 'Year Published', 'COLUMN';
EXEC sp_rename 'dbo.ALEX_THE_ANALYST.Publish_date', 'Publish Date', 'COLUMN';

SELECT * 
FROM dbo.Alex_The_Analyst;


--Add numeric value of Day of Week
ALTER TABLE ALEX_THE_ANALYST
ADD [Day Numeric] INT;

UPDATE Alex_The_Analyst
SET [Day Numeric] = 
	CASE
		WHEN [Day of Week] = 'Mon' THEN 1
		WHEN [Day of Week] = 'Tue' THEN 2
		WHEN [Day of Week] = 'Wed' THEN 3
		WHEN [Day of Week] = 'Thu' THEN 4
		WHEN [Day of Week] = 'Fri' THEN 5
		WHEN [Day of Week] = 'Sat' THEN 6
		WHEN [Day of Week] = 'Sun' THEN 7
	END;


--Add numeric value of month
ALTER TABLE ALEX_THE_ANALYST
ADD [Month Numeric] INT;

UPDATE Alex_The_Analyst
SET [Month Numeric] =
	CASE
		WHEN [Month of Year] = 'Jan' THEN 1
		WHEN [Month of Year] = 'Feb' THEN 2
		WHEN [Month of Year] = 'Mar' THEN 3
		WHEN [Month of Year] = 'Apr' THEN 4
		WHEN [Month of Year] = 'May' THEN 5
		WHEN [Month of Year] = 'Jun' THEN 6
		WHEN [Month of Year] = 'Jul' THEN 7
		WHEN [Month of Year] = 'Aug' THEN 8
		WHEN [Month of Year] = 'Sep' THEN 9
		WHEN [Month of Year] = 'Oct' THEN 10
		WHEN [Month of Year] = 'Nov' THEN 11
		WHEN [Month of Year] = 'Dec' THEN 12
	END;


-- Change datatypes of all the columns
ALTER TABLE ALEX_THE_ANALYST
ALTER COLUMN Views INT;

ALTER TABLE ALEX_THE_ANALYST
ALTER COLUMN Likes INT;

ALTER TABLE ALEX_THE_ANALYST
ALTER COLUMN Comments INT;

ALTER TABLE ALEX_THE_ANALYST
ALTER COLUMN [Hour of Day] INT;

ALTER TABLE ALEX_THE_ANALYST
ALTER COLUMN [Year Published] INT;

-- Convert Publish_date to DATETIME
ALTER TABLE ALEX_THE_ANALYST
ALTER COLUMN [Publish Date] DATETIME;

-- Check the data types of all columns
EXEC sp_help 'ALEX_THE_ANALYST';

-------------------------------------------------------------------------------------------------------------------------
------------------------------------------Exploratory Data Analysis------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
    
	--1. Summary Statistics
	SELECT
		AVG(Views) AS AVG_VIEWS, MIN(Views) AS MIN_VIEWS,
		MAX(Views) AS MAX_VIEWS, ROUND(STDEV(Views),0) AS STD_VIEWS
	FROM Alex_The_Analyst;

	SELECT
		AVG(Likes) AS AVG_LIKES, MIN(Likes) AS MIN_LIKES,
		MAX(Likes) AS MAX_LIKES, ROUND(STDEV(Likes),0) AS STD_LIKES
	FROM Alex_The_Analyst;

	SELECT
		AVG(Comments) AS AVG_COMMENTS, MIN(Comments) AS MIN_COMMENTS,
		MAX(Comments) AS MAX_COMMENTS, ROUND(STDEV(Comments),0) AS STD_COMMENTS
	FROM Alex_The_Analyst;

	--Conclusion: Standard Deviation is higher than average on all the 3 cases,
	--it indicates a high degree of variability in the data when compared to average.

	--2. Time-Based Analysis : This query will give you a detailed analysis of views,
	-- likes and comments over time.
	SELECT 
		[Year Published],
		[Month of Year],
		COUNT(*) AS VIDEO_COUNT,
		AVG(Views) AS AVG_VIEWS, 
		AVG(Likes) AS AVG_Likes,
		AVG(Comments) AS AVG_COMMENTS,
		[Month Numeric]
	FROM Alex_The_Analyst
	GROUP BY [Year Published], [Month of Year], [Month Numeric]
	ORDER BY [Year Published], [Month Numeric];

	--3. Analysis of how views, likes, and comments vary based on the day of the week.
	SELECT
		[Day of Week],
		AVG(Views) AS AVG_VIEWS,
		AVG(Likes) AS AVG_LIKES,
		AVG(Comments) AS AVG_COMMENTS,
		[DAY NUMERIC]
	FROM Alex_The_Analyst
	GROUP BY [Day of Week], [DAY NUMERIC] 
	ORDER BY [DAY NUMERIC];

	--4. Monthly averages of views, likes, and comments.
	SELECT 
		[Month of Year],
		AVG([Views]) AS AVG_VIEWS,
		AVG([Likes]) AS AVG_LIKES,
		AVG([Comments]) AS AVG_COMMENTS,
		[Month Numeric]
	FROM Alex_The_Analyst
	GROUP BY [Month of Year], [Month Numeric]
	ORDER BY [Month Numeric];

	--5. Total videos published in each hour.
	SELECT 
		[Hour of Day],
		COUNT(*) AS TOTAL_VIDEOS
	FROM Alex_The_Analyst
	GROUP BY [Hour of Day]
	ORDER BY TOTAL_VIDEOS DESC;

	--6. Top 5 most viewed videos
	SELECT TOP 5
		Title,
		[Views],
		[Year published]
	FROM Alex_The_Analyst
	ORDER BY [Views] DESC;

	--7. Top 5 least viewed videos
	SELECT TOP 5
		Title,
		[Views],
		[Year published]
	FROM Alex_The_Analyst
	ORDER BY [Views];

	--8. Top 5 most liked videos
	SELECT TOP 5
		Title,
		[Likes],
		[Year published]
	FROM Alex_The_Analyst
	ORDER BY [Likes] DESC;

	--9. Top 5 least liked videos
	SELECT TOP 5
		Title,
		[Likes],
		[Year published]
	FROM Alex_The_Analyst
	ORDER BY [Likes];

	--10. Top 5 videos with most user encagements
	SELECT TOP 5
		Title,
		[Comments],
		[Year published]
	FROM Alex_The_Analyst
	ORDER BY [Comments] DESC;


SELECT * FROM Alex_The_Analyst;
	




