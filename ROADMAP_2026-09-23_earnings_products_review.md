# Barber earnings — product revenue + till adjustments — task list

Confirmed from a live `GET /api/barber/earnings` response (pasted by the user, 2026-09-23) that the backend now returns fields the app silently drops. `EarningsModel.fromJson` (`lib/features/barber/team/data/models/earnings_model.dart`) and `DailyEarningModel.fromJson` (`lib/features/barber/team/data/models/daily_earning_model.dart`) only read a subset of the live payload — the rest is parsed by nothing and never reaches the UI.

Live response captured, for reference:
```json
{
  "today": 0, "last7Days": 0, "thisMonth": 7658,
  "clientsToday": 0, "clientsLast7Days": 0, "clientsThisMonth": 12,
  "avgTicket": 638, "supplierSpendThisMonth": 29533, "netThisMonth": -21575,
  "dailyLast7": [{"date": "2026-09-17", "amount": 0, "clients": 0, "productAmount": 0}, ...],
  "productsToday": 0, "productsLast7Days": 0, "productsThisMonth": 300,
  "productOrdersThisMonth": 1, "totalThisMonth": 7958,
  "tillAddedThisMonth": 0, "tillSubtractedThisMonth": 0
}
```

## Fields already parsed and already shown — no work needed

`today`, `last7Days`, `thisMonth`, `clientsToday`, `clientsLast7Days`, `clientsThisMonth`, `avgTicket`, `supplierSpendThisMonth`, `netThisMonth` — all present in `EarningsModel` and displayed in `earnings_summary_grid.dart` / `earnings_breakdown_card.dart`. `dailyLast7[].date/amount/clients` parsed and shown in `daily_earning_row.dart`.

## Fields silently dropped today (confirmed by diffing the live JSON against the model) — this is the actual gap

- `productsToday`, `productsLast7Days`, `productsThisMonth` — product-store revenue, separate from haircut `today`/`last7Days`/`thisMonth`
- `productOrdersThisMonth` — count of product orders this month
- `totalThisMonth` — combined total (live value 7958 = `thisMonth` 7658 + `productsThisMonth` 300 — **verify this arithmetic holds across more sample data before assuming it's always haircut+products with nothing else folded in**)
- `tillAddedThisMonth`, `tillSubtractedThisMonth` — manual till adjustments (cash added/removed outside of bookings/orders)
- `dailyLast7[].productAmount` — per-day product revenue, missing from `DailyEarning`/`DailyEarningModel`

## Before touching the model: reconcile the numbers by hand — DONE (re-pulled live 2026-09-23, second time same day, numbers stable)

- [x] `netThisMonth` (-21575) confirmed = `totalThisMonth - supplierSpendThisMonth` (7958 - 29533 = -21575 ✓ exact match). The breakdown card previously showed this negative number with nothing explaining it — that's the actual bug, now fixed by adding the products/total rows above it.
- [x] `tillAddedThisMonth`/`tillSubtractedThisMonth` — inconclusive, but not blocking. Both are `0` in every live sample pulled (including a fresh pull after creating a real walk-in booking with a drink), and no UI/endpoint exists anywhere in this app to create a non-zero till adjustment (grepped `till`/`Till` across `lib/features/barber` — zero hits), so it can't be empirically tested yet. Since `netThisMonth` already fully reconciles from `totalThisMonth - supplierSpendThisMonth` alone with these at 0, whether they're folded in or not doesn't currently matter — revisit once a shop has real till data.
- [x] `thisMonth` confirmed haircut-only: 7658 + 300 (`productsThisMonth`) = 7958 = `totalThisMonth` exactly, confirmed across two independent live pulls same day.
- [x] **Extra finding**: earnings only count `DONE`/completed bookings, not `CONFIRMED`/queued ones. Verified by creating a real walk-in booking with a drink (`POST /api/barber/booking/walkin`, addonsTotal 120) and re-pulling earnings immediately after — `today`/`productsToday` did not move. This is correct financial semantics (settled revenue only), not a bug, but means today's/last7Days' figures can look artificially low if a shop has a lot of just-booked-not-yet-served traffic. No code change needed, just documented here for context.

## Domain — entity changes — DONE

- [x] `lib/features/barber/team/domain/entities/earnings.dart` — added `productsToday`, `productsLast7Days`, `productsThisMonth` (num), `productOrdersThisMonth` (int), `totalThisMonth` (num), `tillAddedThisMonth`, `tillSubtractedThisMonth` (num), all defaulted to 0 in `Earnings.empty()` and included in `props`
- [x] `lib/features/barber/team/domain/entities/daily_earning.dart` — added `productAmount` (num)

## Data — model changes — DONE

- [x] `lib/features/barber/team/data/models/earnings_model.dart` — parses all six new top-level fields with the same `(json[...] as num?) ?? 0` pattern already used for `avgTicket`/`supplierSpendThisMonth`
- [x] `lib/features/barber/team/data/models/daily_earning_model.dart` — parses `productAmount` the same way

## Presentation — surface the numbers — DONE (except the two decisions below)

- [x] `lib/features/barber/team/presentation/widgets/earnings_breakdown_card.dart` — added rows for products revenue this month, product orders count, `totalThisMonth`, and till adjustments (added/subtracted — only shown when non-zero, since they're always 0 today), positioned above `netThisMonth` so its math is now visible from the rows above it
- [x] `lib/features/barber/team/presentation/widgets/daily_earning_row.dart` — added a secondary line showing `productAmount` per day, only when non-zero (keeps the row uncluttered for the common all-haircut-no-products day)
- [x] `home_earnings_grid.dart` / `earnings_summary_grid.dart` "this month" tiles — **user decision: keep haircut-only `thisMonth`, do not switch to `totalThisMonth`**. Product revenue stays scoped to the detailed breakdown card only, not the quick-glance tiles. Neither file touched.

## l10n — DONE

- [x] Added Arabic + English strings: `productsThisMonthLabel`, `productOrdersThisMonthLabel`, `totalThisMonthLabel`, `tillAddedLabel`, `tillSubtractedLabel`, `productsAmountLine` — no existing storefront strings fit this context, all net new
- [x] Ran `dart run intl_utils:generate`

## Testing — "نتأكد كويس ونظبطه لو مش مظبط" — mostly done, two items deferred

- [x] Pulled a fresh `GET /api/barber/earnings` live response, twice same day — numbers stable, matches the original pasted sample exactly
- [ ] Cross-check `productsThisMonth`/`productOrdersThisMonth` against actual storefront order history for the same shop — not done this pass, would need to enumerate `BarberStorefrontOrdersCubit` data for the same period; low risk since the number already reconciles arithmetically with `totalThisMonth`
- [ ] Confirm `dailyLast7[].productAmount` sums relate correctly to `productsLast7Days` — not verifiable yet, all daily samples are 0 (see below)
- [ ] Test a day with non-zero daily product sales end-to-end (created a real walk-in with a drink today, but confirmed earnings only count completed/`DONE` bookings — a `CONFIRMED` walk-in doesn't move `productsToday`. Would need to walk a booking through to completion, which the mobile app doesn't have a direct API shortcut for in this session)
- [x] Till-adjustment fields — confirmed no UI/flow exists anywhere in the app to create one (see reconciliation section above); deferred until that exists
- [x] `flutter analyze` clean on all touched files
- [x] Debug build (`flutter build apk --debug --flavor dev`) succeeded
