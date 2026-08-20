-- =========================================================
-- NEON BLACK MARKET LOG ANALYZER
-- 20 INVESTIGATION QUERIES
-- =========================================================

-- HOW I BUILD A QUERY
-- 1. SELECT = What information do I want to see?
-- 2. FROM = What table am I starting from?
-- 3. JOIN = Do I need information from another table?
-- 4. ON = What columns connect the tables?
-- 5. WHERE = Do I need to filter the rows?
-- 6. GROUP BY = Am I grouping similar records together?
-- 7. HAVING = Do I need to filter the groups?
-- 8. ORDER BY = How should the results be sorted?
-- 9. LIMIT = Do I only want a certain number of results?
-- =========================================================
-- QUERY 1: FAILED EVENTS
-- Looking for all failed events.
-- A lot of failed activity could mean someone is trying to get into an account.
--
-- Steps:
-- 1. Start with security_logs.
-- 2. JOIN statuses so I can see the actual status.
-- 3. WHERE keeps only the failed events.

SELECT sl.*, s.status
FROM security_logs sl
         JOIN statuses s
              ON sl.event_status_id = s.status_id
WHERE s.status = 'failed';
-- =========================================================
-- QUERY 2: HIGH AND CRITICAL EVENTS
-- Looking for high and critical events.
-- These are the events I would want to check first because they are more serious.
--
-- Steps:
-- 1. Start with security_logs.
-- 2. JOIN severity_levels so I can see the severity.
-- 3. IN lets me look for high OR critical at the same time.

SELECT sl.*, sev.severity
FROM security_logs sl
         JOIN severity_levels sev
              ON sl.severity_id = sev.severity_id
WHERE sev.severity IN ('high', 'critical');
-- =========================================================
-- QUERY 3: LOCKED ACCOUNTS
-- Looking for activity from locked accounts.
-- A locked account should not normally still be doing things in the system.
--
-- Steps:
-- 1. Start with security_logs.
-- 2. JOIN account_statuses to get the account status.
-- 3. WHERE keeps only locked accounts.

SELECT sl.*, ac.account_status
FROM security_logs sl
         JOIN account_statuses ac
              ON sl.status_id = ac.status_id
WHERE ac.account_status = 'locked';
-- =========================================================
-- QUERY 4: WATCHLIST
-- Looking for anything already marked on the watchlist.
-- These records already have a reason to be looked at closer.
--
-- Steps:
-- 1. Start with security_logs.
-- 2. watchlist_flag is already inside this table.
-- 3. WHERE TRUE only shows records marked on the watchlist.

SELECT *
FROM security_logs
WHERE watchlist_flag = TRUE;
-- =========================================================
-- QUERY 5: LOGIN ACTIVITY
-- Looking at all login activity in time order.
-- This makes it easier to see the order that login events happened.
--
-- Steps:
-- 1. JOIN event_types so I can see the event type.
-- 2. WHERE keeps only login events.
-- 3. ORDER BY puts the login events in time order.

SELECT sl.*, et.event_type
FROM security_logs sl
         JOIN event_types et
              ON sl.event_id = et.event_id
WHERE et.event_type = 'login'
ORDER BY sl.event_time;
-- =========================================================
-- QUERY 6: TOP 10 RISK SCORES
-- Showing the 10 records with the highest risk scores.
-- This helps me find the most risky activity first.
--
-- Steps:
-- 1. Start with security_logs.
-- 2. ORDER BY DESC puts the highest risk score first.
-- 3. LIMIT 10 only gives me the first 10 results.

SELECT *
FROM security_logs
ORDER BY risk_score DESC
LIMIT 10;
-- =========================================================
-- QUERY 7: COUNT EVENT TYPES
-- Counting how many records there are for each event type.
-- This helps show what type of activity happens the most.
--
-- Steps:
-- 1. JOIN event_types to get the event name.
-- 2. GROUP BY puts the same event types together.
-- 3. COUNT tells me how many of each event happened.
-- 4. ORDER BY shows the most common first.

SELECT et.event_type,
       COUNT(*) AS total_events
FROM security_logs sl
         JOIN event_types et
              ON sl.event_id = et.event_id
GROUP BY et.event_type
ORDER BY total_events DESC;
-- =========================================================
-- QUERY 8: FAILED EVENTS BY USER
-- Counting failed events for each user.
-- A user with multiple failures might be worth checking more closely.
--
-- Steps:
-- 1. JOIN statuses so I can find failed events.
-- 2. WHERE keeps only failed records.
-- 3. GROUP BY separates the results by username.
-- 4. COUNT shows how many failures each user has.

SELECT sl.username,
       COUNT(*) AS failed_events
