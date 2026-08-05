## Neon Black Market Database Tables

##Table 1: users

Stores basic anonymous account information.

- user_id - SERIAL, Primary Key
- username - VARCHAR(36), stores the user's unique anonymous username
- password - VARCHAR(36), stores the user's password
- account_status - Varchar (20), shows whether the account is active, disabled, suspended, or locked
- failed_login_attempts - INTEGER, counts unsuccessful login attempts
- created_at - TIMESTAMP, records when the account was created

Primary Key:
- user_id

Relationships:
- One user may have one vendor profile.
- One user may creat many transactions.
- One user may write many reviews.
- One user may have many sessions.

## Table 2 vendors

Stores information for users who sell products.

- vendor_id - SERIAL, Primary Key
- User_id - INTEGER, Foreign Key
- display_name - VARCHAR(36), stores the public vendor name
- vendor_status - BOOLEAN, shows whether the vendor account is active (True/Active, False/Inactive)
- created_at - TIMESTAMP, records when the vendor account was created

Primary Key: 
- vendor_id

Foreign Key: user_id references users (user_id)

Relationships: 
- One user may have one vendor account
- One vendor may list many producs

## Table 3: products 

Stores products listed by vendors.

- product_id - SERIAL, Primary Key
- vendor_id - INTEGER, Foreign Key
- product_name - VARCHAR(50), stores the product name
- description - VARCHAR(255), stores information about the product
- price - DOUBLE, stores the product price
- listing_status - BOOLEAN, shows whether the product is active (True/Active, False/Inactive)
- created_at - TIMESTAMP, records when the product was created

Primary Key:
- product_id

Foreign Key:
- vendor_id references vendors (vser_id)

Relationships:
- One vendor may list many products.
- One product may appear in many transactions.
- One product may reveive many reviews.

## Table 4: Transactions

Stores product purchases.

- transaction_id - Serial, Primary Key
- user_id - INTEGER, Foreign Key
- product_id -Integer, Foreign Key
- transaction_status - VARCHAR(20), stores the current status of the transaction (pending, complete, cancelled, failed, refunded)

Primary Key: 
- transaction_id

Foreign Keys:
- user-id references user (user_id_
- product_id references products (product_id))

Relationships:
- One user may have many transactions.
- One product may appear in many transactions

## Table 5: reviews

Stores reviews written by users.

- review_id - SERIAL, Primary Key
- user_id - INTEGER, Foreign Key
- product_id - INTEGER, Foreign 
- rating - INTEGER, stores a rating from 1 to 5
- review_text - VARCHAR (225), stores the written review
- created_at - TIMESTAMP, records when the review was created

Primary Key:
- review_id

Foreign Keys:
- user_id references users (user_id)
- product_id references products (product_id)

Relationships:
- One user may write many reviews.
- One product may receive many reviews.