# 🎯 Bonus Hunter — New Player Campaign

A gamified, **EV-first** onboarding flow for new online-casino **and sports-betting** players. It takes a small starting bankroll (default **$200**) and walks you, quest-by-quest, through **only the positive-expected-value bonuses** — in the right order — while enforcing disciplined stop-rules as game mechanics.

Two single-file tools, no build step, no server, no dependencies. All your data stays in your own browser (`localStorage`).

> ⚠️ **Read the disclaimer at the bottom first.** Casino games carry a built-in house edge. This is an educational tool about *minimising* losses and capturing bonus value — not a way to beat the casino or guarantee profit. 18+, and only where legal.

---

## What's inside

| File | What it is |
|------|------------|
| `index.html` | Landing — redirects to the **Sports** campaign (the default entry point) |
| `sports.html` | **Bonus Hunter (Sports)** — sports-betting campaign (default) |
| `casino.html` | **Bonus Hunter (Casino)** — casino campaign |
| `tracker.html` | **Bonus & Registration Tracker** — log registrations, KYC, deposits, wagering and results per platform |
| `betting-platforms.json` | The raw platform list (85 records: bonus, wagering, licensing, type) |
| `betting-ev-normalized.json` | Parsed/normalised EV fields (bonusPct, wagerX, capUSD, depositSafe, clearEV, verdict) |

The two HTML tools **share progress** via the same `betTrackerV1` localStorage key, so registering/depositing in the campaign shows up in the tracker and vice-versa.

## The one rule it teaches

A casino match bonus is only worth taking if:

```
wagering-multiplier × house-edge  <  1
```

On a typical 96.5%-RTP slot (house edge ≈ 3.5%), that means take it only if the wagering requirement is **≲ 28× the bonus** (or **≲ 14× on deposit+bonus**). Headline bonus size is irrelevant — a 470% bonus at 45× wagering *loses* money; a boring 100% at 12× *makes* money.

## The campaign tiers

1. **🎓 Academy** — the rule + a quick quiz (unlocks the campaign).
2. **Tier 1 — Pure Value** — no-wager cashback / rakeback offers. No clearing trap; harvested first.
3. **Tier 2 — Low-WR Clears** — 100%-ish matches with low (10–25×) wagering, the only sticky bonuses whose math is positive.
4. **Tier 3 — Parachute (Non-Sticky)** — deposit-recoverable bonuses; play cash on low-edge baccarat to a target, then clear any bonus phase on slots.
5. **⛔ Trap Zone** — the big flashy bonuses, permanently locked, shown with the exact math of how much they'd lose.

**Stop-rules are enforced**, not just suggested: a stop-win banner the instant wagering hits 100%, an "Ice Veins" badge for logging a loss without chasing, and recommended deposit sizing so you never over-commit the bankroll.

## Payout log

A second screen tracks **real results over time** and charts **projected EV vs. realised bankroll**, so you can see how much of your outcome is skill (edge) versus variance (luck). Import completed campaign missions or log sessions manually; export to CSV.

## How to use

- **Online:** open the published link (GitHub Pages) in any modern browser.
- **Offline:** download the repo and open `index.html` (and `tracker.html`) directly — they work fully offline. Your data persists in that browser only.

## Accounts (optional, cross-device sync)

Registration is **optional and one-click** — you can always "Play as guest". Choices:

- **⚡ Quick login** — one click, no email, no verification (Supabase anonymous sign-in).
- **Email + password** — for syncing your campaign, payout log and tracker across devices (no email verification step).

Out of the box the app runs in **demo mode** (login saves a profile in *that browser only* — no server needed, works on GitHub Pages). To enable **real cross-device accounts**:

1. Create a free [Supabase](https://supabase.com) project.
2. Run [`supabase-setup.sql`](supabase-setup.sql) in the SQL Editor (creates the `player_state` table + Row-Level Security).
3. In the dashboard: enable **Anonymous sign-ins** and disable **Confirm email**.
4. Paste your **Project URL** + **anon key** into the `CONFIG` block near the top of `index.html`'s script.

The anon key is safe to commit publicly — Row-Level Security ensures each user can only read/write their own row.

## Methodology & assumptions

- FX: $1 ≈ 35 THB ≈ 10 NOK (the source list's own conversions).
- Slot clearing modelled at **96.5% RTP (3.5% house edge)** — EV is sensitive to this; lower-RTP games worsen every figure.
- EVs are **expected values**, not guarantees — a single session can differ wildly from the average.
- Bonus terms change constantly and a few entries are flagged **VERIFY** — always confirm the live terms on the operator's official page before depositing.

---

## ⚠️ Disclaimer

This project is for **education and entertainment only**. It is **not** financial, betting, or legal advice.

- **The house always has an edge.** Over the long run, casino gambling is expected to lose money. This tool helps minimise that and capture bonus value — it does **not** make gambling profitable or "safe".
- **No guarantees.** All projections are statistical expectations with real variance. You can and may lose your entire deposit.
- **Verify everything.** Bonus amounts, wagering requirements and licensing are copied from research notes and **change frequently**. Confirm current terms on each operator before depositing.
- **Know your law.** Online gambling is restricted or illegal in many jurisdictions. It is **your** responsibility to ensure it is legal where you are. Listing a platform is not an endorsement, and offshore operators carry real withdrawal/counterparty risk.
- **18+ / 21+** as applicable. If gambling stops being fun, stop. Help: [BeGambleAware](https://www.begambleaware.org/) · [GamCare](https://www.gamcare.org.uk/).

No affiliation with any operator listed. Use at your own risk.
