-- ROW LEVEL SECURITY
ALTER TABLE app_public.account ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.hypertext_link_type ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.hypertext_link ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.longdesc ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.image ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.event ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.venue ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.organization ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.duration ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.tag ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.event_tag ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.venue_tag ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.organization_tag ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.event_hypertext_link ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.venue_hypertext_link ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_public.organization_hypertext_link ENABLE ROW LEVEL SECURITY;

-- POLICIES
CREATE POLICY delete_account ON app_public.account FOR DELETE TO cp_account USING ((id = (current_setting('jwt.claims.account_id'::text, true))::uuid));
CREATE POLICY select_account ON app_public.account FOR SELECT USING (true);
CREATE POLICY update_account ON app_public.account FOR UPDATE TO cp_account USING ((id = (current_setting('jwt.claims.account_id'::text, true))::uuid));

-- USAGE
GRANT USAGE ON SCHEMA app_public TO cp_anonymous;
GRANT USAGE ON SCHEMA app_public TO cp_account;

GRANT ALL ON SCHEMA public TO PUBLIC;

-- SELECT POLICIES
CREATE POLICY select_hypertext_link_type ON app_public.hypertext_link_type FOR SELECT USING (true);
CREATE POLICY select_hypertext_link ON app_public.hypertext_link FOR SELECT USING (true);
CREATE POLICY select_longdesc ON app_public.longdesc FOR SELECT USING (true);
CREATE POLICY select_image ON app_public.image FOR SELECT USING (true);
CREATE POLICY select_event ON app_public.event FOR SELECT USING (true);
CREATE POLICY select_venue ON app_public.venue FOR SELECT USING (true);
CREATE POLICY select_organiztion ON app_public.organization FOR SELECT USING (true);
CREATE POLICY select_duration ON app_public.duration FOR SELECT USING (true);
CREATE POLICY select_tag ON app_public.tag FOR SELECT USING (true);
CREATE POLICY select_event_tag ON app_public.event_tag FOR SELECT USING (true);
CREATE POLICY select_venue_tag ON app_public.venue_tag FOR SELECT USING (true);
CREATE POLICY select_organization_tag ON app_public.organization_tag FOR SELECT USING (true);
CREATE POLICY select_event_hypertext_link ON app_public.event_hypertext_link FOR SELECT USING (true);
CREATE POLICY select_venue_hypertext_link ON app_public.venue_hypertext_link FOR SELECT USING (true);
CREATE POLICY select_organization_hypertext_link ON app_public.organization_hypertext_link FOR SELECT USING (true);

-- PERMISSIONS
GRANT SELECT ON TABLE app_public.account TO cp_anonymous;
GRANT SELECT,DELETE,UPDATE ON TABLE app_public.account TO cp_account;

GRANT SELECT ON TABLE app_public.account TO cp_account;


GRANT SELECT ON TABLE app_public.account TO cp_account;
GRANT SELECT ON TABLE app_public.hypertext_link_type TO cp_anonymous;
GRANT SELECT ON TABLE app_public.hypertext_link TO cp_anonymous;
GRANT SELECT ON TABLE app_public.longdesc TO cp_anonymous;
GRANT SELECT ON TABLE app_public.image TO cp_anonymous;
GRANT SELECT ON TABLE app_public.event TO cp_anonymous;
GRANT SELECT ON TABLE app_public.venue TO cp_anonymous;
GRANT SELECT ON TABLE app_public.organization TO cp_anonymous;
GRANT SELECT ON TABLE app_public.duration TO cp_anonymous;
GRANT SELECT ON TABLE app_public.tag TO cp_anonymous;
GRANT SELECT ON TABLE app_public.event_tag TO cp_anonymous;
GRANT SELECT ON TABLE app_public.venue_tag TO cp_anonymous;
GRANT SELECT ON TABLE app_public.organization_tag TO cp_anonymous;
GRANT SELECT ON TABLE app_public.event_hypertext_link TO cp_anonymous;
GRANT SELECT ON TABLE app_public.venue_hypertext_link TO cp_anonymous;
GRANT SELECT ON TABLE app_public.organization_hypertext_link TO cp_anonymous;
GRANT SELECT ON TABLE app_public.managed_page TO cp_anonymous;

-- GRANT FUNCTION PERMISSIONS
REVOKE ALL ON FUNCTION
    app_public.register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password)
    FROM cp_postgraphile;
GRANT ALL ON FUNCTION
  app_public.register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password)
  TO cp_postgraphile
  WITH GRANT OPTION;

REVOKE ALL ON FUNCTION app_public.generate_u_u_i_d() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_d() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_d() TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_d() TO cp_account;

REVOKE ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.generate_u_u_i_ds(quantity integer) TO cp_account;

