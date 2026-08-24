-- Walk Club LV — file existing Gallery photos into "Tree Top Park"
-- (last Saturday's walk: Tree Top Park, 1620 S Laurelglen Dr, Las Vegas, NV 89144)
-- Run once in Supabase ▸ SQL Editor.

update posts
set park = 'Tree Top Park'
where room = 'gallery' and (park is null or park = 'Unsorted');
