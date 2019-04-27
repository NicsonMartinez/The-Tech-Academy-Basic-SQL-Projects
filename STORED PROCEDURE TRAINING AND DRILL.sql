/*
THE TECH ACADEMY
Database & SQL Course

USE THE ADVENTUREWORKS DATABASE FOR THIS DRILL
STORED PROCEDURE TRAINING AND DRILL
SQL Server 2014 - Create basic TSQL stored procedures
INSTRUCTIONS:
DO THE TUTORIAL FOUND HERE:
https://www.mssqltips.com/sqlservertutorial/160/sql-server-stored-procedure-tutorial/

Content below is done by By: Greg Robidoux 3/24/2009
Tests are ran by a student at The Tech Academy - Nicson Martinez 4/26/19
*/


/*
Please visit the following link and under the heading, "Assets" download the file "AdventureWorks2014.bak"

Visit AdventureWorks GitHub page here:
https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks  THE TECH ACADEMY PG.78

*/

/*********************************************************************************************************************************/

/*
Creating a simple SQL Server stored procedure

Overview
As mentioned in the tutorial overview a stored procedure is nothing more than stored SQL code that you would like to 
use over and over again.  In this example we will look at creating a simple stored procedure.

Explanation
Before you create a stored procedure you need to know what your end result is, whether you are selecting data, inserting data, etc..

In this simple example we will just select all data from the Person.Address table that is stored in the AdventureWorks database.

So the simple T-SQL code excuting in the AdventureWorks database would be as follows which will return all rows from this table.

SELECT * FROM Person.Address
To create a stored procedure to do this the code would look like this:

USE AdventureWorks
GO

CREATE PROCEDURE dbo.uspGetAddress
AS
SELECT * FROM Person.Address
GO
To call the procedure to return the contents from the table specified, the code would be:

EXEC dbo.uspGetAddress
-- or
EXEC uspGetAddress
--or just simply
uspGetAddress

When creating a stored procedure you can either use CREATE PROCEDURE or CREATE PROC.  After the stored procedure 
name you need to use the keyword "AS" and then the rest is just the regular SQL code that you would normally execute.

One thing to note is that you cannot use the keyword "GO" in the stored procedure.  Once the SQL Server 
compiler sees "GO" it assumes it is the end of the batch.

Also, you can not change database context within the stored procedure such as using "USE dbName" the 
reason for this is because this would be a separate batch and a stored procedure is a collection of only 
one batch of statements.
*/

USE AdventureWorks2014
GO

CREATE PROCEDURE dbo.uspGetAddressTest0
AS
SELECT * FROM Person.Address
GO

--------------------------------------
EXEC dbo.uspGetAddressTest0

EXEC uspGetAddressTest0

uspGetAddressTest0

/*
How to create a SQL Server stored procedure with parameters

Creating a SQL Stored Procedure with Parameters

1. To create a stored procedure with parameters using the following syntax:

2. CREATE PROCEDURE dbo.uspGetAddress @City nvarchar(30) AS

3. See details and examples below

Create SQL Server Stored Procedure with One Parameter

In this example we will query the Person.Address table from the AdventureWorks database, 
but instead of getting back all records we will limit it to just a particular city.  
This example assumes there will be an exact match on the City value that is passed.

USE AdventureWorks
GO
CREATE PROCEDURE dbo.uspGetAddress @City nvarchar(30)
AS
SELECT * 
FROM Person.Address
WHERE City = @City
GO

*/

USE AdventureWorks2014
GO
CREATE PROCEDURE dbo.uspGetAddressTest1 @City nvarchar(30)
AS
SELECT * 
FROM Person.Address
WHERE City = @City
GO

/*
To call this stored procedure we would execute it as follows:

EXEC dbo.uspGetAddress @City = 'New York'

*/

EXEC dbo.uspGetAddressTest1 @City = 'New York'

/*We can also do the same thing, but allow the users to give us a starting point to search the data.  
Here we can change the "=" to a LIKE and use the "%" wildcard.

USE AdventureWorks
GO
CREATE PROCEDURE dbo.uspGetAddress @City nvarchar(30) 
AS 
SELECT * 
FROM Person.Address 
WHERE City LIKE @City + '%' 
GO

*/

