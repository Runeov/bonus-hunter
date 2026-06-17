-- ============================================================
--  Bonus Hunter — Supabase setup (one-click accounts + cloud sync)
--  Run this in: Supabase Dashboard → SQL Editor → New query → Run
-- ============================================================

-- One row per user holding the whole client state (campaign + payout log + tracker).
create table if not exists public.player_state (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  state      jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- Row-Level Security: each user can only read/write THEIR OWN row.
-- This is what makes it safe to ship the public anon key in the static HTML.
alter table public.player_state enable row level security;

drop policy if exists "player_state self select" on public.player_state;
drop policy if exists "player_state self insert" on public.player_state;
drop policy if exists "player_state self update" on public.player_state;

create policy "player_state self select" on public.player_state
  for select using (auth.uid() = user_id);
create policy "player_state self insert" on public.player_state
  for insert with check (auth.uid() = user_id);
create policy "player_state self update" on public.player_state
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- ============================================================
--  Then, in the Supabase Dashboard (no SQL needed):
--
--  1. Auth → Providers → "Anonymous sign-ins"  → ENABLE
--       (this powers the ⚡ one-click "Quick login" button)
--
--  2. Auth → Providers → Email → "Confirm email"  → DISABLE
--       (so email signups log in instantly, no verification step)
--
--  3. Copy Project URL + anon key from Settings → API, and paste them into
--     the CONFIG block near the top of the <script> in index.html:
--        const SUPABASE_URL = "https://YOURPROJECT.supabase.co";
--        const SUPABASE_ANON_KEY = "eyJ...";
--
--  Until keys are set, the app runs in DEMO MODE: "login" creates a local
--  profile saved only in that browser (no server, no sync). Safe to ship.
-- ============================================================
