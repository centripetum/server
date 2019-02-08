-- ACCOUNT
CREATE TABLE app_public.account (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    bio text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    given_name public.char_48,
    family_name public.char_48
);

ALTER TABLE app_public.account OWNER TO cp_postgraphile;

COMMENT ON TABLE app_public.account IS 'An account (user) for the Centripetal app.';
COMMENT ON COLUMN app_public.account.id IS 'The primary unique ID for this account.';
COMMENT ON COLUMN app_public.account.bio IS 'A brief bio for this account.';
COMMENT ON COLUMN app_public.account.created_at IS 'The date and time this account was created.';
COMMENT ON COLUMN app_public.account.updated_at IS 'The date and time this account was last updated.';

ALTER TABLE ONLY app_public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);

-- CREDENTIAL
CREATE TABLE app_private.credential (
    account_id uuid NOT NULL,
    email text NOT NULL,
    password_hash text NOT NULL,
    authorities app_private.authority[] DEFAULT ARRAY[]::app_private.authority[],
    CONSTRAINT credential_email_check CHECK ((email ~* '^.+@.+\..+$'::text))
);

ALTER TABLE app_private.credential OWNER TO cp_postgraphile;

COMMENT ON TABLE app_private.credential IS 'Private information about a user''s account.';
COMMENT ON COLUMN app_private.credential.account_id IS 'The id of the user associated with this account.';
COMMENT ON COLUMN app_private.credential.email IS 'The email address of the user.';
COMMENT ON COLUMN app_private.credential.password_hash IS 'An opague hash of the user''s password.';

ALTER TABLE ONLY app_private.credential
    ADD CONSTRAINT credential_pkey PRIMARY KEY (account_id);

ALTER TABLE ONLY app_private.credential
    ADD CONSTRAINT credential_email_key UNIQUE (email);

ALTER TABLE ONLY app_private.credential
    ADD CONSTRAINT credential_account_id_fkey FOREIGN KEY (account_id) REFERENCES app_public.account(id) ON DELETE CASCADE;

-- HYPERTEXT LINK TYPE
CREATE TABLE app_public.hypertext_link_type (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    name public.char_48 NOT NULL,
    account uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE app_public.hypertext_link_type OWNER TO cp_postgraphile;

COMMENT ON TABLE app_public.hypertext_link_type IS 'Categories for hypertext links used by events, venues, etc.';
COMMENT ON COLUMN app_public.hypertext_link_type.id IS 'The primary key for this hypertext link type.';
COMMENT ON COLUMN app_public.hypertext_link_type.name IS 'The unique name for this hypertext link type.';
COMMENT ON COLUMN app_public.hypertext_link_type.account IS 'The id of the account that created this hypertext link type.';
COMMENT ON COLUMN app_public.hypertext_link_type.created_at IS 'The date and time this hypertext link type was created.';
COMMENT ON COLUMN app_public.hypertext_link_type.updated_at IS 'The date and time this hypertext link type was last updated.';

ALTER TABLE ONLY app_public.hypertext_link_type
    ADD CONSTRAINT hypertext_link_type_pkey PRIMARY KEY (id);

ALTER TABLE ONLY app_public.hypertext_link_type
    ADD CONSTRAINT hypertext_link_type_name_key UNIQUE (name);

ALTER TABLE ONLY app_public.hypertext_link_type
    ADD CONSTRAINT hypertext_link_type_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);

-- HYPERTEXT LINK
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

COMMENT ON TABLE app_public.hypertext_link IS 'A hypertext link added by an account holder.';
COMMENT ON COLUMN app_public.hypertext_link.id IS 'The primary key for this hypertext link.';
COMMENT ON COLUMN app_public.hypertext_link.url IS 'The URL associated with this hypertext link.';
COMMENT ON COLUMN app_public.hypertext_link.hypertext_link_type IS 'The id of the hypertext link type associated with this URL.';
COMMENT ON COLUMN app_public.hypertext_link.account IS 'The id of the account that created this hypertext_link.';
COMMENT ON COLUMN app_public.hypertext_link.created_at IS 'The date and time this hypertext link was created.';
COMMENT ON COLUMN app_public.hypertext_link.updated_at IS 'The date and time this hypertext link was last updated.';