USE AdventureWorks2014
GO
CREATE PROCEDURE dbo.uspGetAddressTest2 @City nvarchar(30) 
AS 
SELECT * 
FROM Person.Address 
WHERE City LIKE @City + '%' 
GO

/*This is how I decided to test it*/
EXEC dbo.uspGetAddressTest2 @City = 'New'

/*
In both of the proceeding examples it assumes that a parameter value will always be passed. If you try 
to execute the procedure without passing a parameter value you will get an error message such as the following:

Msg 201, Level 16, State 4, Procedure uspGetAddress, Line 0

Procedure or function 'uspGetAddress' expects parameter '@City', which was not supplied.

*/

-------------------------------------------------------------------------------------------------------------------

/*
Create SQL Server Stored Procedure with Default Parameter Values
In most cases it is always a good practice to pass in all parameter values, but sometimes it is not possible.  
So in this example we use the NULL option to allow you to not pass in a parameter value.  If we create and run 
this stored procedure as is it will not return any data, because it is looking for any City values that equal NULL.

USE AdventureWorks
GO
CREATE PROCEDURE dbo.uspGetAddress @City nvarchar(30) = NULL
AS
SELECT *
FROM Person.Address
WHERE City = @City
GO

*/

USE AdventureWorks2014
GO
CREATE PROCEDURE dbo.uspGetAddressTest3 @City nvarchar(30) = NULL
AS
SELECT *
FROM Person.Address
WHERE City = @City
GO

/*This is how I decided to test it*/
EXEC dbo.uspGetAddressTest3 @City = Null

/*
We could change this stored procedure and use the ISNULL function to get around this.  So if a value is 
passed it will use the value to narrow the result set and if a value is not passed it will return all records. 
(Note: if the City column has NULL values this will not include these values. You will have to add additional 
logic for City IS NULL)

USE AdventureWorks
GO
CREATE PROCEDURE dbo.uspGetAddress @City nvarchar(30) = NULL
AS
SELECT *
FROM Person.Address
WHERE City = ISNULL(@City,City)
GO

*/

USE AdventureWorks2014
GO
CREATE PROCEDURE dbo.uspGetAddressTest4 @City nvarchar(30) = NULL
AS
SELECT *
FROM Person.Address
WHERE City = ISNULL(@City,City) /*if @City = NULL inside of the ISNULL() function, then City = City */
GO
/*The whole point of ISNULL(,) in this particular query  is to do 
something (like show the full table instead of returning a blank table) in 
the case that whatever given to the parameter is null.

ISNULL is gonna return whatever you give it on the first parameter unless that first parameter
is NULL. When the first parameter is a NULL then it will return what's on the second parameter. 
*/
http://www.sqlservertutorial.net/sql-server-system-functions/sql-server-isnull-function/

/*This is how I decided to test it*/
EXEC dbo.uspGetAddressTest4 @City = Null

/*
Create SQL Server Stored Procedure with Multiple Parameters
Setting up multiple parameters is very easy to do.  You just need to list each parameter and the data type separated by a comma as shown below.

USE AdventureWorks
GO
CREATE PROCEDURE dbo.uspGetAddress @City nvarchar(30) = NULL, @AddressLine1 nvarchar(60) = NULL
AS
SELECT *
FROM Person.Address
WHERE City = ISNULL(@City,City)
AND AddressLine1 LIKE '%' + ISNULL(@AddressLine1 ,AddressLine1) + '%'
GO
*/

USE AdventureWorks2014
GO
CREATE PROCEDURE dbo.uspGetAddressTest5 @City nvarchar(30) = NULL, @AddressLine1 nvarchar(60) = NULL
AS
SELECT *
FROM Person.Address
WHERE City = ISNULL(@City,City)
AND AddressLine1 LIKE '%' + ISNULL(@AddressLine1 ,AddressLine1) + '%'
GO

/*
To execute this you could do any of the following:

EXEC dbo.uspGetAddress @City = 'Calgary'
*/
EXEC dbo.uspGetAddressTest5 @City = 'Calgary'

/*
--or
EXEC dbo.uspGetAddress @City = 'Calgary', @AddressLine1 = 'A'
*/
EXEC dbo.uspGetAddressTest5 @City = 'Calgary', @AddressLine1 = 'A'

