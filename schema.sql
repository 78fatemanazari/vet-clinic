/* CREATE ANIMALS TABLE */

CREATE TABLE IF NOT EXISTS public.animals
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(100) COLLATE pg_catalog."default",
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg real,
    CONSTRAINT animals_pkey PRIMARY KEY (id)
)

--Update animals table and queries

ALTER TABLE IF EXISTS public.animals
    ADD COLUMN IF NOT EXISTS species character varying(100) COLLATE pg_catalog."default";

--Third project

CREATE TABLE IF NOT EXISTS public.animals
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(100) COLLATE pg_catalog."default",
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg real,
    species_id integer,
    owner_id integer,
    CONSTRAINT animals_pkey PRIMARY KEY (id),
    CONSTRAINT fk_owner FOREIGN KEY (owner_id)
        REFERENCES public.owners (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_species FOREIGN KEY (species_id)
        REFERENCES public.species (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

--Fourth Project
--Vets table:
CREATE TABLE IF NOT EXISTS public.vets
(
    id integer NOT NULL,
    name character varying(100) COLLATE pg_catalog."default",
    age integer,
    date_of_graduation date,
    CONSTRAINT vets_pkey PRIMARY KEY (id)
)
--Specializations table
CREATE TABLE IF NOT EXISTS public.species
CREATE TABLE IF NOT EXISTS public.specializations
(
    vet_id integer NOT NULL,
    species_id integer NOT NULL,
    id integer,
    CONSTRAINT specializations_pkey PRIMARY KEY (vet_id, species_id)
)
--Visits table
CREATE TABLE IF NOT EXISTS public.visits
(
    animal_id integer NOT NULL,
    vet_id integer NOT NULL,
    visit_date date NOT NULL,
    CONSTRAINT visits_pkey PRIMARY KEY (animal_id, vet_id, visit_date)
)