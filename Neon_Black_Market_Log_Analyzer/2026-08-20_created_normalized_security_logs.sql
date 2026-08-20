
/*Conncection between security and the tables I made, this makes information
  more easier to understand the intent
 */

CREATE TABLE security_logs(
    log_id SERIAL PRIMARY KEY,
    event_time timestamp NOT NULL,
    username VARCHAR(30) NOT NULL,
    role_id INT REFERENCES roles(role_id),
    status_id INT REFERENCES account_statuses(status_id),
    device_id INT REFERENCES device_types(device_id),
    system_id INT REFERENCES operating_systems(system_id),
    browser_id INT REFERENCES browser_types(browser_id),
    event_id INT REFERENCES event_types(event_id),
    event_cat_id INT REFERENCES event_categories(event_cat_id),
    action_id INT REFERENCES actions_taken(action_id),
    event_status_id INT REFERENCES statuses(status_id),
    severity_id INT REFERENCES severity_levels(severity_id),
    ip_address VARCHAR(45) NOT NULL,
    port_number INT NOT NULL,
    location_city VARCHAR(30) NOT NULL,
    location_region VARCHAR(30) NOT NULL,
    location_country VARCHAR(30) NOT NULL,
    resource_type VARCHAR(20) NOT NULL,
    resource_name VARCHAR(50) NOT NULL,
    session_id VARCHAR(30) NOT NULL,
    failure_reason VARCHAR(30),
    risk_score INT NOT NULL,
    watchlist_flag BOOLEAN DEFAULT FALSE,
    notes TEXT
);

INSERT INTO public.security_logs (
    event_time,
    username,
    role_id,
    status_id,
    device_id,
    system_id,
    browser_id,
    event_id,
    event_cat_id,
    action_id,
    event_status_id,
    severity_id,
    ip_address,
    port_number,
    location_city,
    location_region,
    location_country,
    resource_type,
    resource_name,
    session_id,
    failure_reason,
    risk_score,
    watchlist_flag,
    notes
    )

SELECT
    raw.event_time,
    raw.username,
    r.role_id,
    acs.status_id,
    d.device_id,
    os.system_id,
    b.browser_id,
    e.event_id,
    ec.event_cat_id,
    a.action_id,
    st.status_id,
    sl.severity_id,
    raw.ip_address,
    raw.port_number,
    raw.location_city,
    raw.location_region,
    raw.location_country,
    raw.resource_type,
    raw.resource_name,
    raw.session_id,
    raw.failure_reason,
    raw.risk_score,
    raw.watchlist_flag,
    raw.notes
FROM security_logs_raw raw
         JOIN roles r
              ON raw.user_role = r.user_role
         JOIN account_statuses acs
              ON raw.account_status = acs.account_status
         JOIN device_types d
              ON raw.device_type = d.device_type
         JOIN operating_systems os
              ON raw.operating_system = os.operating_system
         JOIN browser_types b
              ON raw.browser_name = b.browser_name
         JOIN event_types e
              ON raw.event_type = e.event_type
         JOIN event_categories ec
              ON raw.event_category = ec.event_category
         JOIN actions_taken a
              ON raw.action_taken = a.action_taken
         JOIN statuses st
              ON raw.status = st.status
         JOIN severity_levels sl
              ON raw.severity = sl.severity;

