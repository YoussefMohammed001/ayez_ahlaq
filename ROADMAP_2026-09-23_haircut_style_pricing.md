# Pricing Model Migration (all types) — task list

Full gap analysis against `Ayez_ahlaq-PricingModel-UseCase.postman_collection.json`, done per actor (Admin/Barber/Customer). Booking flow request/response shapes (walk-in + customer) already consume `serviceTypeId`/`haircutStyleId` correctly and need no changes — verified against current code, zero `categoryId` left anywhere in services/team/booking. Three confirmed implementation gaps, listed below in priority order.

Pattern to mirror throughout: `lib/features/barber/services/` (api → repo → use cases → cubit → screen), same Clean Architecture layering as the rest of the app.

**Status as of 2026-09-23: Gap 1 and Gap 2 are fully built, verified against the live server, and shipped (debug build passing). Gap 3 is blocked on the backend. Nothing left to do in this file unless the backend adds the field Gap 3 needs.**

---

# Gap 1 — Barber: haircut style pricing — DONE

Scope: barber-side shop-wide pricing of haircut styles only (`GET /api/barber/haircutStyle`, `PUT /api/barber/haircutStyle/{id}`). No admin/global-catalog work — this app has no `admin` role, that's a separate desktop panel.

Reference: collection sections 2 and 4.

---

## Endpoints — DONE

- [x] `barberHaircutStyle = 'barber/haircutStyle'` in `lib/core/network/constants/endpoints.dart`
- [x] `barberHaircutStyleById(int id) => 'barber/haircutStyle/$id'` in the same file

## Domain — entity — DONE

- [x] `lib/features/barber/services/domain/entities/shop_haircut_style.dart` — `id`, `name`, `serviceTypeId`, `priceDelta` (int), `active` (bool)

## Data — model — DONE

- [x] `lib/features/barber/services/data/models/shop_haircut_style_model.dart` — `fromJson` parses `haircutStyleId` (not `id` — live field name confirmed by hitting the real server, caught and fixed during the build), `name`, `serviceTypeId`, `priceDelta`, `active`

## Data — API — DONE

- [x] `getHaircutStyles()` / `updateHaircutStyle(int id, body)` added to `lib/features/barber/services/data/apis/barber_services_api.dart`

## Domain — repo interface + impl — DONE

- [x] Both methods on `IBarberServicesRepo` and implemented in `BarberServicesRepo`

## Domain — use cases — DONE

- [x] `get_shop_haircut_styles_use_case.dart`, `update_shop_haircut_style_use_case.dart`

## Presentation — state/cubit — DONE

- [x] Went with the sibling-cubit approach: `ShopHaircutStylesCubit`/`ShopHaircutStylesState`, same pattern as `OwnServicesCubit`
- [x] `loadHaircutStyles()`, `updatePriceDelta(id, {priceDelta, active})` with `isSubmitting`/`errorMessage`

## Presentation — DI — DONE

- [x] Use cases registered `registerLazySingleton`, `ShopHaircutStylesCubit` registered `registerFactory` in `services_locator.dart`
- [x] Also wired as a module-level singleton + `BlocProvider` in `app_routes.dart` (both the `barberShell` route and the standalone pricing route) — this extra step wasn't anticipated in the original plan but was required; the DI registration alone doesn't put a cubit in the widget tree

## Presentation — UI — DONE (evolved beyond the original plan, based on user feedback)

- [x] `shop_haircut_style_row.dart` — style name, ± price line, `ToggleSwitch` for active, plus an edit-pencil icon (added after user feedback that the row's tap target wasn't obvious)
- [x] **Not inlined into `barber_services_screen.dart` as a section** — moved to its own standalone screen (`haircut_style_pricing_screen.dart`, route `Routes.barberHaircutStylePricingScreen`) after user feedback that an inline section was buried at the bottom of a long list. The main services screen now shows a single `MenuRow` ("أشكال القصات") right under the main services list, linking to the new screen.
- [x] `context.read<BarberProfileCubit>().profile?.owner` gate — the `MenuRow` only renders for the shop owner
- [x] Fixed a `ListView`-inside-`SingleChildScrollView` crash (`'!semantics.parentDataDirty'`) that surfaced on both the services screen and the new pricing screen during testing — replaced with plain `Column`s, since `RefreshableStateView` already provides the outer scroll

## l10n — DONE

- [x] `haircutStylesTitle` (final value: "أشكال القصات", simplified from an earlier "أسعار أشكال القصات" per user feedback), `haircutStyleNotPricedYet`, `haircutStylePriceDeltaLine`, `editHaircutStylePriceTitle`, `haircutStylePriceDeltaLabel/Hint/Invalid`, `haircutStyleActiveLabel`, `haircutStylePriceUpdated`, `noHaircutStylesYet`
- [x] Ran `dart run intl_utils:generate` (confirmed this project uses the legacy Flutter Intl generator, not `flutter gen-l10n`)

