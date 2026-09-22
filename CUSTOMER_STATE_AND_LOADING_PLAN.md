# Customer state caching + home refresh + blocking-loading plan (2026-09-17)

Source: user report, Arabic — cubits leak stale data on relogin/switch, home screen needs pull-to-refresh, booking cancel (and future edit) needs a blocking `showLoading()` so the user can't interact until the call finishes.

---

## 1. Root cause of the "flashes another user's/old data" bug

`lib/core/routes/app_routes.dart` declares **45 cubits as top-level `final` variables**, e.g.:

```dart
final CustomerShopsCubit _customerShopsCubit = sl<CustomerShopsCubit>();
final CustomerProfileCubit _customerProfileCubit = sl<CustomerProfileCubit>();
final MyBookingsCubit _myBookingsCubit = sl<MyBookingsCubit>();
final StoreOrdersCubit _customerStoreOrdersCubit = sl<StoreOrdersCubit>();
final FavoritesCubit _customerFavoritesCubit = sl<FavoritesCubit>();
final BookingDetailCubit _customerBookingDetailCubit = sl<BookingDetailCubit>();
// ...and 39 more, across customer/barber/merchant
```

A top-level `final` in Dart is evaluated **once**, the first time the library is touched, and lives for the app's process lifetime. Even though `services_locator.dart` registers every one of these with `sl.registerFactory(...)` (a new instance per resolve — the correct choice per `CLAUDE.md`), the `sl<XCubit>()` call here only ever runs once. Every `GoRoute` builder that does `BlocProvider.value(value: _customerShopsCubit, ...)` hands out **the exact same instance**, forever, for the life of the app.

