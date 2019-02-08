
-- generate UUID
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

COMMENT ON FUNCTION app_public.generate_u_u_i_d() IS 'Generates a single v1mc UUID.';

-- generate UUIDs
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

COMMENT ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) IS 'Returns an array of UUIDs of length `quantity`.';

-- uuid to muid
CREATE FUNCTION public.muid_to_uuid(id text) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  select 
    (encode(substring(bin from 9 for 9), 'hex') || encode(substring(bin from 0 for 9), 'hex'))::uuid
  from decode(translate(id, '-_', '+/') || '==', 'base64') as bin;
$$;

ALTER FUNCTION public.muid_to_uuid(id text) OWNER TO cp_postgraphile;

COMMENT ON FUNCTION public.muid_to_uuid(id text) IS 'Converts an MUID to a UUID.';

-- muid to uuid
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

COMMENT ON FUNCTION public.uuid_to_muid(id uuid) IS 'Converts a UUID to an MUID.';

-- register account
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

ALTER FUNCTION app_public.register_account(public.char_48, public.char_48, public.email, public.password) OWNER TO centripetal;

COMMENT ON FUNCTION app_public.register_account(public.char_48, public.char_48, public.email, public.password)
  IS 'Registers a user account on the app.';

-- authenticate
CREATE FUNCTION app_public.authenticate(email public.email, password public.password) RETURNS app_public.jwt_token
    LANGUAGE plpgsql STRICT SECURITY DEFINER
    AS $_$
DECLARE
  account app_private.credential;
BEGIN
  SELECT a.* INTO account
  FROM app_private.credential AS a
  WHERE a.email = $1;

  IF account.password_hash = crypt(password, account.password_hash) THEn
    RETURN ('cp_account', account.account_id)::app_public.jwt_token;
  ELSE
    RETURN NULL;
  END IF;
END;
$_$;

ALTER FUNCTION app_public.authenticate(email public.email, password public.password) OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_public.authenticate(public.email, public.password) IS 'Authenticates (signs in) an account.';

-- current account
CREATE FUNCTION app_public.current_account() RETURNS app_public.account
    LANGUAGE sql STABLE
    AS $$
  SELECT *
  FROM app_public.account
  WHERE id = current_setting('jwt.claims.account_id', true)::uuid
$$;

ALTER FUNCTION app_public.current_account() OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_public.current_account() IS 'Returns the user who was identified by the JWT.';

-- full name
CREATE FUNCTION app_public.full_name(account app_public.account) RETURNS text
    LANGUAGE sql STABLE
    AS $$
  SELECT account.given_name || ' ' || account.family_name
$$;

ALTER FUNCTION app_public.full_name(account app_public.account) OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_public.full_name(account app_public.account) IS 'Generates the full name from given and family names.';

-- set account
CREATE FUNCTION app_private.set_account() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.account := current_setting('jwt.claims.account_id', true)::uuid;
  RETURN new;
END;
$$;

ALTER FUNCTION app_private.set_account() OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_private.set_account() IS 'Sets the account that created a record (triggered).';

-- set created by
CREATE FUNCTION app_private.set_created_by() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.created_by := current_setting('jwt.claims.account_id', true)::integer;
  RETURN new;
END;
$$;

ALTER FUNCTION app_private.set_created_by() OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_private.set_account() IS 'Sets the account that created a record (triggered).';

-- set updated at
CREATE FUNCTION app_private.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.updated_at := current_timestamp;
  RETURN new;
END;
$$;

ALTER FUNCTION app_private.set_updated_at() OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_private.set_updated_at() IS 'Sets the updated at timestamp for a record (on trigger).';

-- set event spot
CREATE FUNCTION app_private.set_event_spot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.spot := app_public.get_event_count_by_parent_id(new.parent)::integer;
  return new;
END;
$$;

ALTER FUNCTION app_private.set_event_spot() OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_private.set_event_spot() IS 'Sets the spot for inserted events to the last child for that parent.';

-- set venue spot
CREATE FUNCTION app_private.set_venue_spot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.spot := app_public.get_venue_count_by_parent_id(new.parent)::integer;
  return new;
END;
$$;

ALTER FUNCTION app_private.set_venue_spot() OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_private.set_venue_spot() IS 'Sets the spot for inserted venues to the last child for that parent.';

-- set organization spot
CREATE FUNCTION app_private.set_organization_spot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.spot := app_public.get_organization_count_by_parent_id(new.parent)::integer;
  return new;
END;
$$;

ALTER FUNCTION app_private.set_organization_spot() OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_private.set_organization_spot() IS 'Sets the spot for inserted organizations to the last child for that parent.';

-- update event spot on deletion
CREATE FUNCTION app_private.update_event_spot_on_deletion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE app_public.event SET spot = spot - 1 WHERE spot > OLD.spot AND parent = OLD.parent;
        RETURN NULL;
    END;
$$;

ALTER FUNCTION app_private.update_event_spot_on_deletion() OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_private.update_event_spot_on_deletion() IS 'Resets event spots to remove a gap on event deletion.';