## Validation / edge cases — DONE

- [x] `priceDelta` field accepts a minus sign (plain `AppTextField`, not `isNumber: true`, validated with `int.tryParse`)
- [x] Owner-only gate via `BarberProfileCubit`
- [x] `priceDelta == 0` renders as "لسه متسعّرش" (not priced yet), not an error state
- [x] Deactivating (`active: false`) is a plain `ToggleSwitch` tap, no confirm dialog

## Explicitly out of scope for Gap 1 — untouched, confirmed correct

- [x] Admin global catalog endpoints — no admin role in this mobile app
- [x] Walk-in booking flow — confirmed correct via live API testing (see the API-review roadmap)
- [x] Customer booking flow — confirmed correct via live API testing
- [x] `barber/service` (service-type pricing) — confirmed correct, 409-duplicate response verified live

## After implementation — DONE

- [x] `flutter analyze` clean
- [x] Manually tested against the live API with the barber owner account: read styles, PUT a priceDelta (verified round-trip, then reverted the test data back to 0/inactive)
- [x] Cross-checked the customer side: `GET /api/customer/shop/{shopId}` already correctly shows priced styles in `haircutStyles[]` (confirmed live, no code change needed there)
- [x] Debug build (`flutter build apk --debug --flavor dev`) succeeded, multiple times across the iteration

---

# Gap 2 — Customer: booking response drops `basePrice`/`styleDelta` — DONE (widened in scope)

Confirmed by reading the code, then confirmed live: the collection's `POST /api/customer/booking` response sends `basePrice`, `styleDelta`, and `totalPrice` as separate fields — the customer side was silently dropping the first two. **While verifying this live, also found `addonsTotal`, `addonsDiscount` on the booking, and `unitDiscount`/`lineTotal` on each addon line — all missing from the models too, and all fixed in the same pass** (confirmed with the user before widening scope).

- [x] `basePrice`, `styleDelta`, `addonsTotal`, `addonsDiscount` added to `lib/features/customer/booking/domain/entities/customer_booking.dart` and parsed in `customer_booking_model.dart`
- [x] `copyWith` fixed to carry all fields through (was previously dropping everything except `ratedBarber`/`ratedShop` — a real pre-existing bug, now fixed)
- [x] All new fields added to `props`
- [x] Breakdown surfaced in `customer_booking_detail_card.dart`: base-price row always shown, style-price row shown when `styleDelta != 0`
- [x] `customer_booking_row.dart` (list row) left total-only, as planned — list rows stay summary-level
- [x] `unitDiscount`, `lineTotal` added to `lib/features/customer/booking/domain/entities/booking_addon.dart` + model — fixes a real bug where the extras list was computing `price × quantity` client-side and silently ignoring any server-side discount, showing an inflated line total whenever `unitDiscount > 0`
- [x] Same `unitDiscount` fix mirrored on the barber side (`lib/features/barber/bookings/domain/entities/booking_addon.dart` already had `lineTotal`, was still missing `unitDiscount`) and `addonsDiscount` added to the barber-side `Booking` entity — both confirmed live via a real walk-in booking with addons
- [x] l10n: added `bookingBasePriceLabel`, `bookingStyleDeltaLabel` (no existing string fit; reusing `servicePriceLabel` would have been ambiguous across two different screen contexts)
- [x] `flutter analyze` clean, debug build succeeded

---

# Gap 3 — Barber: no "not bookable yet" indicator on team members — BLOCKED on backend

Checked live on 2026-09-23: `GET /api/barber/team` response has no `hasServices`/`servicesCount`/similar field — confirmed by hitting the real endpoint (`{id, name, owner, you, rating, ratingCount, clientsToday, clientsThisMonth, rank}`, nothing else), not guessing. Doing this client-side today would require an N+1 `GET /api/barber/team/{id}/service` call per team member, which this plan explicitly rules out.

**Decision (confirmed with the user): parked. This is now a backend request, not mobile work.** When the backend adds a field indicating whether a team member has any priced services:

- [ ] Add it to `lib/features/barber/team/domain/entities/team_member.dart` + `team_member_model.dart`
- [ ] Add a small "not priced yet" badge/tag to `team_member_row.dart` (reuse `StatusBadge`/`BadgeTone` from core, same pattern as `barber_profile_screen.dart`'s verified/under-review badge)

Do not attempt this via N+1 requests as a workaround in the meantime.