ALTER TABLE ONLY app_public.hypertext_link
    ADD CONSTRAINT hypertext_link_pkey PRIMARY KEY (id);

ALTER TABLE ONLY app_public.hypertext_link
    ADD CONSTRAINT hypertext_link_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);

ALTER TABLE ONLY app_public.hypertext_link
    ADD CONSTRAINT hypertext_link_hypertext_link_type_fkey FOREIGN KEY (hypertext_link_type) REFERENCES app_public.hypertext_link_type(id);

-- LONGDESC
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

COMMENT ON TABLE app_public.longdesc IS 'A image longdesc uploaded by an account holder.';
COMMENT ON COLUMN app_public.longdesc.id IS 'The primary key for this longdesc.';
COMMENT ON COLUMN app_public.longdesc.slug IS 'The unique-for-this-path, plain text, train-case "slug" used in the page URL.';
COMMENT ON COLUMN app_public.longdesc.link_label IS 'The plain text label used for links to this longdesc.';
COMMENT ON COLUMN app_public.longdesc.link_description IS 'A plain text description of this longdesc used in links and tables of content.';
COMMENT ON COLUMN app_public.longdesc.title IS 'The plain text title of the longdesc page as seen in the tab and the page header.';
COMMENT ON COLUMN app_public.longdesc.url IS 'The URL at which this longdesc may be found (if external).';
COMMENT ON COLUMN app_public.longdesc.content IS 'XHTML content of the longdesc (if internal).';
COMMENT ON COLUMN app_public.longdesc.account IS 'The id of the account that created this longdesc.';
COMMENT ON COLUMN app_public.longdesc.created_at IS 'The date and time this longdesc was created.';
COMMENT ON COLUMN app_public.longdesc.updated_at IS 'The date and time this longdesc was last updated.';

ALTER TABLE ONLY app_public.longdesc
    ADD CONSTRAINT longdesc_pkey PRIMARY KEY (id);

ALTER TABLE ONLY app_public.longdesc
    ADD CONSTRAINT longdesc_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);

-- IMAGE
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

COMMENT ON TABLE app_public.image IS 'A site image uploaded by an account holder.';
COMMENT ON COLUMN app_public.image.id IS 'The primary key for this image.';
COMMENT ON COLUMN app_public.image.url IS 'The URL at which this image may be found.';
COMMENT ON COLUMN app_public.image.alt IS 'Alternative text for this image (for accessibility).';
COMMENT ON COLUMN app_public.image.image_type IS 'The media type for this image (e.g, image/png).';
COMMENT ON COLUMN app_public.image.account IS 'The id of the account that created this image.';
COMMENT ON COLUMN app_public.image.created_at IS 'The date and time this image was created.';
COMMENT ON COLUMN app_public.image.updated_at IS 'The date and time this image was last updated.';

ALTER TABLE ONLY app_public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);

ALTER TABLE ONLY app_public.image
    ADD CONSTRAINT image_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);

ALTER TABLE ONLY app_public.image
    ADD CONSTRAINT image_longdesc_fkey FOREIGN KEY (longdesc) REFERENCES app_public.longdesc(id);

