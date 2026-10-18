# Daily Tasks & Issues — 2026-09-28

## Tasks

- [x] Home Service customer side — date/time + "any nearby barber" (anyNearby) added to request flow, plus retry/resubmit for expired requests. See "Progress" below.
- [x] Home Service barber side — broadcast inbox (list pending invitations, candidate detail, accept/reject). See "Progress" below.
- [ ] Added "Curls" to Youssef's specific shop (product/service catalog item — verify in backend/shop data).

## Progress — Home Service customer side (2026-09-28)

Found that `customer/home_service`, `barber/home_service`, and `barber/home_service_requests` already existed as a full working feature — this was extending it, not greenfield. What changed:

- `core/network/constants/endpoints.dart` — added `customerHomeServiceRetry(id)` → `PUT customer/homeService/{id}/retry`.
- `HomeServiceRequestStatus` — added `expired` (+ `isRetryable` getter). Backend can now expire a broadcast request; UI needed a state for it.
- `HomeServiceRequest` entity/model — `shopId`/`shopName` now nullable, added `anyNearby`, `date`, `time`.
- Customer API/repo/use case — `createRequest` and new `retryRequest` both send `date`, `time`, and either `shopId` or `anyNearby: true`.
- Shop list screen — added an "any nearby barber" CTA card above the shop list, navigates to the request screen with no shop (anyNearby mode).
- Request screen — now takes `shop` (nullable) and `retryRequest` (optional prefill for the retry flow); added date/time pickers.
- Request detail screen — shows a "Retry request" CTA when status is `expired`, pushing back into the request screen pre-filled from the expired request.
- Added l10n keys (en + ar) for all of the above, regenerated via `dart run intl_utils:generate`.
- Split screens that grew past the 150-line cap into smaller widgets: `home_service_request_shop_card.dart`, `home_service_date_time_row.dart`, `home_service_request_form_fields.dart`, `home_service_cancel_button.dart`.

`flutter analyze` clean on all touched files (only pre-existing unrelated warnings remain elsewhere in the repo).

## Progress — Home Service barber-side broadcast inbox (2026-09-28)

New feature end-to-end at `lib/features/barber/home_service_broadcast/` (full clean-arch: data/domain/presentation), separate from the pre-existing `barber/home_service_requests` (shop-targeted requests) and `barber/broadcast` (unrelated discount-announcement feature — do not confuse the two).

- Endpoints added: `barberHomeServiceBroadcast` (GET inbox), `barberHomeServiceBroadcastRequest(requestId)` (GET candidate detail by request id — used for notification tap-through), `barberHomeServiceBroadcastAccept/Reject(broadcastId)`.
- `HomeServiceBroadcast` entity/model: id (broadcast id, distinct from the request id), requestId, requestCode, customerName, address/lat/lng, distanceKm, note, date, time, price, createdAt, expiresAt.
- Repo/use cases: `getBroadcasts`, `getBroadcastForRequest`, `accept`, `reject`. Accept/reject remove the item from the cubit's in-memory list on success (it's no longer a live invitation once decided).
- Screens: `HomeServiceBroadcastScreen` (inbox list) and `HomeServiceBroadcastDetailScreen`, which accepts either `broadcastId` (row tap) or `requestId` (notification tap — resolved via `resolveForRequest`).
- Reject has no reason field, matching the curl spec (`PUT .../reject` with no body) — just a confirm dialog, unlike the shop-request reject flow which has a reason sheet.
- Notification routing: `barber_notification_tap_router.dart` didn't handle home service at all before this — added both `homeService` (existing shop-request flow, was also missing) and `homeServiceBroadcast` cases.
- Home screen entry point: new `HomeServiceBroadcastCard`, shown in `HomeAlertCards` only when there's at least one pending invitation, pushes to the inbox.
- DI: new `_barberHomeServiceBroadcast()` registration block in `services_locator.dart`; cubit provided at the barber shell level (`app_routes.dart`) and loaded in `barber_home_screen.dart`'s pull-to-refresh alongside the other home cubits.
- l10n keys added (en + ar), regenerated via `dart run intl_utils:generate`.

`flutter analyze` clean (full project run, only the same pre-existing unrelated warnings). All new files under the 150-line cap.

## Verified against the real backend (2026-09-28, later same day)

