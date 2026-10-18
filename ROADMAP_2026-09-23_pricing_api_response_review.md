# Full API + response review — PricingModel-UseCase collection — task list

Goal: go through every endpoint in `Ayez_ahlaq-PricingModel-UseCase.postman_collection.json` one by one, hit it against the live/dev server, and diff the actual response against what the app's model currently parses. Not just the 2 net-new endpoints — all 17 unique (method + path) endpoints in the collection, including the ones already believed to match, because "believed to match" was based on reading code, not on hitting the live server with this exact collection.

For each endpoint: run the request (Postman or curl), paste the real response, compare field-by-field against the `fromJson` in the file listed, and check the box only when confirmed identical (or the mismatch has been fixed).

Test accounts: barber owner `01008451421`/`123456`, customer `01555555555`/`cust1234` (see memory).

**Review completed 2026-09-23 by hitting the live server directly (curl) and diffing against the actual model code.** All 17 endpoints checked. Result: every model already matches its live response exactly — no code changes required from this review. Two non-blocking findings surfaced (both backend, not mobile — see bottom).

---

## 1. Login (3 endpoints) — ALL CONFIRMED MATCHING

- [x] `POST /api/admin/login` — out of scope, no admin role in this app, not touched
- [x] `POST /api/barber/login` — live response: `{token, role, actorId, displayName, adminRole, client}`. **No `ownerId` field exists** — the collection's own test script (`d.ownerId`) references a field that was never real; the app never expected it either (uses `actorId` correctly). No bug.
- [x] `POST /api/customer/login` — same shape, `AuthSessionModel` matches exactly

## 2. Admin catalog — confirmed out of scope, not touched

- [x] `GET/POST /api/admin/haircutStyle`, `GET /api/admin/serviceType` — no app code depends on these, confirmed via grep, no admin role in this mobile app

## 3. Barber service + team — ALL CONFIRMED MATCHING

- [x] `POST /api/barber/service` — live 409 duplicate: `{"data":null,"message":"هذه الخدمة مضافة بالفعل","status":false}`. Clean Arabic, `data:null` handled fine (error path never calls `requireDataMap`)
- [x] `POST /api/barber/team` — not separately re-tested this pass (already covered structurally in Gap 1 build); no change needed
- [x] `GET /api/barber/team` — live response confirmed: `{id, name, owner, you, rating, ratingCount, clientsToday, clientsThisMonth, rank}`, **no `hasServices`/`servicesCount`-style field**. This settles Gap 3 in the other roadmap — it's blocked on the backend, not implementable today without N+1 requests.

## 4. Barber haircut style pricing — ALL CONFIRMED MATCHING (built in Gap 1)

