--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Debian 10.5-1)
-- Dumped by pg_dump version 10.5 (Debian 10.5-1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE centripetal;
--
-- Name: centripetal; Type: DATABASE; Schema: -; Owner: centripetal
--

CREATE DATABASE centripetal WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_NZ.UTF-8' LC_CTYPE = 'en_NZ.UTF-8';


ALTER DATABASE centripetal OWNER TO centripetal;

\connect centripetal

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: app_hidden; Type: SCHEMA; Schema: -; Owner: centripetal
--

CREATE SCHEMA app_hidden;


ALTER SCHEMA app_hidden OWNER TO centripetal;

--
-- Name: app_jobs; Type: SCHEMA; Schema: -; Owner: centripetal
--

CREATE SCHEMA app_jobs;


ALTER SCHEMA app_jobs OWNER TO centripetal;

--
-- Name: app_private; Type: SCHEMA; Schema: -; Owner: centripetal
--

CREATE SCHEMA app_private;


ALTER SCHEMA app_private OWNER TO centripetal;

--
-- Name: app_public; Type: SCHEMA; Schema: -; Owner: centripetal
--

CREATE SCHEMA app_public;


ALTER SCHEMA app_public OWNER TO centripetal;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pg_rrule; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_rrule WITH SCHEMA public;


--
-- Name: EXTENSION pg_rrule; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_rrule IS 'RRULE field type for PostgreSQL';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: authority; Type: TYPE; Schema: app_private; Owner: centripetal
--

CREATE TYPE app_private.authority AS ENUM (
    'God',
    'Admin',
    'Staff',
    'Speaker',
    'Panelist',
    'Media',
    'Volunteer',
    'Attendee',
    'Anonymous'
);


ALTER TYPE app_private.authority OWNER TO centripetal;

--
-- Name: image_media_type; Type: TYPE; Schema: app_public; Owner: centripetal
--

CREATE TYPE app_public.image_media_type AS ENUM (
    'image/gif',
    'image/png',
    'image/jpeg',
    'image/bmp',
    'image/webp',
    'image/x-icon',
    'image/vnd.microsoft.icon',
    'image/svg+xml'
);


ALTER TYPE app_public.image_media_type OWNER TO centripetal;

--
-- Name: jwt_token; Type: TYPE; Schema: app_public; Owner: centripetal
--

CREATE TYPE app_public.jwt_token AS (
	role text,
	account_id uuid
);


ALTER TYPE app_public.jwt_token OWNER TO centripetal;

--
-- Name: char_128; Type: DOMAIN; Schema: public; Owner: cp_postgraphile
--

CREATE DOMAIN public.char_128 AS text
	CONSTRAINT char_128_check CHECK ((char_length(VALUE) <= 128));


ALTER DOMAIN public.char_128 OWNER TO cp_postgraphile;

--
-- Name: char_256; Type: DOMAIN; Schema: public; Owner: cp_postgraphile
--

CREATE DOMAIN public.char_256 AS text
	CONSTRAINT char_256_check CHECK ((char_length(VALUE) <= 256));


ALTER DOMAIN public.char_256 OWNER TO cp_postgraphile;

--
-- Name: char_32; Type: DOMAIN; Schema: public; Owner: cp_postgraphile
--

CREATE DOMAIN public.char_32 AS text
	CONSTRAINT char_32_check CHECK ((char_length(VALUE) <= 32));


ALTER DOMAIN public.char_32 OWNER TO cp_postgraphile;

--
-- Name: char_48; Type: DOMAIN; Schema: public; Owner: cp_postgraphile
--

CREATE DOMAIN public.char_48 AS text
	CONSTRAINT char_48_check CHECK ((char_length(VALUE) <= 48));


ALTER DOMAIN public.char_48 OWNER TO cp_postgraphile;

--
-- Name: char_64; Type: DOMAIN; Schema: public; Owner: cp_postgraphile
--

CREATE DOMAIN public.char_64 AS text
	CONSTRAINT char_64_check CHECK ((char_length(VALUE) <= 64));


ALTER DOMAIN public.char_64 OWNER TO cp_postgraphile;

--
-- Name: email; Type: DOMAIN; Schema: public; Owner: cp_postgraphile
--

CREATE DOMAIN public.email AS text
	CONSTRAINT email_check CHECK ((VALUE ~* '^(("[-\w\s]+")|([\w-]+(?:\.[\w-]+)*)|("[-\w\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)'::text));


ALTER DOMAIN public.email OWNER TO cp_postgraphile;

--
-- Name: password; Type: DOMAIN; Schema: public; Owner: cp_postgraphile
--

CREATE DOMAIN public.password AS text
	CONSTRAINT password_check CHECK ((char_length(VALUE) >= 8));


ALTER DOMAIN public.password OWNER TO cp_postgraphile;

--
-- Name: u_r_l; Type: DOMAIN; Schema: public; Owner: cp_postgraphile
--

CREATE DOMAIN public.u_r_l AS text
	CONSTRAINT url_check CHECK ((VALUE ~* '^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$'::text));


ALTER DOMAIN public.u_r_l OWNER TO cp_postgraphile;

--
-- Name: x_h_t_m_l; Type: DOMAIN; Schema: public; Owner: cp_postgraphile
--

CREATE DOMAIN public.x_h_t_m_l AS xml;


ALTER DOMAIN public.x_h_t_m_l OWNER TO cp_postgraphile;


SET default_tablespace = '';

SET default_with_oids = false;