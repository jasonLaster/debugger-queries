SELECT
  count(url) as num_prs,
  week(created_at) as week_num
FROM

(
  SELECT
    REPLACE(JSON_EXTRACT(payload, "$.action"), "\"", "") as action,
    REPLACE(JSON_EXTRACT(payload, "$.pull_request.html_url"), "\"", "") as url,
    REPLACE(JSON_EXTRACT(payload, "$.pull_request.title"), "\"", "") as title,
    REPLACE(JSON_EXTRACT(payload, "$.pull_request.user.login"), "\"", "") as login,
    REPLACE(JSON_EXTRACT(payload, "$.pull_request.merged"), "\"", "") as merged,
    STRFTIME_UTC_USEC(created_at, "%m/%d/%Y") as date,
    created_at

  FROM [lateral-now-156717:dbg.2016_activity]
  where type = "PullRequestEvent"
),

where action = "closed" and merged = "true"
group by week_num
order by week_num

LIMIT 3000;