FROM security_logs sl
         JOIN statuses s
              ON sl.event_status_id = s.status_id
WHERE s.status = 'failed'
GROUP BY sl.username
ORDER BY failed_events DESC;
-- =========================================================
-- QUERY 9: ACTIVITY BY IP ADDRESS
-- Counting how many records came from each IP address.
-- A really active IP address could stand out from normal activity.
--
-- Steps:
-- 1. Start with security_logs because IP address is already there.
-- 2. GROUP BY puts matching IP addresses together.
-- 3. COUNT shows how many records came from each IP.
-- 4. DESC puts the most active IPs first.

SELECT ip_address,
       COUNT(*) AS total_records
FROM security_logs
GROUP BY ip_address
ORDER BY total_records DESC;
-- =========================================================
-- QUERY 10: SERIOUS EVENTS BY USER
-- Counting high or critical events for each user.
-- This helps show which users are connected to the most serious activity.
--
-- Steps:
-- 1. JOIN severity_levels to get the severity.
-- 2. WHERE keeps high and critical events.
-- 3. GROUP BY separates the results by username.
-- 4. COUNT shows how many serious events each user has.

SELECT sl.username,
       COUNT(*) AS serious_events
FROM security_logs sl
         JOIN severity_levels sev
              ON sl.severity_id = sev.severity_id
WHERE sev.severity IN ('high', 'critical')
GROUP BY sl.username
ORDER BY serious_events DESC;
-- =========================================================
-- QUERY 11: FAILED EVENTS BY DEVICE
-- Counting failed events for each device type.
-- This can help show if one type of device is showing more failed activity.
--
-- Steps:
-- 1. JOIN device_types to get the device name.
-- 2. JOIN statuses to get the event status.
-- 3. WHERE keeps only failed events.
-- 4. GROUP BY puts the same device types together.
-- 5. COUNT shows the failures for each device type.

SELECT d.device_type,
       COUNT(*) AS failed_events
FROM security_logs sl
         JOIN device_types d
              ON sl.device_id = d.device_id
         JOIN statuses s
              ON sl.event_status_id = s.status_id
WHERE s.status = 'failed'
GROUP BY d.device_type
ORDER BY failed_events DESC;
-- =========================================================
-- QUERY 12: SUSPICIOUS EVENTS BY COUNTRY
-- Counting suspicious activity by country.
-- I am using high and critical severity as suspicious activity here.
--
-- Steps:
-- 1. JOIN severity_levels to get the severity.
-- 2. WHERE keeps high and critical events.
-- 3. GROUP BY separates the results by country.
-- 4. COUNT shows how many suspicious events came from each country.

SELECT sl.location_country,
       COUNT(*) AS suspicious_events
FROM security_logs sl
         JOIN severity_levels sev
              ON sl.severity_id = sev.severity_id
WHERE sev.severity IN ('high', 'critical')
GROUP BY sl.location_country
ORDER BY suspicious_events DESC;
-- =========================================================
-- QUERY 13: FAILURE REASONS
-- Counting the different failure reasons.
-- This helps show what is causing failed activity the most.
--
-- Steps:
-- 1. failure_reason is already inside security_logs.
-- 2. IS NOT NULL removes records that do not have a failure reason.
-- 3. GROUP BY puts the same failure reasons together.
-- 4. COUNT shows how many times each reason happened.

SELECT failure_reason,
       COUNT(*) AS total_failures
FROM security_logs
WHERE failure_reason IS NOT NULL
GROUP BY failure_reason
ORDER BY total_failures DESC;
-- =========================================================
-- QUERY 14: RESOURCE TYPES
-- Counting how many records there are for each resource type.
-- This helps show which resources are being used or accessed the most.
--
-- Steps:
-- 1. resource_type is already inside security_logs.
-- 2. GROUP BY puts the same resource types together.
-- 3. COUNT shows how many times each resource type appears.
-- 4. DESC puts the most used resource first.

SELECT resource_type,
       COUNT(*) AS total_records
FROM security_logs
GROUP BY resource_type
ORDER BY total_records DESC;
-- =========================================================
-- QUERY 15: ROLE AND EVENT CATEGORY
-- Counting activity by user role and event category.
-- This helps compare what different types of users are doing in the system.
--
-- Steps:
-- 1. JOIN roles to get the user role.
-- 2. JOIN event_categories to get the event category.
-- 3. GROUP BY both the role and category.
-- 4. COUNT shows how much activity each combination has.

SELECT r.user_role,
       ec.event_category,
       COUNT(*) AS total_records