/*
--or
EXEC dbo.uspGetAddress @AddressLine1 = 'Acardia'
-- etc...
*/
EXEC dbo.uspGetAddressTest5 @AddressLine1 = 'Acardia'

SELECT * FROM Person.Address


/*********************************************************************************************************************************/

/*
Returning SQL Server stored procedure parameter values to a calling stored procedure

Overview
In a previous topic we discussed how to pass parameters into a stored procedure, but another option is to 
pass parameter values back out from a stored procedure.  One option for this may be that you call another 
stored procedure that does not return any data, but returns parameter values to be used by the calling 
stored procedure.

Explanation
Setting up output paramters for a stored procedure is basically the same as setting up input parameters, 
the only difference is that you use the OUTPUT clause after the parameter name to specify that it should 
return a value.  The output clause can be specified by either using the keyword "OUTPUT" or just "OUT". 
For these examples we are still using the AdventureWorks database, so all the stored procedures should 
be created in the AdventureWorks database.

Simple Output
CREATE PROCEDURE dbo.uspGetAddressCount @City nvarchar(30), @AddressCount int OUTPUT
AS
SELECT @AddressCount = count(*) 
FROM AdventureWorks.Person.Address 
WHERE City = @City
*/

CREATE PROCEDURE dbo.uspGetAddressCountTest6 @City nvarchar(30), @AddressCount int OUTPUT
AS
SELECT @AddressCount = count(*) 
FROM AdventureWorks2014.Person.Address 
WHERE City = @City

/* 
Or it can be done this way: 

CREATE PROCEDURE dbo.uspGetAddressCount @City nvarchar(30), @AddressCount int OUT
AS
SELECT @AddressCount = count(*) 
FROM AdventureWorks.Person.Address 
WHERE City = @City
*/

CREATE PROCEDURE dbo.uspGetAddressCountTest7 @City nvarchar(30), @AddressCount int OUT
AS
SELECT @AddressCount = count(*) 
FROM AdventureWorks2014.Person.Address 
WHERE City = @City

/*
To call this stored procedure we would execute it as follows.  First we are going to declare a variable, execute the stored procedure and then select the returned valued.

DECLARE @AddressCount int
EXEC dbo.uspGetAddressCount @City = 'Calgary', @AddressCount = @AddressCount OUTPUT
SELECT @AddressCount

*/

/* for the one that says 'int OUTPUT AS'*/
DECLARE @AddressCount int
EXEC dbo.uspGetAddressCountTest6 @City = 'Calgary', @AddressCount = @AddressCount OUTPUT
SELECT @AddressCount

/* for the one that says 'int OUT AS'*/
DECLARE @AddressCount int
EXEC dbo.uspGetAddressCountTest7 @City = 'Calgary', @AddressCount = @AddressCount OUT
SELECT @AddressCount

/*
This can also be done as follows, where the stored procedure parameter names are not passed.

DECLARE @AddressCount int
EXEC dbo.uspGetAddressCount 'Calgary', @AddressCount OUTPUT
SELECT @AddressCount
*/

DECLARE @AddressCount int
EXEC dbo.uspGetAddressCountTest6 'Calgary', @AddressCount OUTPUT
SELECT @AddressCount

/*********************************************************************************************************************************/

/*
Using try catch in SQL Server stored procedures

Overview
A great new option that was added in SQL Server 2005 was the ability to use the Try..Catch paradigm that 
exists in other development languages.  Doing error handling in SQL Server has not always been the easiest 
thing, so this option definitely makes it much easier to code for and handle errors.

Explanation
If you are not familiar with the Try...Catch paradigm it is basically two blocks of code with your 
stored procedures that lets you execute some code, this is the Try section and if there are errors 
they are handled in the Catch section. 

Let's take a look at an example of how this can be done.  As you can see we are using a basic SELECT 
statement that is contained within the TRY section, but for some reason if this fails it will run 
the code in the CATCH section and return the error information.

CREATE PROCEDURE dbo.uspTryCatchTest
AS
BEGIN TRY
    SELECT 1/0
END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber
     ,ERROR_SEVERITY() AS ErrorSeverity
     ,ERROR_STATE() AS ErrorState
     ,ERROR_PROCEDURE() AS ErrorProcedure
     ,ERROR_LINE() AS ErrorLine
     ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH

*/

CREATE PROCEDURE dbo.uspTryCatchTest8
AS
BEGIN TRY
    SELECT 1/0
