-- Walk Club LV — reset direct messages (clears crossed name-based identities).
-- Profiles, photos, posts, and members are all kept. Everyone's DM threads
-- start fresh; new DMs use the corrected full-name identity.
delete from dms;
