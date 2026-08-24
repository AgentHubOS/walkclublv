-- Walk Club LV — enable video posts
-- 1) Run this SQL (Supabase ▸ SQL Editor ▸ New query ▸ Run):

alter table posts add column if not exists video text;

-- 2) Create the storage bucket for videos (Supabase ▸ Storage ▸ New bucket):
--      Name:   media
--      Public: YES (toggle "Public bucket" on)
--    Then run the policies below so members can upload.

insert into storage.buckets (id, name, public)
values ('media', 'media', true)
on conflict (id) do update set public = true;

drop policy if exists "media read" on storage.objects;
create policy "media read" on storage.objects
  for select using (bucket_id = 'media');

drop policy if exists "media upload" on storage.objects;
create policy "media upload" on storage.objects
  for insert with check (bucket_id = 'media');

drop policy if exists "media update" on storage.objects;
create policy "media update" on storage.objects
  for update using (bucket_id = 'media');

drop policy if exists "media delete" on storage.objects;
create policy "media delete" on storage.objects
  for delete using (bucket_id = 'media');
