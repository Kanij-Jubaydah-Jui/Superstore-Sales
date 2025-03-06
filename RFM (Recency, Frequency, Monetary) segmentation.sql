-- RFM Segmentation
CREATE OR REPLACE VIEW RFM_SCORE_DATA AS
WITH RFM_DATA AS
(SELECT 
    'Customer Name',
    DATEDIFF(
		(SELECT MAX('Order Date') FROM superstoresales.data),
		MAX('Order Date')) AS Recency,
        COUNT(DISTINCT 'Order ID') AS Frequency,
        ROUND(SUM(Sales), 0) AS Monetary
FROM
    superstoresales.data
GROUP BY 'Customer Name')

RFM_SCORE AS
(SELECT 
    C.*
    NTILE(4) OVER (ORDER BY Recency DESC) AS R_Score,
    NTILE(4) OVER (ORDER BY Frequency ASC) AS F_Score,
    NTILE(4) OVER (ORDER BY Monetary ASC) AS M_Score
FROM
    RFM_DATA AS C)
    
SELECT 
    R.'Customer Name',
	R.Recency,
	R.Frequency,
	R.Monetary,
	R_Score,
	F_Score,
	M_Score,
    (R_Score + F_Score + M_Score) AS TOTAL_RFM_SCORE,
    CONCAT_WS('', R_Score, F_Score, M_Score) AS RFM_Score_Combination
FROM
    RFM_SCORE AS R;
    
SELECT * FROM RFM_SCORE_DATA WHERE RFM_Score_Combination = '111';

SELECT RFM_Score_Combination FROM RFM_SCORE_DATA;

CREATE OR REPLACE VIEW AS RFM_ANALYSIS AS
SELECT
	RFM_SCORE_DATA.*,
	CASE
		WHEN R_Score = 4 AND F_Score = 4 AND M_Score = 4 THEN 'High-Value Customers'
		WHEN F_Score = 4 AND M_Score = 4 AND R_Score < 4 THEN 'Loyal Customers'
		WHEN R_Score = 4 AND F_Score < 4 AND M_Score < 4 THEN 'At-Risk Customers'
		WHEN R_Score < 4 AND F_Score < 4 AND M_Score < 4 THEN 'Lost Customers'
	ELSE 'Other'
	END AS 'Customer Segment'
    FROM RFM_SCORE_DATA;
    
SELECT
	'Customer Segment',
    COUNT(*) AS NUMBER_OF_CUSTOMERS,
    ROUND(AVERAGE(Monetary), 0) AS AVERAGE_MONETARY_VALUE
FROM RFM_ANALYSIS
GROUP BY 'Customer Segment';