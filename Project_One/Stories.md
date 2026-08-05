# Neon Black Market User Stories

## Project Overview
The neon Black Market database should support anonymous users, vendors, products, transactions, reviews, and login sessions. The system should limit personally identifiable information while still maintaining reliable records and relationships.



## User Story 1: Product Purchase History
Fragment: "Why can I not see my past purchases?"

As a user, I want to view my previous purchases so that I can track the products I have bought and confirm my transaction history.

## User Story 2: Vendor Product Listings
Fragment: "Products must be tied to vendors."

As an administrator, I want every product to be connected to a vendor so that the system can identify who created and manges each listing.

## User Story 3: Reliable Transactions
Fragment: "Transactions must link users and products"

As an administrator, I want every transaction to identify both the purchasing user and the purchased product so that transactions records are complete and trustworthy.

## User Story 4: Product Reviews
Fragment: "I want to read reviews before buying"

As a user, I want to read reviews for a product before making a purchase so that I can make a more informed buying decision.

## User Story 5: Review Ownership
Fragment: "Are reviews tied to real users?"

As an administrator, I want every review to be linked to a registered user so that reviews can ve verified while the user remains anonymous to the public.

## User Story 6: Session Management
Fragment: "Session expired while I was active"

As a user, I want my active session to remain valid while I am using the platform so that I am not unexpectedly logged out. 

## User Story 7: Login Attempt Tracking
Fragment: "Tracking failed login attempts."

As an administrator, I want failed login attempts to be recorded so that suspicious account activity can be identified and investigated.

## Design Summary
These user stories require a database to store users, vendors, products, transactions, reviews and sessions. The table needs to be connected so that the system can identify ownership, purchasing activity, review authorship, and active login sessions without requiring unnecessary personal information. 
