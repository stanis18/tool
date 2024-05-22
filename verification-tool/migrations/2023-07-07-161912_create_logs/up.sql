-- Your SQL goes here
-- public.logs definition

-- Drop table

CREATE TABLE public.logs (
	id serial NOT NULL,
	author_address TEXT NOT NULL,
	specification TEXT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	specification_id TEXT NOT NULL,
	proxy_address TEXT NOT NULL,
	specification_file_name TEXT NOT NULL,
	proxy TEXT NOT NULL,
	chain_id TEXT NOT NULL,
	deployed BOOLEAN NOT NULL DEFAULT FALSE,
	CONSTRAINT logs_pkey PRIMARY KEY (id)
);