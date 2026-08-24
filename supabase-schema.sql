-- Walk Club LV — Members Lounge · Supabase schema
-- Run this in Supabase ▸ SQL Editor ▸ New query ▸ Run.

create table if not exists members (
  phone text primary key,
  name text not null,
  role text not null default 'member',
  muted boolean not null default false,
  created_at timestamptz default now()
);

create table if not exists posts (
  id text primary key,
  room text not null,
  author text,
  role text,
  body text,
  img text,
  address text,
  t bigint,
  reactions jsonb default '{}'::jsonb,
  comments jsonb default '[]'::jsonb,
  poll jsonb
);

create table if not exists dms (
  id text primary key,
  members jsonb default '[]'::jsonb,
  is_group boolean default false,
  name text,
  messages jsonb default '[]'::jsonb
);

create table if not exists settings (
  key text primary key,
  value text
);

-- Seed the speakeasy password (mods can change it in-app).
insert into settings (key, value) values ('speak_pass', 'kick it')
  on conflict (key) do nothing;

-- Realtime: broadcast row changes to all connected members.
alter publication supabase_realtime add table members, posts, dms, settings;

-- Row Level Security. Prototype policy = any member of the club can read/write.
-- (Tighten later: restrict deletes/mod actions to moderator rows.)
alter table members enable row level security;
alter table posts   enable row level security;
alter table dms     enable row level security;
alter table settings enable row level security;

create policy "club read"  on members for select using (true);
create policy "club write" on members for insert with check (true);
create policy "club upd"    on members for update using (true);
create policy "club del"    on members for delete using (true);

create policy "club read"  on posts for select using (true);
create policy "club write" on posts for insert with check (true);
create policy "club upd"    on posts for update using (true);
create policy "club del"    on posts for delete using (true);

create policy "club read"  on dms for select using (true);
create policy "club write" on dms for insert with check (true);
create policy "club upd"    on dms for update using (true);
create policy "club del"    on dms for delete using (true);

create policy "club read"  on settings for select using (true);
create policy "club upd"    on settings for update using (true);
create policy "club write" on settings for insert with check (true);
