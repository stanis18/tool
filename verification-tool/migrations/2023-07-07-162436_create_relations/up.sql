-- Your SQL goes here

-- public.relations definition

CREATE TABLE public.relations (
	id serial NOT NULL,
	relation TEXT NOT NULL,
	id_log int4 NOT NULL,
	CONSTRAINT relations_pkey PRIMARY KEY (id)
);