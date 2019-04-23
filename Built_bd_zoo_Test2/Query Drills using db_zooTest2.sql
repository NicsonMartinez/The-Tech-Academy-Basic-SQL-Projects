USE db_zooTest2
GO

/*
DRILL 1:
Compose a SELECT statement that queries for the following information

➤ All information from the habitat table.
*/
SELECT * FROM tbl_habitat;

/*
DRILL 2:
Compose a SELECT statement that queries for the following information:

➤ Retrieve all names from the species_name column that have a species_order value of 3.
*/
SELECT * FROM tbl_species WHERE species_order = 3;

/*
DRILL 3:
Compose a SELECT statement that queries for the following information:

➤ Retrieve only the nutrition_type from the nutrition table that have a nutrition_cost of 600.00 or less.
*/
SELECT nutrition_type FROM tbl_nutrition WHERE nutrition_cost <= 600.00;

/*
DRILL 4:
Compose a SELECT statement that queries for the following information:

➤ Retrieve all species_names with the nutrition_id between 2202 and 2206 from the nutrition table.
*/
SELECT species_name FROM tbl_species WHERE species_nutrition BETWEEN 2202 AND 2206;

/*
DRILL 5:
Compose a SELECT statement that queries for the following information:

➤ Retrieve all names within the species_name column using the alias "Species Name:" from the species table 
   and their corresponding nutrition_type under the alias "Nutrition Type:" from the nutrition table.
*/
SELECT
	a.species_name AS 'Species Name:', b.nutrition_type AS 'Nutrition Type:' /*Let me get these columns species_name & nutrition_type from their corresponding tables (a = tbl_speacies, b = tbl_nutrition)*/
	FROM tbl_species a /* FROM table A */
	INNER JOIN tbl_nutrition b ON a.species_nutrition = b.nutrition_id; /* INNER JOIN other table B , by linking them together by connecting what is equal (their fk and pk)*/

/*
DRILL 6:
Compose a SELECT statement that queries for the following information:

➤ From the specialist table, retrieve the first and last name and contact number of those that provide care 
   for the penguins from the species table.
*/
SELECT 
	a.species_name, c.specialist_fname, c.specialist_lname, c.specialist_contact
	FROM tbl_species a
	INNER JOIN tbl_care b ON a.species_care = b.care_id
	INNER JOIN tbl_specialist c ON b.care_specialist = c.specialist_id
	WHERE species_name = 'penguin';


	
