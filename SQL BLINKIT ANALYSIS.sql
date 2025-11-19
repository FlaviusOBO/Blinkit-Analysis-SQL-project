SELECT * FROM Blinkit_Grocery_Data

--Cleaning item fat content column--

UPDATE Blinkit_Grocery_Data
SET Item_Fat_Content = 
CASE
WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'regular'
ELSE Item_Fat_Content
END

--KPI Requirements--

SELECT CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Mill
FROM Blinkit_Grocery_Data

SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales
FROM Blinkit_Grocery_Data

SELECT COUNT(*) AS No_of_items FROM Blinkit_Grocery_Data

SELECT CAST(AVG(Rating) AS DECIMAL (10,1)) AS Avg_Rating
FROM Blinkit_Grocery_Data

--Granular Requirements--
--Total sales by item fat content--
SELECT Item_Fat_Content,
          CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Mill,
          CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
          COUNT(*) AS No_of_items,
          CAST(AVG(Rating) AS DECIMAL (10,1)) AS Avg_Rating
FROM Blinkit_Grocery_Data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Mill DESC

--Total sales by item type--
SELECT Item_Type,
        CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Mill,
        CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
        COUNT(*) AS No_of_items,
        CAST(AVG(Rating) AS DECIMAL (10,1)) AS Avg_Rating
FROM Blinkit_Grocery_Data
GROUP BY Item_Type
ORDER BY Total_Sales_Mill DESC

--Fat Content by Outlet for Total Sales--
SELECT 
    Outlet_Location_Type,
    ISNULL(CAST(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' 
                         THEN Total_Sales END) / 1000000 AS DECIMAL(10,2)), 0) AS Low_Fat,
    ISNULL(CAST(SUM(CASE WHEN Item_Fat_Content = 'Regular' 
                         THEN Total_Sales END) / 1000000 AS DECIMAL(10,2)), 0) AS Regular
FROM Blinkit_Grocery_Data
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;


--Total Sales by Outlet Establishment--
SELECT Outlet_Establishment_Year,
        CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Mill,
        CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
        COUNT(*) AS No_of_items,
        CAST(AVG(Rating) AS DECIMAL (10,1)) AS Avg_Rating
FROM Blinkit_Grocery_Data
GROUP BY Outlet_Establishment_Year
ORDER BY Total_Sales_Mill DESC

SELECT * FROM Blinkit_Grocery_Data

--Percentage of Sales by Outlet Size--
SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Mill,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM Blinkit_Grocery_Data
GROUP BY Outlet_Size
ORDER BY Total_Sales_Mill DESC;

--Sales by Outlet Location--
SELECT Outlet_Location_Type,
       CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Mill
FROM Blinkit_Grocery_Data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales_Mill DESC

--All Metrics by Outlet Type--
SELECT Outlet_Type, 
CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Mill,
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM Blinkit_Grocery_Data
GROUP BY Outlet_Type
ORDER BY Total_Sales_Mill DESC