-- EVENT
CREATE TABLE app_public.event (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    slug public.char_64 DEFAULT ''::text NOT NULL CHECK (slug::text ~* '^[a-z0-9]+(\-([a-z0-9])+)*$'::text),
    link_label public.char_32 NOT NULL,
    link_description public.char_256 NOT NULL,
    title public.char_64 NOT NULL,
    content public.x_h_t_m_l,
    image uuid,
    spot integer DEFAULT 0 NOT NULL,
    parent uuid,
    account uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE app_public.event OWNER TO cp_postgraphile;

COMMENT ON TABLE app_public.event IS 'An event with XHTML content, etc.';
COMMENT ON COLUMN app_public.event.id IS 'The primary key for this event.';
COMMENT ON COLUMN app_public.event.slug IS 'The unique-for-this-path, plain text, train-case "slug" used in the event page URL.';
COMMENT ON COLUMN app_public.event.link_label IS 'The plain text label used for links to this event.';
COMMENT ON COLUMN app_public.event.link_description IS 'A plain text description of this event used in links and tables of content.';
COMMENT ON COLUMN app_public.event.title IS 'The plain text title of the event as seen in the tab and the page header.';
COMMENT ON COLUMN app_public.event.content IS 'XHTML content about the event.';
COMMENT ON COLUMN app_public.event.image IS 'An Image associated with this event (an icon, perhaps).';
COMMENT ON COLUMN app_public.event.spot IS 'The position of this event among its siblings.';
COMMENT ON COLUMN app_public.event.parent IS 'The id of the parent event to this event.';
COMMENT ON COLUMN app_public.event.account IS 'The id of the account holder that created this event.';
COMMENT ON COLUMN app_public.event.created_at IS 'The date and time this event was created.';
COMMENT ON COLUMN app_public.event.updated_at IS 'The date and time this event was last updated.';

ALTER TABLE ONLY app_public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);

ALTER TABLE ONLY app_public.event
    ADD CONSTRAINT event_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);

ALTER TABLE ONLY app_public.event
    ADD CONSTRAINT event_image_fkey FOREIGN KEY (image) REFERENCES app_public.image(id);

-- VENUE
CREATE TABLE app_public.venue (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    slug public.char_64 DEFAULT ''::text NOT NULL CHECK (slug::text ~* '^[a-z0-9]+(\-([a-z0-9])+)*$'::text),
    link_label public.char_32 NOT NULL,
    link_description public.char_256 NOT NULL,
    title public.char_64 NOT NULL,
    content public.x_h_t_m_l,
    image uuid,
    spot integer DEFAULT 0 NOT NULL,
    parent uuid,
    account uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE app_public.venue OWNER TO cp_postgraphile;

COMMENT ON TABLE app_public.venue IS 'An venue with XHTML content, etc.';
COMMENT ON COLUMN app_public.venue.id IS 'The primary key for this venue.';
COMMENT ON COLUMN app_public.venue.slug IS 'The unique-for-this-path, plain text, train-case "slug" used in the venue page URL.';
COMMENT ON COLUMN app_public.venue.link_label IS 'The plain text label used for links to this venue.';
COMMENT ON COLUMN app_public.venue.link_description IS 'A plain text description of this venue used in links and tables of content.';
COMMENT ON COLUMN app_public.venue.title IS 'The plain text title of the venue as seen in the tab and the page header.';
COMMENT ON COLUMN app_public.venue.content IS 'XHTML content about the venue.';
COMMENT ON COLUMN app_public.venue.image IS 'An Image associated with this venue (an icon, perhaps).';
COMMENT ON COLUMN app_public.venue.spot IS 'The position of this venue among its siblings.';
COMMENT ON COLUMN app_public.venue.parent IS 'The id of the parent venue to this venue.';
COMMENT ON COLUMN app_public.venue.account IS 'The id of the account holder that created this venue.';
COMMENT ON COLUMN app_public.venue.created_at IS 'The date and time this venue was created.';
COMMENT ON COLUMN app_public.venue.updated_at IS 'The date and time this venue was last updated.';

ALTER TABLE ONLY app_public.venue
    ADD CONSTRAINT venue_pkey PRIMARY KEY (id);

ALTER TABLE ONLY app_public.venue
    ADD CONSTRAINT venue_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);

ALTER TABLE ONLY app_public.venue
    ADD CONSTRAINT venue_image_fkey FOREIGN KEY (image) REFERENCES app_public.image(id);