END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber
     ,ERROR_SEVERITY() AS ErrorSeverity
     ,ERROR_STATE() AS ErrorState
     ,ERROR_PROCEDURE() AS ErrorProcedure
     ,ERROR_LINE() AS ErrorLine
     ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH


EXEC dbo.uspTryCatchTest8

/*********************************************************************************************************************************/

/*
Using comments in a SQL Server stored procedure

Overview
One very helpful thing to do with your stored procedures is to add comments to your code.  
This helps you to know what was done and why for future reference, but also helps other DBAs 
or developers that may need to make modifications to the code.

Explanation
SQL Server offers two types of comments in a stored procedure; line comments 
and block comments.   The following examples show you how to add comments using 
both techniques.  Comments are displayed in green in a SQL Server query window.
*/

-- this is how you write line comments

/*
This is how you write block comments,
wheren normally group text the way i have been doing
*/


/*********************************************************************************************************************************/

/*
Naming conventions for SQL Server stored procedures

Overview
One good thing to do for all of your SQL Server objects is to come up with a naming convention to use.  
There are not any hard and fast rules, so this is really just a guideline on what should be done.

Explanation
SQL Server uses object names and schema names to find a particular object that it needs to work with.  
This could be a table, stored procedure, function ,etc...

It is a good practice to come up with a standard naming convention for you objects including stored 
procedures.

Do not use sp_ as a prefix
One of the things you do not want to use as a standard is "sp_".  This is a standard naming convention 
that is used in the master database.  If you do not specify the database where the object is, SQL Server 
will first search the master database to see if the object exists there and then it will search the user 
database. So avoid using this as a naming convention.

Standardize on a Prefix
It is a good idea to come up with a standard prefix to use for your stored procedures.  As mentioned 
above do not use "sp_", so here are some other options.

usp_
sp
usp
etc...
To be honest it does not really matter what you use.  SQL Server will figure out that it is a stored 
procedure, but it is helpful to differentiate the objects, so it is easier to manage.

So a few examples could be:

spInsertPerson
uspInsertPerson
usp_InsertPerson
InsertPerson
Again this is totally up to you, but some standard is better than none.

Naming Stored Procedure Action
I liked to first give the action that the stored procedure takes and then give it a name representing 
the object it will affect.

So based on the actions that you may take with a stored procedure, you may use:

Insert
Delete
Update
Select
Get
Validate
etc...
So here are a few examples:

uspInsertPerson
uspGetPerson
spValidatePerson
SelectPerson
etc...
Another option is to put the object name first and the action second, this way all of the stored procedures 
for an object will be together.

uspPersonInsert
uspPersonDelete
uspPersonGet
etc...
Again, this does not really matter what action words that you use, but this will be helpful to classify 
the behavior characteristics.

Naming Stored Procedure Object
The last part of this is the object that you are working with.  Some of these may be real objects like 
tables, but others may be business processes.  Keep the names simple, but meaningful.  As your database 
grows and you add more and more objects you will be glad that you created some standards.

So some of these may be:

uspInsertPerson - insert a new person record
uspGetAccountBalance - get the balance of an account
uspGetOrderHistory - return list of orders
Schema Names
Another thing to consider is the schema that you will use when saving the objects.  A schema is the a 
collection of objects, so basically just a container.  This is useful if you want to keep all utility 
like objects together or have some objects that are HR related, etc...

This logical grouping will help you differentiate the objects further and allow you to focus on a 
group of objects.

Here are some examples of using a schema:

HR.uspGetPerson
HR.uspInsertPerson
UTIL.uspGet
UTIL.uspGetLastBackupDate
etc...
To create a new schema you use the CREATE SCHEMA command

Here is a simple example to create a new schema called "HR" and giving authorization to this schema to "DBO".

CREATE SCHEMA [HumanResources] AUTHORIZATION [dbo]
Putting It All Together
So you basically have four parts that you should consider when you come up with a naming convention:

Schema
Prefix
Action
Object
Take the time to think through what makes the most sense and try to stick to your conventions.

*/

-- May have to do some research on creating schemas since this section is on naming conventions anyway..
CREATE SCHEMA [HumanResources2] AUTHORIZATION [dbo] -- I ran this but I don't know exactly waht it does..

