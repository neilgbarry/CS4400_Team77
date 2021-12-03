-- CS4400: Introduction to Database Systems (Fall 2021)
-- Phase III: Stored Procedures & Views Testing Script

-- Directions:
-- Please reset the database after each test.

USE travel_reservation_service;

-- --------------------------------------------------------------------------
-- Testing
-- --------------------------------------------------------------------------

-- --------------------------------------------------------------------------
-- [1a] Test Procedure: register_customer
-- --------------------------------------------------------------------------
-- Add new customer (Does not exist in DB, Email Not-Unique Only): Expect 0 row(s) affected
CALL register_customer('aray@tiktok.com', 'Michael', 'Jackson', 'mjackson2021', '111-111-1111', '1111 1111 1111 1111', '111', '2019-01-01', 'USA');
-- Add new customer (Does not exist in DB, Phone Number Not-Unique Only): Expect 0 row(s) affected
CALL register_customer('mjackson@gmail.com', 'Michael', 'Jackson', 'mjackson2021', '404-678-5555', '1111 1111 1111 1111', '111', '2019-01-01', 'USA');
-- Add new customer (Does not exist in DB, Credit Card Number Not-Unique Only): Expect 0 row(s) affected
CALL register_customer('mjackson@gmail.com', 'Michael', 'Jackson', 'mjackson2021', '111-111-1111', '3110 2669 7949 5605', '111', '2019-01-01', 'USA');
-- Add new customer (Does not exist in DB): Expect new entry in accounts, clients, and customer
CALL register_customer('mjackson@gmail.com', 'Michael', 'Jackson', 'mjackson2021', '111-111-1111', '1111 1111 1111 1111', '111', '2019-01-01', 'USA');
SELECT * FROM accounts AS A LEFT OUTER JOIN clients AS C ON A.Email = C.Email LEFT OUTER JOIN customer AS U ON C.Email = U.Email WHERE A.Email = 'mjackson@gmail.com';

-- Add new customer (Exists as Account only, Account Fields Do Not Match, Key Fields Unique): Expect 0 row(s) affected
CALL register_customer('mmoss1@travelagency.com', 'Bob', 'Ross', 'password12', '222-222-2222', '2222 2222 2222 2222', '222', '2019-01-02', 'USA');
-- Add new customer (Exists as Account only, Account Fields Match, Phone Number Not-Unique Only): Expect 0 row(s) affected
CALL register_customer('mmoss1@travelagency.com', 'Mark', 'Moss', 'password1', '404-678-5555', '2222 2222 2222 2222', '222', '2019-01-02', 'USA');
-- Add new customer (Exists as Account only, Account Fields Match, Credit Card Number Not-Unique Only): Expect 0 row(s) affected
CALL register_customer('mmoss1@travelagency.com', 'Mark', 'Moss', 'password1', '222-222-2222', '3110 2669 7949 5605', '222', '2019-01-02', 'USA');
-- Add new customer (Exists as Account only, Account Fields Match, Key Fields Unique): Expect new entry in clients and customer
CALL register_customer('mmoss1@travelagency.com', 'Mark', 'Moss', 'password1', '222-222-2222', '2222 2222 2222 2222', '222', '2019-01-02', 'USA');
SELECT * FROM accounts AS A LEFT OUTER JOIN clients AS C ON A.Email = C.Email LEFT OUTER JOIN customer AS U ON C.Email = U.Email WHERE A.Email = 'mmoss1@travelagency.com';

-- Add new customer (Exists as Account and Client, Account Fields Do Not Match, Key Fields Unique): Expect 0 row(s) affected
CALL register_customer('arthurread@gmail.com', 'Peter', 'Parker', 'spidermanRules', '555-234-5678', '3333 3333 3333 3333', '333', '2019-01-03', 'USA');
-- Add new customer (Exists as Account and Client, Client Fields Do Not Match, Key Fields Unique): Expect 0 row(s) affected
CALL register_customer('arthurread@gmail.com', 'Arthur', 'Read', 'password4', '333-333-3333', '3333 3333 3333 3333', '333', '2019-01-03', 'USA');
-- Add new customer (Exists as Account and Client, Account/Client Fields Match, Credit Card Number Not-Unique Only): Expect 0 row(s) affected
CALL register_customer('arthurread@gmail.com', 'Arthur', 'Read', 'password4', '555-234-5678', '3110 2669 7949 5605', '333', '2019-01-03', 'USA');
-- Add new customer (Exists as Account and Client, Account/Client Fields Match, Key Fields Unique): Expect new entry in customer
CALL register_customer('arthurread@gmail.com', 'Arthur', 'Read', 'password4', '555-234-5678', '3333 3333 3333 3333', '333', '2019-01-03', 'USA');
SELECT * FROM accounts AS A LEFT OUTER JOIN clients AS C ON A.Email = C.Email LEFT OUTER JOIN customer AS U ON C.Email = U.Email WHERE A.Email = 'arthurread@gmail.com';

-- Add new customer (Exists as Account, Client, and Customer, field changes): Expect 0 row(s) affected
CALL register_customer('aray@tiktok.com', 'Peter', 'Parker', 'spidermanRules', '770-234-5678', '3110 2669 7949 5605', '444', '2019-01-04', 'USA');
-- Add new customer (Exists as Account, Client, and Customer, no field changes): Expect 0 row(s) affected
CALL register_customer('aray@tiktok.com', 'Addison', 'Ray', 'password17', '770-234-5678', '3110 2669 7949 5605', '744', '2022-08-01', '');

