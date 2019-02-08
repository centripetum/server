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
-- Name: centripetal; Type: DATABASE; Schema: -; Owner: cp_postgraphile
--

CREATE DATABASE centripetal WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_NZ.UTF-8' LC_CTYPE = 'en_NZ.UTF-8';


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
-- Name: set_account(); Type: FUNCTION; Schema: app_private; Owner: cp_postgraphile
--

CREATE FUNCTION app_private.set_account() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.account := current_setting('jwt.claims.account_id', true)::uuid;
  RETURN new;
END;
$$;


ALTER FUNCTION app_private.set_account() OWNER TO cp_postgraphile;

--
-- Name: FUNCTION set_account(); Type: COMMENT; Schema: app_private; Owner: cp_postgraphile
--

COMMENT ON FUNCTION app_private.set_account() IS 'Sets the account that created a record (triggered).';


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
    account uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT page_check CHECK (((((slug)::text ~* '^[a-z]+(\-([a-z])+)*$'::text) AND (parent IS NOT NULL)) OR ((parent IS NULL) AND ((slug)::text = ''::text))))
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
-- Name: COLUMN event.account; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.event.account IS 'The id of the account holder that created this event.';


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
    account uuid,
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
-- Name: COLUMN organization.account; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.organization.account IS 'The id of the account holder that created this organization.';


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
    account uuid,
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
-- Name: COLUMN venue.account; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.venue.account IS 'The id of the account holder that created this venue.';


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
    account uuid,
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
-- Name: COLUMN image.account; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.image.account IS 'The id of the account that created this image.';


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
    account uuid,
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
-- Name: COLUMN tag.account; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.tag.account IS 'The id of the account that created this tag.';


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
-- Name: duration; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.duration (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    begins_at timestamp with time zone NOT NULL,
    ends_at timestamp with time zone NOT NULL,
    rrule public.rrule,
    event uuid,
    account uuid,
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
-- Name: COLUMN duration.account; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.duration.account IS 'The id of the account that created this duration.';


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
-- Name: hypertext_link; Type: TABLE; Schema: app_public; Owner: cp_postgraphile
--

CREATE TABLE app_public.hypertext_link (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    url public.u_r_l,
    name public.char_48,
    hypertext_link_type uuid NOT NULL,
    account uuid,
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
-- Name: COLUMN hypertext_link.account; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link.account IS 'The id of the account that created this hypertext_link.';


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
    account uuid,
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
-- Name: COLUMN hypertext_link_type.account; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.hypertext_link_type.account IS 'The id of the account that created this hypertext link type.';


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
    account uuid,
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
-- Name: COLUMN longdesc.account; Type: COMMENT; Schema: app_public; Owner: cp_postgraphile
--

COMMENT ON COLUMN app_public.longdesc.account IS 'The id of the account that created this longdesc.';


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


--
-- Data for Name: account; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--

INSERT INTO app_public.account (id, bio, created_at, updated_at, given_name, family_name) VALUES ('692504d6-ce6a-11e8-ac21-97703d4c9b95', NULL, '2018-10-13 11:01:46.059872+13', '2018-10-13 11:07:15.066393+13', 'Bob', 'Dobbs');


--
-- Data for Name: duration; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: event; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: event_hypertext_link; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: event_tag; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: hypertext_link; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: hypertext_link_type; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



--
-- Data for Name: image; Type: TABLE DATA; Schema: app_public; Owner: cp_postgraphile
--



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
-- Name: venue_tag delete_unused_tags_on_venue_tag_deletion; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER delete_unused_tags_on_venue_tag_deletion AFTER DELETE ON app_public.venue_tag FOR EACH STATEMENT EXECUTE PROCEDURE app_private.delete_unused_tags();


--
-- Name: duration duration_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER duration_account BEFORE INSERT ON app_public.duration FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();


--
-- Name: duration duration_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER duration_updated_at BEFORE UPDATE ON app_public.duration FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: event event_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER event_account BEFORE INSERT ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();


--
-- Name: event event_positioned_on_insertion; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER event_positioned_on_insertion BEFORE INSERT ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_private.set_event_spot();


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

CREATE TRIGGER hypertext_link_account BEFORE INSERT ON app_public.hypertext_link FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();


--
-- Name: hypertext_link_type hypertext_link_type_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER hypertext_link_type_account BEFORE INSERT ON app_public.hypertext_link_type FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();


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

CREATE TRIGGER image_account BEFORE INSERT ON app_public.image FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();


--
-- Name: image image_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER image_updated_at BEFORE UPDATE ON app_public.image FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: longdesc longdesc_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER longdesc_account BEFORE INSERT ON app_public.longdesc FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();


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

CREATE TRIGGER organization_account BEFORE INSERT ON app_public.organization FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();


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

CREATE TRIGGER tag_account BEFORE INSERT ON app_public.tag FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();


--
-- Name: tag tag_updated_at; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER tag_updated_at BEFORE UPDATE ON app_public.tag FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();


--
-- Name: venue venue_account; Type: TRIGGER; Schema: app_public; Owner: cp_postgraphile
--

CREATE TRIGGER venue_account BEFORE INSERT ON app_public.venue FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();


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
-- Name: duration duration_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.duration
    ADD CONSTRAINT duration_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);


--
-- Name: duration duration_event_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.duration
    ADD CONSTRAINT duration_event_fkey FOREIGN KEY (event) REFERENCES app_public.event(id);


--
-- Name: event event_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event
    ADD CONSTRAINT event_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);


