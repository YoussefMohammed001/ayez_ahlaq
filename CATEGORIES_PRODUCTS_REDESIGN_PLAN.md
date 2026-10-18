# Categories + Products redesign — plan

Base URL confirmed live: `https://gobeeeg.com/ayezAhlaqApi/api/` (the Postman collection's `localhost:8082` is a dev placeholder — ignore it). All endpoints below were hit live during this session with real accounts (barber `01008451421`, merchant `01001234599`, customer `01555555555`) — response shapes are verified, not guessed from the collection.

## What actually changed vs what's already in the code

The old mental model (and the old `barberStoreMerchant*` endpoints already in [endpoints.dart](lib/core/network/constants/endpoints.dart#L145-L149)) was: **barber picks a merchant first, then sees that merchant's products.** The new collection adds a genuinely different, flatter path on top of that — it does not replace the merchant-scoped endpoints, it adds a cross-merchant feed in front of them.

Three barber-side endpoints are **new and missing from `endpoints.dart`**:
- `GET /barber/store/product` — flat, cross-merchant product feed with filters
- `GET /barber/store/category` — flat global category chips (for filtering the feed above)
- `POST /barber/store/quote` — price/delivery/discount preview before checkout

The existing `barberStoreMerchant` / `barberStoreMerchantProducts` endpoints stay — they now serve the **drill-down** ("view this one merchant's full store"), not the primary entry point.

## Verified response shapes (live, not from the collection doc)

**`GET /barber/store/product?sort=relevant&limit=20`** → `{data: {items: [...], nextCursor}, message, status}`. Each item:
```
{id, name, brand, price, effectivePrice, imageUrl, inStock, rating,
 minOrderQty, merchantId, merchantName, merchantRating, distanceKm,
 deliveryOffered, badges: ["sponsored", "ordered"]}
```
Confirmed live: `merchantId`/`merchantName` are inlined on every product — this is what makes the feed "flat" (no need to fetch merchant separately to show who sells it). `badges` includes `sponsored` (paid placement) and `ordered` (barber has bought from this merchant before — likely drives a "reorder" affordance). Cursor pagination (`nextCursor`, base64-ish opaque string, not page numbers).

Filters confirmed working: `merchantId=`, `search=`, `limit=`. (`category=` and `cursor=` per the collection but not individually re-verified this session — same query-param mechanism, low risk.)

**`GET /barber/store/category`** → flat list `{id, name}` only (no sortOrder/active/image fields — those belong to the admin/management category object, this is just filter chips).

**`GET /barber/store/merchant`** → merchant list, confirmed fields: `id, businessName, phoneNumber, rating, ratingCount, productCount, deliveryOffered, deliveryFee, freeDeliveryOver, phones[], sponsored`. This is the "merchant directory" — still useful as a secondary browse path, or as the destination of "view this merchant's full store" from a product card.

**`GET /barber/store/merchant/{id}/product`** → drill-down, confirmed. Flatter item shape than the cross-merchant feed (no `merchantId`/`merchantName`/`badges`/`distanceKm` — you already know the merchant, you navigated there):
```
{id, name, brand, categoryName, price, effectivePrice, minOrderQty, hasImage}
```

**Customer side — two separate, both keyed by the same `shopId`:**
- `GET /customer/shop/{id}` → **full booking profile**: `{shop, barbers[] (with services[]), haircutStyles[], paymentMethods[], addons[], drinks[]}`. This is "view the barber's full profile" (for booking a haircut).
- `GET /customer/shop/{id}/storefront` → **product storefront only**: `{shopId, shopName, delivery, categories[], products[]}`. This is "view the barber's shop products" (for buying شامبو/جل/etc).

Both already exist in `endpoints.dart` (`customerShopById`, `customerShopStorefront`) — no gap here, just need the UI to route to the right one depending on user intent (Book vs Shop).

## Navigation model (answers your specific questions)

**Barber → products → view one merchant's full store:**
Barber home ("الشراء من الموردين") = flat feed screen backed by `GET /barber/store/product`, with category chips (`GET /barber/store/category`) and a search bar up top, sponsored items naturally surfacing first via `badges`. Tapping a product's merchant name/avatar on a card navigates to a **merchant profile screen** backed by `GET /barber/store/merchant/{id}/product` (+ merchant header data, either passed via `state.extra` from the card or re-fetched from `GET /barber/store/merchant` filtered client-side by id — prefer passing via `extra` to avoid a redundant call). The existing merchant-list screen (`GET /barber/store/merchant`) stays as a secondary "Browse merchants" entry, reusing the same merchant-profile destination.

**Customer → barber shop or full profile:**
From wherever a customer currently taps into a shop (search, favorites, home list), branch to two destinations sharing the same `shopId`:
- "احجز موعد" (Book) → full profile screen, `GET /customer/shop/{id}`
- "تسوق من المتجر" (Shop) → storefront screen, `GET /customer/shop/{id}/storefront`

No missing endpoint here — this was already wired for a single shop; the redesign is UI/navigation only on the customer side.

## Feature-folder plan (per [CLAUDE.md](CLAUDE.md) architecture)

New feature: `lib/features/barber/store/` (rename/absorb if a `home_service_requests`-sibling folder for the old merchant-first flow already exists under barber — check before creating a parallel one).

```
features/barber/store/
  data/
    apis/store_api.dart              storeProducts(), storeCategories(), storeMerchants(),
                                      merchantProducts(merchantId), quote(), cart*, order*
    models/store_product_model.dart  flat-feed item (merchantId/merchantName/badges/distanceKm)
    models/merchant_product_model.dart   drill-down item (categoryName, no merchant fields)
    models/store_merchant_model.dart
    repos/store_repo.dart
  domain/
    entities/store_product.dart
    entities/merchant_product.dart
    entities/store_merchant.dart
    repos/i_store_repo.dart
    use_cases/get_store_products_use_case.dart   (search/category/merchantId/sort/cursor params)
    use_cases/get_store_categories_use_case.dart
    use_cases/get_store_merchants_use_case.dart
    use_cases/get_merchant_products_use_case.dart
    use_cases/get_store_quote_use_case.dart
  presentation/
    manager/store_feed_cubit.dart + store_feed_state.dart      (paginated feed + filters)
    manager/merchant_profile_cubit.dart + _state.dart          (one merchant's products)
    pages/store_feed_screen.dart        chips + search + sponsored-first grid
    pages/merchant_profile_screen.dart  merchant header + product grid
    widgets/store_product_card.dart     shows merchantName + badges, tap -> merchant profile
    widgets/store_category_chips.dart
```

Keep existing barber cart/checkout/order/quote code as-is if already ported (this collection's section 4 cart/checkout/order endpoints match what's already in `endpoints.dart`: `barberCart`, `barberCartCheckout`, `barberStoreQuote`, `barberOrder`).

## `endpoints.dart` additions needed

```dart
static const String barberStoreProduct = 'barber/store/product';
static String barberStoreMerchantProductsAlt(int merchantId) =>
    'barber/store/merchant/$merchantId/product'; // already exists as barberStoreMerchantProducts — reuse, don't duplicate
static const String barberStoreCategory = 'barber/store/category';
// barberStoreQuote already exists — reuse
```
Only `barber/store/product` and `barber/store/category` are genuinely missing; everything else needed already has a constant.

## Sequencing

1. Add the two missing endpoint constants.
2. Domain layer: entities + `IStoreRepo` + use cases (list above).
3. Data layer: models (`json_serializable`) + api + repo impl, register in `services_locator.dart` (`Api`/`Repo` as lazy singletons, `Cubit` as factory).
4. `StoreFeedCubit`: paginated (cursor-based `loadMore`), holds current filters (category/search/sort/merchantId), calls `GetStoreProductsUseCase`.
5. `store_feed_screen.dart`: chips row (`GetStoreCategoriesUseCase` on init) + search field + infinite-scroll grid of `StoreProductCard`. Each card shows `sponsored`/`ordered` badge via existing badge/tag widget pattern if one exists in `core/widgets/` (check before building a new one).
6. `merchant_profile_screen.dart`: reached via `Routes` constant + `state.extra` (merchant header fields) + `merchantId` path param; fetches products via `GetMerchantProductsUseCase`.
7. Wire "Browse merchants" secondary entry (existing `GET /barber/store/merchant` list) to push into the same `merchant_profile_screen.dart`.
8. Customer side: no new data layer. Just confirm/add the two-destination navigation (Book vs Shop) wherever a shop is currently tapped from a list — likely `features/customer/.../shop_card.dart` or equivalent; needs an Explore pass to find the current single-destination tap handler before editing.
9. `flutter analyze` + `dart run build_runner build --delete-conflicting-outputs` after models are added.

## Open items to verify before/while building

- ~~`category=` and `cursor=` params on `GET /barber/store/product` weren't independently re-tested~~ — **verified live 2026-09-26**: `category=3` correctly filters, and `cursor=` pagination advances correctly page over page with no gaps/repeats (tested 3 consecutive pages against merchant 10's products).
- Whether `GET /barber/store/merchant/{id}` (single-merchant header, no product list) exists as its own endpoint wasn't tested — **resolved by implementation**: the merchant-profile screen (existing `BarberStoreProductsScreen`) gets its header from `BarberStoreMerchantsCubit`'s cached merchant list (found by id), never re-fetched. No such single-merchant endpoint was needed.

## Implementation status (2026-09-26)

Barber-side flat feed fully implemented in `lib/features/barber/store/`:
- New: `domain/entities/{store_feed_product,store_feed_page,store_category,store_feed_sort}.dart`, matching models, `data/apis/barber_store_feed_api.dart`, `domain/repos/i_barber_store_feed_repo.dart` + `data/repos/barber_store_feed_repo.dart` (kept separate from the existing `IBarberStoreRepo`/`BarberStoreRepo` to respect the 150-line file cap), use cases, `BarberStoreFeedCubit`/`State`, `BarberStoreFeedScreen` (+ `StoreFeedFiltersBar`, `StoreFeedGrid`, `StoreFeedProductCard` widgets).
- `StoreHomeScreen`'s first tab now hosts the flat feed; the old merchant-list screen moved to a "Browse suppliers" app-bar action (new route `barberStoreMerchantsBrowseScreen`), still pushing into the existing `BarberStoreProductsScreen` drill-down.
- Tapping a feed card's merchant looks up the merchant object from `BarberStoreMerchantsCubit`'s cached list (loaded eagerly alongside the feed) and pushes the existing drill-down screen with it as `extra` — avoids needing a new single-merchant-header endpoint.
- `flutter analyze` clean on all new/changed files; l10n regenerated via `intl_utils` (see corrected command in memory, CLAUDE.md's `flutter gen-l10n` doesn't apply to this repo).

## Customer storefront parity pass (2026-09-26, later)

Brought the customer single-shop storefront (`lib/features/customer/store/`) up to the same experience as the barber flat feed:
- **Fixed a pre-existing bug**: `StoreProductModel.fromJson` read a JSON key `hasImage` that the server never sends (real key is `hasOwnImage`) — product images in the customer storefront were always showing the placeholder icon. Fixed to read `hasOwnImage` first, falling back to `hasImage`.
- Added `effectivePrice` + `isDiscounted`/`discountPercent` to `StoreProduct` entity/model (previously not modeled at all client-side, despite the server already returning it) — mirrors the barber-side `StoreFeedProduct` computation.
- New shared `core/widgets/discount_percent_badge.dart` — extracted so both barber and customer sides render the identical discount pill instead of duplicating it; retrofitted the barber's card/details screen to use it too.
- New `core/widgets/app_search_field.dart` reused here as well (`StoreFiltersBar`).
- Added client-side `search`/`categoryId` filter state directly on `StoreCartState`/`StoreCartCubit` (no new API calls needed — the whole storefront, including `categories[]`, already loads in one call via `GET /customer/shop/{id}/storefront`, so filtering is local, unlike the barber's server-paginated feed).
- New `StoreProductDetailsScreen` (tap a product row → detail view: image, price + discount badge, min order qty, quantity stepper) + route `customerStoreProductDetailsScreen`.
- Split `store_products_screen.dart`'s body into `StoreProductsList` widget to stay under the 150-line cap.
- `flutter analyze` clean, no regressions (same 20 pre-existing issues elsewhere).

Customer-side "Book vs Shop" two-destination navigation: **implemented**. Found via Explore pass that the customer storefront screen (`StoreProductsScreen`, `lib/features/customer/store/`) already existed and was already reachable — but only via a storefront icon button inside `CustomerShopDetailScreen` (the booking-profile screen), one hop away from any shop list. Added a direct "Shop" shortcut icon (`onShopTap`) to `ShopRow` (used by both `browse_shops_screen.dart` and `nearest_shops_section.dart`) and `FavoriteBarberRow` (`favorites_screen.dart`), each pushing `Routes.customerStoreProductsScreen` with the shop's `int` id — same contract the existing icon button already used, no new route or screen needed. All 3 real shop-list tap sites now offer both destinations directly from the card. `flutter analyze` clean, no regressions.
