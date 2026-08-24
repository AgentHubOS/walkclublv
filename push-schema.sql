-- Walk Club LV — push subscriptions table. Run once in Supabase SQL Editor.
create table if not exists push_subscriptions (
  endpoint text primary key,
  member text,
  p256dh text,
  auth text,
  t bigint
);
alter table push_subscriptions enable row level security;
create policy "push read"  on push_subscriptions for select using (true);
create policy "push write" on push_subscriptions for insert with check (true);
create policy "push upd"    on push_subscriptions for update using (true);
create policy "push del"    on push_subscriptions for delete using (true);