--
-- Name: event event_image_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.event
    ADD CONSTRAINT event_image_fkey FOREIGN KEY (image) REFERENCES app_public.image(id);


--
-- Name: hypertext_link hypertext_link_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.hypertext_link
    ADD CONSTRAINT hypertext_link_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);


--
-- Name: hypertext_link hypertext_link_hypertext_link_type_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.hypertext_link
    ADD CONSTRAINT hypertext_link_hypertext_link_type_fkey FOREIGN KEY (hypertext_link_type) REFERENCES app_public.hypertext_link_type(id);


--
-- Name: hypertext_link_type hypertext_link_type_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.hypertext_link_type
    ADD CONSTRAINT hypertext_link_type_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);


--
-- Name: image image_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.image
    ADD CONSTRAINT image_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);


--
-- Name: image image_longdesc_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.image
    ADD CONSTRAINT image_longdesc_fkey FOREIGN KEY (longdesc) REFERENCES app_public.longdesc(id);


--
-- Name: longdesc longdesc_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.longdesc
    ADD CONSTRAINT longdesc_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);


--
-- Name: organization organization_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.organization
    ADD CONSTRAINT organization_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);


--
-- Name: organization organization_image_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.organization
    ADD CONSTRAINT organization_image_fkey FOREIGN KEY (image) REFERENCES app_public.image(id);


--
-- Name: tag tag_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.tag
    ADD CONSTRAINT tag_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);


--
-- Name: venue venue_account_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.venue
    ADD CONSTRAINT venue_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);


--
-- Name: venue venue_image_fkey; Type: FK CONSTRAINT; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE ONLY app_public.venue
    ADD CONSTRAINT venue_image_fkey FOREIGN KEY (image) REFERENCES app_public.image(id);


--
-- Name: account; Type: ROW SECURITY; Schema: app_public; Owner: cp_postgraphile
--

