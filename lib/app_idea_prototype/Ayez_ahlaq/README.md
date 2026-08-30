# عايز أحلق — Flutter Source (3 apps)

Three independent Flutter apps, same visual system (dark ink + brass,
Cairo/Reem Kufi via `google_fonts`, RTL-only), same underlying story:

- **`ayez_ahlaq_customer`** — the customer-facing booking + shopping app.
- **`ayez_ahlaq_barber`** — the barber's dashboard (queue, schedule,
  earnings, team performance, walk-in registration, his own storefront).
  Also runs as a **desktop app** (Windows/macOS/Linux) from the same code.
- **`ayez_ahlaq_merchant`** — a wholesale supplier app. Strictly B2B: its
  entire catalog and every incoming order belongs to barber/shop accounts,
  never a regular customer.

Each is a separate, independently runnable Flutter project — ship them as
three separate apps (customer on the Play/App Store, barber as
mobile+desktop, merchant as a lightweight B2B portal).

## Getting started (per app)

```bash
cd ayez_ahlaq_customer   # or ayez_ahlaq_barber / ayez_ahlaq_merchant
flutter create . --platforms=android,ios
flutter pub get
flutter run
```

`flutter create .` in an existing folder only adds the missing platform
scaffolding (android/, ios/, etc.) — it never touches `lib/` or
`pubspec.yaml`. Re-run it any time you need another target.

### Building the barber app for desktop (Windows .exe)

This repo ships `lib/` + `pubspec.yaml` only — no platform folders, and no
compiled binary. Producing an actual `.exe` requires the Flutter SDK *and*
Visual Studio's "Desktop development with C++" workload installed on a
Windows machine — that toolchain isn't available in the environment this
was built in, so the exe couldn't be compiled here. Your developer gets a
real `.exe` in three commands, no code changes needed:

```bash
cd ayez_ahlaq_barber
flutter create . --platforms=windows
flutter pub get
flutter build windows
```

The `.exe` lands in
`build\windows\x64\runner\Release\ayez_ahlaq_barber.exe` (folder name may
be `x64` or `arm64` depending on the machine) — zip that whole `Release`
folder (it needs its sibling `.dll` files) to hand it to anyone else.
`main.dart` already wraps the UI in a centered, max-width column so it
doesn't stretch edge-to-edge on a wide desktop window.

## Project layout (same shape in all three apps)

```
lib/
  main.dart          entry point, theme + Provider wiring, forces RTL
  theme/              colors, text styles, ThemeData
  models/             plain Dart data classes (no backend coupling)
  data/mock_data.dart all mock/demo content — swap for real API calls here
  state/              ChangeNotifier holding all app state (Provider)
  widgets/            shared building blocks (buttons, cards, badges…)
  screens/            one file per screen
```

## Where to plug in a real backend

1. **`lib/data/mock_data.dart`** in each app — static lists (shops,
   barbers, services, haircut styles, products, queue, reviews…). Replace
   with repository calls that hit your API and return the same model
   types.
2. **`lib/state/*.dart`** — the single `ChangeNotifier` every screen reads
   from via `context.watch<...>()`. Mutator methods (`confirmBooking`,
   `addToCart`, `startService`, `addWalkIn`, `advanceOrderStatus`, …)
   currently just mutate in-memory lists; swap their bodies for API calls
   and nothing in `screens/` needs to change.

No navigation package — just Flutter's built-in `Navigator` for flow
screens, and an `IndexedStack` + custom bottom nav (`MainShell`) for the
tabbed sections.

## What's new since the first drop

- **Haircut style picker.** After choosing the service ("نوع الخدمة"),
  the customer picks the specific look **by name** (مولت، فيد، أندركت…)
  from a small square swatch gallery (`ChooseStyleScreen`) — each style
  has its own price add-on (`HaircutStyle.priceDelta`), reflected all the
  way through to the booking summary and history.
- **Barbers selling to customers.** A barber's own products
  (`BarberState.myProducts`, managed from "منتجاتي") now also show up in
  the **customer app** on the shop's page ("منتجات الحلاقين هنا",
  `ShopDetailScreen`) — separate from the wholesale catalog in `المتجر`,
  which comes from merchants and is barber-only.
- **Walk-in registration.** From "الطابور" in the barber app (and, once
  built, the desktop app — same `BarberState`), "عميل من الشارع" opens a
  form to register someone who showed up without booking through the app:
  which team barber served them, what service, what time, done or still
  in the chair. It's added straight into `queueToday`, the same list the
  rest of the queue UI reads from.
- **Team performance tab ("الفريق").** Ranks every barber at the shop by
  clients served this month + rating (`MockData.team`,
  `screens/team_screen.dart`) — highlights "أنت" and the top performer.
- **Merchant app (new, 3rd project).** Manages a wholesale product
  catalog and fulfills purchase orders placed by barbershops
  (`MerchantState`, `screens/orders_screen.dart`) — no consumer-facing
  storefront at all, by design.
- **Barber app tabs reshuffled:** لوحتي، الطابور، **المتجر** (now a main
  tab — same browse/buy experience as the customer app, buying shop
  supplies from merchants), **الفريق**، أرباحي، حسابي. **الجدول** (weekly
  hours) moved into حسابي → الإدارة, alongside **منتجاتي** (the barber's
  own storefront) and **تسجيل عميل من الشارع** is reachable from الطابور.

## Notes

- State management: `provider`.
- Fonts load from Google Fonts at runtime — no font files to bundle.
- The customer app's booking flow and the barber app's queue share one
  demo booking (محمد سعيد / مختار توفيق, 12:30) so both apps visibly tell
  the same story when demoed side by side; the merchant app's sample
  orders reference the same shop names (صالون الملك، صالون الأصالة…) for
  the same reason.
- All three apps are RTL-only for this prototype (forced via
  `Directionality` in `main.dart`) — no `flutter_localizations` wiring
  yet. Add it if/when an English locale is needed.
- None of the three apps share a live backend (there isn't one yet), so
  data added in one (e.g. a barber's new product) won't appear in another
  app's running instance automatically — each app's `mock_data.dart` has
  been hand-kept in sync where the demo needs it to (e.g. محمد سعيد's two
  sample products appear in both his own app and the customer app).
  Wiring a real API removes this limitation for free, since every screen
  already reads only from `state/`, never straight from mock data.