FROM security_logs sl
         JOIN roles r
              ON sl.role_id = r.role_id
         JOIN event_categories ec
              ON sl.event_cat_id = ec.event_cat_id
GROUP BY r.user_role, ec.event_category
ORDER BY r.user_role, total_records DESC;
-- =========================================================
-- QUERY 16: IP ADDRESSES WITH MULTIPLE USERS
-- Looking for IP addresses being used by more than one username.
-- Different users sharing an IP could be something worth checking.
--
-- Steps:
-- 1. GROUP BY puts matching IP addresses together.
-- 2. DISTINCT makes sure the same username is not counted twice.
-- 3. COUNT tells me how many different users used the IP.
-- 4. HAVING keeps only IPs used by more than one user.

SELECT ip_address,
       COUNT(DISTINCT username) AS total_users
FROM security_logs
GROUP BY ip_address
HAVING COUNT(DISTINCT username) > 1
ORDER BY total_users DESC;
-- =========================================================
-- QUERY 17: USERS WITH FAILED AND SERIOUS EVENTS
-- Looking for users who have failed activity and also high or critical activity.
-- Having both problems on the same user makes the account more suspicious.
--
-- Steps:
-- 1. Start by finding users with failed events.
-- 2. EXISTS checks the security logs again for the same username.
-- 3. The second part looks for high or critical severity.
-- 4. DISTINCT removes duplicate usernames from the results.

SELECT DISTINCT sl.username
FROM security_logs sl
         JOIN statuses s
              ON sl.event_status_id = s.status_id
WHERE s.status = 'failed'
  AND EXISTS (
    SELECT 1
    FROM security_logs sl2
             JOIN severity_levels sev
                  ON sl2.severity_id = sev.severity_id
    WHERE sl2.username = sl.username
      AND sev.severity IN ('high', 'critical')
);
-- =========================================================
-- QUERY 18: MULTIPLE FAILURES IN A SESSION
-- Looking for sessions with more than one failed event.
-- Multiple failures in the same session could mean repeated attempts.
--
-- Steps:
-- 1. JOIN statuses so I can find failed events.
-- 2. WHERE keeps only the failed events.
-- 3. GROUP BY puts matching session IDs together.
-- 4. COUNT shows how many failures happened in each session.
-- 5. HAVING keeps sessions with more than one failure.

SELECT sl.session_id,
       COUNT(*) AS failed_events
FROM security_logs sl
         JOIN statuses s
              ON sl.event_status_id = s.status_id
WHERE s.status = 'failed'
GROUP BY sl.session_id
HAVING COUNT(*) > 1
ORDER BY failed_events DESC;
-- =========================================================
-- QUERY 19: RESTRICTED ACCOUNTS WITH SUCCESSFUL ACTIVITY
-- Looking for locked or suspended accounts that still had successful activity.
-- These accounts should normally not be able to keep using the system.
--
-- Steps:
-- 1. JOIN account_statuses to see if an account is locked or suspended.
-- 2. JOIN statuses to see if the event was successful.
-- 3. IN lets me check for locked OR suspended accounts.
-- 4. AND keeps only successful activity.
-- 5. ORDER BY puts the activity in time order.

SELECT sl.username,
       ac.account_status,
       s.status,
       sl.event_time
FROM security_logs sl
         JOIN account_statuses ac
              ON sl.status_id = ac.status_id
         JOIN statuses s
              ON sl.event_status_id = s.status_id
WHERE ac.account_status IN ('locked', 'suspended')
  AND s.status = 'success'
ORDER BY sl.event_time;
-- =========================================================
-- QUERY 20: MULTIPLE WARNING SIGNS
-- Looking for records that have several warning signs at the same time.
-- Failed status, serious severity, watchlist, and a high risk score together
-- would make the activity stand out as more suspicious.
--
-- Steps:
-- 1. JOIN statuses to get the event status.
-- 2. JOIN severity_levels to get the severity.
-- 3. WHERE checks for a failed status.
-- 4. AND checks for high or critical severity.
-- 5. AND checks if the event is on the watchlist.
-- 6. AND checks if the risk score is 80 or higher.
-- 7. ORDER BY puts the highest risk scores first.

SELECT sl.username,
       sl.ip_address,
       sl.session_id,
       s.status,
       sev.severity,
       sl.watchlist_flag,
       sl.risk_score
FROM security_logs sl
         JOIN statuses s
              ON sl.event_status_id = s.status_id
         JOIN severity_levels sev
              ON sl.severity_id = sev.severity_id
WHERE s.status = 'failed'
  AND sev.severity IN ('high', 'critical')
  AND sl.watchlist_flag = TRUE
  AND sl.risk_score >= 80
ORDER BY sl.risk_score DESC;