ALTER TABLE app_public.account ENABLE ROW LEVEL SECURITY;

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
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: FUNCTION delete_unused_tags(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.delete_unused_tags() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.delete_unused_tags() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.delete_unused_tags() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.delete_unused_tags() TO cp_account;


--
-- Name: FUNCTION set_account(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_account() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_account() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION set_created_by(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_created_by() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_created_by() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION set_event_spot(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_event_spot() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_event_spot() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.set_event_spot() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.set_event_spot() TO cp_account;


--
-- Name: FUNCTION set_organization_spot(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_organization_spot() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_organization_spot() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.set_organization_spot() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.set_organization_spot() TO cp_account;


--
-- Name: FUNCTION set_updated_at(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_updated_at() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_updated_at() TO cp_postgraphile WITH GRANT OPTION;


--
-- Name: FUNCTION set_venue_spot(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.set_venue_spot() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_venue_spot() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.set_venue_spot() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.set_venue_spot() TO cp_account;


--
-- Name: FUNCTION update_event_spot_on_deletion(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.update_event_spot_on_deletion() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.update_event_spot_on_deletion() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.update_event_spot_on_deletion() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.update_event_spot_on_deletion() TO cp_account;


--
-- Name: FUNCTION update_organization_spot_on_deletion(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.update_organization_spot_on_deletion() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.update_organization_spot_on_deletion() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.update_organization_spot_on_deletion() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.update_organization_spot_on_deletion() TO cp_account;


--
-- Name: FUNCTION update_venue_spot_on_deletion(); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.update_venue_spot_on_deletion() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.update_venue_spot_on_deletion() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.update_venue_spot_on_deletion() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.update_venue_spot_on_deletion() TO cp_account;


--
-- Name: FUNCTION upsert_tag(tag_body text); Type: ACL; Schema: app_private; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_private.upsert_tag(tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.upsert_tag(tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.upsert_tag(tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.upsert_tag(tag_body text) TO cp_account;


--
-- Name: FUNCTION authenticate(email public.email, password public.password); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) TO cp_account;


--
-- Name: FUNCTION child_paths_by_parent_path_and_depth(parent_path text, depth integer); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) TO cp_account;


--
-- Name: TABLE account; Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

GRANT SELECT ON TABLE app_public.account TO cp_anonymous;
GRANT SELECT,DELETE,UPDATE ON TABLE app_public.account TO cp_account;


--
-- Name: FUNCTION current_account(); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.current_account() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.current_account() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.current_account() TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.current_account() TO cp_account;


--
-- Name: FUNCTION full_name(account app_public.account); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.full_name(account app_public.account) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.full_name(account app_public.account) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.full_name(account app_public.account) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.full_name(account app_public.account) TO cp_account;


--
-- Name: FUNCTION generate_u_u_i_d(); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.generate_u_u_i_d() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_d() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_d() TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_d() TO cp_account;


--
-- Name: FUNCTION generate_u_u_i_ds(quantity integer); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) TO cp_account;


--
-- Name: FUNCTION get_event_count_by_parent_id(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) TO cp_account;


--
-- Name: FUNCTION get_organization_count_by_parent_id(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) TO cp_account;


--
-- Name: FUNCTION get_venue_count_by_parent_id(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) TO cp_account;


--
-- Name: FUNCTION move_event_down(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_event_down(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_event_down(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_event_down(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_event_down(uuid) TO cp_account;


--
-- Name: FUNCTION move_event_up(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_event_up(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_event_up(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_event_up(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_event_up(uuid) TO cp_account;


--
-- Name: FUNCTION move_organization_down(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_organization_down(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_organization_down(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_organization_down(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_organization_down(uuid) TO cp_account;


--
-- Name: FUNCTION move_organization_up(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_organization_up(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_organization_up(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_organization_up(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_organization_up(uuid) TO cp_account;


--
-- Name: FUNCTION move_venue_down(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_venue_down(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_venue_down(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_venue_down(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_venue_down(uuid) TO cp_account;


--
-- Name: FUNCTION move_venue_up(uuid); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.move_venue_up(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_venue_up(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_venue_up(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_venue_up(uuid) TO cp_account;


--
-- Name: FUNCTION refresh_managed_page_materialized_view(); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() TO cp_account;


--
-- Name: FUNCTION register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

GRANT ALL ON FUNCTION app_public.register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password) TO cp_anonymous;


--
-- Name: FUNCTION remove_tag_from_event(event_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) TO cp_account;


--
-- Name: FUNCTION remove_tag_from_organization(organization_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) TO cp_account;


--
-- Name: FUNCTION remove_tag_from_venue(venue_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) TO cp_account;


--
-- Name: FUNCTION upsert_event_tag(event_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) TO cp_account;


--
-- Name: FUNCTION upsert_organization_tag(organization_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) TO cp_account;


--
-- Name: FUNCTION upsert_venue_tag(venue_row_id uuid, tag_body text); Type: ACL; Schema: app_public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) TO cp_account;


--
-- Name: FUNCTION muid_to_uuid(id text); Type: ACL; Schema: public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION public.muid_to_uuid(id text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION public.muid_to_uuid(id text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.muid_to_uuid(id text) TO cp_anonymous;
GRANT ALL ON FUNCTION public.muid_to_uuid(id text) TO cp_account;


--
-- Name: FUNCTION uuid_to_muid(id uuid); Type: ACL; Schema: public; Owner: cp_postgraphile
--

REVOKE ALL ON FUNCTION public.uuid_to_muid(id uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION public.uuid_to_muid(id uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.uuid_to_muid(id uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION public.uuid_to_muid(id uuid) TO cp_account;


REFRESH MATERIALIZED VIEW app_public.managed_page;
--
-- PostgreSQL database dump complete
--

