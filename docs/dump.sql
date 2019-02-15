--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

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
-- Name: centripetal; Type: DATABASE; Schema: -; Owner: cp_postgraphile
--

CREATE DATABASE centripetal WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE centripetal OWNER TO cp_postgraphile;

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
-- Name: app_hidden; Type: SCHEMA; Schema: -; Owner: cp_postgraphile
--

CREATE SCHEMA app_hidden;


ALTER SCHEMA app_hidden OWNER TO cp_postgraphile;

--
-- Name: app_jobs; Type: SCHEMA; Schema: -; Owner: cp_postgraphile
--

CREATE SCHEMA app_jobs;


ALTER SCHEMA app_jobs OWNER TO cp_postgraphile;

--
-- Name: app_private; Type: SCHEMA; Schema: -; Owner: cp_postgraphile
--

CREATE SCHEMA app_private;


ALTER SCHEMA app_private OWNER TO cp_postgraphile;

--
-- Name: app_public; Type: SCHEMA; Schema: -; Owner: cp_postgraphile
--

CREATE SCHEMA app_public;


ALTER SCHEMA app_public OWNER TO cp_postgraphile;

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
-- Name: authority; Type: TYPE; Schema: app_private; Owner: cp_postgraphile
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


ALTER TYPE app_private.authority OWNER TO cp_postgraphile;

--
-- Name: image_media_type; Type: TYPE; Schema: app_public; Owner: cp_postgraphile
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


ALTER TYPE app_public.image_media_type OWNER TO cp_postgraphile;

--
-- Name: jwt_token; Type: TYPE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TYPE app_public.jwt_token AS (
	role text,
	account_id uuid
);


ALTER TYPE app_public.jwt_token OWNER TO cp_postgraphile;

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

--
-- Name: delete_unused_tags(); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.delete_unused_tags() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  DELETE FROM app_public.tag WHERE id IN (
    SELECT id FROM app_private.tag_use_count WHERE use_count IS NULL
  );
  RETURN NULL;
END;
$$;


ALTER FUNCTION app_private.delete_unused_tags() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION delete_unused_tags(); Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_private.delete_unused_tags() IS 'Deletes any unused tags.';


--
-- Name: set_account_id(); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.set_account_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.account_id := current_setting('jwt.claims.account_id', true)::uuid;
  RETURN new;
END;
$$;


ALTER FUNCTION app_private.set_account_id() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION set_account_id(); Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_private.set_account_id() IS 'Sets the account that created a record (triggered).';


--
-- Name: set_created_by(); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.set_created_by() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.created_by := current_setting('jwt.claims.account_id', true)::integer;
  RETURN new;
END;
$$;


ALTER FUNCTION app_private.set_created_by() OWNER TO cp_postgraphile;

--
-- Name: set_event_spot(); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.set_event_spot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.spot := app_public.get_event_count_by_parent_id(new.parent)::integer;
  return new;
END;
$$;


ALTER FUNCTION app_private.set_event_spot() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION set_event_spot(); Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_private.set_event_spot() IS 'Sets the spot for inserted events to the last child for that parent.';


--
-- Name: set_organization_spot(); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.set_organization_spot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.spot := app_public.get_organization_count_by_parent_id(new.parent)::integer;
  return new;
END;
$$;


ALTER FUNCTION app_private.set_organization_spot() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION set_organization_spot(); Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_private.set_organization_spot() IS 'Sets the spot for inserted organizations to the last child for that parent.';


--
-- Name: set_updated_at(); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.updated_at := current_timestamp;
  RETURN new;
END;
$$;


ALTER FUNCTION app_private.set_updated_at() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION set_updated_at(); Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_private.set_updated_at() IS 'Sets the updated at timestamp for a record (on trigger).';


--
-- Name: set_venue_spot(); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.set_venue_spot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.spot := app_public.get_venue_count_by_parent_id(new.parent)::integer;
  return new;
END;
$$;


ALTER FUNCTION app_private.set_venue_spot() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION set_venue_spot(); Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_private.set_venue_spot() IS 'Sets the spot for inserted venues to the last child for that parent.';


--
-- Name: update_event_spot_on_deletion(); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.update_event_spot_on_deletion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE app_public.event SET spot = spot - 1 WHERE spot > OLD.spot AND parent = OLD.parent;
        RETURN NULL;
    END;
$$;


ALTER FUNCTION app_private.update_event_spot_on_deletion() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION update_event_spot_on_deletion(); Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_private.update_event_spot_on_deletion() IS 'Resets event spots to remove a gap on event deletion.';


--
-- Name: update_organization_spot_on_deletion(); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.update_organization_spot_on_deletion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE app_public.organization SET spot = spot - 1 WHERE spot > OLD.spot AND parent = OLD.parent;
        RETURN NULL;
    END;
$$;


ALTER FUNCTION app_private.update_organization_spot_on_deletion() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION update_organization_spot_on_deletion(); Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_private.update_organization_spot_on_deletion() IS 'Resets organization spots to remove a gap on organization deletion.';


--
-- Name: update_venue_spot_on_deletion(); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.update_venue_spot_on_deletion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE app_public.venue SET spot = spot - 1 WHERE spot > OLD.spot AND parent = OLD.parent;
        RETURN NULL;
    END;
$$;


ALTER FUNCTION app_private.update_venue_spot_on_deletion() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION update_venue_spot_on_deletion(); Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_private.update_venue_spot_on_deletion() IS 'Resets venue spots to remove a gap on venue deletion.';


--
-- Name: upsert_tag(text); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.upsert_tag(tag_body text) RETURNS uuid
    LANGUAGE plpgsql
    AS $_$
DECLARE
  id uuid;
BEGIN
  INSERT INTO app_public.tag AS t (body) VALUES ($1) ON CONFLICT (lower(body)) DO UPDATE SET updated_at = NOW() RETURNING t.id INTO id;
  
  RETURN id;
END;
$_$;


ALTER FUNCTION app_private.upsert_tag(tag_body text) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION upsert_tag(tag_body text); Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_private.upsert_tag(tag_body text) IS 'Inserts a tag unless it already exists and returns the tag id.';


--
-- Name: authenticate(public.email, public.password); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.authenticate(email public.email, password public.password) RETURNS app_public.jwt_token
    LANGUAGE plpgsql STRICT SECURITY DEFINER
    AS $_$
DECLARE
  account app_private.credential;
BEGIN
  SELECT a.* INTO account
  FROM app_private.credential AS a
  WHERE a.email = $1;

  IF account.password_hash = crypt(password, account.password_hash) THEN
    RETURN ('cp_account', account.account_id)::app_public.jwt_token;
  ELSE
    RETURN NULL;
  END IF;
END;
$_$;


ALTER FUNCTION app_public.authenticate(email public.email, password public.password) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION authenticate(email public.email, password public.password); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.authenticate(email public.email, password public.password) IS 'Authenticates (signs in) an account.';


--
-- Name: child_paths_by_parent_path_and_depth(text, integer); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) RETURNS text[]
    LANGUAGE sql STABLE
    AS $_$
    SELECT array_agg(full_path) AS child_paths
    FROM app_private.full_path
    WHERE full_path like $1 || '%'
    AND depth = $2;
$_$;


ALTER FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION child_paths_by_parent_path_and_depth(parent_path text, depth integer); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) IS 'Generates an array of full_paths to children using the parent_path.';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.account (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    given_name public.char_48,
    family_name public.char_48,
    job_title public.char_64,
    bio text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE app_public.account OWNER TO cp_postgraphile;

--
-- Name: TABLE account; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON TABLE app_public.account IS 'An account (user) for the Centripetal app.';


--
-- Name: COLUMN account.id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.account.id IS 'The primary unique ID for this account.';


--
-- Name: COLUMN account.job_title; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.account.job_title IS 'Job title of person associated with this account.';


--
-- Name: COLUMN account.bio; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.account.bio IS 'A brief bio for this account.';


--
-- Name: COLUMN account.created_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.account.created_at IS 'The date and time this account was created.';


--
-- Name: COLUMN account.updated_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.account.updated_at IS 'The date and time this account was last updated.';


--
-- Name: current_account(); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.current_account() RETURNS app_public.account
    LANGUAGE sql STABLE
    AS $$
  SELECT *
  FROM app_public.account
  WHERE id = current_setting('jwt.claims.account_id', true)::uuid
$$;


ALTER FUNCTION app_public.current_account() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION current_account(); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.current_account() IS 'Returns the user who was identified by the JWT.';


--
-- Name: full_name(app_public.account); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.full_name(account app_public.account) RETURNS text
    LANGUAGE sql STABLE
    AS $$
  SELECT account.given_name || ' ' || account.family_name
$$;


ALTER FUNCTION app_public.full_name(account app_public.account) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION full_name(account app_public.account); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.full_name(account app_public.account) IS 'Generates the full name from given and family names.';


--
-- Name: generate_u_u_i_d(); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.generate_u_u_i_d() RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
  output uuid;
BEGIN
  output := uuid_generate_v1mc();

  RETURN output;
END;
$$;


ALTER FUNCTION app_public.generate_u_u_i_d() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION generate_u_u_i_d(); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.generate_u_u_i_d() IS 'Generates a single v1mc UUID.';


--
-- Name: generate_u_u_i_ds(integer); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.generate_u_u_i_ds(quantity integer) RETURNS uuid[]
    LANGUAGE plpgsql
    AS $_$
DECLARE
  counter integer := 0;
  uuids uuid[];
BEGIN
  WHILE counter < $1 LOOP
    counter := counter + 1;
    uuids := array_append(uuids, uuid_generate_v1mc());
  END LOOP;

  RETURN uuids;
END;
$_$;


ALTER FUNCTION app_public.generate_u_u_i_ds(quantity integer) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION generate_u_u_i_ds(quantity integer); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) IS 'Returns an array of UUIDs of length `quantity`.';


--
-- Name: get_event_count_by_parent_id(uuid); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.get_event_count_by_parent_id(uuid) RETURNS bigint
    LANGUAGE sql
    AS $_$
  SELECT count(id) AS RESULT FROM app_public.event WHERE parent = $1;
$_$;


ALTER FUNCTION app_public.get_event_count_by_parent_id(uuid) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION get_event_count_by_parent_id(uuid); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.get_event_count_by_parent_id(uuid) IS 'Returns the number of children this event has.';


--
-- Name: get_organization_count_by_parent_id(uuid); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.get_organization_count_by_parent_id(uuid) RETURNS bigint
    LANGUAGE sql
    AS $_$
  SELECT count(id) AS RESULT FROM app_public.organization WHERE parent = $1;
$_$;


ALTER FUNCTION app_public.get_organization_count_by_parent_id(uuid) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION get_organization_count_by_parent_id(uuid); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) IS 'Returns the number of children this organization has.';


--
-- Name: get_venue_count_by_parent_id(uuid); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.get_venue_count_by_parent_id(uuid) RETURNS bigint
    LANGUAGE sql
    AS $_$
  SELECT count(id) AS RESULT FROM app_public.venue WHERE parent = $1;
$_$;


ALTER FUNCTION app_public.get_venue_count_by_parent_id(uuid) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION get_venue_count_by_parent_id(uuid); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) IS 'Returns the number of children this venue has.';


--
-- Name: event; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.event (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    slug public.char_64 DEFAULT ''::text NOT NULL,
    link_label public.char_32 NOT NULL,
    link_description public.char_256 NOT NULL,
    title public.char_64 NOT NULL,
    content public.x_h_t_m_l,
    image uuid,
    spot integer DEFAULT 0 NOT NULL,
    parent uuid,
    event_type uuid NOT NULL,
    account_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT page_check CHECK ((((slug)::text ~* '^[a-z]+(\-([a-z])+)*$'::text) OR ((parent IS NULL) AND ((slug)::text = ''::text))))
);


ALTER TABLE app_public.event OWNER TO cp_postgraphile;

--
-- Name: TABLE event; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON TABLE app_public.event IS 'An event with XHTML content, etc.';


--
-- Name: COLUMN event.id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.id IS 'The primary key for this event.';


--
-- Name: COLUMN event.slug; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.slug IS 'The unique-for-this-path, plain text, train-case "slug" used in the event page URL.';


--
-- Name: COLUMN event.link_label; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.link_label IS 'The plain text label used for links to this event.';


--
-- Name: COLUMN event.link_description; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.link_description IS 'A plain text description of this event used in links and tables of content.';


--
-- Name: COLUMN event.title; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.title IS 'The plain text title of the event as seen in the tab and the page header.';


--
-- Name: COLUMN event.content; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.content IS 'XHTML content about the event.';


--
-- Name: COLUMN event.image; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.image IS 'An Image associated with this event (an icon, perhaps).';


--
-- Name: COLUMN event.spot; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.spot IS 'The position of this event among its siblings.';


--
-- Name: COLUMN event.parent; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.parent IS 'The id of the parent event to this event.';


--
-- Name: COLUMN event.event_type; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.event_type IS 'The id of the event type of this event';


--
-- Name: COLUMN event.account_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.account_id IS 'The id of the account holder that created this event.';


--
-- Name: COLUMN event.created_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.created_at IS 'The date and time this event was created.';


--
-- Name: COLUMN event.updated_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.updated_at IS 'The date and time this event was last updated.';


--
-- Name: move_event_down(uuid); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.move_event_down(uuid) RETURNS app_public.event
    LANGUAGE plpgsql
    AS $_$
DECLARE
  current_row RECORD;
  event_count BIGINT;
BEGIN
  SELECT INTO current_row p.*
  FROM app_public.event AS p
  WHERE p.id = $1;
  
  SELECT INTO event_count COUNT(p.id)
  FROM app_public.event AS p
  WHERE p.parent = current_row.parent;
  
  IF current_row.spot < event_count - 1 THEN
    UPDATE app_public.event SET spot = -1 WHERE id = $1;
    UPDATE app_public.event SET spot = spot - 1 WHERE spot = current_row.spot + 1 AND parent = current_row.parent;
    UPDATE app_public.event SET spot = current_row.spot + 1 WHERE spot = -1;
    SELECT INTO current_row p.* FROM app_public.event AS p WHERE p.id = $1;
  END IF;
  
  RETURN current_row;
END;
$_$;


ALTER FUNCTION app_public.move_event_down(uuid) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION move_event_down(uuid); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.move_event_down(uuid) IS 'Moves the event with specified id down one spot if not last child.';


--
-- Name: move_event_up(uuid); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.move_event_up(uuid) RETURNS app_public.event
    LANGUAGE plpgsql
    AS $_$
DECLARE
  current_row RECORD;
BEGIN
  SELECT INTO current_row p.*
  FROM app_public.event AS p
  WHERE p.id = $1;
  
  IF current_row.spot > 0 THEN
    UPDATE app_public.event SET spot = -1 WHERE id = $1;
    UPDATE app_public.event SET spot = spot + 1 WHERE spot = current_row.spot - 1 AND parent = current_row.parent;
    UPDATE app_public.event SET spot = current_row.spot - 1 WHERE spot = -1;
    SELECT INTO current_row p.* FROM app_public.event AS p WHERE p.id = $1;
  END IF;
  
  RETURN current_row;
END;
$_$;


ALTER FUNCTION app_public.move_event_up(uuid) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION move_event_up(uuid); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.move_event_up(uuid) IS 'Moves the event with specified id up one spot if not first child.';


--
-- Name: organization; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.organization (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    slug public.char_64 DEFAULT ''::text NOT NULL,
    link_label public.char_32 NOT NULL,
    link_description public.char_256 NOT NULL,
    title public.char_64 NOT NULL,
    content public.x_h_t_m_l,
    image uuid,
    spot integer DEFAULT 0 NOT NULL,
    parent uuid,
    account_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT page_check CHECK (((((slug)::text ~* '^[a-z]+(\-([a-z])+)*$'::text) AND (parent IS NOT NULL)) OR ((parent IS NULL) AND ((slug)::text = ''::text))))
);


ALTER TABLE app_public.organization OWNER TO cp_postgraphile;

--
-- Name: TABLE organization; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON TABLE app_public.organization IS 'An organization with XHTML content, etc.';


--
-- Name: COLUMN organization.id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.id IS 'The primary key for this organization.';


--
-- Name: COLUMN organization.slug; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.slug IS 'The unique-for-this-path, plain text, train-case "slug" used in the organization page URL.';


--
-- Name: COLUMN organization.link_label; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.link_label IS 'The plain text label used for links to this organization.';


--
-- Name: COLUMN organization.link_description; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.link_description IS 'A plain text description of this organization used in links and tables of content.';


--
-- Name: COLUMN organization.title; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.title IS 'The plain text title of the organization as seen in the tab and the page header.';


--
-- Name: COLUMN organization.content; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.content IS 'XHTML content about the organization.';


--
-- Name: COLUMN organization.image; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.image IS 'An Image associated with this organization (an icon, perhaps).';


--
-- Name: COLUMN organization.spot; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.spot IS 'The position of this organization among its siblings.';


--
-- Name: COLUMN organization.parent; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.parent IS 'The id of the parent organization to this organization.';


--
-- Name: COLUMN organization.account_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.account_id IS 'The id of the account holder that created this organization.';


--
-- Name: COLUMN organization.created_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.created_at IS 'The date and time this organization was created.';


