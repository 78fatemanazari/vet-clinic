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

