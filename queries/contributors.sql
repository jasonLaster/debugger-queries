SELECT
  REPLACE(login, "\"","") as login,
  REPLACE(avatar_url, "\"","") as avatar_url,
  STRFTIME_UTC_USEC(REPLACE(min(created_at), "\"", ""), "%m/%d/%Y") as first_comment,
  STRFTIME_UTC_USEC(REPLACE(max(created_at), "\"", ""), "%m/%d/%Y") as last_comment,
  count(created_at) as comments
FROM (
  SELECT
    JSON_EXTRACT(payload, "$.comment.user.login") as login,
    JSON_EXTRACT(payload, "$.comment.user.avatar_url") as avatar_url,
    JSON_EXTRACT(payload, "$.comment.created_at") as created_at

  FROM  [lateral-now-156717:dbg.february_activity2]
  WHERE (type = "IssueCommentEvent" or type="IssuesEvent" or type="PullRequestEvent")
),
(
  SELECT
    JSON_EXTRACT(payload, "$.comment.user.login") as login,
    JSON_EXTRACT(payload, "$.comment.user.avatar_url") as avatar_url,
    JSON_EXTRACT(payload, "$.comment.created_at") as created_at

  FROM  [lateral-now-156717:dbg.january_activity]
  WHERE (type = "IssueCommentEvent" or type="IssuesEvent" or type="PullRequestEvent")
),
(
  SELECT
    JSON_EXTRACT(payload, "$.comment.user.login") as login,
    JSON_EXTRACT(payload, "$.comment.user.avatar_url") as avatar_url,
    JSON_EXTRACT(payload, "$.comment.created_at") as created_at

  FROM  [lateral-now-156717:dbg.2016_activity]
  WHERE (type = "IssueCommentEvent" or type="IssuesEvent" or type="PullRequestEvent")
),
(
  SELECT
    JSON_EXTRACT(payload, "$.comment.user.login") as login,
    JSON_EXTRACT(payload, "$.comment.user.avatar_url") as avatar_url,
    JSON_EXTRACT(payload, "$.comment.created_at") as created_at

  FROM  [lateral-now-156717:dbg.march_activity]
  WHERE (type = "IssueCommentEvent" or type="IssuesEvent" or type="PullRequestEvent")
),
(
  SELECT
    JSON_EXTRACT(payload, "$.comment.user.login") as login,
    JSON_EXTRACT(payload, "$.comment.user.avatar_url") as avatar_url,
    JSON_EXTRACT(payload, "$.comment.created_at") as created_at

  FROM  [lateral-now-156717:dbg.april_activity]
  WHERE (type = "IssueCommentEvent" or type="IssuesEvent" or type="PullRequestEvent")
),


GROUP BY login, avatar_url
ORDER BY comments desc
LIMIT 5000;
