CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(36) NOT NULL,
    password VARCHAR(36) NOT NULL,
    account_status VARCHAR(20),
    failed_login_attempts INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE vendors (
    vendor_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    display_name VARCHAR(36),
    vendor_status BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id));

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    vendor_id INTEGER,
    product_name VARCHAR(36),
    description VARCHAR(255),
    price DOUBLE PRECISION,
    listing_status BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id));

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    product_id INTEGER,
    transaction_status VARCHAR(20),
    amount_paid DOUBLE PRECISION,
    purchased_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
    );

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    product_id INTEGER,
    rating INTEGER,
    review_text VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id));

CREATE TABLE sessions (
    session_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    session_token VARCHAR(36),
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,
    is_active BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE test_users(
    id SERIAL PRIMARY KEY,
    username VARCHAR(30)
);