-- ORGANIZATION
CREATE TABLE app_public.organization (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    slug public.char_64 DEFAULT ''::text NOT NULL CHECK (slug::text ~* '^[a-z0-9]+(\-([a-z0-9])+)*$'::text),
    link_label public.char_32 NOT NULL,
    link_description public.char_256 NOT NULL,
    title public.char_64 NOT NULL,
    content public.x_h_t_m_l,
    image uuid,
    spot integer DEFAULT 0 NOT NULL,
    parent uuid,
    account uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE app_public.organization OWNER TO cp_postgraphile;

COMMENT ON TABLE app_public.organization IS 'An organization with XHTML content, etc.';
COMMENT ON COLUMN app_public.organization.id IS 'The primary key for this organization.';
COMMENT ON COLUMN app_public.organization.slug IS 'The unique-for-this-path, plain text, train-case "slug" used in the organization page URL.';
COMMENT ON COLUMN app_public.organization.link_label IS 'The plain text label used for links to this organization.';
COMMENT ON COLUMN app_public.organization.link_description IS 'A plain text description of this organization used in links and tables of content.';
COMMENT ON COLUMN app_public.organization.title IS 'The plain text title of the organization as seen in the tab and the page header.';
COMMENT ON COLUMN app_public.organization.content IS 'XHTML content about the organization.';
COMMENT ON COLUMN app_public.organization.image IS 'An Image associated with this organization (an icon, perhaps).';
COMMENT ON COLUMN app_public.organization.spot IS 'The position of this organization among its siblings.';
COMMENT ON COLUMN app_public.organization.parent IS 'The id of the parent organization to this organization.';
COMMENT ON COLUMN app_public.organization.account IS 'The id of the account holder that created this organization.';
COMMENT ON COLUMN app_public.organization.created_at IS 'The date and time this organization was created.';
COMMENT ON COLUMN app_public.organization.updated_at IS 'The date and time this organization was last updated.';

ALTER TABLE ONLY app_public.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);

ALTER TABLE ONLY app_public.organization
    ADD CONSTRAINT organization_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);

ALTER TABLE ONLY app_public.organization
    ADD CONSTRAINT organization_image_fkey FOREIGN KEY (image) REFERENCES app_public.image(id);

-- DURATION
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

COMMENT ON TABLE app_public.duration IS 'A site duration uploaded by an account holder.';
COMMENT ON COLUMN app_public.duration.id IS 'The primary key for this duration.';
COMMENT ON COLUMN app_public.duration.begins_at IS 'The date and time at which this duration begins.';
COMMENT ON COLUMN app_public.duration.ends_at IS 'The date and time at which this duration ends.';
COMMENT ON COLUMN app_public.duration.rrule IS 'The icalendar rrule for recurrence of this duration.';
COMMENT ON COLUMN app_public.duration.account IS 'The id of the account that created this duration.';
COMMENT ON COLUMN app_public.duration.created_at IS 'The date and time this duration was created.';
COMMENT ON COLUMN app_public.duration.updated_at IS 'The date and time this duration was last updated.';

ALTER TABLE ONLY app_public.duration
    ADD CONSTRAINT duration_pkey PRIMARY KEY (id);

ALTER TABLE ONLY app_public.duration
    ADD CONSTRAINT duration_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);

ALTER TABLE ONLY app_public.duration
    ADD CONSTRAINT duration_event_fkey FOREIGN KEY (event) REFERENCES app_public.event(id);

-- TAG
CREATE TABLE app_public.tag (
    id uuid DEFAULT public.uuid_generate_v1mc() NOT NULL,
    body text NOT NULL,
    account uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT tag_body_check CHECK ((char_length(body) <= 32))
);

ALTER TABLE app_public.tag OWNER TO cp_postgraphile;

CREATE UNIQUE INDEX unique_lowercase_body_in_tag ON app_public.tag USING btree (lower(body));

