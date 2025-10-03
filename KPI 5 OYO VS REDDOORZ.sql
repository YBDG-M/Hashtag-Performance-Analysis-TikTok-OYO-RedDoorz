WITH combined AS (
  SELECT 'RedDoorz' AS brand, text, playCount, shareCount, collectCount, authorMeta_name, webVideoUrl, createTimeISO, hashtags
  FROM `oyo-vs-reddoorz.Data_reddoorz.clean_data`
  UNION ALL
  SELECT 'OYO' AS brand, text, playCount, shareCount, collectCount, authorMeta_name, webVideoUrl, createTimeISO, hashtags
  FROM `oyo-vs-reddoorz.Data_oyo.clean_data`
),

filtered AS (
  SELECT *,
         CASE
           WHEN LOWER(hashtags) LIKE '%hotelreddoorz%' THEN '#hotelreddoorz'
           WHEN LOWER(hashtags) LIKE '%hoteloyo%' THEN '#hoteloyo'
         END AS hashtag_group
  FROM combined
  WHERE LOWER(hashtags) LIKE '%hotelreddoorz%'
     OR LOWER(hashtags) LIKE '%hoteloyo%'
)

SELECT
  brand,
  hashtag_group,
  DATE(createTimeISO) AS date,
  text,
  playCount,
  shareCount,
  collectCount,
  authorMeta_name,
  webVideoUrl
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY brand, hashtag_group ORDER BY collectCount DESC) AS rn
  FROM filtered
)
WHERE rn <= 5
ORDER BY hashtag_group, brand, collectCount DESC;