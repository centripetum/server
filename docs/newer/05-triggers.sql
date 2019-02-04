-- TRIGGERS
CREATE TRIGGER account_updated_at BEFORE UPDATE
  ON app_public.account FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();
CREATE TRIGGER managed_page_view_refreshed_on_event_insert_or_delete AFTER INSERT OR DELETE
  ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();
CREATE TRIGGER managed_page_view_refreshed_on_event_update AFTER UPDATE
  ON app_public.event FOR EACH ROW WHEN ((((old.slug)::text IS DISTINCT FROM (new.slug)::text)
  OR (old.parent IS DISTINCT FROM new.parent))) EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();
CREATE TRIGGER managed_page_view_refreshed_on_venue_insert_or_delete AFTER INSERT OR DELETE
  ON app_public.venue FOR EACH ROW EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();
CREATE TRIGGER managed_page_view_refreshed_on_venue_update AFTER UPDATE
  ON app_public.venue FOR EACH ROW WHEN ((((old.slug)::text IS DISTINCT FROM (new.slug)::text)
  OR (old.parent IS DISTINCT FROM new.parent))) EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();
CREATE TRIGGER managed_page_view_refreshed_on_organization_insert_or_delete AFTER INSERT OR DELETE
  ON app_public.organization FOR EACH ROW EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();
CREATE TRIGGER managed_page_view_refreshed_on_organization_update AFTER UPDATE
  ON app_public.organization FOR EACH ROW WHEN ((((old.slug)::text IS DISTINCT FROM (new.slug)::text)
  OR (old.parent IS DISTINCT FROM new.parent))) EXECUTE PROCEDURE app_public.refresh_managed_page_materialized_view();

CREATE TRIGGER delete_unused_tags_on_event_tag_deletion AFTER DELETE ON app_public.event_tag FOR EACH STATEMENT EXECUTE PROCEDURE app_private.delete_unused_tags();
CREATE TRIGGER delete_unused_tags_on_venue_tag_deletion AFTER DELETE ON app_public.venue_tag FOR EACH STATEMENT EXECUTE PROCEDURE app_private.delete_unused_tags();

CREATE TRIGGER hypertext_link_type_account BEFORE INSERT ON app_public.hypertext_link_type FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();
CREATE TRIGGER hypertext_link_type_updated_at BEFORE UPDATE ON app_public.hypertext_link_type FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();

CREATE TRIGGER hypertext_link_account BEFORE INSERT ON app_public.hypertext_link FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();
CREATE TRIGGER hypertext_link_updated_at BEFORE UPDATE ON app_public.hypertext_link FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();

CREATE TRIGGER longdesc_account BEFORE INSERT ON app_public.longdesc FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();
CREATE TRIGGER longdesc_updated_at BEFORE UPDATE ON app_public.longdesc FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();

CREATE TRIGGER image_account BEFORE INSERT ON app_public.image FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();
CREATE TRIGGER image_updated_at BEFORE UPDATE ON app_public.image FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();

CREATE TRIGGER event_account BEFORE INSERT ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();
CREATE TRIGGER event_positioned_on_insertion BEFORE INSERT ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_private.set_event_spot();
CREATE TRIGGER event_updated_at BEFORE UPDATE ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();
CREATE TRIGGER events_repositioned_on_deletion AFTER DELETE ON app_public.event FOR EACH ROW EXECUTE PROCEDURE app_private.update_event_spot_on_deletion();

CREATE TRIGGER venue_account BEFORE INSERT ON app_public.venue FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();
CREATE TRIGGER venue_positioned_on_insertion BEFORE INSERT ON app_public.venue FOR EACH ROW EXECUTE PROCEDURE app_private.set_venue_spot();
CREATE TRIGGER venue_updated_at BEFORE UPDATE ON app_public.venue FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();
CREATE TRIGGER venues_repositioned_on_deletion AFTER DELETE ON app_public.venue FOR EACH ROW EXECUTE PROCEDURE app_private.update_venue_spot_on_deletion();

CREATE TRIGGER organization_account BEFORE INSERT ON app_public.organization FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();
CREATE TRIGGER organization_positioned_on_insertion BEFORE INSERT ON app_public.organization FOR EACH ROW EXECUTE PROCEDURE app_private.set_organization_spot();
CREATE TRIGGER organization_updated_at BEFORE UPDATE ON app_public.organization FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();
CREATE TRIGGER organizations_repositioned_on_deletion AFTER DELETE ON app_public.organization FOR EACH ROW EXECUTE PROCEDURE app_private.update_organization_spot_on_deletion();

CREATE TRIGGER duration_account BEFORE INSERT ON app_public.duration FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();
CREATE TRIGGER duration_updated_at BEFORE UPDATE ON app_public.duration FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();

CREATE TRIGGER tag_account BEFORE INSERT ON app_public.tag FOR EACH ROW EXECUTE PROCEDURE app_private.set_account();
CREATE TRIGGER tag_updated_at BEFORE UPDATE ON app_public.tag FOR EACH ROW EXECUTE PROCEDURE app_private.set_updated_at();

-- UNIQUE INDEXES
CREATE UNIQUE INDEX unique_event_slug_in_parent ON app_public.event USING btree (slug, parent) WHERE (parent IS NOT NULL);
CREATE UNIQUE INDEX unique_event_slug_on_home_event ON app_public.event USING btree (slug) WHERE (parent IS NULL);
CREATE UNIQUE INDEX unique_event_spot_in_parent ON app_public.event USING btree (spot, parent);
CREATE UNIQUE INDEX unique_event_tags ON app_public.event_tag USING btree (tag_id, event_id);

CREATE UNIQUE INDEX unique_venue_slug_in_parent ON app_public.venue USING btree (slug, parent) WHERE (parent IS NOT NULL);
CREATE UNIQUE INDEX unique_venue_slug_on_home_venue ON app_public.venue USING btree (slug) WHERE (parent IS NULL);
CREATE UNIQUE INDEX unique_venue_spot_in_parent ON app_public.venue USING btree (spot, parent);
CREATE UNIQUE INDEX unique_venue_tags ON app_public.venue_tag USING btree (tag_id, venue_id);

CREATE UNIQUE INDEX unique_organization_slug_in_parent ON app_public.organization USING btree (slug, parent) WHERE (parent IS NOT NULL);
CREATE UNIQUE INDEX unique_organization_slug_on_home_organization ON app_public.organization USING btree (slug) WHERE (parent IS NULL);
CREATE UNIQUE INDEX unique_organization_spot_in_parent ON app_public.organization USING btree (spot, parent);
CREATE UNIQUE INDEX unique_organization_tags ON app_public.organization_tag USING btree (tag_id, organization_id);
