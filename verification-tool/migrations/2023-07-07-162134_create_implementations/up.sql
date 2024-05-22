-- Your SQL goes here
-- public.implementations definition

CREATE TABLE public.implementations (
	id serial NOT NULL,
	"content" TEXT NOT NULL,
	"name" TEXT NOT NULL,
	id_log int4 NOT NULL,
	verify BOOLEAN NOT NULL DEFAULT FALSE,
	CONSTRAINT implementations_pkey PRIMARY KEY (id)
);