Logged in as both test accounts (barber 01008451421 / customer 01555555555) against the real API at `https://gobeeeg.com/ayezAhlaqApi/api/` (not localhost:8082 — that was just the user's local curl testing port) and exercised every endpoint live: login, shops, create request, retry, broadcast inbox, candidate detail, accept, reject, cancel, confirmPrice. This caught real field-name mismatches that would have broken parsing in production:

- **Response field names differ from request field names.** Request payloads use `date`/`time`/`anyNearby` (confirmed correct, unchanged). But **responses** use `scheduledDate`/`scheduledTime`/`broadcast` instead. Fixed `HomeServiceRequestModel.fromJson` to read the right keys on the way in.
- **`price`/`finalPrice` can be `null`** on a still-broadcasting request with no shop assigned yet (confirmed: `shopId`, `shopName`, `price`, `finalPrice` are all `null` until a barber accepts). Changed `HomeServiceRequest.price` from `required num` to `num?` and added a "price pending" UI fallback everywhere it's displayed.
- **Barber broadcast candidate shape was substantially wrong.** Rebuilt `HomeServiceBroadcast` entity/model to match the real payload exactly: `candidateId`, `requestId`, `code`, `candidateStatus`, `requestStatus`, `address`, `distanceKm`, `note`, `scheduledDate`, `scheduledTime`, `suggestedPrice`, `expiresAt`. Dropped fields that don't exist in the real response: `customerName`, `lat`/`lng`, `createdAt`. Row/info-card widgets updated to not reference the dropped fields.
- **Accept and reject return completely different shapes than I'd assumed.** Accept returns a full barber-side `HomeServiceRequest` (the shop-request shape from `barber/home_service_requests`) — meaning once accepted, the request moves into the regular requests flow, not the broadcast one. Reject returns `data: null`. Changed `IBarberHomeServiceBroadcastRepo.accept/reject` to return `Either<Failure, Unit>` instead of a bogus `HomeServiceBroadcast`, since neither response is actually a broadcast object.
- **Candidates expire in ~10 minutes.** Confirmed live — every test candidate I created had flipped to `EXPIRED` by the time I checked back a few minutes later. Added `HomeServiceBroadcast.isPending` and gated the accept/reject buttons on it, so an expired candidate viewed via notification tap-through doesn't show dead action buttons.

**Confirmed backend bug, not a client issue:** `PUT customer/homeService/{id}/retry` is currently broken server-side. Tested with correct `date`/`time` field names (verified as the right names from the create-endpoint's own validation error), both `anyNearby: true` and `shopId` payloads, and multiple different expired requests — every attempt returns `"حدث خطأ في قاعدة البيانات أثناء معالجة الطلب"` (database error) or `"بيانات الطلب غير صحيحة"` depending on payload shape. The client-side retry UI is built and correct; it will work once the backend team fixes that endpoint. Worth reporting to them with these repro steps.

All fixes re-verified with `flutter analyze` (clean, same pre-existing unrelated warnings only) and all files re-checked against the 150-line cap.

## Found via real device logs: Arabic-Indic digits leaking into API payloads (2026-09-28, later same day)

User ran the app on a real device in Arabic and pasted the Dio request logs. Two `POST` calls (`customer/homeService` and `customer/booking`) were sending `date: ٢٠٢٦-٠٩-٣٠` (Arabic-Indic digits) instead of `date: 2026-09-30`.

**Root cause**: `lib/generated/l10n.dart` sets `Intl.defaultLocale = localeName` globally (so `'ar'` when the app is in Arabic). Any `DateFormat('yyyy-MM-dd')` call with no explicit locale argument silently inherits that and renders Arabic-Indic digits. The backend expects plain ASCII digits, so every home-service and booking request sent while the app was in Arabic was silently malformed — this would have caused hard-to-diagnose backend validation failures in production, exactly during the busiest usage window (Arabic being the app's primary language).

**Fixed at every call site that builds an API payload or a user-visible date, pinning `'en'` explicitly**, matching the convention already established in `core/helpers/app_date_time.dart` (which does this correctly everywhere else):
- `home_service_request_screen.dart` — the `date` sent on create/retry.
- `home_service_date_time_row.dart` — the date field's displayed value.
- `choose_time_screen.dart` (customer booking feature, not something built this session, but the same bug) — both the slots-fetch call and the date-picker button label; this same `state.date` string also flows straight into the final `POST customer/booking` call, so one fix covered both.
- `app_date_time.dart`'s `combineToTimestamp` — currently dead code (no callers), fixed defensively so it isn't a landmine later.

Confirmed via `grep -rn "DateFormat(" lib` that no other unpinned call sites remain outside of ones that are intentionally locale-aware (relative date labels for display only, never sent over the wire).

`flutter analyze` clean after these fixes (same pre-existing unrelated warnings only).

## Second confirmed backend bug + UI polish (2026-09-28, later same day)

User hit a 400 (`"بيانات الطلب غير صحيحة"`) submitting a shop-targeted home service request after the digit fix was already applied (confirmed via device log: `date: 2026-09-30` was clean ASCII this time). Bisected live against the real API by holding every field constant and swapping one at a time:

- Same payload with `"anyNearby": true` instead of `"shopId": 3` → succeeds (gets the expected "no nearby shop for this time" business error, meaning it passed validation).
- Tried `shopId` 3, 8, 15, 1 → **all four rejected** with the same "invalid request data" error, real coordinates or not, note present/absent/null, address length varied, date/time varied.

**Conclusion: shop-targeted home service create (`POST customer/homeService` with `shopId`) is currently broken server-side for every shop**, while the `anyNearby` broadcast path works correctly. This is independent of anything in the client — the exact same request shape that worked when I tested it live earlier today (see the "Verified against the real backend" section above) now fails identically regardless of which field changes. Second backend-side bug found today, alongside the retry endpoint. Nothing to fix client-side; needs to go to whoever owns the API.

**Also fixed, from a screenshot of the request screen**: the date and time fields looked structurally mismatched — the date field's label sat above the box (`AppDateField`'s design) while the time field's label sat inside the box next to the icon (`TimePickerButton`'s old design), so they didn't visually pair even though they're side by side. Checked usage first — `TimePickerButton` had no other consumers in the app, so it was safe to restyle without risking other screens. Rebuilt it to structurally mirror `AppDateField` exactly (label above, same padding/radius/border-color-on-selection logic, icon on the trailing side). Also tightened the gap between the two fields from 12.w to 8.w so they sit closer together as asked.

`flutter analyze` clean after these changes.

## Correctness pass (2026-09-28, same day)

Went back through both home-service pieces (customer request/retry flow, barber broadcast inbox) looking for real bugs, not just compile errors. Found and fixed:

- **Retry didn't prefill date/time** — `HomeServiceRequestScreen.initState` copied address/note/lat/lng from the expired request but left date/time blank, defeating half the point of "retry." Added `HomeServiceDateTimeParsing` (new small helper file) to parse the entity's `date`/`time` strings back into `DateTime`/`TimeOfDay`.
- **Date picker could crash on retry** — `initialDate` used the (possibly past, since expired) prefilled date with `firstDate: now`; Flutter's `showDatePicker` asserts `initialDate >= firstDate`. Fixed by clamping in `HomeServiceDateTimeRow._pickDate`.
- **No "must be in the future" validation** — a customer could retry with a prefilled past date/time and submit it unchanged. Added a check in `_submit` + new l10n key `homeServiceDateTimeMustBeFuture`.
- **"Any nearby" CTA vanished when the shop list was empty** — it was only rendered inside the non-empty list branch, so a customer with zero nearby shops lost the one option that still applied to them. Restructured `home_service_shop_list_screen.dart` so the CTA always shows and the empty state renders below it.
- **Shop-targeted retry showed "any nearby" copy** — `widget.shop` is always null on retry (only `retryRequest` is passed), so `HomeServiceRequestShopCard` always fell into the "any nearby barber" branch even when retrying a request that was originally sent to a specific shop. Added a `retryShopName` fallback so shop-targeted retries show the shop name instead of the wrong copy.
- **Form cubit is an app-lifetime singleton** (existing app-wide pattern in `app_routes.dart`, not something introduced this session) — `HomeServiceRequestFormCubit`'s `success`/`failure` state could leak across separate visits to the request screen. Added `cubit.reset()` called from `initState`.
- **Broadcast candidate-detail (notification tap-through) had no loading state and swallowed errors** — `resolveForRequest` didn't emit `loading`, so the skeleton never showed for that entry path, and on failure it silently returned `null` with no error message, landing on a blank "not found" screen. Fixed the cubit to emit loading/success/failure properly, and added a retry action on that error screen.

`flutter analyze` clean across the full project after all fixes (same pre-existing unrelated warnings only). All files re-checked against the 150-line cap.

## Issues

-

## Notes

### Home Service API contract (base: http://localhost:8082)

**Customer — request home service at a specific shop**
`POST /api/customer/homeService`
```json
{
  "shopId": 1,
  "address": "شارع النصر، مدينة نصر، عمارة 5، الدور السادس بدون أسانسير",
  "lat": 30.0561,
  "lng": 31.3272,
  "note": "الدور السادس، لا يوجد أسانسير",
  "date": "2026-10-01",
  "time": "16:30"
}
```

**Customer — request home service, any nearby shop**
`POST /api/customer/homeService`
```json
{
  "anyNearby": true,
  "address": "...",
  "lat": 30.0561,
  "lng": 31.3272,
  "note": "...",
  "date": "2026-10-01",
  "time": "16:30"
}
```

**Customer — check a request status**
`PUT /api/customer/homeService/{id}/retry` (also used to check/retry, e.g. id=42)

**Customer — update & resubmit an expired request**
`PUT /api/customer/homeService/{id}/retry`
```json
{
  "anyNearby": true,
  "address": "...",
  "lat": 30.0561,
  "lng": 31.3272,
  "note": "...",
  "date": "2026-10-01",
  "time": "19:00"
}
```

**Barber — pending broadcast invitations inbox**
`GET /api/barber/homeService/broadcast`
Header: `X-Client: DESKTOP`
Notification `referenceType` = `homeServiceBroadcast`

**Barber — tap broadcast notification → resolve request → candidate detail**
`GET /api/barber/homeService/broadcast/request/{requestId}` (e.g. 42)

**Barber — accept broadcast**
`PUT /api/barber/homeService/broadcast/{broadcastId}/accept` (e.g. 17)

**Barber — reject broadcast**
`PUT /api/barber/homeService/broadcast/{broadcastId}/reject` (e.g. 17)

All barber home-service calls include `X-Client: DESKTOP` header alongside Bearer auth.