/*
Reducing amount of network data for SQL Server stored procedures

Overview
There are many tricks that can be used when you write T-SQL code.  One of these is to reduce the amount of 
network data for each statement that occurs within your stored procedures.  Every time a SQL statement is 
executed it returns the number of rows that were affected.  By using "SET NOCOUNT ON" within your stored 
procedure you can shut off these messages and reduce some of the traffic.

Explanation
As mentioned above there is not really any reason to return messages about what is occuring within SQL 
Server when you run a stored procedure.  If you are running things from a query window, this may be useful, 
but most end users that run stored procedures through an application would never see these messages. 

You can still use @@ROWCOUNT to get the number of rows impacted by a SQL statement, so turning SET NOCOUNT 
ON will not change that behavior.

Not using SET NOCOUNT ON
Here is an example without using SET NOCOUNT ON:

-- not using SET NOCOUNT ON 
CREATE PROCEDURE dbo.uspGetAddress @City nvarchar(30)
AS
SELECT * 
FROM Person.Address
WHERE City = @City
GO
The messages that are returned would be similar to this:

(23 row(s) affected)

*/

-- Not using SET NOCOUNT ON
CREATE PROCEDURE dbo.uspGetAddressTest9 @City nvarchar(30)
AS
SELECT * 
FROM Person.Address
WHERE City = @City
GO

-- After running the above codes I didn't get '(23 row(s) affected)' I got 'Commands completed successfully' using SQL Server Management Studio v18.0 RC1

/*
Using SET NOCOUNT ON
This example uses the SET NOCOUNT ON as shown below.  It is a good practice to put this at the beginning of the stored procedure.

-- using SET NOCOUNT ON 
CREATE PROCEDURE dbo.uspGetAddress @City nvarchar(30)
AS
SET NOCOUNT ON
SELECT * 
FROM Person.Address
WHERE City = @City
GO
The messages that are returned would be similar to this:

Command(s) completed successfully.
*/

-- Using SET NOCOUNT ON 
CREATE PROCEDURE dbo.uspGetAddressTest10 @City nvarchar(30)
AS
SET NOCOUNT ON
SELECT * 
FROM Person.Address
WHERE City = @City
GO

-- After running the above codes I got 'Commands completed successfully' using SQL Server Management Studio v18.0 RC1 4/26/19

/*
Using SET NOCOUNT ON and @@ROWCOUNT
This example uses SET NOCOUNT ON, but will still return the number of rows impacted by the previous statement.  This just shows that this still works.

-- not using SET NOCOUNT ON 
CREATE PROCEDURE dbo.uspGetAddress @City nvarchar(30)
AS
SET NOCOUNT ON
SELECT * 
FROM Person.Address
WHERE City = @City
PRINT @@ROWCOUNT
GO
The messages that are returned would be similar to this:

23

SET NOCOUNT OFF
If you wanted to turn this behavior off, you would just use the command "SET NOCOUNT OFF".
*/

CREATE PROCEDURE dbo.uspGetAddressTest11 @City nvarchar(30)
AS
SET NOCOUNT ON
SELECT * 
FROM Person.Address
WHERE City = @City
PRINT @@ROWCOUNT
GO
-- After running the above codes I got 'Commands completed successfully' using SQL Server Management Studio v18.0 RC1 4/26/19

-- I tried this below to see if it would count the rows but it didn't, it just returned what it's supposed to.
EXEC dbo.uspGetAddressTest11 @City = 'New York'

SET NOCOUNT OFF
-- After running the above codes I got 'Commands completed successfully' using SQL Server Management Studio v18.0 RC1 4/26/19
-- Im not excatly sure  what how NOCOUNT works or it is probably an outdated feature..

/*
Deleting a SQL Server stored procedure

Overview
In addition to creating stored procedures there is also the need to delete stored procedures.  This topic 
shows you how you can delete stored procedures that are no longer needed.

Explanation
The syntax is very straightforward to drop a stored procedure, here are some examples.

Dropping Single Stored Procedure
To drop a single stored procedure you use the DROP PROCEDURE or DROP PROC command as follows.

DROP PROCEDURE dbo.uspGetAddress 
GO
-- or
DROP PROC dbo.uspGetAddress 
GO
*/

--Run this to create something to delete later
CREATE PROCEDURE dbo.uspGetAddressTest12
AS
SELECT * 
FROM Person.Address
WHERE City = 'New York'
GO

