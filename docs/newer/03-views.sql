-- PATH RELATIONSHIP
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

COMMENT ON VIEW app_private.path_relationship IS 'Derives the parent-child edges for the event/venue (page) tree.';

-- FULL PATH
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

COMMENT ON VIEW app_private.full_path IS 'Recurses through the page tree to derive the full URL path for each event, venue, etc.';
-- FULL EVENT
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

COMMENT ON VIEW app_private.full_event IS 'Provides a view of each event with the full URL path and an array of associated tags.';

-- FULL VENUE
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

COMMENT ON VIEW app_private.full_venue IS 'Provides a view of each venue with the full URL path and an array of associated tags.';

-- FULL ORGANIZATION
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

COMMENT ON VIEW app_private.full_organization IS 'Provides a view of each organization with the full URL path and an array of associated tags.';

-- TAG USE COUNT
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

COMMENT ON VIEW app_private.tag_use_count IS 'Returns a count of the total events, venues, etc. with which a tag is associated.';

-- MANAGED PAGE (MATERIALIZED)
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

ALTER MATERIALIZED VIEW app_public.managed_page OWNER TO cp_postgraphile;

CREATE UNIQUE INDEX unique_managed_page ON app_public.managed_page USING btree (full_path);

COMMENT ON MATERIALIZED VIEW app_public.managed_page IS 'Provides a view into all generated site pages (events, venues, organizations, etc.).';