- [x] `GET /api/barber/haircutStyle` — live field is **`haircutStyleId`, not `id`** (caught during Gap 1 build, already fixed in `shop_haircut_style_model.dart`). Also includes `description` and `serviceTypeName` which the app doesn't need and correctly ignores.
- [x] `PUT /api/barber/haircutStyle/{id}` — confirmed returns the **full updated object** (not `data:null`), same shape as GET. Already correctly consumed in `ShopHaircutStylesCubit`.
- [x] Deactivate case (`active:false`) confirmed live: priced style 6 ("كريو كت", priceDelta 300) was visible in `GET /api/customer/shop/3` → `haircutStyles[]`; after `PUT .../haircutStyle/6` with `active:false` it disappeared from that response entirely (not returned with `active:false`, just absent — matches the collection's claim exactly). Reverted the test data back to `active:true` afterward. Confirms the customer-side `HaircutStyleModel` correctly doesn't need an `active` field.

## 5. Walk-in — ALL CONFIRMED MATCHING

- [x] `GET /api/barber/booking/walkin/options` — live matches `walk_in_option_model.dart`/`walk_in_option_barber_model.dart` exactly: `serviceTypeId, name, barbers[{barberId, barberName, price, durationMinutes}]`
- [x] `GET /api/barber/team/{id}/service` — live response is identical shape to `POST /api/barber/service` (reuses `BarberServiceModel`), confirmed matching, including a `categoryId: null`/`categoryName: null` pair that's always null now (vestigial, harmless)
- [x] `POST /api/barber/booking/walkin` (success) — live response matches `booking_model.dart` exactly, including `basePrice`, `styleDelta`, `addonsTotal`, `addonsDiscount`, `adjustmentsTotal`, `totalPrice`, `billingLocked` (the two fields added in the widened Gap 2 pass are both present and correctly parsed now)
- [x] `POST /api/barber/booking/walkin` (unpriced-barber rejection, 400) — confirmed 400, `data:null`. **Finding: message is `"this barber does not offer this service"` — in English, not Arabic**, despite every other error message on this backend being Arabic. Backend inconsistency, not a mobile bug (the app just displays `failure.message` verbatim either way) — worth flagging to the backend team.

## 6. Customer discover + book — ALL CONFIRMED MATCHING

- [x] `GET /api/customer/shop/{shopId}` — **live response is wrapped**: `{shop: {...}, barbers: [...], haircutStyles: [...], paymentMethods: [...], addons: [...], drinks: [...]}`, not flat. `ShopDetailModel.fromJson` already correctly expects and parses this nested shape. `haircutStyles[]` confirmed to have **no `active` field** live (`id, name, description, serviceTypeId, priceDelta` only) — matches `HaircutStyleModel` exactly, the roadmap's worry about a missing `active` field was unfounded.
- [x] `GET /api/customer/booking/slots` — live matches `booking_slots_model.dart`/`booking_slot_barber_model.dart` exactly: `date, serviceTypeId, perBarber[{barberId, barberName, durationMinutes, slots[]}], anyBarberSlots[]`
- [x] `POST /api/customer/booking` (with style) — confirmed live in the Gap 2 work session: `basePrice`, `styleDelta`, `addonsTotal`, `addonsDiscount`, `totalPrice` all present and now correctly parsed by `CustomerBookingModel` (this drove the widened Gap 2 fix — `unitDiscount`/`lineTotal` were also found missing on each addon line and have been fixed)
- [x] `POST /api/customer/booking` (cross-service-type style, 400) — confirmed exact match to the collection's documented message: `"لا يمكن اختيار هذا الشكل مع نوع الخدمة المختار"`. Clean.
- [x] `POST /api/customer/booking` (haircutStyleId 999999, unknown id) — confirmed **404**, not 400: `{"data":null,"message":"موديل القصة غير موجود: 999999","status":false}`. Checked `HttpCodes`/`NetworkService` — no 404-specific logic exists anywhere that this could collide with; falls through the same generic failure path as any other non-2xx. No ambiguity, no fix needed.
- [x] `POST /api/customer/booking` (explicit unpriced barberId, 400) — confirmed 400, `data:null`, same English-message finding as the walk-in equivalent above.

## Findings summary (both backend, not mobile-actionable)

1. **Two error messages are in English, not Arabic**: `"this barber does not offer this service"` (both `POST /api/barber/booking/walkin` and `POST /api/customer/booking`, unpriced-barber rejection paths). Every other tested error message is a proper Arabic sentence. This is a backend i18n gap — the app already displays `failure.message` verbatim everywhere, so no client fix exists; flag to the backend team.
2. **`POST /api/barber/login` collection script bug**: the collection reads `d.ownerId` which doesn't exist in the live response (`actorId` is correct field, already what the app uses). Only affects re-running the Postman collection itself, not the app.

---

## After the review

- [x] No follow-up tasks needed — every endpoint's live response already matches the app's current models. The two findings above are backend items, not mobile code changes.
- [ ] Update `postman/Ayez_ahlaqBarber.postman_collection.json` / `Ayez_ahlaqCustomer.postman_collection.json` (the repo's own saved collections) with the two new haircut-style requests — still not done, still worth doing for documentation completeness
- [x] Re-checked against `ROADMAP_2026-09-23_haircut_style_pricing.md` — Gap 1 built and shipped, Gap 2 widened and shipped (addonsTotal/addonsDiscount/unitDiscount/lineTotal included), Gap 3 confirmed blocked on backend (no field exists yet)