-- --------------------------------------------------------------------------
-- [1b] Test Procedure: register_owner
-- --------------------------------------------------------------------------
-- Add new owner (Does not exist in DB, Email Not-Unique Only): Expect 0 row(s) affected
CALL register_owner('aray@tiktok.com', 'Michael', 'Jackson', 'mjackson2021', '111-111-1111');
-- Add new owner (Does not exist in DB, Phone Number Not-Unique Only): Expect 0 row(s) affected
CALL register_owner('mjackson@gmail.com', 'Michael', 'Jackson', 'mjackson2021', '404-678-5555');
-- Add new owner (Does not exist in DB): Expect new entry in accounts, clients, and owners
CALL register_owner('mjackson@gmail.com', 'Michael', 'Jackson', 'mjackson2021', '111-111-1111');
SELECT * FROM accounts AS A LEFT OUTER JOIN clients AS C ON A.Email = C.Email LEFT OUTER JOIN owners AS O ON C.Email = O.Email WHERE A.Email = 'mjackson@gmail.com';

-- Add new owner (Exists as Account only, Account Fields Do Not Match, Key Fields Unique): Expect 0 row(s) affected
CALL register_owner('mmoss1@travelagency.com', 'Bob', 'Ross', 'password12', '222-222-2222');
-- Add new owner (Exists as Account only, Account Fields Match, Phone Number Not-Unique Only): Expect 0 row(s) affected
CALL register_owner('mmoss1@travelagency.com', 'Mark', 'Moss', 'password1', '404-678-5555');
-- Add new owner (Exists as Account only, Account Fields Match, Key Fields Unique): Expect new entry in clients and owners
CALL register_owner('mmoss1@travelagency.com', 'Mark', 'Moss', 'password1', '222-222-2222');
SELECT * FROM accounts AS A LEFT OUTER JOIN clients AS C ON A.Email = C.Email LEFT OUTER JOIN owners AS O ON C.Email = O.Email WHERE A.Email = 'mmoss1@travelagency.com';

-- Add new owner (Exists as Account and Client, Account Fields Do Not Match): Expect 0 row(s) affected
CALL register_owner('aray@tiktok.com', 'Peter', 'Parker', 'spidermanRules', '770-234-5678');
-- Add new owner (Exists as Account and Client, Client Fields Do Not Match): Expect 0 row(s) affected
CALL register_owner('aray@tiktok.com', 'Addison', 'Ray', 'password17', '333-333-3333');
-- Add new owner (Exists as Account and Client, Account/Client Fields Match): Expect new entry in owners
CALL register_owner('aray@tiktok.com', 'Addison', 'Ray', 'password17', '770-234-5678');
SELECT * FROM accounts AS A LEFT OUTER JOIN clients AS C ON A.Email = C.Email LEFT OUTER JOIN owners AS O ON C.Email = O.Email WHERE A.Email = 'aray@tiktok.com';

-- Add new owner (Exists as Account, Client, and Owner, field changes): Expect 0 row(s) affected
CALL register_owner('arthurread@gmail.com', 'Peter', 'Parker', 'spidermanRules', '555-234-5678');
-- Add new owner (Exists as Account, Client, and Owner, no field changes): Expect 0 row(s) affected
CALL register_owner('arthurread@gmail.com', 'Arthur', 'Read', 'password4', '555-234-5678');

-- --------------------------------------------------------------------------
-- [1c] Test Procedure: remove_owner
-- --------------------------------------------------------------------------
-- Remove owner (Owner does not exist): Expect 0 row(s) affected
CALL remove_owner('mjackson@gmail.com');
-- Remove owner (Owner exists, has listed properties): Expect 0 row(s) affected
CALL remove_owner('arthurread@gmail.com');
-- Remove owner (Owner exists, no listed properties, also a customer): Expect removal from owners table only
CALL register_owner('aray@tiktok.com', 'Addison', 'Ray', 'password17', '770-234-5678');
SELECT * FROM customer AS C LEFT OUTER JOIN owners AS O ON C.Email = O.Email WHERE C.Email = 'aray@tiktok.com';
CALL remove_owner('aray@tiktok.com');
SELECT * FROM customer AS C LEFT OUTER JOIN owners AS O ON C.Email = O.Email WHERE C.Email = 'aray@tiktok.com';
-- Remove owner (Owner exists, no listed properties, not a customer): Expect removal from owners, clients, and accounts tables
INSERT INTO customers_rate_owners(Customer, Owner_Email, Score) VALUES ('aray@tiktok.com', 'jwayne@gmail.com', 5);
INSERT INTO owners_rate_customers(Owner_Email, Customer, Score) VALUES ('jwayne@gmail.com', 'aray@tiktok.com', 5);
SELECT * FROM owners AS O LEFT OUTER JOIN property AS P ON O.Email = P.Owner_Email LEFT OUTER JOIN customers_rate_owners AS A ON O.Email = A.Owner_Email LEFT OUTER JOIN owners_rate_customers AS B ON O.Email = B.Owner_Email WHERE O.Email = 'jwayne@gmail.com';
CALL remove_owner('jwayne@gmail.com');
SELECT * FROM owners AS O LEFT OUTER JOIN property AS P ON O.Email = P.Owner_Email LEFT OUTER JOIN customers_rate_owners AS A ON O.Email = A.Owner_Email LEFT OUTER JOIN owners_rate_customers AS B ON O.Email = B.Owner_Email WHERE O.Email = 'jwayne@gmail.com';
