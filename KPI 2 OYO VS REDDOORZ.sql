WITH combined AS (
  SELECT 'RedDoorz' AS brand, text, playCount, shareCount, collectCount, authorMeta_name, webVideoUrl
  FROM `oyo-vs-reddoorz.Data_reddoorz.clean_data`
  UNION ALL
  SELECT 'OYO' AS brand, text, playCount, shareCount, collectCount, authorMeta_name, webVideoUrl
  FROM `oyo-vs-reddoorz.Data_oyo.clean_data`
)

SELECT *
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY brand ORDER BY playCount DESC) AS rn
  FROM combined
)
WHERE rn <= 5
ORDER BY brand, playCount DESC;
