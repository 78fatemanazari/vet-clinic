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

/* Fourth Project*/

-- Query 1:
SELECT a.name
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vet ON v.vet_id = vet.id
WHERE vet.name = 'Vet William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

-- Query 2:
SELECT COUNT(DISTINCT v.animal_id) AS animal_count
FROM visits AS v
JOIN vets AS vet ON v.vet_id = vet.id
WHERE vet.name = 'Stephanie Mendez';
-- Query 3:
SELECT v.name, s.species_id, sp.name as specialty
FROM vets as v
LEFT JOIN specializations as s ON (v.id = s.vet_id)
LEFT JOIN species as sp ON (s.species_id = sp.id);
-- Query 4:
SELECT a.name AS animal_name
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vet ON v.vet_id = vet.id
WHERE vet.name = 'Stephanie Mendez'
AND v.visit_date >= '2020-04-01' 
AND v.visit_date <= '2020-08-30';
-- Query 5:
SELECT a.name AS animal_name, COUNT(v.animal_id) AS visit_count
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;
-- Query 6:
SELECT a.name AS animal_name, MIN(v.visit_date) AS first_visit_date
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vet ON v.vet_id = vet.id
WHERE vet.name = 'Maisy Smith'
GROUP BY a.name
ORDER BY first_visit_date
LIMIT 1;
-- Query 7:
SELECT a.name AS animal_name, vet.name AS vet_name, v.visit_date AS visit_date
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS vet ON v.vet_id = vet.id
WHERE v.visit_date = (SELECT MAX(visit_date) FROM visits);
-- Query 8:
SELECT COUNT(*) AS visits_without_specialty
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS vet ON v.vet_id = vet.id
LEFT JOIN specializations AS s ON vet.id = s.vet_id AND a.species_id = s.species_id
WHERE s.vet_id IS NULL;
-- query 9:
SELECT a.name as animal, ve.name as vet, 
s.name as species, COUNT(v.date_of_visit) 
FROM visits as v
JOIN animals as a ON (v.animal_id = a.id)
JOIN vets as ve ON (v.vet_id = ve.id)
LEFT JOIN species as s ON (a.species_id = s.id)
WHERE (v.vet_id = (SELECT (id) FROM vets 
	WHERE v.vet_id = vets.id 
	AND vets.name = ('Maisy Smith')))
GROUP BY a.name, ve.name, s.name;