--
-- Name: COLUMN organization.updated_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.updated_at IS 'The date and time this organization was last updated.';


--
-- Name: move_organization_down(uuid); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.move_organization_down(uuid) RETURNS app_public.organization
    LANGUAGE plpgsql
    AS $_$
DECLARE
  current_row RECORD;
  organization_count BIGINT;
BEGIN
  SELECT INTO current_row p.*
  FROM app_public.organization AS p
  WHERE p.id = $1;
  
  SELECT INTO organization_count COUNT(p.id)
  FROM app_public.organization AS p
  WHERE p.parent = current_row.parent;
  
  IF current_row.spot < organization_count - 1 THEN
    UPDATE app_public.organization SET spot = -1 WHERE id = $1;
    UPDATE app_public.organization SET spot = spot - 1 WHERE spot = current_row.spot + 1 AND parent = current_row.parent;
    UPDATE app_public.organization SET spot = current_row.spot + 1 WHERE spot = -1;
    SELECT INTO current_row p.* FROM app_public.organization AS p WHERE p.id = $1;
  END IF;
  
  RETURN current_row;
END;
$_$;


ALTER FUNCTION app_public.move_organization_down(uuid) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION move_organization_down(uuid); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.move_organization_down(uuid) IS 'Moves the organization with specified id down one spot if not last child.';


--
-- Name: move_organization_up(uuid); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.move_organization_up(uuid) RETURNS app_public.organization
    LANGUAGE plpgsql
    AS $_$
DECLARE
  current_row RECORD;
BEGIN
  SELECT INTO current_row p.*
  FROM app_public.organization AS p
  WHERE p.id = $1;
  
  IF current_row.spot > 0 THEN
    UPDATE app_public.organization SET spot = -1 WHERE id = $1;
    UPDATE app_public.organization SET spot = spot + 1 WHERE spot = current_row.spot - 1 AND parent = current_row.parent;
    UPDATE app_public.organization SET spot = current_row.spot - 1 WHERE spot = -1;
    SELECT INTO current_row p.* FROM app_public.organization AS p WHERE p.id = $1;
  END IF;
  
  RETURN current_row;
END;
$_$;


ALTER FUNCTION app_public.move_organization_up(uuid) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION move_organization_up(uuid); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.move_organization_up(uuid) IS 'Moves the organization with specified id up one spot if not first child.';


--
-- Name: venue; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.venue (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    slug public.char_64 DEFAULT ''::text NOT NULL,
    link_label public.char_32 NOT NULL,
    link_description public.char_256 NOT NULL,
    title public.char_64 NOT NULL,
    content public.x_h_t_m_l,
    image uuid,
    spot integer DEFAULT 0 NOT NULL,
    parent uuid,
    account_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT page_check CHECK (((((slug)::text ~* '^[a-z]+(\-([a-z])+)*$'::text) AND (parent IS NOT NULL)) OR ((parent IS NULL) AND ((slug)::text = ''::text))))
);


ALTER TABLE app_public.venue OWNER TO cp_postgraphile;

--
-- Name: TABLE venue; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON TABLE app_public.venue IS 'An venue with XHTML content, etc.';


--
-- Name: COLUMN venue.id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.id IS 'The primary key for this venue.';


--
-- Name: COLUMN venue.slug; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.slug IS 'The unique-for-this-path, plain text, train-case "slug" used in the venue page URL.';


--
-- Name: COLUMN venue.link_label; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.link_label IS 'The plain text label used for links to this venue.';


--
-- Name: COLUMN venue.link_description; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.link_description IS 'A plain text description of this venue used in links and tables of content.';


--
-- Name: COLUMN venue.title; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.title IS 'The plain text title of the venue as seen in the tab and the page header.';


--
-- Name: COLUMN venue.content; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.content IS 'XHTML content about the venue.';


--
-- Name: COLUMN venue.image; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.image IS 'An Image associated with this venue (an icon, perhaps).';


--
-- Name: COLUMN venue.spot; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.spot IS 'The position of this venue among its siblings.';


--
-- Name: COLUMN venue.parent; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.parent IS 'The id of the parent venue to this venue.';


--
-- Name: COLUMN venue.account_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.account_id IS 'The id of the account holder that created this venue.';


--
-- Name: COLUMN venue.created_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.created_at IS 'The date and time this venue was created.';


--
-- Name: COLUMN venue.updated_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.updated_at IS 'The date and time this venue was last updated.';


--
-- Name: move_venue_down(uuid); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.move_venue_down(uuid) RETURNS app_public.venue
    LANGUAGE plpgsql
    AS $_$
DECLARE
  current_row RECORD;
  venue_count BIGINT;
BEGIN
  SELECT INTO current_row p.*
  FROM app_public.venue AS p
  WHERE p.id = $1;
  
  SELECT INTO venue_count COUNT(p.id)
  FROM app_public.venue AS p
  WHERE p.parent = current_row.parent;
  
  IF current_row.spot < venue_count - 1 THEN
    UPDATE app_public.venue SET spot = -1 WHERE id = $1;
    UPDATE app_public.venue SET spot = spot - 1 WHERE spot = current_row.spot + 1 AND parent = current_row.parent;
    UPDATE app_public.venue SET spot = current_row.spot + 1 WHERE spot = -1;
    SELECT INTO current_row p.* FROM app_public.venue AS p WHERE p.id = $1;
  END IF;
  
  RETURN current_row;
END;
$_$;


ALTER FUNCTION app_public.move_venue_down(uuid) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION move_venue_down(uuid); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.move_venue_down(uuid) IS 'Moves the venue with specified id down one spot if not last child.';


--
-- Name: move_venue_up(uuid); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.move_venue_up(uuid) RETURNS app_public.venue
    LANGUAGE plpgsql
    AS $_$
DECLARE
  current_row RECORD;
BEGIN
  SELECT INTO current_row p.*
  FROM app_public.venue AS p
  WHERE p.id = $1;
  
  IF current_row.spot > 0 THEN
    UPDATE app_public.venue SET spot = -1 WHERE id = $1;
    UPDATE app_public.venue SET spot = spot + 1 WHERE spot = current_row.spot - 1 AND parent = current_row.parent;
    UPDATE app_public.venue SET spot = current_row.spot - 1 WHERE spot = -1;
    SELECT INTO current_row p.* FROM app_public.venue AS p WHERE p.id = $1;
  END IF;
  
  RETURN current_row;
END;
$_$;


ALTER FUNCTION app_public.move_venue_up(uuid) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION move_venue_up(uuid); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.move_venue_up(uuid) IS 'Moves the venue with specified id up one spot if not first child.';


--
-- Name: refresh_managed_page_materialized_view(); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.refresh_managed_page_materialized_view() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY app_public.managed_page;
  RETURN null;
END;
$$;


ALTER FUNCTION app_public.refresh_managed_page_materialized_view() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION refresh_managed_page_materialized_view(); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.refresh_managed_page_materialized_view() IS 'Automatically refreshes the managed_page view on inserts, updates, and deletions of page, zone, track, etc.';


--
-- Name: register_account(public.char_48, public.char_48, public.email, public.password); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password) RETURNS app_public.account
    LANGUAGE plpgsql STRICT SECURITY DEFINER
    AS $$
DECLARE
  account app_public.account;
BEGIN
  INSERT INTO app_public.account (given_name, family_name) VALUES (given_name, family_name) RETURNING * INTO account;

  INSERT INTO app_private.credential (account_id, email, password_hash) VALUES (
    account.id, email,crypt(password, gen_salt('bf'))
  );

  RETURN account;
END;
$$;


ALTER FUNCTION app_public.register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password) IS 'Registers a user account on the app.';


--
-- Name: remove_tag_from_event(uuid, text); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
  tag_id uuid;
BEGIN
  SELECT id FROM app_public.tag WHERE lower(body) = lower($2) INTO tag_id;
  
  DELETE FROM app_public.tag_event tp WHERE tp.tag_id = tag_id AND tp.event_id = $1;

  REFRESH MATERIALIZED VIEW app_public.managed_event;
  
  RETURN;
END;
$_$;


ALTER FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION remove_tag_from_event(event_row_id uuid, tag_body text); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) IS 'Deletes an edge between a event and a tag and refreshes the full_event view.';


--
-- Name: remove_tag_from_organization(uuid, text); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
  tag_id uuid;
BEGIN
  SELECT id FROM app_public.tag WHERE lower(body) = lower($2) INTO tag_id;
  
  DELETE FROM app_public.tag_organization tp WHERE tp.tag_id = tag_id AND tp.organization_id = $1;

  REFRESH MATERIALIZED VIEW app_public.managed_organization;
  
  RETURN;
END;
$_$;


ALTER FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION remove_tag_from_organization(organization_row_id uuid, tag_body text); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) IS 'Deletes an edge between a organization and a tag and refreshes the full_organization view.';


--
-- Name: remove_tag_from_venue(uuid, text); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
  tag_id uuid;
BEGIN
  SELECT id FROM app_public.tag WHERE lower(body) = lower($2) INTO tag_id;
  
  DELETE FROM app_public.tag_venue tp WHERE tp.tag_id = tag_id AND tp.venue_id = $1;

  REFRESH MATERIALIZED VIEW app_public.managed_venue;
  
  RETURN;
END;
$_$;


ALTER FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION remove_tag_from_venue(venue_row_id uuid, tag_body text); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) IS 'Deletes an edge between a venue and a tag and refreshes the full_venue view.';


--
-- Name: path_relationship; Type: VIEW; Schema: app_private; Owner: cp_postgraphile
--

CREATE VIEW app_private.path_relationship AS
 SELECT 'Event'::text AS type,
    event.id,
        CASE
            WHEN (event.parent IS NULL) THEN NULL::uuid
            ELSE event.parent
        END AS parent_id,
        CASE
            WHEN (event.parent IS NULL) THEN '/'::text
            ELSE concat('/', event.slug)
        END AS slug,
    event.link_label,
    event.link_description,
    event.spot
   FROM app_public.event
UNION
 SELECT 'Venue'::text AS type,
    venue.id,
    venue.parent AS parent_id,
    concat('/', venue.slug) AS slug,
    venue.link_label,
    venue.link_description,
    venue.spot
   FROM app_public.venue
  ORDER BY 1, 4;


ALTER TABLE app_private.path_relationship OWNER TO cp_postgraphile;

--
-- Name: VIEW path_relationship; Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON VIEW app_private.path_relationship IS 'Derives the parent-child edges for the event/venue (page) tree.';


--
-- Name: full_path; Type: VIEW; Schema: app_private; Owner: cp_postgraphile
--

CREATE VIEW app_private.full_path AS
 WITH RECURSIVE path_line AS (
         SELECT '/'::text AS full_path,
            path_relationship.type,
            path_relationship.id,
            path_relationship.parent_id,
            NULL::text AS parent_path,
            path_relationship.link_label,
            path_relationship.link_description,
            path_relationship.spot,
            0 AS depth
           FROM app_private.path_relationship
          WHERE (path_relationship.parent_id IS NULL)
        UNION ALL
         SELECT
                CASE
                    WHEN (pl.full_path = '/'::text) THEN pr.slug
                    ELSE concat(pl.full_path, pr.slug)
                END AS full_path,
            pr.type,
            pr.id,
            pr.parent_id,
            pl.full_path AS parent_path,
            pr.link_label,
            pr.link_description,
            pr.spot,
            (pl.depth + 1)
           FROM (app_private.path_relationship pr
             JOIN path_line pl ON ((pr.parent_id = pl.id)))
        )
 SELECT path_line.type,
    path_line.id,
    path_line.full_path,
    path_line.link_label,
    path_line.link_description,
    path_line.parent_path,
    path_line.spot,
    path_line.depth
   FROM path_line
  ORDER BY path_line.full_path;


ALTER TABLE app_private.full_path OWNER TO cp_postgraphile;

--
-- Name: VIEW full_path; Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON VIEW app_private.full_path IS 'Recurses through the page tree to derive the full URL path for each event, venue, etc.';


--
-- Name: event_tag; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.event_tag (
    tag_id uuid NOT NULL,
    event_id uuid NOT NULL
);


ALTER TABLE app_public.event_tag OWNER TO cp_postgraphile;

--
-- Name: COLUMN event_tag.tag_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event_tag.tag_id IS 'A tag assigned to this event.';


--
-- Name: COLUMN event_tag.event_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event_tag.event_id IS 'A event to which this tag is assigned.';


--
-- Name: image; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.image (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    url public.u_r_l NOT NULL,
    alt public.char_128,
    longdesc uuid,
    image_type app_public.image_media_type DEFAULT 'image/png'::app_public.image_media_type NOT NULL,
    account_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE app_public.image OWNER TO cp_postgraphile;

--
-- Name: TABLE image; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON TABLE app_public.image IS 'A site image uploaded by an account holder.';


--
-- Name: COLUMN image.id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.image.id IS 'The primary key for this image.';


--
-- Name: COLUMN image.url; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.image.url IS 'The URL at which this image may be found.';


--
-- Name: COLUMN image.alt; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.image.alt IS 'Alternative text for this image (for accessibility).';


--
-- Name: COLUMN image.image_type; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.image.image_type IS 'The media type for this image (e.g, image/png).';


--
-- Name: COLUMN image.account_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.image.account_id IS 'The id of the account that created this image.';


--
-- Name: COLUMN image.created_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.image.created_at IS 'The date and time this image was created.';


--
-- Name: COLUMN image.updated_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.image.updated_at IS 'The date and time this image was last updated.';


--
-- Name: tag; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.tag (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    body text NOT NULL,
    account_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT tag_body_check CHECK ((char_length(body) <= 32))
);


ALTER TABLE app_public.tag OWNER TO cp_postgraphile;

--
-- Name: TABLE tag; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON TABLE app_public.tag IS 'A tag created by an account holder.';


--
-- Name: COLUMN tag.id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.tag.id IS 'The primary key for this tag.';


--
-- Name: COLUMN tag.body; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.tag.body IS 'The textual content of this tag.';


--
-- Name: COLUMN tag.account_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.tag.account_id IS 'The id of the account that created this tag.';


--
-- Name: COLUMN tag.created_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.tag.created_at IS 'The date and time this tag was created.';


--
-- Name: COLUMN tag.updated_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.tag.updated_at IS 'The date and time this tag was last updated.';


--
-- Name: full_event; Type: VIEW; Schema: app_private; Owner: cp_postgraphile
--

CREATE VIEW app_private.full_event AS
 SELECT paths.full_path,
    event.id,
    event.slug,
    event.link_label,
    event.link_description,
    event.title,
    event.content,
    ( SELECT array_agg(tag.body) AS tags
           FROM ((app_public.event trk
             JOIN app_public.event_tag ttag ON ((trk.id = ttag.event_id)))
             JOIN app_public.tag tag ON ((ttag.tag_id = tag.id)))
          WHERE (ttag.event_id = event.id)) AS tags,
    image.url AS image_url,
    image.alt AS image_alt,
    event.spot,
    event.parent,
    paths.parent_path,
    ( SELECT array_agg(fpath.full_path) AS array_agg
           FROM ( SELECT full_path.full_path,
                    full_path.spot,
                    full_path.depth
                   FROM app_private.full_path
                  ORDER BY full_path.spot) fpath
          WHERE ((fpath.full_path ~~ (paths.full_path || '%'::text)) AND (fpath.depth = (paths.depth + 1)))) AS child_paths,
    paths.depth
   FROM ((app_private.full_path paths
     JOIN app_public.event event ON ((paths.id = event.id)))
     LEFT JOIN app_public.image image ON ((event.image = image.id)));


ALTER TABLE app_private.full_event OWNER TO cp_postgraphile;

--
-- Name: VIEW full_event; Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON VIEW app_private.full_event IS 'Provides a view of each event with the full URL path and an array of associated tags.';


--
-- Name: upsert_event_tag(uuid, text); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) RETURNS app_private.full_event
    LANGUAGE plpgsql
    AS $_$
DECLARE
  tag_id uuid;
  event app_private.full_event;
BEGIN
  SELECT app_private.upsert_tag($2) INTO tag_id;
  
  INSERT INTO app_public.tag_event AS p (event_id, tag_id) VALUES ($1, tag_id) ON CONFLICT DO NOTHING;
  
  SELECT * FROM app_private.full_event pwp WHERE pwp.id = $1 INTO event;

  REFRESH MATERIALIZED VIEW app_public.managed_event;
  
  RETURN event;
END;
$_$;


ALTER FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION upsert_event_tag(event_row_id uuid, tag_body text); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) IS 'Inserts a tag unless it already exists and links it to a specified event.';


--
-- Name: organization_tag; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.organization_tag (
    tag_id uuid NOT NULL,
    organization_id uuid NOT NULL
);


ALTER TABLE app_public.organization_tag OWNER TO cp_postgraphile;

--
-- Name: COLUMN organization_tag.tag_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization_tag.tag_id IS 'A tag assigned to this organization.';


--
-- Name: COLUMN organization_tag.organization_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization_tag.organization_id IS 'A organization to which this tag is assigned.';


--
-- Name: full_organization; Type: VIEW; Schema: app_private; Owner: cp_postgraphile
--

