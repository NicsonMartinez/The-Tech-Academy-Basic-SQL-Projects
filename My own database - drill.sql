/* - Nicson Martinez 4/23/19
DRILL 7:
Creating your own tables: Build a select statement that queries for the following information:

➤ Create a database with two tables. Assign a foreign key constraint on one table that shares 
related data with the primary key on the second table. Finally, create a statement that queries 
data from both tables.
*/
	/******************************************************
	 * Build our database tables and define their schema
	 ******************************************************/


CREATE TABLE tbl_customer (
	customer_id INT PRIMARY KEY NOT NULL IDENTITY (1001, 1),
	customer_fname VARCHAR(50) NOT NULL,
	customer_lname VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_contact (
	contact_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	contact_phone VARCHAR(50) NOT NULL,
	contact_address VARCHAR(50) NOT NULL,
	contact_cutomer INT NOT NULL CONSTRAINT fk_customer_id FOREIGN KEY REFERENCES tbl_customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

	/******************************************************
	 * Now that the tables are built, we populate them
	 ******************************************************/

INSERT INTO  tbl_customer
	(customer_fname, customer_lname)
	VALUES
	('Cristiano','Ronaldo'),
	('Lionel','Messi'),
	('Sergio','Aguero'),
	('Nicson','Martinez')
;

SELECT * FROM tbl_customer;

INSERT INTO  tbl_contact
	(contact_phone, contact_address, contact_cutomer)
	VALUES
	('111-111-1234','Somewhere in Portugal',1001),
	('222-222-1234','Somewhere in Argentina',1002),
	('333-333-1234','Somewhere in Argentina',1003),
	('444-444-1234','Somewhere in Honduras',1004)
;

SELECT * FROM tbl_contact;

	/*****************************************************
	 * The following queries database using INNER JOINS.
	 ******************************************************/

SELECT a.customer_lname, b.contact_phone, b.contact_address
	FROM tbl_customer a
	INNER JOIN tbl_contact b ON a.customer_id = b.contact_cutomer;



