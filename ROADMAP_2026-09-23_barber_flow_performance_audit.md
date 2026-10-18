# Barber flow — full performance & loading-discipline audit — task list

Full review of the entire barber flow: auth → shell bootstrap → all 24 feature areas (~85 screens, 45 cubits), read line-by-line, not grepped. Two things checked everywhere: (1) does every POST/PUT/DELETE/PATCH block user interaction with a loading state, and (2) is any API call firing without real need (redundant reloads, no caching, fresh-instance-per-sheet refetching). Also swept for dispose hygiene and `build()`-triggered side effects while in each file.

**Same pattern to be repeated for merchant and customer after this file is worked through — do not start those until barber is done and confirmed.**

Reference pattern for "correct": `BusyErrorListener` (`lib/shared/widgets/busy_error_locale.dart` — ties a cubit's busy bool to global `showLoading()`/`hideLoading()`) combined with either a reactive `BlocBuilder`-driven button or a local `setState`-driven `_submitting` flag in the sheet itself. `lib/features/barber/money/` is the cleanest example in the whole app — use its form sheets as the template when fixing the buggy ones below.

---

## Priority 0 — DONE

### The shell fires 15 unconditional loads on every mount — DONE

Decision made and implemented: 8 cubits gained a `{bool force = false}` guard (same pattern as the pre-existing `BarberProfileCubit._imageLoadRequested`) — `state.status == XStatus.success` skips reload unless `force: true` is passed:
- [x] `BarberProfileCubit.loadProfile`
- [x] `BarberDocumentsCubit.loadDocuments`
- [x] `BarberServicesCubit.loadServices`
- [x] `BarberStoreMerchantsCubit.loadMerchants`
- [x] `BarberStorefrontProductsCubit.loadProducts`
- [x] `BarberStorefrontCategoriesCubit.loadCategories`
- [x] `BarberStorefrontDeliveryCubit.loadDelivery`
- [x] `BarberSubscriptionCubit.load`

Left reloading every time (correct, time-sensitive): `EarningsCubit`, `BookingsCubit` (pending/queue/history), `BarberNotificationsCubit.refreshUnseenCount`, `BarberStorefrontOrdersCubit`.

- [x] All pull-to-refresh / retry-on-failure / "data genuinely changed" call sites updated to pass `force: true`: home screen refresh, documents screen, services screen refresh helper, store merchants screen, storefront products screen, storefront categories screen, and the two discount screens that reload products after creating/closing a discount (price changed, so a real reload is correct there).
- [x] Retry-on-failure buttons (`onRetry` shown only when `status == failure`) needed no change — the guard only blocks `success`-state reloads, so failure retries already work correctly.
- [x] **Bonus bug found and fixed while implementing**: `barber_services_actions.dart`'s `openOwnServiceForm` was reloading the unrelated `BarberServicesCubit` catalog every time an *own service* was created — the two lists are independent and `OwnServicesCubit.createOwnService` already updates its own state correctly. Removed the unnecessary reload.

### Split-state via duplicate `BlocProvider` of the same cubit type — DONE

`BarberDrinksCubit` was registered `registerFactory` in DI but treated as a singleton via a private `app_routes.dart` global (`_barberDrinksCubit`) — except two sheet widgets called `sl<BarberDrinksCubit>()` directly, which under `registerFactory` created a genuinely separate, empty-state instance each time, making the existing `if (cubit.state.drinks.isEmpty) cubit.loadDrinks();` guard in `walk_in_drinks_field.dart` a permanent no-op.

- [x] Changed `BarberDrinksCubit` registration from `registerFactory` to `registerLazySingleton` in `services_locator.dart` — `sl<BarberDrinksCubit>()` now always returns the same instance everywhere, no code needs access to `app_routes.dart`'s private global
- [x] `BarberDrinksCubit.loadDrinks` also gained the `{bool force = false}` guard (same P0 pattern) — call sites updated (`walk_in_sheet_launcher.dart`, `edit_bill_sheet.dart` now do `sl<BarberDrinksCubit>()..loadDrinks()` safely, since it's a no-op if already loaded; `barber_drinks_screen.dart`'s pull-to-refresh passes `force: true`)
- [x] `WalkInOptionsCubit` — investigated, left as a fresh instance per walk-in sheet open **intentionally**: it's the only call site in the app, and represents "which services does each barber currently offer, at what price" — data a barber could change moments before opening the sheet, so fresh-every-time is the correct behavior here, not a bug. Judgment call resolved: no change.

---

## Priority 1 — double-submit bugs (missing/broken loading discipline on mutations)

### "Static isSubmitting" bug — DONE

All 5 sheets converted to a local `setState`-driven `_submitting` bool (dropped the `isSubmitting` constructor param entirely, matching `money_item_form_sheet.dart`'s proven pattern), with a re-entrancy guard (`if (_submitting || ...) return;`) at the top of `_submit()`:
- [x] `service_form_sheet.dart` — shared by both Services and Team (`member_services_section.dart`), both call sites updated
- [x] `own_service_form_sheet.dart`
- [x] `haircut_style_price_sheet.dart`
- [x] `add_team_member_sheet.dart`
- [x] `edit_member_sheet.dart`

- [x] **`TeamScreen` wrapped in `BusyErrorListener<BarberTeamCubit, BarberTeamState>`** — it had none before, now matches `TeamMemberDetailScreen`'s pattern. `AddTeamMemberSheet`'s double-submit is now doubly protected (local `_submitting` + global overlay fallback).

### Fire-and-forget "reject with reason" sheets — DONE

All 3 now `await` the cubit's reject call (all return `Future<void>`, no success bool to check), with a local `_submitting` bool disabling/spinning the confirm button while awaiting, and only popping after the await completes:
- [x] `reject_storefront_order_sheet.dart`
- [x] `reject_home_service_sheet.dart`
- [x] `reject_booking_sheet.dart`

### Mutations with no busy-flag emission at all — DONE

- [x] `team_member_detail_cubit.dart` `setAvailability()` — now sets `isSubmitting: true` before the call and resets it on both branches. `TeamMemberDetailScreen` already had `BusyErrorListener` reading `isSubmitting`, so the global overlay now correctly fires during the toggle. Did not add a local disable to `ToggleSwitch` itself — the global overlay is sufficient protection and avoids threading busy state through `MemberInfoCard`'s props.
- [x] `member_services_cubit.dart` `deleteService()` — now sets `isSubmitting: true`/`false` around the optimistic delete, matching sibling cubits' pattern. `MemberServicesSection` already had its own `BusyErrorListener`, so it now correctly surfaces during delete.
- [x] `BarberStorefrontProductsCubit.setStock()` — **user decision: wire it up with real UI, not delete.** Added busy-flag emission (`isSubmitting`) matching `createProduct`/`updateProduct`, changed return type to `Future<bool>` so callers can react to success. Built a new `EditStockSheet` (mirrors `HaircutStylePriceSheet`'s local-`_submitting` pattern) and wired it to the stock `InfoRow` on `storefront_product_details_screen.dart` (now tappable via `GestureDetector`, opens the sheet). That screen also had **no `BusyErrorListener` at all** — added one, so both the new stock edit and the existing delete-product action are now properly protected and error-surfaced. New l10n strings: `editStockTitle`, `stockQuantityHint`, `stockUpdated`.

### Weaker cases — global-overlay-only protection — DONE

- [x] `booking_actions.dart` — now reads `context.select<BookingsCubit, bool>((cubit) => cubit.state.updatingBookingId == booking.id)` and passes it as `isLoading` on both the confirm/reject decision buttons and the status-advance buttons. `updatingBookingId` already existed on `BookingsState`, just wasn't being read here.
- [x] `cart_line_row.dart` — `QuantityStepper` already had a full `disabled` state built (renders a spinner in place of the +/- buttons) but was never wired. Added a `disabled` prop to `CartLineRow`, threaded from `barber_store_cart_screen.dart` as `state.isUpdatingCart` (which the cubit's `setQuantity` already toggled correctly — just wasn't read by the UI).
- [x] `edit_home_service_price_sheet.dart` — `HomeServiceRequestsCubit`'s shared `_mutate` helper (backing `updatePrice`/`accept`/`reject`/`advanceStatus`) changed from `Future<void>` to `Future<bool>`. Sheet now only pops on success; `reject_home_service_sheet.dart` (fixed earlier this pass) updated the same way for consistency, since it uses the same now-bool-returning `reject()`. Verified no other call site depended on the old `void` return.

---

## Priority 2 — redundant/stale-data issues

- [x] `barber_documents_screen.dart` double-load — DONE, resolved automatically by P0's `loadDocuments({bool force})` guard. Verified: the screen's `initState` call is now a no-op if the shell already loaded it.
- [x] `home_alert_cards.dart` Home Service preload — **user decision: leave as-is.** Not added to the shell's preload list; stays lazy (loads on pull-to-refresh or when the user visits the Home Service screens directly). No code change.
- [x] `unseen_notifications_badge.dart` polling — **user decision: leave as-is.** No polling/refresh-on-resume added — avoids introducing the exact "calls for no reason" pattern this audit exists to remove. No code change.
- [x] `bookings_cubit.dart` `loadHistory()` pagination — **user decision: leave as-is.** Confirmed shops realistically have a few dozen historical bookings, not hundreds — pagination would be solving a problem that doesn't exist yet. No code change.

---

## Confirmed clean — no action needed (listed so nothing gets re-reviewed by mistake)

auth (all 6 screens), broadcast, device_token, discounts, drinks, home_service, hours, invite, money (all 5 screens — the reference example), payment_methods, profile (all 10 screens, except the `loadProfile` guard decision folded into P0), reviews, sponsorship, subscription, wallet (all 6 screens — money-critical flow, solid), and the following individually-verified sheets that superficially resemble the buggy pattern but are actually correct: `drink_form_sheet.dart`, `add_storefront_category_sheet.dart`, `add_walk_in_sheet.dart` (has extra manual re-entrancy guards beyond the reactive pattern — exemplary), `storefront_product_form_screen.dart`, `WalletRequestSubmitButton`.

Dispose hygiene: clean app-wide — no `Timer`/`StreamSubscription` leaks anywhere in `lib/features/barber/`, all `TextEditingController`s disposed, `TabController`s in `BookingsHomeScreen`/`StorefrontHomeScreen`/`StoreHomeScreen` correctly disposed, `ResendButton`'s cooldown `Timer` correctly cancelled.

No `build()`-triggered side-effecting API calls found anywhere — all mutation/load triggers are correctly confined to `initState`, button callbacks, or route builders.

---

## After fixing

- [ ] `flutter analyze` clean on all touched files
- [ ] Manual test pass focused on double-tap behavior: rapid-tap every "Save"/"Add"/"Delete" button touched in P1, confirm no duplicate network calls fire (watch Chucker/Dio logs in dev flavor)
- [ ] Manual test pass on the P0 guard decisions: navigate away from and back to the shell (e.g. via a blocking-gate flow or logout/login) and confirm the chosen cubits skip their redundant reload while the ones that should still reload do
- [ ] Debug build succeeds

## Then repeat for merchant and customer

Same audit shape (auth → shell → every feature area, read line-by-line), same two-part focus (loading discipline on mutations, redundant/unnecessary calls), same output format. Do not start until this file's P0/P1 items are resolved and confirmed working.