CREATE VIEW app_private.full_organization AS
 SELECT paths.full_path,
    organization.id,
    organization.slug,
    organization.link_label,
    organization.link_description,
    organization.title,
    organization.content,
    ( SELECT array_agg(tag.body) AS tags
           FROM ((app_public.organization trk
             JOIN app_public.organization_tag ttag ON ((trk.id = ttag.organization_id)))
             JOIN app_public.tag tag ON ((ttag.tag_id = tag.id)))
          WHERE (ttag.organization_id = organization.id)) AS tags,
    image.url AS image_url,
    image.alt AS image_alt,
    organization.spot,
    organization.parent,
    paths.parent_path,
    ( SELECT array_agg(fpath.full_path) AS array_agg
           FROM ( SELECT full_path.full_path,
                    full_path.spot,
                    full_path.depth
                   FROM app_private.full_path
                  ORDER BY full_path.spot) fpath
          WHERE ((fpath.full_path ~~ (paths.full_path || '%'::text)) AND (fpath.depth = (paths.depth + 1)))) AS child_paths,
    paths.depth
   FROM ((app_private.full_path paths
     JOIN app_public.organization organization ON ((paths.id = organization.id)))
     LEFT JOIN app_public.image image ON ((organization.image = image.id)));


ALTER TABLE app_private.full_organization OWNER TO cp_postgraphile;

--
-- Name: VIEW full_organization; Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON VIEW app_private.full_organization IS 'Provides a view of each organization with the full URL path and an array of associated tags.';


--
-- Name: upsert_organization_tag(uuid, text); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) RETURNS app_private.full_organization
    LANGUAGE plpgsql
    AS $_$
DECLARE
  tag_id uuid;
  organization app_private.full_organization;
BEGIN
  SELECT app_private.upsert_tag($2) INTO tag_id;
  
  INSERT INTO app_public.tag_organization AS p (organization_id, tag_id) VALUES ($1, tag_id) ON CONFLICT DO NOTHING;
  
  SELECT * FROM app_private.full_organization pwp WHERE pwp.id = $1 INTO organization;

  REFRESH MATERIALIZED VIEW app_public.managed_organization;
  
  RETURN organization;
END;
$_$;


ALTER FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION upsert_organization_tag(organization_row_id uuid, tag_body text); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) IS 'Inserts a tag unless it already exists and links it to a specified organization.';


--
-- Name: venue_tag; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.venue_tag (
    tag_id uuid NOT NULL,
    venue_id uuid NOT NULL
);


ALTER TABLE app_public.venue_tag OWNER TO cp_postgraphile;

--
-- Name: COLUMN venue_tag.tag_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue_tag.tag_id IS 'A tag assigned to this venue.';


--
-- Name: COLUMN venue_tag.venue_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue_tag.venue_id IS 'A venue to which this tag is assigned.';


--
-- Name: full_venue; Type: VIEW; Schema: app_private; Owner: cp_postgraphile
--

CREATE VIEW app_private.full_venue AS
 SELECT paths.full_path,
    venue.id,
    venue.slug,
    venue.link_label,
    venue.link_description,
    venue.title,
    venue.content,
    ( SELECT array_agg(tag.body) AS tags
           FROM ((app_public.venue trk
             JOIN app_public.venue_tag ttag ON ((trk.id = ttag.venue_id)))
             JOIN app_public.tag tag ON ((ttag.tag_id = tag.id)))
          WHERE (ttag.venue_id = venue.id)) AS tags,
    image.url AS image_url,
    image.alt AS image_alt,
    venue.spot,
    venue.parent,
    paths.parent_path,
    ( SELECT array_agg(fpath.full_path) AS array_agg
           FROM ( SELECT full_path.full_path,
                    full_path.spot,
                    full_path.depth
                   FROM app_private.full_path
                  ORDER BY full_path.spot) fpath
          WHERE ((fpath.full_path ~~ (paths.full_path || '%'::text)) AND (fpath.depth = (paths.depth + 1)))) AS child_paths,
    paths.depth
   FROM ((app_private.full_path paths
     JOIN app_public.venue venue ON ((paths.id = venue.id)))
     LEFT JOIN app_public.image image ON ((venue.image = image.id)));


ALTER TABLE app_private.full_venue OWNER TO cp_postgraphile;

--
-- Name: VIEW full_venue; Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON VIEW app_private.full_venue IS 'Provides a view of each venue with the full URL path and an array of associated tags.';


--
-- Name: upsert_venue_tag(uuid, text); Type: FUNCTION; Schema: app_public; Owner: cp_postgraphile
--

CREATE FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) RETURNS app_private.full_venue
    LANGUAGE plpgsql
    AS $_$
DECLARE
  tag_id uuid;
  venue app_private.full_venue;
BEGIN
  SELECT app_private.upsert_tag($2) INTO tag_id;
  
  INSERT INTO app_public.tag_venue AS p (venue_id, tag_id) VALUES ($1, tag_id) ON CONFLICT DO NOTHING;
  
  SELECT * FROM app_private.full_venue pwp WHERE pwp.id = $1 INTO venue;

  REFRESH MATERIALIZED VIEW app_public.managed_venue;
  
  RETURN venue;
END;
$_$;


ALTER FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION upsert_venue_tag(venue_row_id uuid, tag_body text); Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) IS 'Inserts a tag unless it already exists and links it to a specified venue.';


--
-- Name: muid_to_uuid(text); Type: FUNCTION; Schema: public; Owner: cp_postgraphile
--

CREATE FUNCTION public.muid_to_uuid(id text) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  select 
    (encode(substring(bin from 9 for 9), 'hex') || encode(substring(bin from 0 for 9), 'hex'))::uuid
  from decode(translate(id, '-_', '+/') || '==', 'base64') as bin;
$$;


ALTER FUNCTION public.muid_to_uuid(id text) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION muid_to_uuid(id text); Type: COMMENT; Schema: public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION public.muid_to_uuid(id text) IS 'Converts an MUID to a UUID.';


--
-- Name: uuid_to_muid(uuid); Type: FUNCTION; Schema: public; Owner: cp_postgraphile
--

CREATE FUNCTION public.uuid_to_muid(id uuid) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  select translate(
    encode(
      substring(decode(replace(id::text, '-', ''), 'hex') from 9 for 8) || 
      substring(decode(replace(id::text, '-', ''), 'hex') from 1 for 8), 
      'base64'
    ), 
    '+/=', '-_'
  );
$$;


ALTER FUNCTION public.uuid_to_muid(id uuid) OWNER TO cp_postgraphile;

--
-- Name: FUNCTION uuid_to_muid(id uuid); Type: COMMENT; Schema: public; Owner: cp_postgraphile
--

COMMENT ON FUNCTION public.uuid_to_muid(id uuid) IS 'Converts a UUID to an MUID.';


--
-- Name: credential; Type: TABLE; Schema: app_private; Owner: cp_postgraphile
--

CREATE TABLE app_private.credential (
    account_id uuid NOT NULL,
    email text NOT NULL,
    password_hash text NOT NULL,
    authorities app_private.authority[] DEFAULT ARRAY[]::app_private.authority[],
    CONSTRAINT credential_email_check CHECK ((email ~* '^.+@.+\..+$'::text))
);


ALTER TABLE app_private.credential OWNER TO cp_postgraphile;

--
-- Name: TABLE credential; Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON TABLE app_private.credential IS 'Private information about a user''s account.';


--
-- Name: COLUMN credential.account_id; Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_private.credential.account_id IS 'The id of the user associated with this account.';


--
-- Name: COLUMN credential.email; Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_private.credential.email IS 'The email address of the user.';


--
-- Name: COLUMN credential.password_hash; Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_private.credential.password_hash IS 'An opague hash of the user''s password.';


--
-- Name: tag_use_count; Type: VIEW; Schema: app_private; Owner: cp_postgraphile
--

CREATE VIEW app_private.tag_use_count AS
 SELECT tg.id,
    tg.body,
    tc.use_count
   FROM (app_public.tag tg
     LEFT JOIN ( SELECT count(t.id) AS use_count,
            t.tag_id
           FROM ( SELECT event_tag.event_id AS id,
                    event_tag.tag_id
                   FROM app_public.event_tag
                UNION ALL
                 SELECT venue_tag.venue_id AS id,
                    venue_tag.tag_id
                   FROM app_public.venue_tag
                UNION ALL
                 SELECT organization_tag.organization_id AS id,
                    organization_tag.tag_id
                   FROM app_public.organization_tag) t
          GROUP BY t.tag_id) tc ON ((tg.id = tc.tag_id)))
  ORDER BY tg.body;


ALTER TABLE app_private.tag_use_count OWNER TO cp_postgraphile;

--
-- Name: VIEW tag_use_count; Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON VIEW app_private.tag_use_count IS 'Returns a count of the total events, venues, etc. with which a tag is associated.';


--
-- Name: account_hypertext_link; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.account_hypertext_link (
    account_id uuid NOT NULL,
    hypertext_link_id uuid NOT NULL
);


ALTER TABLE app_public.account_hypertext_link OWNER TO cp_postgraphile;

--
-- Name: COLUMN account_hypertext_link.account_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.account_hypertext_link.account_id IS 'An account to which this hypertext link is assigned';


--
-- Name: COLUMN account_hypertext_link.hypertext_link_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.account_hypertext_link.hypertext_link_id IS 'A hypertext link assigned to this account';


