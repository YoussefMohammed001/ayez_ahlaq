# Customer flow — reported issues (2026-09-17)

## Bugs

- [x] 1. FAB in customer shell removed (user decided: no real destination exists yet — booking requires picking a shop first, no "all shops" screen exists). Deleted `customer_booking_fab.dart`; customer shell now uses new `FlatBottomNavBar` (no notch) instead of the shared `NotchedBottomNavBar` (which barber still uses correctly, since barber keeps its FAB).
  - `lib/core/widgets/flat_bottom_nav_bar.dart` (new)
  - `lib/features/customer/presentation/pages/customer_shell.dart`

- [x] 2. "My Bookings" screen (from Profile) had no back button — fixed, added explicit leading `IconButton` matching `AppTopBar`'s style (couldn't reuse `AppTopBar` directly since this screen needs a `TabBar` bottom slot that `AppTopBar` doesn't support; barber's equivalent screen is a shell tab so it correctly has no back button, this one is pushed via `context.push` so it needed one).
  - `lib/features/customer/booking/presentation/pages/my_bookings_screen.dart`

- [x] 3. Home service booking flow — confirmed it exists end-to-end (`lib/features/customer/home_service/`), entry point is `HomeServiceEntryCard` on `customer_dashboard_screen.dart`. Not a bug — needs UX/visibility improvement (see below, 3b).

- [x] 4. "Nearest barbers/salons" stuck on loading forever — fixed. Same bug also hit the home-service shop list (user confirmed separately). Root cause: `Geolocator.getCurrentPosition()` had no timeout in both `customer_shops_cubit.dart` and `home_service_shops_cubit.dart` (duplicated code), hanging indefinitely on poor/no GPS fix. Extracted shared `CurrentPositionResolver` (`lib/shared/location/current_position_resolver.dart`) with an 8s timeout, wired into both cubits via DI (`CustomerShopsCubit(sl(), sl())`, `HomeServiceShopsCubit(sl(), sl())` in `services_locator.dart`).

- [x] 6. Crash opening order details from Store Orders list — fixed.
  - `lib/features/customer/store/data/repos/customer_store_repo.dart:70-74` — `getOrders()` built a list via `.map((e) => StoreOrderModel.fromJson(...)).toList()` with no explicit type arg, so the reified runtime type was `List<StoreOrderModel>` even though declared as `List<StoreOrder>`. `firstWhere` in `store_order_details_screen.dart:30-33` then inferred its generic from the concrete list, requiring `orElse` to return `StoreOrderModel`, but the widget's `order` field is typed `StoreOrder` → crash.
  - Fix: added explicit `.map<StoreOrder>(...)` type argument so the list is genuinely reified as `List<StoreOrder>`.

## UX / redesign

- [x] 5. Reorganize customer Profile like barber Profile (hub-and-spoke menu screens instead of one flat menu) — done.
  - Moved shared `ProfileMenuSectionScreen` from `barber/profile/presentation/widgets/` to `lib/shared/widgets/` (now used by both features) and repointed all 7 barber menu screens to it.
  - `customer_profile_menu.dart` rewritten as a top-level hub (`MenuSection` with 4 rows: Account, Bookings & Services, App Settings, Support) instead of the old flat two-`MenuSection` list.
  - New hub screens (all `ProfileMenuSectionScreen`, ≤150 lines): `customer_account_menu_screen.dart` (change password, delete account), `customer_bookings_and_services_menu_screen.dart` (bookings, home service, wallet, reviews), `customer_app_settings_menu_screen.dart` (theme, language), `customer_support_menu_screen.dart` (about, logout).
  - Notifications row (with `CustomerUnseenNotificationsBadge`) stays on the top-level `customer_profile_menu.dart`, not inside a sub-screen — `CustomerNotificationsCubit` is only provided by the `MultiBlocProvider` around `customerShell` (`app_routes.dart:554-566`), and a `context.push`'d hub screen is a sibling route outside that provider scope, so the badge threw `ProviderNotFoundException` when first placed in `customer_app_settings_menu_screen.dart`. Matches how barber already does it (`barber_profile_menu.dart` keeps its own notifications row at the top level for the same reason).
  - New routes added to `route_paths.dart`/`app_routes.dart`: `customerAccountMenuScreen`, `customerBookingsAndServicesMenuScreen`, `customerAppSettingsMenuScreen`, `customerSupportMenuScreen`.
  - New l10n key `bookingsAndServicesSection` added to both arb files, regenerated via `dart run intl_utils:generate`.

