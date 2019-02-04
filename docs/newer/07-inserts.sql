INSERT INTO app_public.account (id, given_name, family_name, bio, created_at, updated_at)
  VALUES ('692504d6-ce6a-11e8-ac21-97703d4c9b95', 'Bob', 'Dobbs', NULL, '2018-10-13 11:01:46.059872+13', '2018-10-13 11:07:15.066393+13');

INSERT INTO app_private.credential (account_id, email, password_hash, authorities)
  VALUES ('692504d6-ce6a-11e8-ac21-97703d4c9b95', 'bobdobbs@munat.com', '$2a$06$o3hBzSQqkjBbxSBVeiijhePXMXr4RJVINWv1wezWPyA4SpXpMDPJq', '{}');

INSERT INTO app_public.event (
      slug
    , link_label
    , link_description
    , title
    , content
    , image
    , spot
    , parent
    , account
) VALUES (
      'nzjs-conf-2019' -- slug text
    , 'NZ.js Conf 2019' -- link_label text
    , 'The New Zealand JavaScript Conference for 2019' -- link_description text
    , 'NZ.js Conf 2019' -- title text
    , '<p>This is gonna be a hell of a conference!</p>' -- content xml NULLABLE
    , NULL -- image uuid NULLABLE
    , 0 -- spot integer
    , NULL -- parent uuid NULLABLE
    , '7580edf4-cf54-11e8-ac21-bb299c8d21cf' -- account uuid NULLABLE
);
