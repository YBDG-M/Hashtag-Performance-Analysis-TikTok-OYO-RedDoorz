WITH combined AS (
  SELECT 'RedDoorz' AS brand, createTimeISO, collectCount, webVideoUrl
  FROM `oyo-vs-reddoorz.Data_reddoorz.clean_data`
  UNION ALL
  SELECT 'OYO' AS brand, createTimeISO, collectCount, webVideoUrl
  FROM `oyo-vs-reddoorz.Data_oyo.clean_data`
)

SELECT
  brand,
  DATE(createTimeISO) AS date,
  SUM(collectCount) AS total_collect,
  ARRAY_AGG(DISTINCT webVideoUrl) AS video_links
FROM combined
GROUP BY brand, date
ORDER BY brand, date DESC;
