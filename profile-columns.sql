-- Add profile columns to members so profile info actually saves.
-- Run once in Supabase (SQL Editor). Safe to re-run.
alter table members add column if not exists bio text;
alter table members add column if not exists hobbies text;
alter table members add column if not exists business text;
alter table members add column if not exists address text;
alter table members add column if not exists website text;
alter table members add column if not exists avatar text;