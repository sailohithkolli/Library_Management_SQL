--LAB1A
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name varchar(255),
  last_name varchar(255),
  email varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  created_at timestamp,
  updated_at timestamp
);
CREATE TABLE status (
  id SERIAL PRIMARY KEY,
  description varchar(255) NOT NULL,
  created_at timestamp,
  updated_at timestamp
);
CREATE TABLE inventory (
  id SERIAL PRIMARY KEY,
  status_id integer REFERENCES status (id) NOT NULL,
  description varchar(255) NOT NULL,
  created_at timestamp,
  updated_at timestamp
);
CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  user_id integer REFERENCES users (id) NOT NULL,
  inventory_id integer REFERENCES inventory (id) NOT NULL,
  checkout_time timestamp NOT NULL,
  scheduled_checkin_time timestamp,
  actual_checkin_time timestamp,
  created_at timestamp,
  updated_at timestamp
);
INSERT INTO users (first_name, last_name, email, password)
VALUES
('Sai', 'Lohith', 'sl@mail.com', 'password'),
('Richie', 'Kolli', 'rk@mail.com', 'password'),
('Sri Lakshmi', 'Kolli', 'ks@mail.com', 'password'),
('Naveen Babu', 'Kolli', 'nbk@mail.com', 'password'),
('Haasini', 'Kolli', 'hk@mail.com', 'password');
INSERT INTO status (description)
VALUES
('Available'),
('Checked out'),
('Overdue'),
('Unavailable'),
('Under Repair');
INSERT INTO inventory (status_id, description)
VALUES
(2, 'Laptop1'),
(2, 'Laptop2'),
(1, 'Webcam1'),
(4, 'TV1'),
(5, 'Microphone1');
INSERT INTO transactions (user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time)
VALUES
(1, 1,current_timestamp,'2023-09-04 10:00:00', '2023-09-04 12:34:56'),
(1, 2,current_timestamp,'2023-09-04 11:00:00', '2023-09-05 12:00:00'),
(2, 3,current_timestamp,'2020-07-27 07:00:00', '2020-07-27 08:12:33');
UPDATE inventory
SET status_id = 2
WHERE id IN (1, 2, 3);
ALTER TABLE users ADD COLUMN signed_agreement BOOLEAN DEFAULT FALSE;
SELECT inventory.id, inventory.description, transactions.scheduled_checkin_time
FROM transactions
INNER JOIN inventory ON transactions.inventory_id = inventory.id
WHERE inventory.status_id = 2
ORDER BY transactions.scheduled_checkin_time DESC;
SELECT inventory.id, inventory.description, transactions.scheduled_checkin_time
FROM transactions
INNER JOIN inventory ON transactions.inventory_id = inventory.id
WHERE inventory.status_id = 2
AND transactions.scheduled_checkin_time > '2020-07-31';
SELECT COUNT(*)
FROM transactions
JOIN inventory ON transactions.inventory_id = inventory.id
WHERE user_id = 1
AND inventory.status_id = 2;
--LAB1B
--1a.	Using the tables created in Lab 1 Part 1, insert 20 transactions.
-- Three of these transactions need to have the actual_checkin_time after the scheduled_checkin_time. 
-- This will allow you to test the view you will be creating in the next steps. 
-- For example, a transaction where the scheduled_checkin_time is 2020-08-01 14:39:53 and the actual_checkin_time is 2020-08-02 14:39:53. 
-- Additionally, five of the transactions need to have a checkout_time after September 3 2020.
INSERT INTO transactions
(user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at)
VALUES 
(1, 1, '2020-09-04 14:39:53', '2020-08-01 14:39:53', '2020-08-02 14:39:53', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 1, '2020-09-05 14:39:53', '2020-08-02 14:39:53', '2020-08-03 14:39:53', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 2, '2020-09-06 14:39:53', '2020-08-03 14:39:53', '2020-08-04 14:39:53', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 3, '2020-09-05 12:00:00', '2020-08-01 12:00:00', '2020-08-02 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 3, '2020-09-06 12:00:00', '2020-08-02 12:00:00', '2020-08-03 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 3, '2020-09-07 12:00:00', '2020-08-03 12:00:00', '2020-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, '2020-09-08 12:00:00', '2020-08-04 12:00:00', '2020-08-05 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 3, '2020-09-09 12:00:00', '2020-08-05 12:00:00', '2020-08-06 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '2020-09-04 12:00:00', '2020-08-01 12:00:00', '2020-08-02 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, '2020-09-05 12:00:00', '2020-08-02 12:00:00', '2020-08-03 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 1, '2020-09-06 12:00:00', '2020-08-03 12:00:00', '2020-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '2020-09-07 12:00:00', '2020-08-04 12:00:00', '2020-08-05 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, '2020-09-08 12:00:00', '2020-08-05 12:00:00', '2020-08-06 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 3, '2020-09-09 12:00:00', '2020-08-06 12:00:00', '2020-08-07 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '2020-09-10 12:00:00', '2020-08-07 12:00:00', '2020-08-08 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, '2020-09-11 12:00:00', '2020-08-08 12:00:00', '2020-08-09 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, '2020-09-12 12:00:00', '2020-08-09 12:00:00', '2020-08-10 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 3, '2020-09-13 12:00:00', '2020-08-10 12:00:00', '2020-08-11 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '2020-09-14 12:00:00', '2020-08-11 12:00:00', '2020-08-12 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, '2020-09-15 12:00:00', '2020-08-12 12:00:00', '2020-08-13 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
--1b.	Create a late checkins view of distinct items that were checked in late grouped by user_id, inventory_id, and description. 
--This view should display the total number of late checkins per device per user.
--For example, 
--if user1 checked in two items late, there should be two rows displayed for user1 and each row should include the total number of times that user returned that particular item late.
CREATE OR REPLACE VIEW checkins AS
SELECT user_id, inventory_id, COUNT(inventory_id)
FROM transactions
WHERE actual_checkin_time > scheduled_checkin_time
GROUP BY user_id, inventory_id;
--1c.Test the late checkins view by selecting and displaying all records from the view.
SELECT * FROM checkins;