--
-- Name: duration; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.duration (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    begins_at timestamp with time zone NOT NULL,
    ends_at timestamp with time zone NOT NULL,
    rrule public.rrule,
    event uuid,
    account_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE app_public.duration OWNER TO cp_postgraphile;

--
-- Name: TABLE duration; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON TABLE app_public.duration IS 'A site duration uploaded by an account holder.';


--
-- Name: COLUMN duration.id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.duration.id IS 'The primary key for this duration.';


--
-- Name: COLUMN duration.begins_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.duration.begins_at IS 'The date and time at which this duration begins.';


--
-- Name: COLUMN duration.ends_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.duration.ends_at IS 'The date and time at which this duration ends.';


--
-- Name: COLUMN duration.rrule; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.duration.rrule IS 'The icalendar rrule for recurrence of this duration.';


--
-- Name: COLUMN duration.account_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.duration.account_id IS 'The id of the account that created this duration.';


--
-- Name: COLUMN duration.created_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.duration.created_at IS 'The date and time this duration was created.';


--
-- Name: COLUMN duration.updated_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.duration.updated_at IS 'The date and time this duration was last updated.';


--
-- Name: event_hypertext_link; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.event_hypertext_link (
    hypertext_link_id uuid NOT NULL,
    event_id uuid NOT NULL
);


ALTER TABLE app_public.event_hypertext_link OWNER TO cp_postgraphile;

--
-- Name: COLUMN event_hypertext_link.hypertext_link_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event_hypertext_link.hypertext_link_id IS 'A hypertext link assigned to this event.';


--
-- Name: COLUMN event_hypertext_link.event_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event_hypertext_link.event_id IS 'A event to which this hypertext link is assigned.';


--
-- Name: event_type; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.event_type (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    name public.char_48 NOT NULL,
    account_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE app_public.event_type OWNER TO cp_postgraphile;

--
-- Name: TABLE event_type; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON TABLE app_public.event_type IS 'Set of event types e.g. ( workshop, conference... )';


--
-- Name: COLUMN event_type.id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event_type.id IS 'The primary key for this event type.';


--
-- Name: COLUMN event_type.name; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event_type.name IS 'The unique name for this event type.';


--
-- Name: COLUMN event_type.account_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event_type.account_id IS 'The id of the account that created this event type.';


--
-- Name: COLUMN event_type.created_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event_type.created_at IS 'The date and time this event type was created.';


--
-- Name: COLUMN event_type.updated_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event_type.updated_at IS 'The date and time this event type was last updated.';


--
-- Name: hypertext_link; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.hypertext_link (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    url public.u_r_l,
    name public.char_48,
    hypertext_link_type uuid NOT NULL,
    account_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE app_public.hypertext_link OWNER TO cp_postgraphile;

--
-- Name: TABLE hypertext_link; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON TABLE app_public.hypertext_link IS 'A hypertext link added by an account holder.';


--
-- Name: COLUMN hypertext_link.id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link.id IS 'The primary key for this hypertext link.';


--
-- Name: COLUMN hypertext_link.url; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link.url IS 'The URL associated with this hypertext link.';


--
-- Name: COLUMN hypertext_link.hypertext_link_type; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link.hypertext_link_type IS 'The id of the hypertext link type associated with this URL.';


--
-- Name: COLUMN hypertext_link.account_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link.account_id IS 'The id of the account that created this hypertext_link.';


--
-- Name: COLUMN hypertext_link.created_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link.created_at IS 'The date and time this hypertext link was created.';


--
-- Name: COLUMN hypertext_link.updated_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link.updated_at IS 'The date and time this hypertext link was last updated.';


--
-- Name: hypertext_link_type; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.hypertext_link_type (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    name public.char_48 NOT NULL,
    account_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE app_public.hypertext_link_type OWNER TO cp_postgraphile;

--
-- Name: TABLE hypertext_link_type; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON TABLE app_public.hypertext_link_type IS 'Categories for hypertext links used by events, venues, etc.';


--
-- Name: COLUMN hypertext_link_type.id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link_type.id IS 'The primary key for this hypertext link type.';


--
-- Name: COLUMN hypertext_link_type.name; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link_type.name IS 'The unique name for this hypertext link type.';


--
-- Name: COLUMN hypertext_link_type.account_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link_type.account_id IS 'The id of the account that created this hypertext link type.';


--
-- Name: COLUMN hypertext_link_type.created_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link_type.created_at IS 'The date and time this hypertext link type was created.';


--
-- Name: COLUMN hypertext_link_type.updated_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link_type.updated_at IS 'The date and time this hypertext link type was last updated.';


--
-- Name: longdesc; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.longdesc (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    slug public.char_64 DEFAULT ''::text NOT NULL,
    link_label public.char_32 NOT NULL,
    link_description public.char_256 NOT NULL,
    title public.char_64 NOT NULL,
    url public.u_r_l,
    content public.x_h_t_m_l,
    account_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE app_public.longdesc OWNER TO cp_postgraphile;

--
-- Name: TABLE longdesc; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON TABLE app_public.longdesc IS 'A image longdesc uploaded by an account holder.';


--
-- Name: COLUMN longdesc.id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.longdesc.id IS 'The primary key for this longdesc.';


--
-- Name: COLUMN longdesc.slug; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.longdesc.slug IS 'The unique-for-this-path, plain text, train-case "slug" used in the page URL.';


--
-- Name: COLUMN longdesc.link_label; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.longdesc.link_label IS 'The plain text label used for links to this longdesc.';


--
-- Name: COLUMN longdesc.link_description; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.longdesc.link_description IS 'A plain text description of this longdesc used in links and tables of content.';


--
-- Name: COLUMN longdesc.title; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.longdesc.title IS 'The plain text title of the longdesc page as seen in the tab and the page header.';


--
-- Name: COLUMN longdesc.url; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.longdesc.url IS 'The URL at which this longdesc may be found (if external).';


--
-- Name: COLUMN longdesc.content; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.longdesc.content IS 'XHTML content of the longdesc (if internal).';


--
-- Name: COLUMN longdesc.account_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.longdesc.account_id IS 'The id of the account that created this longdesc.';


--
-- Name: COLUMN longdesc.created_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.longdesc.created_at IS 'The date and time this longdesc was created.';


--
-- Name: COLUMN longdesc.updated_at; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.longdesc.updated_at IS 'The date and time this longdesc was last updated.';


--
-- Name: managed_page; Type: MATERIALIZED VIEW; Schema: app_public; Owner: cp_postgraphile
--

CREATE MATERIALIZED VIEW app_public.managed_page AS
 SELECT 'Event'::text AS type,
    full_event.full_path,
    full_event.id,
    full_event.slug,
    full_event.link_label,
    full_event.link_description,
    full_event.title,
    full_event.content,
    full_event.tags,
    full_event.image_url,
    full_event.image_alt,
    full_event.spot,
    full_event.parent,
    full_event.parent_path,
    full_event.child_paths,
    NULL::text[] AS sibling_paths,
    full_event.depth
   FROM app_private.full_event
UNION ALL
 SELECT 'Venue'::text AS type,
    full_venue.full_path,
    full_venue.id,
    full_venue.slug,
    full_venue.link_label,
    full_venue.link_description,
    full_venue.title,
    full_venue.content,
    full_venue.tags,
    full_venue.image_url,
    full_venue.image_alt,
    full_venue.spot,
    full_venue.parent,
    full_venue.parent_path,
    full_venue.child_paths,
    NULL::text[] AS sibling_paths,
    full_venue.depth
   FROM app_private.full_venue
UNION ALL
 SELECT 'Organization'::text AS type,
    full_organization.full_path,
    full_organization.id,
    full_organization.slug,
    full_organization.link_label,
    full_organization.link_description,
    full_organization.title,
    full_organization.content,
    full_organization.tags,
    full_organization.image_url,
    full_organization.image_alt,
    full_organization.spot,
    full_organization.parent,
    full_organization.parent_path,
    full_organization.child_paths,
    NULL::text[] AS sibling_paths,
    full_organization.depth
   FROM app_private.full_organization
  ORDER BY 1, 14, 12
  WITH NO DATA;


ALTER TABLE app_public.managed_page OWNER TO cp_postgraphile;

--
-- Name: MATERIALIZED VIEW managed_page; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON MATERIALIZED VIEW app_public.managed_page IS 'Provides a view into all generated site pages (events, venues, organizations, etc.).';


--
-- Name: organization_hypertext_link; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.organization_hypertext_link (
    hypertext_link_id uuid NOT NULL,
    organization_id uuid NOT NULL
);


ALTER TABLE app_public.organization_hypertext_link OWNER TO cp_postgraphile;

--
-- Name: COLUMN organization_hypertext_link.hypertext_link_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization_hypertext_link.hypertext_link_id IS 'A hypertext link assigned to this organization.';


--
-- Name: COLUMN organization_hypertext_link.organization_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization_hypertext_link.organization_id IS 'A organization to which this hypertext link is assigned.';


--
-- Name: venue_hypertext_link; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.venue_hypertext_link (
    hypertext_link_id uuid NOT NULL,
    venue_id uuid NOT NULL
);


ALTER TABLE app_public.venue_hypertext_link OWNER TO cp_postgraphile;

--
-- Name: COLUMN venue_hypertext_link.hypertext_link_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue_hypertext_link.hypertext_link_id IS 'A hypertext link assigned to this venue.';


--
-- Name: COLUMN venue_hypertext_link.venue_id; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue_hypertext_link.venue_id IS 'A venue to which this hypertext link is assigned.';


--
-- Data for Name: credential; Type: TABLE DATA; Schema: app_private; Owner: cp_postgraphile
--

INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('692504d6-ce6a-11e8-ac21-97703d4c9b95', 'bobdobbs@munat.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('401680d0-f1ea-11e8-a52e-7775e0e66497', 'pattyboy07@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('40be7c18-f1ea-11e8-a52e-53dd0db17b32', 'blahblahblah@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('4132dee6-f1ea-11e8-a52e-1ba36abdedda', 'brian2ho@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('419a989c-f1ea-11e8-a52e-7f502e4d49b5', 'edward.hong527@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', 'michaelvdlnz@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('43e9924c-f1ea-11e8-a52e-5b4666e062c5', 'steve@nasa.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('4aeb031e-f1ea-11e8-a52e-0ffab1819afb', 'Aristarkh4@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('4b5989e2-f1ea-11e8-a52e-c355e3f29b74', 'wanja.leuthold@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('4bb10faa-f1ea-11e8-a52e-0fe006889889', 'reuben.berghan@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('4c0fa1dc-f1ea-11e8-a52e-1b7fdbebca2b', 'prashant.nagrecha@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('4c6b6cc4-f1ea-11e8-a52e-7bcbc2c09924', 'ritikasrivastava1509@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('4cc64d60-f1ea-11e8-a52e-f345d295a629', 'confernceapp1@mailinator.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('4d2034b0-f1ea-11e8-a52e-432470351dbe', 'confernceapp2@mailinator.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('4d772298-f1ea-11e8-a52e-fff630074150', 'confernceapp3@mailinator.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('4dab5d2a-f1df-11e8-a52e-03eedefce6b1', 'nick.mangos@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('570b1170-f1ea-11e8-a52e-5f5854b371fc', 'qaz90930@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('576e650e-f1ea-11e8-a52e-9fe6a1114e42', 'bgag1111@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('57ce4cd0-f1ea-11e8-a52e-37bca9c608ee', 'funny@ulli.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('5826e4c6-f1ea-11e8-a52e-b70d0eab9f82', 'garricknorthover@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('588d5c24-f1ea-11e8-a52e-636f6acd5dc6', 'stan.roache@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', 'catherinepalmer@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('59377c7c-f1ea-11e8-a52e-3b42dc91b7ff', 'deliciousdisposable@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');
INSERT INTO app_private.credential (account_id, email, password_hash, authorities) VALUES ('5fb046b0-f1ea-11e8-a52e-c37fb0054913', 'richardgarciaph@gmail.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');


--
-- Data for Name: account; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--

INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('692504d6-ce6a-11e8-ac21-97703d4c9b95', 'Bob', 'Dobbs', NULL, NULL, '2018-10-13 11:01:46.059872+13', '2018-10-13 11:07:15.066393+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('401680d0-f1ea-11e8-a52e-7775e0e66497', 'Patrick', 'Ryan', 'Grand Wizard', 'I was born at a very young age and ever since then I''ve had a passion for all things code. ', '2018-12-09 14:52:25.928017+13', '2018-12-09 14:52:25.928017+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('40be7c18-f1ea-11e8-a52e-53dd0db17b32', 'Blah Blah', 'Blah', 'Junior Blah Dev at yeah nah', 'nothing very interesting, really.', '2018-12-09 14:52:47.096068+13', '2018-12-09 14:52:47.096068+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('4132dee6-f1ea-11e8-a52e-1ba36abdedda', 'Brian', 'Ho', 'CEO of Google LLC', 'Was a software developer in BNZ, then moved over to work as a Senior Developer in TradeMe. Then joined AirBnb as a Technical Manager. Eventually joined Google as a Technical Director and then got nominated to be the CEO', '2018-12-09 14:53:01.744667+13', '2018-12-09 14:53:01.744667+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('419a989c-f1ea-11e8-a52e-7f502e4d49b5', 'Edward', 'Hong', 'Life Liver', 'I''m a professional liver of life. I have 12 pet ferrets. In my spare time I like to make sculptures out of pistachio shells', '2018-12-09 14:53:36.035224+13', '2018-12-09 14:53:36.035224+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', 'Juliette Roberta', 'capulet', 'School of healing and natural therapies', 'Owner of a holistic clinic in NZ and worldwide holistic instructor that help people mentally,emotionally and physically.', '2018-12-09 14:54:26.338453+13', '2018-12-09 14:54:26.338453+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('43e9924c-f1ea-11e8-a52e-5b4666e062c5', 'Steve', 'Logs', 'Conspiracy theory creator', 'My job at NASA is to come up with conspiracy theories and release them into the public to create confusion about what NASA is really doing.', '2018-12-09 14:54:47.462232+13', '2018-12-09 14:54:47.462232+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('4aeb031e-f1ea-11e8-a52e-0ffab1819afb', 'Stephan', 'Streider', 'Data Science Researcher at Microsoft Research', 'After doing 5 years research at Victoria University of Wellington, Stephen moved to Redmond to join Microsoft Research team, looking into Natural Language Understanding.', '2018-12-09 14:55:06.554076+13', '2018-12-09 14:55:06.554076+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('4b5989e2-f1ea-11e8-a52e-c355e3f29b74', 'Jean-Luc', 'Picard', 'Captain of the USS Enterprise', 'Ever since he was a little boy, Jean-Luc Picard dreamed of exploring the stars as a member of starfleet. Despite a rocky start in the Starfleet Academy he graduated a high achiever an went on to have a successful career in Starfleet. His love for archeology and devotion to exploring the far reaches of space have given him insight into worlds others would never even dream of. ', '2018-12-09 14:55:25.777765+13', '2018-12-09 14:55:25.777765+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('4bb10faa-f1ea-11e8-a52e-0fe006889889', 'Reuben', 'Berghan', 'Software Developer at Ambiguous Widget Inc', 'Reuben lives to solve problems. With a passion for all things web and a focus in JavaScript he works to make lives easier users and developers alike.', '2018-12-09 14:55:41.367237+13', '2018-12-09 14:55:41.367237+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('4c0fa1dc-f1ea-11e8-a52e-1b7fdbebca2b', 'Prashant', NULL, 'Sr. Developer', 'Full Stack developer', '2018-12-09 14:56:33.281801+13', '2018-12-09 14:56:33.281801+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('4c6b6cc4-f1ea-11e8-a52e-7bcbc2c09924', 'Ritz', NULL, 'Software Developer', 'I am a Software Developer as well as a researcher', '2018-12-09 14:57:18.451914+13', '2018-12-09 14:57:18.451914+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('4cc64d60-f1ea-11e8-a52e-f345d295a629', 'Tony', NULL, 'Technical Researcher', 'A strong knowledge about writing conference journal Research Papers ', '2018-12-09 14:57:38.432149+13', '2018-12-09 14:57:38.432149+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('4d2034b0-f1ea-11e8-a52e-432470351dbe', 'Romil', NULL, 'Tech Lead', 'Working with Facebook', '2018-12-09 14:58:07.771199+13', '2018-12-09 14:58:07.771199+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('4d772298-f1ea-11e8-a52e-fff630074150', 'Zain', 'Khan', 'Sr.Analyst Programmer', 'working with BNZ', '2018-12-09 14:58:36.44697+13', '2018-12-09 14:58:36.44697+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('4dab5d2a-f1df-11e8-a52e-03eedefce6b1', 'Guy', 'Incognito', 'International Traveller - Self Employed', 'Greetings, good man.Guy Incognito is a man who, except for having a mustache, slightly lighter-colored muzzle and an unusual accent, looks and sounds exactly like Homer.The resemblance to Homer has proven to be very unfortunate for Guy, as it has gotten him into trouble on at least one occasion.Where Guy lives is unknown, though his appearance and manner of speaking suggest he is an English foreigner.', '2018-12-09 14:58:53.015969+13', '2018-12-09 14:58:53.015969+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('570b1170-f1ea-11e8-a52e-5f5854b371fc', 'Hank', 'Chou', 'Software Developer', 'I come from Taiwan, I have been in New Zealand 7 months. I was a mechincal engineer', '2018-12-09 14:59:04.939954+13', '2018-12-09 14:59:04.939954+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('576e650e-f1ea-11e8-a52e-9fe6a1114e42', 'Brian', 'Gill', 'Tech evangelist for E Corp', 'For the past 10 years, I''ve worked as the chief technology evangelist at E Corp.  ', '2018-12-09 14:59:28.353087+13', '2018-12-09 14:59:28.353087+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('57ce4cd0-f1ea-11e8-a52e-37bca9c608ee', 'Ulli Kazimir Colt', 'Bodnar', 'The Anti-Sparkle', 'When not being an asshat, Ulli can be found being a coding wizard and stuff. ', '2018-12-09 14:59:55.235335+13', '2018-12-09 14:59:55.235335+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('5826e4c6-f1ea-11e8-a52e-b70d0eab9f82', 'Vladimir', 'Bigglesworth', 'Snack Procurement', 'Vladimir Bigglesworth was on a quest to walk the earth in search of the perfect taco. After being successful in this venture, Vladimir became despondent having reached the peak of his ambition and entered the dark years.This is the comeback tour!Mr Bigglesworth has found his North Star,... snacks!Watch as Mr Bigglesworth outlines his travels and enquiry into snacks, on where they come from, and where they might be now. Behold as he uses interrogation on audience members with pleas, blackmail and hypnoses. ', '2018-12-09 15:00:12.183013+13', '2018-12-09 15:00:12.183013+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('588d5c24-f1ea-11e8-a52e-636f6acd5dc6', 'James', 'Hopper', 'Data Flow Consultant, FD Ltd', 'James worked Facebook for 5 years contributing to dataloader, an opensource utility for caching and batching requests through API layers. He has an interest in finding bottlenecks in APIs and opportunities for high impact caching.', '2018-12-09 15:00:23.557456+13', '2018-12-09 15:00:23.557456+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', 'Cate', 'Palmer', 'CEO, Google', 'Cate rose up the ranks in Google seemingly overnight despite not having a tech background!!! She really likes cocoa, tabasco sauce, and George Michael.', '2018-12-09 15:00:39.94362+13', '2018-12-09 15:00:39.94362+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('59377c7c-f1ea-11e8-a52e-3b42dc91b7ff', 'Bevy', 'Swann', 'VP Product, Swann Networks', 'Over 100 years of programming experience, can reach a length of over 1.5 m (59 in) and weigh over 15 kg (33 lb). My wingspan is over 3.1 m (10 ft). Compared to the closely related geese, I am much larger and have a proportionally larger neck.', '2018-12-09 15:00:57.183091+13', '2018-12-09 15:00:57.183091+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('598d5444-f1ea-11e8-a52e-63361829519d', 'Diego de la', 'Vega', 'Nobleman Vigilante', 'Masked agile methodology expert from San Diago. Beloved by the people, feared by my enemigoes.', '2018-12-09 15:01:28.296304+13', '2018-12-09 15:01:28.296304+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('5fb046b0-f1ea-11e8-a52e-c37fb0054913', 'Richard', 'Garcia', 'Software Developer', 'I am Software developer and I want to practice my passion for creating people-oriented solutions that make life easier for users and continue to solidify the craft of software development .', '2018-12-09 15:02:18.446241+13', '2018-12-09 15:02:18.446241+13');
INSERT INTO app_public.account (id, given_name, family_name, job_title, bio, created_at, updated_at) VALUES ('5ff76126-f1ea-11e8-a52e-4334282117e5', 'Berger', 'MacDonald', 'Writer/ Wizard / Mall santa / smarties expert', 'Writer recognise of most popular book:-How to be funny;-Save a writer buy a book;-Rewrite your life;Chalenges are what make life interesting and overcoming them is what make life meaningful.', '2018-12-09 15:02:32.720715+13', '2018-12-09 15:02:32.720715+13');


--
-- Data for Name: account_hypertext_link; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: duration; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--

INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91cd5d4a-011c-11e9-8a12-8fc33c4c3950', '2019-07-16 08:00:00+12', '2019-07-16 17:00:00+12', NULL, '32b63cb4-0112-11e9-babd-d7a3c9d9a91a', '401680d0-f1ea-11e8-a52e-7775e0e66497', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.038489+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d47b16-011c-11e9-8a12-8f92bc665b21', '2019-07-16 08:00:00+12', '2019-07-16 08:15:00+12', NULL, '40053af0-0112-11e9-babd-6fe405d7282c', '40be7c18-f1ea-11e8-a52e-53dd0db17b32', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.056961+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4814c-011c-11e9-8a12-634fc44232af', '2019-07-16 08:00:00+12', '2019-07-16 08:30:00+12', NULL, '99f35776-0113-11e9-babd-072bd87e98ae', '4132dee6-f1ea-11e8-a52e-1ba36abdedda', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.071203+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d48692-011c-11e9-8a12-53d8a6c74c04', '2019-07-16 08:00:00+12', '2019-07-16 09:00:00+12', NULL, 'c1dbdca4-0113-11e9-babd-b31407da757a', '419a989c-f1ea-11e8-a52e-7f502e4d49b5', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.089563+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d48ade-011c-11e9-8a12-0b49dac4d0ac', '2019-07-16 08:00:00+12', '2019-07-16 17:00:00+12', NULL, 'f3730fb2-0113-11e9-babd-7b28137bd62d', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.107937+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d48f16-011c-11e9-8a12-4fdb3729bc0b', '2019-07-16 08:00:00+12', '2019-07-16 08:30:00+12', NULL, '043a4180-0114-11e9-babd-332d64b13024', '43e9924c-f1ea-11e8-a52e-5b4666e062c5', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.130713+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d49236-011c-11e9-8a12-db5dd1c73b7f', '2019-07-16 08:00:00+12', '2019-07-16 09:00:00+12', NULL, '6716cd2a-0112-11e9-babd-cbe8651cf2a1', '4aeb031e-f1ea-11e8-a52e-0ffab1819afb', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.151893+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d49646-011c-11e9-8a12-3b3e139ef403', '2019-07-16 08:00:00+12', '2019-07-16 08:30:00+12', NULL, 'b2710fb0-0112-11e9-babd-83c4e5c819d9', '4b5989e2-f1ea-11e8-a52e-c355e3f29b74', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.166992+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d49b1e-011c-11e9-8a12-5737c412fc17', '2019-07-16 08:00:00+12', '2019-07-16 08:30:00+12', NULL, 'c6103e92-0112-11e9-babd-73e0d62d51db', '4bb10faa-f1ea-11e8-a52e-0fe006889889', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.181387+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d49f74-011c-11e9-8a12-c36b5d3df9d7', '2019-07-16 08:00:00+12', '2019-07-16 09:00:00+12', NULL, 'f59b9bb6-0112-11e9-babd-8f1b199552a2', '4c0fa1dc-f1ea-11e8-a52e-1b7fdbebca2b', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.196599+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4a38e-011c-11e9-8a12-93c5ff74ba3a', '2019-07-16 08:00:00+12', '2019-07-16 08:15:00+12', NULL, '04ed717a-0113-11e9-babd-cfb428ba4028', '4c6b6cc4-f1ea-11e8-a52e-7bcbc2c09924', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.211286+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4a7d0-011c-11e9-8a12-17c50a693550', '2019-07-16 08:00:00+12', '2019-07-16 08:30:00+12', NULL, '10a7559e-0113-11e9-babd-1b1985d577ef', '4cc64d60-f1ea-11e8-a52e-f345d295a629', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.227391+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4ac1c-011c-11e9-8a12-8f793be050d0', '2019-07-16 08:00:00+12', '2019-07-16 08:30:00+12', NULL, '1a893118-0113-11e9-babd-e7f9560466e7', '4d2034b0-f1ea-11e8-a52e-432470351dbe', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.243446+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4b018-011c-11e9-8a12-3fae1d6eeeb5', '2019-07-16 08:00:00+12', '2019-07-16 09:00:00+12', NULL, '28c69b62-0113-11e9-babd-4b4b0d2eac6e', '4d772298-f1ea-11e8-a52e-fff630074150', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.260079+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4b4be-011c-11e9-8a12-7b73b7b2a71a', '2019-07-16 08:00:00+12', '2019-07-16 08:15:00+12', NULL, '4277b82a-0113-11e9-babd-837e24722533', '4dab5d2a-f1df-11e8-a52e-03eedefce6b1', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.27359+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4b7d4-011c-11e9-8a12-8358aa66f6e8', '2019-07-16 08:00:00+12', '2019-07-16 08:30:00+12', NULL, '63251fc2-0113-11e9-babd-0bc6060cb02b', '570b1170-f1ea-11e8-a52e-5f5854b371fc', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.285893+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4bb6c-011c-11e9-8a12-bb388cc7bbb3', '2019-07-16 08:00:00+12', '2019-07-16 10:00:00+12', NULL, '59933df8-0114-11e9-babd-b3151e33d2d3', '576e650e-f1ea-11e8-a52e-9fe6a1114e42', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.300762+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4be0a-011c-11e9-8a12-976ccdddc5dc', '2019-07-16 08:00:00+12', '2019-07-16 09:30:00+12', NULL, '6e837eda-0114-11e9-babd-eb456483de88', '57ce4cd0-f1ea-11e8-a52e-37bca9c608ee', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.315322+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4c08a-011c-11e9-8a12-7758c14234d0', '2019-07-16 08:00:00+12', '2019-07-16 17:00:00+12', NULL, '8f9620c8-0114-11e9-babd-b391da05d0cd', '5826e4c6-f1ea-11e8-a52e-b70d0eab9f82', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.329289+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4c3f0-011c-11e9-8a12-f3dc67375652', '2019-07-16 08:00:00+12', '2019-07-16 09:30:00+12', NULL, 'b7363af0-0114-11e9-babd-bff660dcf41d', '588d5c24-f1ea-11e8-a52e-636f6acd5dc6', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.34308+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4c684-011c-11e9-8a12-5f8831ba00db', '2019-07-16 08:00:00+12', '2019-07-16 09:00:00+12', NULL, 'e31ce9ca-0114-11e9-babd-3ffce5ea955b', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.357972+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4c904-011c-11e9-8a12-47cd64155506', '2019-07-16 08:00:00+12', '2019-07-16 08:30:00+12', NULL, 'edf26456-0114-11e9-babd-dff448974502', '59377c7c-f1ea-11e8-a52e-3b42dc91b7ff', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.370259+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4cc4c-011c-11e9-8a12-03a404a8afe1', '2019-07-16 08:00:00+12', '2019-07-16 08:30:00+12', NULL, 'fa060978-0114-11e9-babd-3fa6925dbde4', '598d5444-f1ea-11e8-a52e-63361829519d', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.393162+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4cf76-011c-11e9-8a12-9387226e92c5', '2019-07-16 08:00:00+12', '2019-07-16 09:30:00+12', NULL, '0746ef58-0115-11e9-babd-6739903b21d4', '5fb046b0-f1ea-11e8-a52e-c37fb0054913', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.406366+13');
INSERT INTO app_public.duration (id, begins_at, ends_at, rrule, event, account_id, created_at, updated_at) VALUES ('91d4d2b4-011c-11e9-8a12-c7bd6f0337da', '2019-07-16 08:00:00+12', '2019-07-16 08:15:00+12', NULL, '10dd6736-0115-11e9-babd-3323e6a3379b', '5ff76126-f1ea-11e8-a52e-4334282117e5', '2018-12-16 23:23:02.702297+13', '2018-12-16 23:30:55.460926+13');


--
-- Data for Name: event; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--

INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'test-event', 'Test Event', 'This is the Test Event', 'A Test Event', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 0, NULL, 'e5346688-f922-11e8-9e0c-171f3d9c359e', '692504d6-ce6a-11e8-ac21-97703d4c9b95', '2018-10-27 17:25:03.870431+13', '2018-12-16 22:52:25.008044+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('40053af0-0112-11e9-babd-6fe405d7282c', 'test-event-b', 'Test Event', 'This is the Test Event', 'dont know yet ', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 1, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', '0b5912da-01ae-11e9-ad7b-2731cd494b6f', '40be7c18-f1ea-11e8-a52e-53dd0db17b32', '2018-12-16 22:09:10.662594+13', '2018-12-17 17:00:47.999274+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('043a4180-0114-11e9-babd-332d64b13024', 'test-event-f', 'Test Event', 'This is the Test Event', 'conspiracy theories and you', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 15, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '43e9924c-f1ea-11e8-a52e-5b4666e062c5', '2018-12-16 22:21:49.340734+13', '2018-12-17 17:00:48.064722+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('6716cd2a-0112-11e9-babd-cbe8651cf2a1', 'test-event-g', 'Test Event', 'This is the Test Event', 'Natural Language Understanding for Analysing Judicial Cases', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 2, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '4aeb031e-f1ea-11e8-a52e-0ffab1819afb', '2018-12-16 22:10:16.209362+13', '2018-12-17 17:00:48.087123+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('b2710fb0-0112-11e9-babd-83c4e5c819d9', 'test-event-h', 'Test Event', 'This is the Test Event', 'In his talk Captain Picard will share some of his experiences', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 3, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '4b5989e2-f1ea-11e8-a52e-c355e3f29b74', '2018-12-16 22:12:22.630167+13', '2018-12-17 17:00:48.108601+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('c6103e92-0112-11e9-babd-73e0d62d51db', 'test-event-i', 'Test Event', 'This is the Test Event', 'Functional Programming', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 4, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '4bb10faa-f1ea-11e8-a52e-0fe006889889', '2018-12-16 22:12:55.549907+13', '2018-12-17 17:00:48.124526+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('f59b9bb6-0112-11e9-babd-8f1b199552a2', 'test-event-j', 'Test Event', 'This is the Test Event', 'Machine Learning with Bots', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 5, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', '0b5912da-01ae-11e9-ad7b-2731cd494b6f', '4c0fa1dc-f1ea-11e8-a52e-1b7fdbebca2b', '2018-12-16 22:14:15.316229+13', '2018-12-17 17:00:48.139072+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('04ed717a-0113-11e9-babd-cfb428ba4028', 'test-event-k', 'Test Event', 'This is the Test Event', 'Docker', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 6, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', '0b5912da-01ae-11e9-ad7b-2731cd494b6f', '4c6b6cc4-f1ea-11e8-a52e-7bcbc2c09924', '2018-12-16 22:14:41.010509+13', '2018-12-17 17:00:48.157136+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('10a7559e-0113-11e9-babd-1b1985d577ef', 'test-event-l', 'Test Event', 'This is the Test Event', 'Antenna Theory', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 7, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '4cc64d60-f1ea-11e8-a52e-f345d295a629', '2018-12-16 22:15:00.691291+13', '2018-12-17 17:00:48.17194+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('1a893118-0113-11e9-babd-e7f9560466e7', 'test-event-m', 'Test Event', 'This is the Test Event', 'CI/CD and Linq', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 8, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', '0b5912da-01ae-11e9-ad7b-2731cd494b6f', '4d2034b0-f1ea-11e8-a52e-432470351dbe', '2018-12-16 22:15:17.271042+13', '2018-12-17 17:00:48.187285+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('28c69b62-0113-11e9-babd-4b4b0d2eac6e', 'test-event-n', 'Test Event', 'This is the Test Event', 'JavaScript', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 9, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', '0b5912da-01ae-11e9-ad7b-2731cd494b6f', '4d772298-f1ea-11e8-a52e-fff630074150', '2018-12-16 22:15:41.16+13', '2018-12-17 17:00:48.202093+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('4277b82a-0113-11e9-babd-837e24722533', 'test-event-o', 'Test Event', 'This is the Test Event', 'Immutable data structures for functional JavaScript.', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 10, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '4dab5d2a-f1df-11e8-a52e-03eedefce6b1', '2018-12-16 22:16:24.265127+13', '2018-12-17 17:00:48.216364+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('63251fc2-0113-11e9-babd-0bc6060cb02b', 'test-event-p', 'Test Event', 'This is the Test Event', 'Lecturer, talking about human history', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 11, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', '0b5912da-01ae-11e9-ad7b-2731cd494b6f', '570b1170-f1ea-11e8-a52e-5f5854b371fc', '2018-12-16 22:17:19.089109+13', '2018-12-17 17:00:48.230989+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('59933df8-0114-11e9-babd-b3151e33d2d3', 'test-event-q', 'Test Event', 'This is the Test Event', 'This afternoon, I''ll be talking about technological futurology', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 16, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '576e650e-f1ea-11e8-a52e-9fe6a1114e42', '2018-12-16 22:24:12.529989+13', '2018-12-17 17:00:48.245135+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('6e837eda-0114-11e9-babd-eb456483de88', 'test-event-r', 'Test Event', 'This is the Test Event', 'Comedy Coding', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 17, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '57ce4cd0-f1ea-11e8-a52e-37bca9c608ee', '2018-12-16 22:24:47.65877+13', '2018-12-17 17:00:48.259426+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('8f9620c8-0114-11e9-babd-b391da05d0cd', 'test-event-s', 'Test Event', 'This is the Test Event', 'On snacks, what they are and where they come from', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 18, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '5826e4c6-f1ea-11e8-a52e-b70d0eab9f82', '2018-12-16 22:25:43.145167+13', '2018-12-17 17:00:48.272385+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('b7363af0-0114-11e9-babd-bff660dcf41d', 'test-event-t', 'Test Event', 'This is the Test Event', 'Data Flow Optimisation', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 19, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', '0b5912da-01ae-11e9-ad7b-2731cd494b6f', '588d5c24-f1ea-11e8-a52e-636f6acd5dc6', '2018-12-16 22:26:49.626563+13', '2018-12-17 17:00:48.287943+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('e31ce9ca-0114-11e9-babd-3ffce5ea955b', 'test-event-u', 'Test Event', 'This is the Test Event', 'How to schmooze at tech conferences', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 20, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-16 22:28:03.279975+13', '2018-12-17 17:00:48.302311+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('edf26456-0114-11e9-babd-dff448974502', 'test-event-v', 'Test Event', 'This is the Test Event', 'Effects of javascript on waterfowl', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 21, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '59377c7c-f1ea-11e8-a52e-3b42dc91b7ff', '2018-12-16 22:28:21.456403+13', '2018-12-17 17:00:48.318796+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('fa060978-0114-11e9-babd-3fa6925dbde4', 'test-event-w', 'Test Event', 'This is the Test Event', 'Agile methodology - from A to Z', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 22, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '598d5444-f1ea-11e8-a52e-63361829519d', '2018-12-16 22:28:41.71795+13', '2018-12-17 17:00:48.333444+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('0746ef58-0115-11e9-babd-6739903b21d4', 'test-event-x', 'Test Event', 'This is the Test Event', 'ReactJS + Storybook + Atomic Design Methodology Workshop', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 23, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', '0b5912da-01ae-11e9-ad7b-2731cd494b6f', '5fb046b0-f1ea-11e8-a52e-c37fb0054913', '2018-12-16 22:29:03.95365+13', '2018-12-17 17:00:48.347809+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('10dd6736-0115-11e9-babd-3323e6a3379b', 'test-event-y', 'Test Event', 'This is the Test Event', 'I will be talking about "how to get the 8 figure in no time"', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 24, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '5ff76126-f1ea-11e8-a52e-4334282117e5', '2018-12-16 22:29:20.039054+13', '2018-12-17 17:00:48.362607+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('32b63cb4-0112-11e9-babd-d7a3c9d9a91a', 'test-event-a', 'Test Event', 'This is the Test Event', 'Categorising butterflies', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 0, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '401680d0-f1ea-11e8-a52e-7775e0e66497', '2018-12-16 22:08:48.282176+13', '2018-12-17 17:00:47.936092+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('99f35776-0113-11e9-babd-072bd87e98ae', 'test-event-c', 'Test Event', 'This is the Test Event', 'Google''s mobile market strategy', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 12, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '4132dee6-f1ea-11e8-a52e-1ba36abdedda', '2018-12-16 22:18:51.037039+13', '2018-12-17 17:00:48.013991+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('c1dbdca4-0113-11e9-babd-b31407da757a', 'test-event-d', 'Test Event', 'This is the Test Event', 'Creating sculptures with pistachio shells', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 13, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', 'fc85d69e-01ad-11e9-ad7b-5f485920c7c4', '419a989c-f1ea-11e8-a52e-7f502e4d49b5', '2018-12-16 22:19:57.992463+13', '2018-12-17 17:00:48.030186+13');
INSERT INTO app_public.event (id, slug, link_label, link_description, title, content, image, spot, parent, event_type, account_id, created_at, updated_at) VALUES ('f3730fb2-0113-11e9-babd-7b28137bd62d', 'test-event-e', 'Test Event', 'This is the Test Event', '9am registration 10am meditation', '<p>This is a very <b>Testy</b> Event.</p>', NULL, 14, '46afe664-d9a0-11e8-bbdb-f754d1b177a2', '0b5912da-01ae-11e9-ad7b-2731cd494b6f', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-16 22:21:21.191945+13', '2018-12-17 17:00:48.05031+13');


--
-- Data for Name: event_hypertext_link; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: event_tag; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: event_type; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--

INSERT INTO app_public.event_type (id, name, account_id, created_at, updated_at) VALUES ('e5346688-f922-11e8-9e0c-171f3d9c359e', 'event-type', NULL, '2018-12-09 14:06:28.862825+13', '2018-12-09 14:06:28.862825+13');
INSERT INTO app_public.event_type (id, name, account_id, created_at, updated_at) VALUES ('fc85d69e-01ad-11e9-ad7b-5f485920c7c4', 'A lecture / talk', NULL, '2018-12-17 16:43:58.847721+13', '2018-12-17 16:43:58.847721+13');
INSERT INTO app_public.event_type (id, name, account_id, created_at, updated_at) VALUES ('0b5912da-01ae-11e9-ad7b-2731cd494b6f', 'Workshop (interactive)', NULL, '2018-12-17 16:44:23.783187+13', '2018-12-17 16:44:23.783187+13');


--
-- Data for Name: hypertext_link; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--

INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e406f5d4-00f5-11e9-8925-8b0952e292ff', 'www.facebook.com', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '401680d0-f1ea-11e8-a52e-7775e0e66497', '2018-12-16 18:46:10.281146+13', '2018-12-16 18:50:38.557754+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e407dd78-00f5-11e9-8925-83dabf34b9af', 'https://twitter.com/fakelink?lang=en', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '4132dee6-f1ea-11e8-a52e-1ba36abdedda', '2018-12-16 18:46:10.281146+13', '2018-12-16 18:52:07.220303+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e407eb10-00f5-11e9-8925-e7bf78ab5a80', 'www.instagram.com', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.397938+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e407fbc8-00f5-11e9-8925-f772eff8ba6a', 'www.facebook.com', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.460599+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4081266-00f5-11e9-8925-43613bc4874a', 'www.youtube.com', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.475403+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4081e6e-00f5-11e9-8925-87cc3e079caa', 'nasa.gov', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '43e9924c-f1ea-11e8-a52e-5b4666e062c5', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.489057+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4082954-00f5-11e9-8925-83c5a34fd2e7', 'https://twitter.com/CaptJeanLPicard', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '4b5989e2-f1ea-11e8-a52e-c355e3f29b74', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.50236+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4083bc4-00f5-11e9-8925-f3bfcd266d1f', 'https://github.com/reubenberghan,', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '4bb10faa-f1ea-11e8-a52e-0fe006889889', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.515594+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e40844de-00f5-11e9-8925-4b40a4ed9758', 'https://twitter.com/ReubenBerghan,', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '4bb10faa-f1ea-11e8-a52e-0fe006889889', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.528563+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4084f6a-00f5-11e9-8925-1f7d516d9905', 'https://www.linkedin.com/in/reubenberghan', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '4bb10faa-f1ea-11e8-a52e-0fe006889889', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.541771+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4085708-00f5-11e9-8925-1bd0b95afe12', 'www.linkedin.com/prashant', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '4c0fa1dc-f1ea-11e8-a52e-1b7fdbebca2b', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.554183+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4085cda-00f5-11e9-8925-df579b91b1ba', 'www.facebook.com/prashant', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '4c0fa1dc-f1ea-11e8-a52e-1b7fdbebca2b', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.568064+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e408627a-00f5-11e9-8925-2be66cc06dfb', 'http://simpsons.wikia.com/wiki/Guy_Incognito', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '4dab5d2a-f1df-11e8-a52e-03eedefce6b1', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.58055+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4086734-00f5-11e9-8925-abeadca9c7f8', 'instagram.com/ullibodnar', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '57ce4cd0-f1ea-11e8-a52e-37bca9c608ee', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.594075+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4087058-00f5-11e9-8925-a388f9112053', 'www.twitter.com/wherearethey', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '5826e4c6-f1ea-11e8-a52e-b70d0eab9f82', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.607498+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e40875b2-00f5-11e9-8925-23c1d25ef205', 'https://github.com/jhopper', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '588d5c24-f1ea-11e8-a52e-636f6acd5dc6', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.665097+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4087ad0-00f5-11e9-8925-bbe3eede6d3a', 'https://www.linkedin.com/in/james-hopper-91228011/', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '588d5c24-f1ea-11e8-a52e-636f6acd5dc6', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.678034+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4087fd0-00f5-11e9-8925-97dbdb06e46b', 'https://twitter.com/big_ben_clock,', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.692072+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4088390-00f5-11e9-8925-c3cdd9f6ee14', 'https://www.facebook.com/catejpalmer,', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.703422+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4088750-00f5-11e9-8925-f3800486e896', 'https://www.linkedin.com/in/cate-palmer-60617715a/,', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.717108+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4088b7e-00f5-11e9-8925-6770f02b9c8c', 'https://github.com/catepalmer),', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.730243+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4088fb6-00f5-11e9-8925-f7799a678b74', 'https://www.youtube.com/watch?v=74ceC7ERsLc,', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.744864+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e40893ee-00f5-11e9-8925-631768113989', 'https://www.instagram.com/palmer.cate/', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.759122+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e40897ae-00f5-11e9-8925-6375ef2874db', 'https://en.wikipedia.org/wiki/Dennis_Ritchie', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '5fb046b0-f1ea-11e8-a52e-c37fb0054913', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.770495+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4089b8c-00f5-11e9-8925-631c526d0470', 'www.facebook.com/OneFunnyMuutha/', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '5ff76126-f1ea-11e8-a52e-4334282117e5', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.786164+13');
INSERT INTO app_public.hypertext_link (id, url, name, hypertext_link_type, account_id, created_at, updated_at) VALUES ('e4089fce-00f5-11e9-8925-7b5af7fea107', 'www.youtu.be/Ad-pxjmlpds', NULL, '6423d3f4-f2e1-11e8-bea8-47ca8911719b', '5ff76126-f1ea-11e8-a52e-4334282117e5', '2018-12-16 18:46:10.281146+13', '2018-12-16 19:05:30.799757+13');


--
-- Data for Name: hypertext_link_type; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--

INSERT INTO app_public.hypertext_link_type (id, name, account_id, created_at, updated_at) VALUES ('6423d3f4-f2e1-11e8-bea8-47ca8911719b', 'account', NULL, '2018-12-16 14:19:15.246491+13', '2018-12-16 14:19:15.246491+13');


--
-- Data for Name: image; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--

INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e1ed4e-0100-11e9-bdbd-e79976e05a01', 'https://drive.google.com/open?id=1G1B_uJ261tRH97Yy7e89ybfZ2h3pYCso', 'profile_pic', NULL, 'image/jpeg', '401680d0-f1ea-11e8-a52e-7775e0e66497', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.017658+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e27fe8-0100-11e9-bdbd-43b3ae7faeab', 'https://drive.google.com/open?id=1kU-WdWGmAiCjwI-tPref0VLCUT2EuBdD', 'profile_pic', NULL, 'image/jpeg', '40be7c18-f1ea-11e8-a52e-53dd0db17b32', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.087801+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e289fc-0100-11e9-bdbd-9f70cca8584c', 'https://drive.google.com/open?id=1777riLD4KT8_wQCRps8pL-QaYAaChy6p', 'profile_pic', NULL, 'image/jpeg', '4132dee6-f1ea-11e8-a52e-1ba36abdedda', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.143192+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e29000-0100-11e9-bdbd-6ba9cd5b235a', 'https://drive.google.com/open?id=1cPJgsWj1Lt_jVEmpOeziHqpFwO_ccAIT', 'profile_pic', NULL, 'image/jpeg', '419a989c-f1ea-11e8-a52e-7f502e4d49b5', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.158937+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e298e8-0100-11e9-bdbd-37715562bef9', 'https://drive.google.com/open?id=1cP8M2ZjMUOKefjr1ZnX6pwHJoBG5kQZP', 'profile_pic', NULL, 'image/jpeg', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.173549+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e2a126-0100-11e9-bdbd-3743ea903f68', 'https://drive.google.com/open?id=1T2zMXCjBex3jfr8aJxDxKThYsXVsFVB3', 'profile_pic', NULL, 'image/jpeg', '43e9924c-f1ea-11e8-a52e-5b4666e062c5', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.187244+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e2b350-0100-11e9-bdbd-ab836a5b90e3', 'https://drive.google.com/open?id=1JZ4PkFWzhyCRKuuLLc2RTKFa56hM2tFf', 'profile_pic', NULL, 'image/jpeg', '4aeb031e-f1ea-11e8-a52e-0ffab1819afb', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.202378+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e2e5c8-0100-11e9-bdbd-57148d275c1b', 'https://drive.google.com/open?id=1tnso7H0Sq3PxMgnrDnB92xqLpCARbna4', 'profile_pic', NULL, 'image/jpeg', '4b5989e2-f1ea-11e8-a52e-c355e3f29b74', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.219231+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e2fbe4-0100-11e9-bdbd-27ce582debe7', 'https://drive.google.com/open?id=1NU9PV6b21YswAUr1sRbOxR8oPPXLu2Bj', 'profile_pic', NULL, 'image/jpeg', '4bb10faa-f1ea-11e8-a52e-0fe006889889', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.235729+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e304fe-0100-11e9-bdbd-1b2208686230', 'https://drive.google.com/open?id=11TvXw_yUm_L26_IItTSUA0eABARPhWBs', 'profile_pic', NULL, 'image/jpeg', '4dab5d2a-f1df-11e8-a52e-03eedefce6b1', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.252083+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e30aa8-0100-11e9-bdbd-77cd99fac4d6', 'https://drive.google.com/open?id=1gl2h-X4YWisZvI3hqEYOSHSzOATwAxxe', 'profile_pic', NULL, 'image/jpeg', '570b1170-f1ea-11e8-a52e-5f5854b371fc', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.266568+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e30e0e-0100-11e9-bdbd-6f138723fcb1', 'https://drive.google.com/open?id=1_MzT9D8KWVwBH0xga43ZR14_4dMSCES6', 'profile_pic', NULL, 'image/jpeg', '57ce4cd0-f1ea-11e8-a52e-37bca9c608ee', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.280302+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e3119c-0100-11e9-bdbd-fb3e7727f249', 'https://drive.google.com/open?id=1PJzYdmSlfuImZGGn6b_s2fIE3wtz49MB', 'profile_pic', NULL, 'image/jpeg', '5826e4c6-f1ea-11e8-a52e-b70d0eab9f82', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.294127+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e314c6-0100-11e9-bdbd-f739a3c19245', 'https://drive.google.com/open?id=1YQ0kYP3_Bgcnofmbk4zMs_LE-w8cm5gq', 'profile_pic', NULL, 'image/jpeg', '588d5c24-f1ea-11e8-a52e-636f6acd5dc6', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.308585+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e31a70-0100-11e9-bdbd-df5aec5ca7de', 'https://drive.google.com/open?id=1tjySHFr05BRQap2en_TPtx7m-4rTYqb9', 'profile_pic', NULL, 'image/jpeg', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.322048+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e31f66-0100-11e9-bdbd-f7c555c0cf7f', 'https://drive.google.com/open?id=1XTL0Hxtbdii7LwdGSlTrEpiSiVlXdFBg', 'profile_pic', NULL, 'image/jpeg', '59377c7c-f1ea-11e8-a52e-3b42dc91b7ff', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.336118+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e32358-0100-11e9-bdbd-5b4346ec0235', 'https://drive.google.com/open?id=1NPI9W_sYqMO5hbqiSHWw-mq7eVi-nzaX', 'profile_pic', NULL, 'image/jpeg', '598d5444-f1ea-11e8-a52e-63361829519d', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.349867+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e326b4-0100-11e9-bdbd-1f8701f38498', 'https://drive.google.com/open?id=1cbYj_SpaCaTIUSZ-laZ0Kp0w6EoUkjjw', 'profile_pic', NULL, 'image/jpeg', '5fb046b0-f1ea-11e8-a52e-c37fb0054913', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.362005+13');
INSERT INTO app_public.image (id, url, alt, longdesc, image_type, account_id, created_at, updated_at) VALUES ('e1e329b6-0100-11e9-bdbd-0fdfdd3f8eb7', 'https://drive.google.com/open?id=10S1AVHn5nnWWEz5ejC0ZjWCDaiXOVAns', 'profile_pic', NULL, 'image/jpeg', '5ff76126-f1ea-11e8-a52e-4334282117e5', '2018-12-16 20:04:51.270666+13', '2018-12-16 20:16:22.375721+13');


--
-- Data for Name: longdesc; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: organization; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: organization_hypertext_link; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: organization_tag; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: tag; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--

INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('4c257f3e-0121-11e9-848e-dbbc83130117', 'Machine learning', '4aeb031e-f1ea-11e8-a52e-0ffab1819afb', '2018-12-16 23:56:53.458279+13', '2018-12-16 23:58:19.498853+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('4c258e3e-0121-11e9-848e-1719b5723566', 'ai', '4aeb031e-f1ea-11e8-a52e-0ffab1819afb', '2018-12-16 23:56:53.458279+13', '2018-12-16 23:58:19.517406+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('4c2595e6-0121-11e9-848e-1382e522533c', 'nlp', '4aeb031e-f1ea-11e8-a52e-0ffab1819afb', '2018-12-16 23:56:53.458279+13', '2018-12-16 23:58:19.532175+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('4c259d48-0121-11e9-848e-4b2ba428aaf7', 'nlu', '4aeb031e-f1ea-11e8-a52e-0ffab1819afb', '2018-12-16 23:56:53.458279+13', '2018-12-16 23:58:19.549147+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('4c25a310-0121-11e9-848e-ab14ff39650d', 'lstm', '4aeb031e-f1ea-11e8-a52e-0ffab1819afb', '2018-12-16 23:56:53.458279+13', '2018-12-16 23:58:19.563755+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('4c25b030-0121-11e9-848e-bfd9ad6f7172', 'rnn', '4aeb031e-f1ea-11e8-a52e-0ffab1819afb', '2018-12-16 23:56:53.458279+13', '2018-12-16 23:58:19.577888+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('4c25b724-0121-11e9-848e-6b4b033bdafa', 'language understanding', '4aeb031e-f1ea-11e8-a52e-0ffab1819afb', '2018-12-16 23:56:53.458279+13', '2018-12-16 23:58:19.592032+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('4c25becc-0121-11e9-848e-bba3ab28e2a5', 'language peocessing', '4aeb031e-f1ea-11e8-a52e-0ffab1819afb', '2018-12-16 23:56:53.458279+13', '2018-12-16 23:58:19.619791+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('92bf86ec-0121-11e9-848e-f728bab38aa4', 'yolo', '401680d0-f1ea-11e8-a52e-7775e0e66497', '2018-12-16 23:58:51.908095+13', '2018-12-17 00:00:11.097748+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('92bf93e4-0121-11e9-848e-436b0f5a0691', 'swag', '401680d0-f1ea-11e8-a52e-7775e0e66497', '2018-12-16 23:58:51.908095+13', '2018-12-17 00:00:11.119754+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('b7ac64ca-0121-11e9-848e-87983444238f', 'Google', '4132dee6-f1ea-11e8-a52e-1ba36abdedda', '2018-12-16 23:59:53.858358+13', '2018-12-17 00:00:23.549164+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('b7ac6f1a-0121-11e9-848e-732055dadad1', 'iPhone', '4132dee6-f1ea-11e8-a52e-1ba36abdedda', '2018-12-16 23:59:53.858358+13', '2018-12-17 00:00:23.565277+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('b7ac735c-0121-11e9-848e-6b7c842e4551', 'Revenue', '4132dee6-f1ea-11e8-a52e-1ba36abdedda', '2018-12-16 23:59:53.858358+13', '2018-12-17 00:00:23.580962+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('b7ac7672-0121-11e9-848e-1b17b632fb0c', 'Business', '4132dee6-f1ea-11e8-a52e-1ba36abdedda', '2018-12-16 23:59:53.858358+13', '2018-12-17 00:00:23.59611+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('dfcef38c-0121-11e9-848e-371d6a6f3854', 'Art', '419a989c-f1ea-11e8-a52e-7f502e4d49b5', '2018-12-17 00:01:01.193844+13', '2018-12-17 00:01:18.300066+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('dfcefcec-0121-11e9-848e-efe362f8c4c4', 'Sculpture', '419a989c-f1ea-11e8-a52e-7f502e4d49b5', '2018-12-17 00:01:01.193844+13', '2018-12-17 00:01:18.317801+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('00669a00-0122-11e9-848e-f7feae0a16b0', 'welness', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-17 00:01:55.874851+13', '2018-12-17 00:02:19.525673+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('0066a1a8-0122-11e9-848e-c3cc71d16f8f', 'holistic', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-17 00:01:55.874851+13', '2018-12-17 00:02:19.540958+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('0066a5ae-0122-11e9-848e-abfe17a9cc2b', 'bodymindsoul', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-17 00:01:55.874851+13', '2018-12-17 00:02:19.555878+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('0066a932-0122-11e9-848e-d3ce20179036', 'newyou', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-17 00:01:55.874851+13', '2018-12-17 00:02:19.569198+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('0066ac5c-0122-11e9-848e-8b35752d5df4', 'learnnewskills', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-17 00:01:55.874851+13', '2018-12-17 00:02:19.583795+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('0066af72-0122-11e9-848e-97116d6aee23', 'wholefood', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-17 00:01:55.874851+13', '2018-12-17 00:02:19.597313+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('0066b288-0122-11e9-848e-cb291ee8a617', 'exercise', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-17 00:01:55.874851+13', '2018-12-17 00:02:19.620042+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('0066b576-0122-11e9-848e-9f3c831b0384', 'meditation', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-17 00:01:55.874851+13', '2018-12-17 00:02:19.635474+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('0066b88c-0122-11e9-848e-73c29ffd9cf4', 'daytoyou', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-17 00:01:55.874851+13', '2018-12-17 00:02:19.689958+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('0066bb70-0122-11e9-848e-53eab3f1e2d5', 'miniretreat', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-17 00:01:55.874851+13', '2018-12-17 00:02:19.704246+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('0066befe-0122-11e9-848e-7b62f1500a24', 'beabitsefish', '4370e7fc-f1ea-11e8-a52e-8b7a2a76b93c', '2018-12-17 00:01:55.874851+13', '2018-12-17 00:02:19.719147+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('82846038-0124-11e9-848e-1b1d7d6b85e9', 'conspiracy', '43e9924c-f1ea-11e8-a52e-5b4666e062c5', '2018-12-17 00:19:53.165878+13', '2018-12-17 00:20:14.920332+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('82847370-0124-11e9-848e-97575ca0f7d9', 'theory', '43e9924c-f1ea-11e8-a52e-5b4666e062c5', '2018-12-17 00:19:53.165878+13', '2018-12-17 00:20:14.936526+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('8284771c-0124-11e9-848e-efdce82a8fb2', 'theories', '43e9924c-f1ea-11e8-a52e-5b4666e062c5', '2018-12-17 00:19:53.165878+13', '2018-12-17 00:20:14.951016+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('8284884c-0124-11e9-848e-1f50ae18ed1a', 'moon', '43e9924c-f1ea-11e8-a52e-5b4666e062c5', '2018-12-17 00:19:53.165878+13', '2018-12-17 00:20:14.964932+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('8284a03e-0124-11e9-848e-1720cedf5a4e', 'cheese', '43e9924c-f1ea-11e8-a52e-5b4666e062c5', '2018-12-17 00:19:53.165878+13', '2018-12-17 00:20:14.977264+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('afd43c66-0124-11e9-848e-0b7e00e01c5e', 'Leadership', '4b5989e2-f1ea-11e8-a52e-c355e3f29b74', '2018-12-17 00:21:09.188131+13', '2018-12-17 00:22:00.939534+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('afd442ba-0124-11e9-848e-7bea34e7246e', 'Policy', '4b5989e2-f1ea-11e8-a52e-c355e3f29b74', '2018-12-17 00:21:09.188131+13', '2018-12-17 00:22:00.955591+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('afd445bc-0124-11e9-848e-fb5e37d85294', 'Ethics', '4b5989e2-f1ea-11e8-a52e-c355e3f29b74', '2018-12-17 00:21:09.188131+13', '2018-12-17 00:22:00.972186+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('db1d1c26-0124-11e9-848e-1fb3f2fb9e02', 'JavaScript', '4bb10faa-f1ea-11e8-a52e-0fe006889889', '2018-12-17 00:22:21.80773+13', '2018-12-17 00:22:35.748204+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('fc0f894e-0126-11e9-848e-6f4efd0a9114', 'Word War 2', '570b1170-f1ea-11e8-a52e-5f5854b371fc', '2018-12-17 00:37:36.077009+13', '2018-12-17 00:38:43.217527+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('fc0f96d2-0126-11e9-848e-8769e03eb6a4', 'Mongol invasion of Europe', '570b1170-f1ea-11e8-a52e-5f5854b371fc', '2018-12-17 00:37:36.077009+13', '2018-12-17 00:38:43.236028+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('6c6ae3c8-0127-11e9-848e-3b796a4dc0ee', 'Tech', '576e650e-f1ea-11e8-a52e-9fe6a1114e42', '2018-12-17 00:40:44.58054+13', '2018-12-17 00:41:37.461224+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('6c6af3a4-0127-11e9-848e-7b953e7b41a1', 'future', '576e650e-f1ea-11e8-a52e-9fe6a1114e42', '2018-12-17 00:40:44.58054+13', '2018-12-17 00:41:37.519932+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('6c6afcc8-0127-11e9-848e-a3265b01e3ad', 'electronics', '576e650e-f1ea-11e8-a52e-9fe6a1114e42', '2018-12-17 00:40:44.58054+13', '2018-12-17 00:41:37.535762+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('9fe9492e-0127-11e9-848e-17fec5103288', 'comedy', '57ce4cd0-f1ea-11e8-a52e-37bca9c608ee', '2018-12-17 00:42:10.972694+13', '2018-12-17 00:42:52.357699+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('9fe95298-0127-11e9-848e-ebff28a8f2fe', 'programming', '57ce4cd0-f1ea-11e8-a52e-37bca9c608ee', '2018-12-17 00:42:10.972694+13', '2018-12-17 00:42:52.41202+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('9fe95608-0127-11e9-848e-cf0200c25d59', 'how-to', '57ce4cd0-f1ea-11e8-a52e-37bca9c608ee', '2018-12-17 00:42:10.972694+13', '2018-12-17 00:42:52.425051+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('9fe95a18-0127-11e9-848e-3b72b1c1b516', 'kidneystones', '57ce4cd0-f1ea-11e8-a52e-37bca9c608ee', '2018-12-17 00:42:10.972694+13', '2018-12-17 00:42:52.438473+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('9fe95d24-0127-11e9-848e-7b791db7125d', 'mango hand cream', '57ce4cd0-f1ea-11e8-a52e-37bca9c608ee', '2018-12-17 00:42:10.972694+13', '2018-12-17 00:42:52.451937+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('c7a30f04-0127-11e9-848e-6f6f86fb6ecf', 'snacks', '5826e4c6-f1ea-11e8-a52e-b70d0eab9f82', '2018-12-17 00:43:17.621346+13', '2018-12-17 00:43:31.194104+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('ee6b7ca2-0127-11e9-848e-2b0814f9337d', 'refactor', '588d5c24-f1ea-11e8-a52e-636f6acd5dc6', '2018-12-17 00:44:22.688037+13', '2018-12-17 00:44:43.336589+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('ee6b853a-0127-11e9-848e-0f879be27fcd', 'code-along', '588d5c24-f1ea-11e8-a52e-636f6acd5dc6', '2018-12-17 00:44:22.688037+13', '2018-12-17 00:44:43.353473+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('ee6b89ea-0127-11e9-848e-efb9a7fcc5d7', 'API', '588d5c24-f1ea-11e8-a52e-636f6acd5dc6', '2018-12-17 00:44:22.688037+13', '2018-12-17 00:44:43.367176+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('ee6b902a-0127-11e9-848e-c3222eb7ac9d', 'data', '588d5c24-f1ea-11e8-a52e-636f6acd5dc6', '2018-12-17 00:44:22.688037+13', '2018-12-17 00:44:43.381927+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('ee6b9610-0127-11e9-848e-1be093050e45', 'caching', '588d5c24-f1ea-11e8-a52e-636f6acd5dc6', '2018-12-17 00:44:22.688037+13', '2018-12-17 00:44:43.393944+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('44dcd1da-0128-11e9-848e-e359ef0a435d', 'Bullshit artistry', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-17 00:46:47.715028+13', '2018-12-17 00:47:16.874148+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('44dcdaa4-0128-11e9-848e-eb545304af70', 'schmoozing', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-17 00:46:47.715028+13', '2018-12-17 00:47:16.891586+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('44dce0a8-0128-11e9-848e-9ba7b8b68438', 'getting hired', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-17 00:46:47.715028+13', '2018-12-17 00:47:16.905193+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('44dce7ba-0128-11e9-848e-f70d99efb636', 'lazy programming', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-17 00:46:47.715028+13', '2018-12-17 00:47:16.918808+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('44dcef76-0128-11e9-848e-535dd68ae1df', 'conning people', '58dabdfc-f1ea-11e8-a52e-1b4e6da0f14e', '2018-12-17 00:46:47.715028+13', '2018-12-17 00:47:16.934416+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('967c1550-0128-11e9-848e-2b1e1ea65deb', 'honk', '59377c7c-f1ea-11e8-a52e-3b42dc91b7ff', '2018-12-17 00:49:04.65429+13', '2018-12-17 00:49:26.266345+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('b0ade890-0128-11e9-848e-1fa880ba2150', 'Z', '598d5444-f1ea-11e8-a52e-63361829519d', '2018-12-17 00:49:48.601634+13', '2018-12-17 00:50:02.184256+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('e1326f18-0128-11e9-848e-db3939f14f45', 'React', '5fb046b0-f1ea-11e8-a52e-c37fb0054913', '2018-12-17 00:51:10.000755+13', '2018-12-17 00:52:05.202382+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('e1327530-0128-11e9-848e-0b2d1851cf64', 'UI', '5fb046b0-f1ea-11e8-a52e-c37fb0054913', '2018-12-17 00:51:10.000755+13', '2018-12-17 00:52:05.259931+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('e1327a9e-0128-11e9-848e-33d66a2aaf7c', 'Storybook', '5fb046b0-f1ea-11e8-a52e-c37fb0054913', '2018-12-17 00:51:10.000755+13', '2018-12-17 00:52:05.273594+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('e1327fd0-0128-11e9-848e-df63baff0922', 'Atomic', '5fb046b0-f1ea-11e8-a52e-c37fb0054913', '2018-12-17 00:51:10.000755+13', '2018-12-17 00:52:05.286675+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('e132a79e-0128-11e9-848e-8730ca706fa2', 'Design', '5fb046b0-f1ea-11e8-a52e-c37fb0054913', '2018-12-17 00:51:10.000755+13', '2018-12-17 00:52:05.299421+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('e132ae4c-0128-11e9-848e-7fdbc077ae03', 'CSS', '5fb046b0-f1ea-11e8-a52e-c37fb0054913', '2018-12-17 00:51:10.000755+13', '2018-12-17 00:52:05.314531+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('11ce9d40-0129-11e9-848e-dffe5a20f9d3', 'Funny,', '5ff76126-f1ea-11e8-a52e-4334282117e5', '2018-12-17 00:52:31.55492+13', '2018-12-17 00:52:56.544132+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('11ceadf8-0129-11e9-848e-a38b7636fed5', 'book,', '5ff76126-f1ea-11e8-a52e-4334282117e5', '2018-12-17 00:52:31.55492+13', '2018-12-17 00:52:56.55985+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('11ceb53c-0129-11e9-848e-6f6bb91726ae', 'entertainment,', '5ff76126-f1ea-11e8-a52e-4334282117e5', '2018-12-17 00:52:31.55492+13', '2018-12-17 00:52:56.573266+13');
INSERT INTO app_public.tag (id, body, account_id, created_at, updated_at) VALUES ('11cec040-0129-11e9-848e-3b2764b9233d', 'money,', '5ff76126-f1ea-11e8-a52e-4334282117e5', '2018-12-17 00:52:31.55492+13', '2018-12-17 00:52:56.586857+13');


--
-- Data for Name: venue; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: venue_hypertext_link; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: venue_tag; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Name: credential credential_email_key; Type: CONSTRAINT; Schema: app_private; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_private.credential
    ADD CONSTRAINT credential_email_key UNIQUE (email);


--
-- Name: credential credential_pkey; Type: CONSTRAINT; Schema: app_private; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_private.credential
    ADD CONSTRAINT credential_pkey PRIMARY KEY (account_id);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: duration duration_pkey; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.duration
    ADD CONSTRAINT duration_pkey PRIMARY KEY (id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: event_type event_type_name_key; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event_type
    ADD CONSTRAINT event_type_name_key UNIQUE (name);


--
-- Name: event_type event_type_pkey; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event_type
    ADD CONSTRAINT event_type_pkey PRIMARY KEY (id);


--
-- Name: hypertext_link hypertext_link_pkey; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.hypertext_link
    ADD CONSTRAINT hypertext_link_pkey PRIMARY KEY (id);


--
-- Name: hypertext_link_type hypertext_link_type_name_key; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.hypertext_link_type
    ADD CONSTRAINT hypertext_link_type_name_key UNIQUE (name);


--
-- Name: hypertext_link_type hypertext_link_type_pkey; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.hypertext_link_type
    ADD CONSTRAINT hypertext_link_type_pkey PRIMARY KEY (id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: longdesc longdesc_pkey; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.longdesc
    ADD CONSTRAINT longdesc_pkey PRIMARY KEY (id);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- Name: tag tag_body_key; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.tag
    ADD CONSTRAINT tag_body_key UNIQUE (body);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: venue venue_pkey; Type: CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.venue
    ADD CONSTRAINT venue_pkey PRIMARY KEY (id);


--
-- Name: unique_account_hypertext_links; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_account_hypertext_links ON app_public.account_hypertext_link USING btree (account_id, hypertext_link_id);


--
-- Name: unique_event_hypertext_links; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_event_hypertext_links ON app_public.event_hypertext_link USING btree (event_id, hypertext_link_id);


--
-- Name: unique_event_slug_in_parent; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_event_slug_in_parent ON app_public.event USING btree (slug, parent) WHERE (parent IS NOT NULL);


--
-- Name: unique_event_slug_on_home_event; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_event_slug_on_home_event ON app_public.event USING btree (slug) WHERE (parent IS NULL);


--
-- Name: unique_event_spot_in_parent; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_event_spot_in_parent ON app_public.event USING btree (spot, parent);


--
-- Name: unique_event_tags; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_event_tags ON app_public.event_tag USING btree (tag_id, event_id);


--
-- Name: unique_lowercase_body_in_tag; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_lowercase_body_in_tag ON app_public.tag USING btree (lower(body));


--
-- Name: unique_managed_page; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_managed_page ON app_public.managed_page USING btree (full_path);


--
-- Name: unique_organization_hypertext_links; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_organization_hypertext_links ON app_public.organization_hypertext_link USING btree (organization_id, hypertext_link_id);


--
-- Name: unique_organization_slug_in_parent; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_organization_slug_in_parent ON app_public.organization USING btree (slug, parent) WHERE (parent IS NOT NULL);


--
-- Name: unique_organization_slug_on_home_organization; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_organization_slug_on_home_organization ON app_public.organization USING btree (slug) WHERE (parent IS NULL);


--
-- Name: unique_organization_spot_in_parent; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_organization_spot_in_parent ON app_public.organization USING btree (spot, parent);


--
-- Name: unique_organization_tags; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_organization_tags ON app_public.organization_tag USING btree (tag_id, organization_id);


--
-- Name: unique_venue_hypertext_links; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_venue_hypertext_links ON app_public.venue_hypertext_link USING btree (venue_id, hypertext_link_id);


--
-- Name: unique_venue_slug_in_parent; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_venue_slug_in_parent ON app_public.venue USING btree (slug, parent) WHERE (parent IS NOT NULL);


--
-- Name: unique_venue_slug_on_home_venue; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_venue_slug_on_home_venue ON app_public.venue USING btree (slug) WHERE (parent IS NULL);


--
-- Name: unique_venue_spot_in_parent; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_venue_spot_in_parent ON app_public.venue USING btree (spot, parent);


--
-- Name: unique_venue_tags; Type: INDEX; Schema: app_public; Owner: cp_postgraphile
--

CREATE UNIQUE INDEX unique_venue_tags ON app_public.venue_tag USING btree (tag_id, venue_id);


--
-- Name: account account_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER account_updated_at BEFORE UPDATE ON app_public.account FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: event_tag delete_unused_tags_on_event_tag_deletion; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER delete_unused_tags_on_event_tag_deletion AFTER DELETE ON app_public.event_tag FOR EACH STATEMENT EXECUTE PROCEDURE app_private.delete_unused_tags();


--
-- Name: organization_tag delete_unused_tags_on_organization_tag_deletion; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER delete_unused_tags_on_organization_tag_deletion AFTER DELETE ON app_public.organization_tag FOR EACH STATEMENT EXECUTE PROCEDURE app_private.delete_unused_tags();


--
-- Name: venue_tag delete_unused_tags_on_venue_tag_deletion; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER delete_unused_tags_on_venue_tag_deletion AFTER DELETE ON app_public.venue_tag FOR EACH STATEMENT EXECUTE PROCEDURE app_private.delete_unused_tags();


--
-- Name: duration duration_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER duration_account BEFORE INSERT ON app_public.duration FOR EACH ROW EXECUTE PROCEDURE app_private.set_account_id();


--
-- Name: duration duration_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER duration_updated_at BEFORE UPDATE ON app_public.duration FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: event event_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER event_account BEFORE INSERT ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_private.set_account_id();


--
-- Name: event event_positioned_on_insertion; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER event_positioned_on_insertion BEFORE INSERT ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_private.set_event_spot();


--
-- Name: event_type event_type_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER event_type_account BEFORE INSERT ON app_public.event_type FOR EACH ROW EXECUTE PROCEDURE app_private.set_account_id();


--
-- Name: event_type event_type_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER event_type_updated_at BEFORE UPDATE ON app_public.event_type FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: event event_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER event_updated_at BEFORE UPDATE ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: event events_repositioned_on_deletion; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER events_repositioned_on_deletion AFTER DELETE ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_private.update_event_spot_on_deletion();


--
-- Name: hypertext_link hypertext_link_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER hypertext_link_account BEFORE INSERT ON app_public.hypertext_link FOR EACH ROW EXECUTE PROCEDURE app_private.set_account_id();


--
-- Name: hypertext_link_type hypertext_link_type_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER hypertext_link_type_account BEFORE INSERT ON app_public.hypertext_link_type FOR EACH ROW EXECUTE PROCEDURE app_private.set_account_id();


--
-- Name: hypertext_link_type hypertext_link_type_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER hypertext_link_type_updated_at BEFORE UPDATE ON app_public.hypertext_link_type FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: hypertext_link hypertext_link_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER hypertext_link_updated_at BEFORE UPDATE ON app_public.hypertext_link FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: image image_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER image_account BEFORE INSERT ON app_public.image FOR EACH ROW EXECUTE PROCEDURE app_private.set_account_id();


--
-- Name: image image_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER image_updated_at BEFORE UPDATE ON app_public.image FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: longdesc longdesc_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER longdesc_account BEFORE INSERT ON app_public.longdesc FOR EACH ROW EXECUTE PROCEDURE app_private.set_account_id();


--
-- Name: longdesc longdesc_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER longdesc_updated_at BEFORE UPDATE ON app_public.longdesc FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: event managed_page_view_refreshed_on_event_insert_or_delete; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER managed_page_view_refreshed_on_event_insert_or_delete AFTER INSERT OR DELETE ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();


--
-- Name: event managed_page_view_refreshed_on_event_update; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER managed_page_view_refreshed_on_event_update AFTER UPDATE ON app_public.event FOR EACH ROW WHEN ((((old.slug)::text IS DISTINCT FROM (new.slug)::text) OR (old.parent IS DISTINCT FROM new.parent))) EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();


--
-- Name: organization managed_page_view_refreshed_on_organization_insert_or_delete; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER managed_page_view_refreshed_on_organization_insert_or_delete AFTER INSERT OR DELETE ON app_public.organization FOR EACH ROW EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();


--
-- Name: organization managed_page_view_refreshed_on_organization_update; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER managed_page_view_refreshed_on_organization_update AFTER UPDATE ON app_public.organization FOR EACH ROW WHEN ((((old.slug)::text IS DISTINCT FROM (new.slug)::text) OR (old.parent IS DISTINCT FROM new.parent))) EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();


--
-- Name: venue managed_page_view_refreshed_on_venue_insert_or_delete; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER managed_page_view_refreshed_on_venue_insert_or_delete AFTER INSERT OR DELETE ON app_public.venue FOR EACH ROW EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();


--
-- Name: venue managed_page_view_refreshed_on_venue_update; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER managed_page_view_refreshed_on_venue_update AFTER UPDATE ON app_public.venue FOR EACH ROW WHEN ((((old.slug)::text IS DISTINCT FROM (new.slug)::text) OR (old.parent IS DISTINCT FROM new.parent))) EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();


--
-- Name: organization organization_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER organization_account BEFORE INSERT ON app_public.organization FOR EACH ROW EXECUTE PROCEDURE app_private.set_account_id();


--
-- Name: organization organization_positioned_on_insertion; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER organization_positioned_on_insertion BEFORE INSERT ON app_public.organization FOR EACH ROW EXECUTE PROCEDURE app_private.set_organization_spot();


--
-- Name: organization organization_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER organization_updated_at BEFORE UPDATE ON app_public.organization FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: organization organizations_repositioned_on_deletion; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER organizations_repositioned_on_deletion AFTER DELETE ON app_public.organization FOR EACH ROW EXECUTE PROCEDURE app_private.update_organization_spot_on_deletion();


--
-- Name: tag tag_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER tag_account BEFORE INSERT ON app_public.tag FOR EACH ROW EXECUTE PROCEDURE app_private.set_account_id();


--
-- Name: tag tag_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER tag_updated_at BEFORE UPDATE ON app_public.tag FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: venue venue_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER venue_account BEFORE INSERT ON app_public.venue FOR EACH ROW EXECUTE PROCEDURE app_private.set_account_id();


--
-- Name: venue venue_positioned_on_insertion; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER venue_positioned_on_insertion BEFORE INSERT ON app_public.venue FOR EACH ROW EXECUTE PROCEDURE app_private.set_venue_spot();


--
-- Name: venue venue_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER venue_updated_at BEFORE UPDATE ON app_public.venue FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: venue venues_repositioned_on_deletion; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER venues_repositioned_on_deletion AFTER DELETE ON app_public.venue FOR EACH ROW EXECUTE PROCEDURE app_private.update_venue_spot_on_deletion();


--
-- Name: credential credential_account_id_fkey; Type: FK CONSTRAINT; Schema: app_private; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_private.credential
    ADD CONSTRAINT credential_account_id_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id) ON DELETE CASCADE;


--
-- Name: account_hypertext_link account_hypertext_link_account_id_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.account_hypertext_link
    ADD CONSTRAINT account_hypertext_link_account_id_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id) ON DELETE CASCADE;


--
-- Name: account_hypertext_link account_hypertext_link_hypertext_link_id_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.account_hypertext_link
    ADD CONSTRAINT account_hypertext_link_hypertext_link_id_fkey FOREIGN KEY (hypertext_link_id) REFERENCES app_public.hypertext_link(id) ON DELETE CASCADE;


--
-- Name: duration duration_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.duration
    ADD CONSTRAINT duration_account_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id);


--
-- Name: duration duration_event_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.duration
    ADD CONSTRAINT duration_event_fkey FOREIGN KEY (event) REFERENCES app_public.event(id);


--
-- Name: event event_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event
    ADD CONSTRAINT event_account_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id);


--
-- Name: event event_event_type_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event
    ADD CONSTRAINT event_event_type_fkey FOREIGN KEY (event_type) REFERENCES app_public.event_type(id);


--
-- Name: event_hypertext_link event_hypertext_link_event_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event_hypertext_link
    ADD CONSTRAINT event_hypertext_link_event_fkey FOREIGN KEY (event_id) REFERENCES app_public.event(id) ON DELETE CASCADE;


--
-- Name: event_hypertext_link event_hypertext_link_hypertext_link_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event_hypertext_link
    ADD CONSTRAINT event_hypertext_link_hypertext_link_fkey FOREIGN KEY (hypertext_link_id) REFERENCES app_public.hypertext_link(id) ON DELETE CASCADE;


--
-- Name: event event_image_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event
    ADD CONSTRAINT event_image_fkey FOREIGN KEY (image) REFERENCES app_public.image(id);


--
-- Name: event_tag event_tag_event_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event_tag
    ADD CONSTRAINT event_tag_event_fkey FOREIGN KEY (event_id) REFERENCES app_public.event(id) ON DELETE CASCADE;


--
-- Name: event_tag event_tag_tag_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event_tag
    ADD CONSTRAINT event_tag_tag_fkey FOREIGN KEY (tag_id) REFERENCES app_public.tag(id) ON DELETE CASCADE;


--
-- Name: event_type event_type_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event_type
    ADD CONSTRAINT event_type_account_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id);


--
-- Name: hypertext_link hypertext_link_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.hypertext_link
    ADD CONSTRAINT hypertext_link_account_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id);


--
-- Name: hypertext_link hypertext_link_hypertext_link_type_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.hypertext_link
    ADD CONSTRAINT hypertext_link_hypertext_link_type_fkey FOREIGN KEY (hypertext_link_type) REFERENCES app_public.hypertext_link_type(id);


--
-- Name: hypertext_link_type hypertext_link_type_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.hypertext_link_type
    ADD CONSTRAINT hypertext_link_type_account_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id);


--
-- Name: image image_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.image
    ADD CONSTRAINT image_account_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id);


--
-- Name: image image_longdesc_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.image
    ADD CONSTRAINT image_longdesc_fkey FOREIGN KEY (longdesc) REFERENCES app_public.longdesc(id);


--
-- Name: longdesc longdesc_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.longdesc
    ADD CONSTRAINT longdesc_account_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id);


--
-- Name: organization organization_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.organization
    ADD CONSTRAINT organization_account_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id);


--
-- Name: organization_hypertext_link organization_hypertext_link_hypertext_link_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.organization_hypertext_link
    ADD CONSTRAINT organization_hypertext_link_hypertext_link_fkey FOREIGN KEY (hypertext_link_id) REFERENCES app_public.hypertext_link(id) ON DELETE CASCADE;


--
-- Name: organization_hypertext_link organization_hypertext_link_organization_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.organization_hypertext_link
    ADD CONSTRAINT organization_hypertext_link_organization_fkey FOREIGN KEY (organization_id) REFERENCES app_public.organization(id) ON DELETE CASCADE;


--
-- Name: organization organization_image_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.organization
    ADD CONSTRAINT organization_image_fkey FOREIGN KEY (image) REFERENCES app_public.image(id);


--
-- Name: organization_tag organization_tag_organization_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.organization_tag
    ADD CONSTRAINT organization_tag_organization_fkey FOREIGN KEY (organization_id) REFERENCES app_public.organization(id) ON DELETE CASCADE;


--
-- Name: organization_tag organization_tag_tag_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.organization_tag
    ADD CONSTRAINT organization_tag_tag_fkey FOREIGN KEY (tag_id) REFERENCES app_public.tag(id) ON DELETE CASCADE;


--
-- Name: tag tag_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.tag
    ADD CONSTRAINT tag_account_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id);


--
-- Name: venue venue_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.venue
    ADD CONSTRAINT venue_account_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id);


--
-- Name: venue_hypertext_link venue_hypertext_link_hypertext_link_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.venue_hypertext_link
    ADD CONSTRAINT venue_hypertext_link_hypertext_link_fkey FOREIGN KEY (hypertext_link_id) REFERENCES app_public.hypertext_link(id) ON DELETE CASCADE;


--
-- Name: venue_hypertext_link venue_hypertext_link_venue_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.venue_hypertext_link
    ADD CONSTRAINT venue_hypertext_link_venue_fkey FOREIGN KEY (venue_id) REFERENCES app_public.venue(id) ON DELETE CASCADE;


--
-- Name: venue venue_image_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.venue
    ADD CONSTRAINT venue_image_fkey FOREIGN KEY (image) REFERENCES app_public.image(id);


--
-- Name: venue_tag venue_tag_tag_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.venue_tag
    ADD CONSTRAINT venue_tag_tag_fkey FOREIGN KEY (tag_id) REFERENCES app_public.tag(id) ON DELETE CASCADE;


--
-- Name: venue_tag venue_tag_venue_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.venue_tag
    ADD CONSTRAINT venue_tag_venue_fkey FOREIGN KEY (venue_id) REFERENCES app_public.venue(id) ON DELETE CASCADE;


--
-- Name: account; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.account ENABLE ROW LEVEL SECURITY;

--
-- Name: account_hypertext_link; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.account_hypertext_link ENABLE ROW LEVEL SECURITY;

--
-- Name: account delete_account; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY delete_account ON app_public.account FOR DELETE TO cp_account USING ((id = (current_setting('jwt.claims.account_id'::text, true))::uuid));


--
-- Name: duration; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.duration ENABLE ROW LEVEL SECURITY;

--
-- Name: event; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.event ENABLE ROW LEVEL SECURITY;

--
-- Name: event_hypertext_link; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.event_hypertext_link ENABLE ROW LEVEL SECURITY;

--
-- Name: event_tag; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.event_tag ENABLE ROW LEVEL SECURITY;

--
-- Name: event_type; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.event_type ENABLE ROW LEVEL SECURITY;

--
-- Name: hypertext_link; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.hypertext_link ENABLE ROW LEVEL SECURITY;

--
-- Name: hypertext_link_type; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.hypertext_link_type ENABLE ROW LEVEL SECURITY;

--
-- Name: image; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.image ENABLE ROW LEVEL SECURITY;

--
-- Name: longdesc; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.longdesc ENABLE ROW LEVEL SECURITY;

--
-- Name: organization; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.organization ENABLE ROW LEVEL SECURITY;

--
-- Name: organization_hypertext_link; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.organization_hypertext_link ENABLE ROW LEVEL SECURITY;

--
-- Name: organization_tag; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.organization_tag ENABLE ROW LEVEL SECURITY;

--
-- Name: account select_account; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_account ON app_public.account FOR SELECT USING (true);


--
-- Name: account_hypertext_link select_account_hypertext_link; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_account_hypertext_link ON app_public.account_hypertext_link FOR SELECT USING (true);


--
-- Name: duration select_duration; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_duration ON app_public.duration FOR SELECT USING (true);


--
-- Name: event select_event; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_event ON app_public.event FOR SELECT USING (true);


--
-- Name: event_hypertext_link select_event_hypertext_link; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_event_hypertext_link ON app_public.event_hypertext_link FOR SELECT USING (true);


--
-- Name: event_tag select_event_tag; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_event_tag ON app_public.event_tag FOR SELECT USING (true);


--
-- Name: event_type select_event_type; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_event_type ON app_public.event_type FOR SELECT USING (true);


--
-- Name: hypertext_link select_hypertext_link; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_hypertext_link ON app_public.hypertext_link FOR SELECT USING (true);


--
-- Name: hypertext_link_type select_hypertext_link_type; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_hypertext_link_type ON app_public.hypertext_link_type FOR SELECT USING (true);


--
-- Name: image select_image; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_image ON app_public.image FOR SELECT USING (true);


--
-- Name: longdesc select_longdesc; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_longdesc ON app_public.longdesc FOR SELECT USING (true);


--
-- Name: organization_hypertext_link select_organization_hypertext_link; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_organization_hypertext_link ON app_public.organization_hypertext_link FOR SELECT USING (true);


--
-- Name: organization_tag select_organization_tag; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_organization_tag ON app_public.organization_tag FOR SELECT USING (true);


--
-- Name: organization select_organiztion; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_organiztion ON app_public.organization FOR SELECT USING (true);


--
-- Name: tag select_tag; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_tag ON app_public.tag FOR SELECT USING (true);


--
-- Name: venue select_venue; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_venue ON app_public.venue FOR SELECT USING (true);


--
-- Name: venue_hypertext_link select_venue_hypertext_link; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_venue_hypertext_link ON app_public.venue_hypertext_link FOR SELECT USING (true);


--
-- Name: venue_tag select_venue_tag; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY select_venue_tag ON app_public.venue_tag FOR SELECT USING (true);


--
-- Name: tag; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.tag ENABLE ROW LEVEL SECURITY;

--
-- Name: account update_account; Type: POLICY; Schema: app_public; Owner: cp_postgraphile
--

CREATE POLICY update_account ON app_public.account FOR UPDATE TO cp_account USING ((id = (current_setting('jwt.claims.account_id'::text, true))::uuid));


--
-- Name: venue; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.venue ENABLE ROW LEVEL SECURITY;

--
-- Name: venue_hypertext_link; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.venue_hypertext_link ENABLE ROW LEVEL SECURITY;

--
-- Name: venue_tag; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.venue_tag ENABLE ROW LEVEL SECURITY;

--
-- Name: SCHEMA app_public; Type: ACL; Schema: -; Owner: cp_postgraphile
--

GRANT USAGE ON SCHEMA app_public TO cp_anonymous;
GRANT USAGE ON SCHEMA app_public TO cp_account;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: edward
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: FUNCTION delete_unused_tags(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.delete_unused_tags() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.delete_unused_tags() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.delete_unused_tags() TO cp_account;
GRANT ALL ON FUNCTION app_private.delete_unused_tags() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION set_account_id(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_account_id() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_account_id() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION set_created_by(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_created_by() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_created_by() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION set_event_spot(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_event_spot() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_event_spot() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.set_event_spot() TO cp_account;
GRANT ALL ON FUNCTION app_private.set_event_spot() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION set_organization_spot(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_organization_spot() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_organization_spot() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.set_organization_spot() TO cp_account;
GRANT ALL ON FUNCTION app_private.set_organization_spot() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION set_updated_at(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_updated_at() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_updated_at() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION set_venue_spot(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_venue_spot() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_venue_spot() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.set_venue_spot() TO cp_account;
GRANT ALL ON FUNCTION app_private.set_venue_spot() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION update_event_spot_on_deletion(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.update_event_spot_on_deletion() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.update_event_spot_on_deletion() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.update_event_spot_on_deletion() TO cp_account;
GRANT ALL ON FUNCTION app_private.update_event_spot_on_deletion() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION update_organization_spot_on_deletion(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.update_organization_spot_on_deletion() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.update_organization_spot_on_deletion() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.update_organization_spot_on_deletion() TO cp_account;
GRANT ALL ON FUNCTION app_private.update_organization_spot_on_deletion() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION update_venue_spot_on_deletion(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.update_venue_spot_on_deletion() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.update_venue_spot_on_deletion() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.update_venue_spot_on_deletion() TO cp_account;
GRANT ALL ON FUNCTION app_private.update_venue_spot_on_deletion() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION upsert_tag(tag_body text); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.upsert_tag(tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.upsert_tag(tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.upsert_tag(tag_body text) TO cp_account;
GRANT ALL ON FUNCTION app_private.upsert_tag(tag_body text) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION authenticate(email public.email, password public.password); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) TO cp_account;
GRANT ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION child_paths_by_parent_path_and_depth(parent_path text, depth integer); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) TO cp_account;
GRANT ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: TABLE account; Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

GRANT SELECT ON TABLE app_public.account TO cp_anonymous;
GRANT SELECT,DELETE,UPDATE ON TABLE app_public.account TO cp_account;


--
-- Name: FUNCTION current_account(); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.current_account() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.current_account() TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.current_account() TO cp_account;
GRANT ALL ON FUNCTION app_public.current_account() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION full_name(account app_public.account); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.full_name(account app_public.account) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.full_name(account app_public.account) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.full_name(account app_public.account) TO cp_account;
GRANT ALL ON FUNCTION app_public.full_name(account app_public.account) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION generate_u_u_i_d(); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.generate_u_u_i_d() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_d() TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_d() TO cp_account;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_d() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION generate_u_u_i_ds(quantity integer); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) TO cp_account;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION get_event_count_by_parent_id(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) TO cp_account;
GRANT ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION get_organization_count_by_parent_id(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) TO cp_account;
GRANT ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION get_venue_count_by_parent_id(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) TO cp_account;
GRANT ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION move_event_down(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_event_down(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_event_down(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_event_down(uuid) TO cp_account;
GRANT ALL ON FUNCTION app_public.move_event_down(uuid) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION move_event_up(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_event_up(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_event_up(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_event_up(uuid) TO cp_account;
GRANT ALL ON FUNCTION app_public.move_event_up(uuid) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION move_organization_down(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_organization_down(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_organization_down(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_organization_down(uuid) TO cp_account;
GRANT ALL ON FUNCTION app_public.move_organization_down(uuid) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION move_organization_up(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_organization_up(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_organization_up(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_organization_up(uuid) TO cp_account;
GRANT ALL ON FUNCTION app_public.move_organization_up(uuid) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION move_venue_down(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_venue_down(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_venue_down(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_venue_down(uuid) TO cp_account;
GRANT ALL ON FUNCTION app_public.move_venue_down(uuid) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION move_venue_up(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_venue_up(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_venue_up(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_venue_up(uuid) TO cp_account;
GRANT ALL ON FUNCTION app_public.move_venue_up(uuid) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION refresh_managed_page_materialized_view(); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() TO cp_account;
GRANT ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION remove_tag_from_event(event_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) TO cp_account;
GRANT ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION remove_tag_from_organization(organization_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) TO cp_account;
GRANT ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION remove_tag_from_venue(venue_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) TO cp_account;
GRANT ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION upsert_event_tag(event_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) TO cp_account;
GRANT ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION upsert_organization_tag(organization_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) TO cp_account;
GRANT ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION upsert_venue_tag(venue_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) TO cp_account;
GRANT ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION muid_to_uuid(id text); Type: ACL; Schema: public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION public.muid_to_uuid(id text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION public.muid_to_uuid(id text) TO cp_anonymous;
GRANT ALL ON FUNCTION public.muid_to_uuid(id text) TO cp_account;
GRANT ALL ON FUNCTION public.muid_to_uuid(id text) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_to_muid(id uuid); Type: ACL; Schema: public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION public.uuid_to_muid(id uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION public.uuid_to_muid(id uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION public.uuid_to_muid(id uuid) TO cp_account;
GRANT ALL ON FUNCTION public.uuid_to_muid(id uuid) TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: TABLE managed_page; Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

GRANT SELECT ON TABLE app_public.managed_page TO cp_anonymous;


--
-- Name: managed_page; Type: MATERIALIZED VIEW DATA; Schema: app_public; Owner: cp_postgraphile
--

REFRESH MATERIALIZED VIEW app_public.managed_page;


--
-- PostgreSQL database dump complete
--

