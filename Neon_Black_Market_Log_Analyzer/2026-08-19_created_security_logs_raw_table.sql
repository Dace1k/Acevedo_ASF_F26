CREATE TABLE security_logs_raw (
    log_id SERIAL PRIMARY KEY,
    event_time TIMESTAMP NOT NULL,
    username VARCHAR(30) NOT NULL,
    user_role VARCHAR(20) NOT NULL,
    account_status VARCHAR(20) NOT NULL,
    ip_address VARCHAR(45) NOT NULL,
    port_number INT NOT NULL,
    device_type VARCHAR(20) NOT NULL,
    operating_system VARCHAR(20) NOT NULL,
    browser_name VARCHAR(20) NOT NULL,
    location_city VARCHAR(30) NOT NULL,
    location_region VARCHAR(30) NOT NULL,
    location_country VARCHAR(30) NOT NULL,
    event_type VARCHAR(20) NOT NULL,
    event_category VARCHAR(20) NOT NULL,
    action_taken VARCHAR(10) NOT NULL,
    status VARCHAR(10) NOT NULL,
    severity VARCHAR(10) NOT NULL,
    resource_type VARCHAR(20) NOT NULL,
    resource_name VARCHAR(50) NOT NULL,
    session_id VARCHAR(30) NOT NULL,
    failure_reason VARCHAR(30),
    risk_score INT NOT NULL,
    watchlist_flag BOOLEAN DEFAULT FALSE,
    notes TEXT
);

SELECT * FROM security_logs_raw;
TRUNCATE TABLE security_logs_raw RESTART IDENTITY;

SELECT COUNT(*)
FROM security_logs_raw;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;



