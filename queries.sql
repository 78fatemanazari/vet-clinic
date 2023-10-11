/* Queries about animals table*/

/* The 1st query */
SELECT * From animals Where name Like '%mon';
/* The 2nd query */
SELECT id, name From animals Where (date_of_birth > '2015-12-31' and date_of_birth < '2020-01-01');
/* The 3rd query */
SELECT id, name From animals Where (neutered = true and escape_attempts < '3');
/* The 4th query*/
SELECT id, name, date_of_birth from animals Where name in ('Agumon', 'Pikachu');
/* The 5th query*/
SELECT id, name, escape_attempts from animals Where (weight_kg > '10.5');
/* The 6th query */
SELECT * From animals Where neutered = true ; 
/* The 7th qeury*/
SELECT * From animals Where name not in ('Gabumon'); 
/* The 8th query*/
SELECT * From animals Where (weight_kg >= '10.4' and weight_kg <= '17.3');