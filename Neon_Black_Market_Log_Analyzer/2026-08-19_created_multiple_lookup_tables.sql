CREATE TABLE roles (
  role_id SERIAL PRIMARY KEY,
user_role VARCHAR(20));

INSERT INTO roles (user_role)
VALUES
('buyer'),
('vendor'),
('admin'),
('analyst'),
('moderator'),
('guest');


CREATE TABLE account_statuses
(
    status_id      SERIAL PRIMARY KEY,
    account_status VARCHAR(20)
);
INSERT INTO account_statuses (account_status)
VALUES
('active'),
('locked'),
('suspended');


CREATE TABLE device_types (
    device_id SERIAL PRIMARY KEY,
    device_type VARCHAR(20)
);

INSERT INTO device_types (device_type)
VALUES
    ('desktop'),
    ('mobile'),
    ('tablet'),
    ('server');


CREATE TABLE operating_systems
(
    system_id SERIAL PRIMARY KEY,
    operating_system VARCHAR(20)
);

INSERT INTO operating_systems (operating_system)
    VALUES
    ('Windows'),
    ('Linux'),
    ('macOS'),
    ('iOS'),
        ('Android');


CREATE TABLE browser_types (
    browser_id SERIAL PRIMARY KEY,
    browser_name VARCHAR(20)
);

INSERT INTO browser_types(browser_name)
values
('Chrome'),
('Firefox'),
('Safari'),
('Edge');


CREATE TABLE event_types (
    event_id SERIAL PRIMARY KEY,
    event_type VARCHAR(20)
);

INSERT INTO event_types(event_type)
values
('login'),
('purchase'),
('admin_action'),
('file_access'),
('account_update'),
('logout'),
('password_change');


CREATE TABLE event_categories
(
    event_cat_id   SERIAL PRIMARY KEY,
    event_category VARCHAR(20)
)
INSERT INTO event_categories(event_category)
values
('authentication'),
('transaction'),
('user_management'),
('security'),
('system');

CREATE TABLE actions_taken (
    action_id SERIAL PRIMARY KEY,
    action_taken VARCHAR(10)
);

INSERT INTO actions_taken (action_taken)
VALUES
    ('allow'),
    ('deny'),
    ('block');


CREATE TABLE statuses (
    status_id SERIAL PRIMARY KEY,
    status VARCHAR(10)
);

INSERT INTO statuses (status)
VALUES
    ('success'),
    ('failed'),
    ('blocked');


CREATE TABLE severity_levels (
    severity_id SERIAL PRIMARY KEY,
    severity VARCHAR(10)
);

INSERT INTO severity_levels (severity)
VALUES
    ('low'),
    ('medium'),
    ('high'),
    ('critical');