Effect: if the app logs out and a different account logs in (or the same account's data changes on the backend), these cubits still hold whatever state they had from the previous session until something explicitly calls `.loadX()` again. Since most `initState()`s only call `loadX()` once and don't clear first, the widget briefly renders the **old cached state** on first build, then flips to new data once the load resolves — exactly the "بيظهر لثواني داتا حد تاني" symptom.

This is not customer-specific — it is the same pattern for all three user types — but only customer was reported, so customer is in scope for the fix; barber/merchant should get the same fix in a follow-up pass once this is validated, since the bug is identical there.

### Fix options (pick one before starting)

- **A. Reset cubits to their initial state on logout.** Add a `resetToInitial()` (or similar) to each affected cubit and call it from the logout handler(s) in `app_routes.dart` (`_handleCustomerLogout` and equivalents) before navigating to the login/user-type screen. Minimal change, keeps the existing DI shape, but has to be done for every affected cubit (and kept in sync if new ones are added).
- **B. Stop using top-level `final` cubit singletons; resolve via `sl<T>()` (or a fresh `BlocProvider(create: ...)`) at the point each route is built**, matching what `registerFactory` already promises. Larger diff across `app_routes.dart`, but removes the whole class of bug permanently and matches the DI contract already documented in `CLAUDE.md` ("Cubit as `registerFactory`" — the intent was clearly per-navigation instances, not app-lifetime ones).
- **C. Hybrid** — keep singletons only for genuinely app-lifetime cubits (e.g. `CustomerNotificationsCubit`, which is intentionally shared — see `CLAUDE.md`'s note on "Cubit as `registerFactory` (except app-lifetime cubits)"), and switch the rest to option B.

**Recommendation:** C. Some of these 45 are probably meant to be app-lifetime (shell-scoped: profile, notifications) and some clearly should not be (`BookingDetailCubit`, `CustomerShopDetailCubit` — per-screen, keyed by an id). Needs a pass to classify each one before touching `app_routes.dart`.

### Scope decision needed
Confirm before starting: fix customer cubits only in this pass, or all 45 (customer + barber + merchant) in one pass since it's the same bug. Doing customer only risks the same complaint coming back for barber/merchant later.

---

## 2. Home screen pull-to-refresh

`lib/features/customer/presentation/pages/customer_dashboard_screen.dart` currently has **no `RefreshIndicator`** — data is loaded exactly once, in `CustomerShell.initState()` (`lib/features/customer/presentation/pages/customer_shell.dart:39-44`):

```dart
context.read<CustomerShopsCubit>().loadShops();
context.read<StoreOrdersCubit>().loadOrders();
context.read<FavoritesCubit>().loadFavorites();
context.read<CustomerProfileCubit>().loadProfile();
context.read<CustomerNotificationsCubit>().refreshUnseenCount();
context.read<MyBookingsCubit>().loadBookings();
```

The dashboard screen itself only reads a subset of these (shops via `NearestShopsSection`, bookings via `UpcomingBookingsSection`, orders via `DashboardOrdersSection`) plus the profile for the greeting.

### Plan
Wrap `customer_dashboard_screen.dart`'s `ListView` in a `RefreshIndicator` (same pattern already used on `MyStoreOrdersScreen`, `CustomerShopDetailScreen`, `BookingDetailScreen` — search "RefreshIndicator" for reference). On pull, re-trigger the loads that actually feed what's visible on this screen:

```dart
Future<void> _refresh(BuildContext context) => Future.wait([
  context.read<CustomerShopsCubit>().loadShops(),
  context.read<MyBookingsCubit>().loadBookings(),
  context.read<StoreOrdersCubit>().loadOrders(),
  context.read<CustomerProfileCubit>().loadProfile(),
]);
```

No new cubit methods needed — `loadShops`, `loadBookings`, `loadOrders`, `loadProfile` already exist and already support being called again (they re-emit `loading` → `success`/`failure`). This part is low-risk and independent of the section-1 caching fix (though it's easiest to verify both together, since a correct pull-to-refresh is also validation that the cubit isn't stuck holding stale state).

---

## 3. Blocking `showLoading()` during booking cancel (and future edit)

`core/helpers/alerts.dart` already has exactly what's needed:

```dart
Future<void> showLoading({bool canDismiss = false}) // full-screen blocking dialog, default not dismissible
void hideLoading()
```

Already used this way elsewhere, e.g. `barber_profile_menu.dart`:
```dart
await showLoading();
await onLogout();
hideLoading();
```

### Cancel booking
`lib/features/customer/booking/presentation/pages/booking_detail_screen.dart:32-41` (`_cancel()`) currently only disables the button and shows an inline `CircularProgressIndicator` via `state.isCancelling` — the rest of the screen (including the app bar back button, pull-to-refresh, any nav) stays interactive during the cancel call. Wrap it:

```dart
Future<void> _cancel() async {
  final cubit = context.read<BookingDetailCubit>();
  await showLoading();
  final success = await cubit.cancelBooking(widget.bookingId);
  hideLoading();
  if (!mounted) return;
  if (success) {
    showSuccess(S().bookingCancelledMessage);
  } else if (cubit.state.errorMessage != null) {
    showError(cubit.state.errorMessage!);
  }
}
```

Keep or drop the existing `state.isCancelling` button-spinner — redundant once `showLoading()` blocks the whole screen, but harmless to leave as a secondary visual cue. Decide during implementation.

Also add a confirmation step before cancelling (there isn't one today — tapping "إلغاء الحجز" cancels immediately), consistent with the confirm-before-submit pattern just added to the booking summary screen. Reuse `showConfirmDialog` (`core/helpers/show_confirm_dialog.dart`), `isDestructive: true` since cancelling is a destructive action, before calling `showLoading()`.

### Edit booking — **does not exist yet**
Checked the customer Postman collection (`postman/Ayez_ahlaqCustomer.postman_collection.json`, "Haircut booking" folder): the backend only exposes
```
POST   /api/customer/booking                      create
GET    /api/customer/booking                       list
GET    /api/customer/booking/{id}                   detail
PUT    /api/customer/booking/{id}/cancel            cancel
```
**There is no update/reschedule endpoint.** "تعديل" (edit) cannot be wired to `showLoading()` because there is nothing to call yet — this needs a real feature (new use case, repo method, endpoint, screen) before a loading state is meaningful. Two options:
- Confirm with the backend whether an edit/reschedule endpoint exists or is planned, and scope it as a separate feature ticket once confirmed.
- If "تعديل" actually meant something narrower already in the app (e.g. editing the note on a pending booking, or changing payment method before confirmation — which *is* still possible pre-submit in the booking flow, just not post-booking), clarify which action is meant.

**Do not start building an edit-booking screen until this is resolved** — it's the one item in this request that isn't a matter of wiring existing pieces together.

---

## Suggested order of work

1. Classify the 45 `app_routes.dart` cubit singletons (app-lifetime vs per-navigation) — a short audit, no code changes yet.
2. Fix customer cubits per the classification (option C above): reset-on-logout for app-lifetime ones, switch to fresh-per-navigation for the rest.
3. Add `RefreshIndicator` + `_refresh()` to `customer_dashboard_screen.dart`.
4. Add `showConfirmDialog` + `showLoading()`/`hideLoading()` around `BookingDetailScreen._cancel()`.
5. Get an answer on "edit booking" scope before touching it.
6. Manually verify the original repro: log out, log in as a different customer account, confirm no stale data flash on the shell's first frame.
