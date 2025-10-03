SELECT
  brand,
  COUNT(authorMeta_name) AS total_konten,
  SUM(playCount) AS total_play,
  AVG(playCount) AS avg_play,
  SUM(diggCount) AS total_likes,
  AVG(diggCount) AS avg_likes,
  SUM(commentCount) AS total_comment,
  AVG(commentCount) AS avg_comment,
  SUM(shareCount) AS total_share,
  AVG(shareCount) AS avg_share,
  SUM(collectCount) AS total_collect,
  AVG(collectCount) AS avg_collect
FROM (
  SELECT 'RedDoorz' AS brand, * FROM `oyo-vs-reddoorz.Data_reddoorz.clean_data`
  UNION ALL
  SELECT 'OYO' AS brand, * FROM `oyo-vs-reddoorz.Data_oyo.clean_data`
)
GROUP BY brand
ORDER BY brand;