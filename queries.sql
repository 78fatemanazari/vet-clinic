/* Queries about animals table*/
/* First Project*/

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

/* Second Project*/

--PART ONE - transactions - animals table by setting the species column to unspecified
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species from animals;
ROLLBACK;
SELECT species from animals;
--PART TWO - transactions - species column and insertion
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT species from animals; 
COMMIT;
SELECT species from animals;
commit;

--PART THREE - TRANSACTION- Delete animals table
BEGIN Transaction;
DELETE FROM animals;
ROLLBACK;

--PART 4 - TRANSACTION- multiply rows to -1
BEGIN Transaction;
DELETE From animals Where date_of_Birth > '2022-01-01';
UPDATE animals set weight_kg = (weight_kg * -1);
SAVEPOINT fn1;
ROLLBACK to fn1;
Update animals set weight_kg = (weight_kg * -1) Where weight_kg < 0;
COMMIT;

/* QUERIES - PART 5*/

-- 1st query
SELECT Count(name) From animals;
-- 2nd query
SELECT Count(name) From animals Where escape_attempts = 0;
-- 3th query
SELECT Avg(weight_kg) From animals;
-- 4th query
SELECT neutered, Count(neutered) From animals Group by (neutered); 
-- 5th query
SELECT species, Min(weight_kg) From animals Group by species;
SELECT species, Max(weight_kg) From animals Group by species;
-- 6th query
SELECT species, Avg(escape_attempts) From animals Where
(date_of_birth Between '1990-01-01' and '2000-12-31')
Group by (species); 

/* Third Project */
-- Query 1:
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';
-- Query 2:
SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';
-- Query 3:
SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
ORDER BY owners.full_name, animals.name;
-- Query 4:
SELECT species.name, COUNT(animals.id) AS num_animals
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name
ORDER BY num_animals DESC;
-- Query 5:
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell'
AND species.name = 'Digimon';
-- Query 6:
SELECT animals.name as animal_name, owners.full_name as owner_name, 
animals.escape_attempts 
FROM animals
JOIN owners ON (animals.owner_id = owners.id
AND owners.full_name like 'Dean Winchester');
-- Query 7:
SELECT owners.full_name, COUNT(animals.id) AS num_animals
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY num_animals DESC
LIMIT 1;