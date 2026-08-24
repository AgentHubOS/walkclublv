# Walk Club LV — Push Notifications setup

Members get a real phone banner (app closed) for: new DMs, group messages,
@mentions, and moderator alerts. Works after they "Add to Home Screen"
(required on iPhone, iOS 16.4+).

You do this ONCE. Steps 1–4 need the Supabase CLI on your computer.

## 1. Create the subscriptions table
Supabase ▸ SQL Editor ▸ paste `push-schema.sql` ▸ Run.

## 2. Generate VAPID keys (the push signing keys)
In a terminal:
    npx web-push generate-vapid-keys
Copy the **Public Key** and **Private Key** it prints.

## 3. Give me the Public Key
Paste the **VAPID Public Key** back to me in chat. I drop it into the app so
phones can subscribe. (The Private Key stays secret — never paste it in the app.)

## 4. Deploy the sender function + secrets
With the Supabase CLI (from the project folder that has the `supabase/` folder):
    supabase login
    supabase link --project-ref giyajrnkqdgfaugakjny
    supabase secrets set VAPID_PUBLIC=<public key> VAPID_PRIVATE=<private key> VAPID_SUBJECT=mailto:hello@walkclublv.com
    supabase functions deploy push --no-verify-jwt

That's it. Once the Public Key is in the app (step 3) and the function is
deployed (step 4), notifications are live. Members will see a one-time
"Enable notifications?" prompt inside the lounge (or a button in the 👥 panel).

## Notes
- SMS via SweatPals stays your channel for walk reminders; this push covers
  in-app social activity (messages, mentions, mod alerts).
- If a member declines the prompt, they still get the in-app 🔔 bell.