--Run this to test the procedure
EXEC dbo.uspGetAddressTest12

--Run this to delete the procedure
DROP PROCEDURE dbo.uspGetAddressTest12 
GO

--Run this to test the procedure (you should get an error)
EXEC dbo.uspGetAddressTest12

/*
Dropping Multiple Stored Procedures
To drop multiple stored procedures with one command you specify each procedure separated by a comma as shown below.

DROP PROCEDURE dbo.uspGetAddress, dbo.uspInsertAddress, dbo.uspDeleteAddress
GO
-- or
DROP PROC dbo.uspGetAddress, dbo.uspInsertAddress, dbo.uspDeleteAddress
GO
*/

--------------------------------------------------
CREATE PROCEDURE dbo.TestToDELETE1
AS
SELECT * 
FROM Person.Address
GO

EXEC dbo.TestToDELETE1
--------------------------------------------------
CREATE PROCEDURE dbo.TestToDELETE2
AS
SELECT * 
FROM Person.Address
GO

EXEC dbo.TestToDELETE2
--------------------------------------------------
CREATE PROCEDURE dbo.TestToDELETE3
AS
SELECT * 
FROM Person.Address
GO

EXEC dbo.TestToDELETE3
--------------------------------------------------

DROP PROCEDURE dbo.TestToDELETE1, dbo.TestToDELETE2, dbo.TestToDELETE3

/*
Modifying an existing SQL Server stored procedure

Overview
When you first create your stored procedures it may work as planned, but how to do you modify an existing stored procedure.  
In this topic we look at the ALTER PROCEDURE command and it is used.

Explanation
Modifying or ALTERing a stored procedure is pretty simple.  Once a stored procedure has been created it is stored within 
one of the system tables in the database that is was created in.  When you modify a stored procedure the entry that was 
originally made in the system table is replaced by this new code.  Also, SQL Server will recompile the stored procedure 
the next time it is run, so your users are using the new logic.  The command to modify an existing stored procedure is 
ALTER PROCEDURE or ALTER PROC.

Modifying an Existing Stored Procedure
Let's say we have the following existing stored procedure:  This allows us to do an exact match on the City.

CREATE PROCEDURE dbo.uspGetAddress @City nvarchar(30)
AS
SELECT * 
FROM Person.Address
WHERE City = @City
GO
Let's say we want to change this to do a LIKE instead of an equals.

To change the stored procedure and save the updated code you would use the ALTER PROCEDURE command as follows.

ALTER PROCEDURE dbo.uspGetAddress @City nvarchar(30)
AS
SELECT * 
FROM Person.Address
WHERE City LIKE @City + '%'
GO
Now the next time that the stored procedure is called by an end user it will use this new logic.
*/


--This is my Test
CREATE PROCEDURE dbo.uspGetAddressTest13 
AS
SELECT * 
FROM Person.Address
WHERE City = 'New York'
GO

EXEC dbo.uspGetAddressTest13 

ALTER PROCEDURE dbo.uspGetAddressTest13 
AS
SELECT * 
FROM Person.Address
WHERE StateProvinceID = 9
GO

EXEC dbo.uspGetAddressTest13

/*********************************************************************************************************************************/

/*
USE THE ADVENTUREWORKS DATABASE FOR THIS DRILL
STORED PROCEDURE TRAINING AND DRILL

Design a stored procedure that has at least two joins and two parameters.

*/

--This query has First Name and Last Name string parameters that will retrieve email and password data
CREATE PROCEDURE GetPersonEmailAndPassword @FirstName VARCHAR(50), @LastName VARCHAR(50)
AS
SELECT a.BusinessEntityID, a.FirstName, a.LastName, b.EmailAddress, c.PasswordHash, c.PasswordSalt, c.ModifiedDate
FROM Person.Person a
INNER JOIN Person.EmailAddress b ON a.BusinessEntityID = b.BusinessEntityID
INNER JOIN Person.Password c ON b.BusinessEntityID = c.BusinessEntityID
WHERE FirstName LIKE '%' + @FirstName + '%' AND LastName LIKE '%' + @LastName + '%'

-- This is my test
EXEC GetPersonEmailAndPassword @FirstName = '', @LastName = 'Nixon'