COMMENT ON TABLE app_public.tag IS 'A tag created by an account holder.';
COMMENT ON COLUMN app_public.tag.id IS 'The primary key for this tag.';
COMMENT ON COLUMN app_public.tag.body IS 'The textual content of this tag.';
COMMENT ON COLUMN app_public.tag.account IS 'The id of the account that created this tag.';
COMMENT ON COLUMN app_public.tag.created_at IS 'The date and time this tag was created.';
COMMENT ON COLUMN app_public.tag.updated_at IS 'The date and time this tag was last updated.';

ALTER TABLE ONLY app_public.tag
    ADD CONSTRAINT tag_account_fkey FOREIGN KEY (account) REFERENCES app_public.account(id);

ALTER TABLE ONLY app_public.tag
    ADD CONSTRAINT tag_body_key UNIQUE (body);

ALTER TABLE ONLY app_public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);

-- EVENT TAG
CREATE TABLE app_public.event_tag (
    tag_id uuid NOT NULL,
    event_id uuid NOT NULL
);

ALTER TABLE app_public.event_tag OWNER TO cp_postgraphile;

COMMENT ON COLUMN app_public.event_tag.tag_id IS 'A tag assigned to this event.';
COMMENT ON COLUMN app_public.event_tag.event_id IS 'A event to which this tag is assigned.';

-- VENUE TAG
CREATE TABLE app_public.venue_tag (
    tag_id uuid NOT NULL,
    venue_id uuid NOT NULL
);

ALTER TABLE app_public.venue_tag OWNER TO cp_postgraphile;

COMMENT ON COLUMN app_public.venue_tag.tag_id IS 'A tag assigned to this venue.';
COMMENT ON COLUMN app_public.venue_tag.venue_id IS 'A venue to which this tag is assigned.';

-- ORGANIZATION TAG
CREATE TABLE app_public.organization_tag (
    tag_id uuid NOT NULL,
    organization_id uuid NOT NULL
);

ALTER TABLE app_public.organization_tag OWNER TO cp_postgraphile;

COMMENT ON COLUMN app_public.organization_tag.tag_id IS 'A tag assigned to this organization.';
COMMENT ON COLUMN app_public.organization_tag.organization_id IS 'A organization to which this tag is assigned.';

-- EVENT HYPERTEXT LINK
CREATE TABLE app_public.event_hypertext_link (
    hypertext_link_id uuid NOT NULL,
    event_id uuid NOT NULL
);

ALTER TABLE app_public.event_hypertext_link OWNER TO cp_postgraphile;

COMMENT ON COLUMN app_public.event_hypertext_link.hypertext_link_id IS 'A hypertext link assigned to this event.';
COMMENT ON COLUMN app_public.event_hypertext_link.event_id IS 'A event to which this hypertext link is assigned.';

-- VENUE HYPERTEXT LINK
CREATE TABLE app_public.venue_hypertext_link (
    hypertext_link_id uuid NOT NULL,
    venue_id uuid NOT NULL
);

ALTER TABLE app_public.venue_hypertext_link OWNER TO cp_postgraphile;

COMMENT ON COLUMN app_public.venue_hypertext_link.hypertext_link_id IS 'A hypertext link assigned to this venue.';
COMMENT ON COLUMN app_public.venue_hypertext_link.venue_id IS 'A venue to which this hypertext link is assigned.';


-- ORGANIZATION HYPERTEXT LINK
CREATE TABLE app_public.organization_hypertext_link (
    hypertext_link_id uuid NOT NULL,
    organization_id uuid NOT NULL
);

ALTER TABLE app_public.organization_hypertext_link OWNER TO cp_postgraphile;

COMMENT ON COLUMN app_public.organization_hypertext_link.hypertext_link_id IS 'A hypertext link assigned to this organization.';
COMMENT ON COLUMN app_public.organization_hypertext_link.organization_id IS 'A organization to which this hypertext link is assigned.';

