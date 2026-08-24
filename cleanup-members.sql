-- Walk Club LV — clean out duplicate & test members
-- The duplicates happened because the same person's number was stored in
-- different formats (7027864275 vs 702-786-4275). The app now forces
-- XXX-XXX-XXXX everywhere, so this won't happen again.
--
-- Run this once in Supabase ▸ SQL Editor to wipe the member roster clean.
-- It's the simplest fix for a small club: everyone just re-enters the lounge
-- once (name + number) and gets a single, correctly-formatted entry.

delete from members;

-- Add the email column members now collect (safe to run once):
alter table members add column if not exists email text;
-- Profile fields (safe to run once):
alter table members add column if not exists bio text;
alter table members add column if not exists hobbies text;
alter table members add column if not exists business text;
alter table members add column if not exists address text;
alter table members add column if not exists avatar text;
-- Read-state (which rooms/DMs a member has seen), so unread badges survive sessions:
alter table members add column if not exists seen_rooms jsonb default '{}'::jsonb;
alter table members add column if not exists seen_dms jsonb default '{}'::jsonb;
-- Gallery album tag (which park a photo belongs to):
alter table posts add column if not exists park text;

-- Moderation: table of flagged (blocked) message attempts.
create table if not exists flags (
  id text primary key,
  who text,
  where_at text,
  word text,
  snippet text,
  t bigint
);
alter table flags enable row level security;
create policy "club read"  on flags for select using (true);
create policy "club write" on flags for insert with check (true);
create policy "club del"    on flags for delete using (true);
alter publication supabase_realtime add table flags;


-- (Optional) also clear any leftover test posts/DMs:
-- delete from posts where id in ('p1','p2','p3','p4','p5','p6');
-- delete from dms;