-- update venue spot on deletion
CREATE FUNCTION app_private.update_venue_spot_on_deletion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE app_public.venue SET spot = spot - 1 WHERE spot > OLD.spot AND parent = OLD.parent;
        RETURN NULL;
    END;
$$;

ALTER FUNCTION app_private.update_venue_spot_on_deletion() OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_private.update_venue_spot_on_deletion() IS 'Resets venue spots to remove a gap on venue deletion.';

-- update organization spot on deletion
CREATE FUNCTION app_private.update_organization_spot_on_deletion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE app_public.organization SET spot = spot - 1 WHERE spot > OLD.spot AND parent = OLD.parent;
        RETURN NULL;
    END;
$$;

ALTER FUNCTION app_private.update_organization_spot_on_deletion() OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_private.update_organization_spot_on_deletion() IS 'Resets organization spots to remove a gap on organization deletion.';

-- upsert tag
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

COMMENT ON FUNCTION app_private.upsert_tag(tag_body text) IS 'Inserts a tag unless it already exists and returns the tag id.';

-- delete unused tags
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

COMMENT ON FUNCTION app_private.delete_unused_tags() IS 'Deletes any unused tags.';

-- child paths by parent path and depth
CREATE FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) RETURNS text[]
    LANGUAGE sql STABLE
    AS $_$
    SELECT array_agg(full_path) AS child_paths
    FROM app_private.full_path
    WHERE full_path like $1 || '%'
    AND depth = $2;
$_$;

ALTER FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer)
  IS 'Generates an array of full_paths to children using the parent_path.';

-- get event count by parent id
CREATE FUNCTION app_public.get_event_count_by_parent_id(uuid) RETURNS bigint
    LANGUAGE sql
    AS $_$
  SELECT count(id) AS RESULT FROM app_public.event WHERE parent = $1;
$_$;

ALTER FUNCTION app_public.get_event_count_by_parent_id(uuid) OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_public.get_event_count_by_parent_id(uuid) IS 'Returns the number of children this event has.';

-- get venue count by parent id
CREATE FUNCTION app_public.get_venue_count_by_parent_id(uuid) RETURNS bigint
    LANGUAGE sql
    AS $_$
  SELECT count(id) AS RESULT FROM app_public.venue WHERE parent = $1;
$_$;

ALTER FUNCTION app_public.get_venue_count_by_parent_id(uuid) OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) IS 'Returns the number of children this venue has.';

-- get organization count by parent id
CREATE FUNCTION app_public.get_organization_count_by_parent_id(uuid) RETURNS bigint
    LANGUAGE sql
    AS $_$
  SELECT count(id) AS RESULT FROM app_public.organization WHERE parent = $1;
$_$;

ALTER FUNCTION app_public.get_organization_count_by_parent_id(uuid) OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) IS 'Returns the number of children this organization has.';

 -- move event down
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

COMMENT ON FUNCTION app_public.move_event_down(uuid) IS 'Moves the event with specified id down one spot if not last child.';

-- move event up
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

COMMENT ON FUNCTION app_public.move_event_up(uuid) IS 'Moves the event with specified id up one spot if not first child.';

-- move venue down
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

COMMENT ON FUNCTION app_public.move_venue_down(uuid) IS 'Moves the venue with specified id down one spot if not last child.';

-- move venue up
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

COMMENT ON FUNCTION app_public.move_venue_up(uuid) IS 'Moves the venue with specified id up one spot if not first child.';

-- move organization down
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

COMMENT ON FUNCTION app_public.move_organization_down(uuid) IS 'Moves the organization with specified id down one spot if not last child.';

-- move organization up
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

COMMENT ON FUNCTION app_public.move_organization_up(uuid) IS 'Moves the organization with specified id up one spot if not first child.';

-- upsert event tag
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

COMMENT ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text)
  IS 'Inserts a tag unless it already exists and links it to a specified event.';

-- upsert venue tag
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

COMMENT ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text)
  IS 'Inserts a tag unless it already exists and links it to a specified venue.';

-- upsert organization tag
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

COMMENT ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text)
  IS 'Inserts a tag unless it already exists and links it to a specified organization.';

-- remove tag from event
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

COMMENT ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text)
  IS 'Deletes an edge between a event and a tag and refreshes the full_event view.';

-- remove tag from venue
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

COMMENT ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text)
  IS 'Deletes an edge between a venue and a tag and refreshes the full_venue view.';

-- remove tag from organization
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

COMMENT ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text)
  IS 'Deletes an edge between a organization and a tag and refreshes the full_organization view.';

-- refresh manage page materialized view
CREATE FUNCTION app_public.refresh_managed_page_materialized_view() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY app_public.managed_page;
  RETURN null;
END;
$$;

ALTER FUNCTION app_public.refresh_managed_page_materialized_view() OWNER TO cp_postgraphile;

COMMENT ON FUNCTION app_public.refresh_managed_page_materialized_view()
  IS 'Automatically refreshes the managed_page view on inserts, updates, and deletions of page, zone, track, etc.';
