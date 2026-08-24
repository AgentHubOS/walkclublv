-- Set all Gallery photos to the walk date: July 18, 2026, 8:30 AM
update posts
set t = (extract(epoch from timestamptz '2026-07-18 08:30:00-07') * 1000)::bigint
where room = 'gallery';