- [x] 7. Phone-verified users should show a "verified" green checkmark badge — done, using `active` as the verification signal for all three types (user decision: Postman collections only confirm an `otpVerified` field for customer; barber/merchant only expose `active`, already used elsewhere as their account-approval status badge).
  - `InfoRow` (`core/widgets/info_row.dart`) got a new optional `verified` flag that renders a small `Icons.verified_rounded` in `context.semantic.success` next to the value.
  - Wired `verified: profile.active` into the phone-number `InfoRow` in all three profile screens (`customer_profile_screen.dart`, `barber_profile_screen.dart`, `merchant_profile_screen.dart`) plus `barber_profile_details_screen.dart`. Left `member_info_card.dart`'s `member.active` alone — that's team-member blocked/active status, not phone verification.

- [x] 8. Prevent a customer from rating the same barber/shop twice — investigated, already correctly guarded, no code change needed. Rating is per-booking (`booking.ratedBarber` / `booking.ratedShop`), not a global "rate this barber" action: `booking_detail_screen.dart` only shows the "Rate" button while at least one of the two is still unrated, and `RateBookingSheet` walks barber → shop and closes once both are done. `BookingDetailCubit.rateBooking` also disables the submit CTA via `isRating` while a request is in flight, preventing double-submit races.

- [x] 9. Barber/shop profile page flow is unclear — done (visual polish only, no navigation change, per user decision — the existing Service → Style → Barber → Time booking flow can't jump straight to a specific barber without a service already chosen, so barber rows stay non-interactive; "Book Now" remains the only booking entry point).
  - `shop_barber_row.dart` rebuilt: bigger/bolder barber name, avatar, real `BarberStatusBadge` (reused from the booking flow) instead of nothing, and a visible per-barber favorite `IconButton` (was previously only a single favorite icon in the app bar, hardcoded to the shop owner).
  - `customer_shop_detail_cubit.dart`'s `toggleFavorite` now targets whichever barber's icon was tapped instead of always resolving to the shop owner — matches how the favorites API actually works (`AddFavoriteUseCase`/`RemoveFavoriteUseCase` are per-barber-id, there's no shop-level favorite endpoint).
  - Split the 176-line `customer_shop_detail_screen.dart` (over the 150-line cap) into `shop_detail_header_card.dart` (shop name/rating/address in an `AppCard`), `shop_detail_body.dart`, and `shop_payment_methods_row.dart`.

- [x] 3b. Home service flow was undiscoverable — fixed. Also separately confirmed the home-service shop list was stuck loading (same Geolocator timeout bug as #4, fixed there).
  - Added `QuickActionsSection` (new, horizontal row of icon-over-label items per user's requested layout) to top of dashboard: `lib/features/customer/presentation/widgets/quick_actions_section.dart` + `quick_action_item.dart`. Currently has Home Service + My Bookings actions.
  - Wired into `customer_dashboard_screen.dart`, replacing the old single-row `HomeServiceEntryCard` (deleted, now redundant).
  - Added a "Home service" row to Profile menu too: `customer_profile_menu.dart`.
  - Added `quickActionsTitle` l10n key to both `intl_ar.arb`/`intl_en.arb`, regenerated via `dart run intl_utils:generate`.

---
Source: user report 2026-09-17, screenshot of profile/contact screen + Arabic notes.
