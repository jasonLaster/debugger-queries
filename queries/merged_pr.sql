SELECT
  url,
  title,
  login,
  date
FROM
(
  SELECT
    REPLACE(JSON_EXTRACT(payload, "$.action"), "\"", "") as action,
    REPLACE(JSON_EXTRACT(payload, "$.pull_request.html_url"), "\"", "") as url,
    REPLACE(JSON_EXTRACT(payload, "$.pull_request.title"), "\"", "") as title,
    REPLACE(JSON_EXTRACT(payload, "$.pull_request.user.login"), "\"", "") as login,
    REPLACE(JSON_EXTRACT(payload, "$.pull_request.merged"), "\"", "") as merged,
    STRFTIME_UTC_USEC(created_at, "%m/%d/%Y") as date

  FROM [lateral-now-156717:dbg.april_activity]
  where type = "PullRequestEvent"
)

where action = "closed" and merged = "true"
order by date

LIMIT 3000;