REVOKE ALL ON FUNCTION public.muid_to_uuid(id text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION public.muid_to_uuid(id text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.muid_to_uuid(id text) TO cp_anonymous;
GRANT ALL ON FUNCTION public.muid_to_uuid(id text) TO cp_account;

REVOKE ALL ON FUNCTION public.uuid_to_muid(id uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION public.uuid_to_muid(id uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION public.uuid_to_muid(id uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION public.uuid_to_muid(id uuid) TO cp_account;

GRANT ALL ON FUNCTION
  app_public.register_account(given_name public.char_48, family_name public.char_48, email public.email, password public.password)
  TO cp_anonymous;

REVOKE ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.authenticate(email public.email, password public.password) TO cp_account;

REVOKE ALL ON FUNCTION app_public.current_account() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.current_account() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.current_account() TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.current_account() TO cp_account;

REVOKE ALL ON FUNCTION app_public.full_name(account app_public.account) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.full_name(account app_public.account) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.full_name(account app_public.account) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.full_name(account app_public.account) TO cp_account;

REVOKE ALL ON FUNCTION app_private.set_account() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_account() TO cp_postgraphile WITH GRANT OPTION;

REVOKE ALL ON FUNCTION app_private.set_created_by() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_created_by() TO cp_postgraphile WITH GRANT OPTION;

REVOKE ALL ON FUNCTION app_private.set_updated_at() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_updated_at() TO cp_postgraphile WITH GRANT OPTION;

REVOKE ALL ON FUNCTION app_private.set_event_spot() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_event_spot() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.set_event_spot() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.set_event_spot() TO cp_account;

REVOKE ALL ON FUNCTION app_private.set_venue_spot() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_venue_spot() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.set_venue_spot() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.set_venue_spot() TO cp_account;

REVOKE ALL ON FUNCTION app_private.set_organization_spot() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.set_organization_spot() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.set_organization_spot() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.set_organization_spot() TO cp_account;

REVOKE ALL ON FUNCTION app_private.update_event_spot_on_deletion() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.update_event_spot_on_deletion() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.update_event_spot_on_deletion() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.update_event_spot_on_deletion() TO cp_account;

REVOKE ALL ON FUNCTION app_private.update_venue_spot_on_deletion() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.update_venue_spot_on_deletion() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.update_venue_spot_on_deletion() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.update_venue_spot_on_deletion() TO cp_account;

REVOKE ALL ON FUNCTION app_private.update_organization_spot_on_deletion() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.update_organization_spot_on_deletion() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.update_organization_spot_on_deletion() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.update_organization_spot_on_deletion() TO cp_account;

REVOKE ALL ON FUNCTION app_private.upsert_tag(tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.upsert_tag(tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.upsert_tag(tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.upsert_tag(tag_body text) TO cp_account;

REVOKE ALL ON FUNCTION app_private.delete_unused_tags() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_private.delete_unused_tags() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_private.delete_unused_tags() TO cp_anonymous;
GRANT ALL ON FUNCTION app_private.delete_unused_tags() TO cp_account;

REVOKE ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.child_paths_by_parent_path_and_depth(parent_path text, depth integer) TO cp_account;

REVOKE ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.get_event_count_by_parent_id(uuid) TO cp_account;

REVOKE ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.get_venue_count_by_parent_id(uuid) TO cp_account;

REVOKE ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.get_organization_count_by_parent_id(uuid) TO cp_account;

REVOKE ALL ON FUNCTION app_public.move_event_down(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_event_down(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_event_down(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_event_down(uuid) TO cp_account;

REVOKE ALL ON FUNCTION app_public.move_event_up(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_event_up(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_event_up(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_event_up(uuid) TO cp_account;

REVOKE ALL ON FUNCTION app_public.move_venue_down(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_venue_down(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_venue_down(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_venue_down(uuid) TO cp_account;

REVOKE ALL ON FUNCTION app_public.move_venue_up(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_venue_up(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_venue_up(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_venue_up(uuid) TO cp_account;

REVOKE ALL ON FUNCTION app_public.move_organization_down(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_organization_down(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_organization_down(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_organization_down(uuid) TO cp_account;

REVOKE ALL ON FUNCTION app_public.move_organization_up(uuid) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.move_organization_up(uuid) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.move_organization_up(uuid) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.move_organization_up(uuid) TO cp_account;

REVOKE ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.upsert_event_tag(event_row_id uuid, tag_body text) TO cp_account;

REVOKE ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.upsert_venue_tag(venue_row_id uuid, tag_body text) TO cp_account;

REVOKE ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.upsert_organization_tag(organization_row_id uuid, tag_body text) TO cp_account;

REVOKE ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.remove_tag_from_event(event_row_id uuid, tag_body text) TO cp_account;

REVOKE ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.remove_tag_from_venue(venue_row_id uuid, tag_body text) TO cp_account;

REVOKE ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.remove_tag_from_organization(organization_row_id uuid, tag_body text) TO cp_account;

REVOKE ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() FROM cp_postgraphile;
GRANT ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() TO cp_postgraphile WITH GRANT OPTION;
GRANT ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() TO cp_anonymous;
GRANT ALL ON FUNCTION app_public.refresh_managed_page_materialized_view() TO cp_account;

REFRESH MATERIALIZED VIEW app_public.managed_page;