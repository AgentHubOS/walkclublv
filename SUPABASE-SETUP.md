# Walk Club LV — make the Lounge multi-user (Supabase)

Right now the lounge stores data in each person's browser. These steps make it a
shared, live database so every member sees the same posts, reactions, DMs and polls.

## What I need from you (2 values)
1. Go to **supabase.com** → sign in → **New project** (free tier is fine).
   - Name: `walkclublv` · pick a region near Las Vegas (US West).
   - Set a database password (save it somewhere; you won't need it in the app).
2. When it finishes building, open **Project Settings ▸ API** and copy:
   - **Project URL**  (looks like `https://xxxxxxxx.supabase.co`)
   - **anon public** key  (a long `eyJ...` string — the *anon* one, NOT service_role)
3. Open **SQL Editor ▸ New query**, paste the contents of `supabase-schema.sql`
   (in this project), and click **Run**. You should see "Success".

Then paste the **Project URL** and **anon key** back to me. I drop them into the
lounge, and it goes live multi-user — no other work on your side.

## About phone verification (SMS codes)
Real "text me a code" sign-up needs an SMS provider (Twilio) wired to Supabase Auth,
which costs per message and takes extra setup. For launch, sign-up is name + phone
(no code) — still members-only via the speakeasy. We can switch on true SMS
verification afterward without changing anything members see.

## Security note
The starter policy lets any club member read/write (fine for launch). Once we're
live we can tighten it so only moderator phone numbers can delete posts or manage
members.
