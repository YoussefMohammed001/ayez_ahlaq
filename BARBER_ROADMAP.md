# رود ماب الحلاق

مرجع دايم — عدّل الحالة هنا كل ما نخلّص حاجة. الترتيب مقصود، متتخطاش خطوة إلا لو فيه سبب.

**خلص:** Auth (login بـ `identifier`+`password`+`X-Client`) · Profile (`GET /barber/me` + nav bar بستايل التاجر) · Working hours + Services & prices (`barber/hours`, `barber/service/catalog`, `barber/service` CRUD) · Documents (`barber/attachment`) · Store & orders (شراء من تاجر)

**✅ اتعملت فجوة الـ Profile بالكامل:** `PUT /barber/location` (زرار "استخدام موقعي الحالي" بـ `geolocator` + حقل عنوان يدوي، الحقول التلاتة اختيارية) و`PUT /barber/password` (تغيير كلمة السر — نسخة طبق الأصل من شاشة التاجر). الاتنين متوصلين من قايمة البروفايل. `BarberProfile` entity اتضاف لها `latitude`/`longitude`.

**مرجع دايم للـ API:** الـ Postman collections الكاملة (barber/merchant/customer) محفوظة في `postman/*.json` — اقرأها قبل أي feature جديدة بدل التخمين.

---

## ١. Working hours + Services & prices — ✅ خلص
- `GET/PUT /barber/hours` — أسبوع كامل، ٧ أيام، `dayOfWeek` 0-6 — `features/barber/hours/`
- `GET /barber/service/catalog` — الأنواع المتاحة مش مقدَّمة لسه
- `GET/POST/PUT/DELETE /barber/service` — الخدمات اللي بيقدّمها الحلاق — `features/barber/services/`
- الخدمات كانت تاب أساسي في الـ bottom nav وبعدين اترجعت تحت البروفايل (`Routes.barberServicesScreen`) جنب الساعات — الاتنين settings-ish وملهومش داعي ياخدوا تاب لوحدهم. الـ bottom nav دلوقتي: الحجوزات / المتجر / حسابي (٣ تابز بس). `BarberServicesCubit` لسه متعمول provide على مستوى الـ shell عشان `AddWalkInSheet` بيحتاجه.
- الـ JSON اتأكد من الـ Postman collection الحقيقي

## ٢. Bookings & queue — ✅ خلص
`features/barber/bookings/` — قائمة معلقة (pending) + طابور اليومي (queue) في شاشة واحدة بـ tabs، تفاصيل حجز، confirm/reject/تقدّم الحالة، walk-in.
- `GET /barber/booking` (list بفلتر date/status) · `pending` · `queue`
- `GET /barber/booking/{id}` (detail)
- `PUT /barber/booking/{id}/confirm` · `reject` (بسبب) · `status` (بيعتمد على `nextStatuses` القادم من السيرفر، مفيش ترتيب حالات متسلسل مكتوب في الكود)
- `POST /barber/booking/walkin`
- **بقت أول تاب في الـ bottom nav** (الحجوزات / المتجر / حسابي) بدل ما تتحط تحت البروفايل — لأنها أهم شاشة يومية للحلاق
- **مهم:** السيرفر هو المسؤول عن التصفية — الـ owner بيشوف حجوزات كل المحل (كل حجز فيه `barberId`/`barberName` واضح)، وعضو الفريق بيشوف حجوزاته بس تلقائيًا من نفس الـ endpoint، مفيش فلترة client-side.
- الويدجت بتاعة تفاصيل الحجز بتستخدم spread operator (`[...pending, ...queue]`) بدل الاعتماد على list مبني بـ `.map().toList()` عشان تتفادى نفس bug الـ type-mismatch اللي حصل قبل كده في `barber/store`.
- **تعديلات إضافية بعد المراجعة:**
  - أول كارت في pending/queue كان لاصق في الـ `TabBar` من غير مسافة — اتضاف padding فوق.
  - الـ walk-in كان بيبعت `addons: []` فاضية دايمًا — دلوقتي فيه `WalkInAddonsField` بيدي اختيار فعلي من منتجات "متجرك" (Storefront) بـ quantity stepper، وبيتبعت في الـ request زي المفروض.
  - `TeamScreen` كانت بتعرض الـ owner (اللي مسجل دخول) في ليستة الفريق — اتصلحت تستبعده (`!m.owner`) لأنه مش عضو تدير نفسك بيه.
  - الـ walk-in كان بيبعت `barberId: null` دايمًا (مفيش UI أصلاً لاختياره) — دلوقتي لو اليوزر owner (`BarberProfileCubit.state.profile?.owner`) بيظهر `WalkInBarberField` (دروب داون فيه "ليّا أنا" + كل أعضاء الفريق ما عدا الـ owner نفسه، من `BarberTeamCubit`) وبيتبعت `barberId` الصح. لو مش owner الحقل مش بيظهر خالص وبيتبعت `null` زي ما المفروض (يبقى للحلاق نفسه). الـ `BarberTeamCubit` بقى متعمول provide جوه `AddWalkInSheet.show()` بس (مش على مستوى الـ shell) عشان مالوش داعي غير هنا.

## ٣. Documents — ✅ خلص
نسخة طبق الأصل من `merchant/documents` — `features/barber/documents/`.
- `GET /barber/attachment` · `POST/DELETE /barber/attachment/{id}/file` · `GET .../file` (تحميل)
- متوصلة من قايمة البروفايل (`Routes.barberDocumentsScreen`)

## ٤. Store & orders (شراء من تاجر) — ✅ خلص
`features/barber/store/` — merchants list → products (+ quantity stepper) → cart (fulfillment type + note + quote) → place order → orders list/detail/cancel.
- `GET /barber/store/merchant` · `GET /barber/store/merchant/{id}/product`
- `POST /barber/store/quote` · `POST /barber/order`
- `GET /barber/order` · `GET /barber/order/{id}` · `PUT /barber/order/{id}/cancel`
- المتجر بقى تاب أساسي في الـ bottom nav (مش تحت البروفايل). "طلباتي" (`Routes.barberStoreOrdersScreen`) لسه تحت البروفايل كسجلّ.
- أيقونة سلة + badge في `AppTopBar` لشاشة التجار عشان السلة تبقى واضحة ومتاحة دايمًا.
- **فجوة معروفة:** مفيش endpoint موثّق لصورة منتج التاجر من ناحية الحلاق (بس `hasImage: bool`) — الصفوف بتعرض أيقونة placeholder. لو ظهر endpoint فعلي (زي `customer/shop/{id}/storefront/product/{id}/image` بس لسياق التاجر) نضيفه بعدين.

### ⏳ Follow-up: هجرة السلة من client-side لـ server-side cart API
دلوقتي فيه endpoints فعلية للسلة ظهرت — لسه متعملة في الكود. الكود الحالي: `BarberStoreCartCubit` بيبني السلة كلها client-side (مفيش persist في السيرفر إلا لحظة `POST /barber/order`)، والـ quote عن طريق `POST /barber/store/quote`.

الـ endpoints الجداد:
- `GET /api/barber/cart` — يرجع السلة الحالية من السيرفر
- `PUT /api/barber/cart` — يستبدل محتوى السلة كامل، بودي `{"items":[{"productId":..,"quantity":..}]}` (`items:[]` لتفريغ السلة)
- `POST /api/barber/cart/checkout` — يعمل checkout للسلة الحالية، بودي `{"fulfillmentType":"DELIVERY"|"PICKUP_AT_BRANCH","deliveryAddress":..,"deliveryLat":..,"deliveryLng":..,"note":..}` (العنوان/الإحداثيات اختيارية لـ B2B، مفيش `paymentMethod`)

المطلوب لما نرجعلها:
- نتأكد هل `checkout` ده بديل لـ `POST /barber/order` القديم ولا بيتحط جنبه (يحتاج توضيح من الـ backend/Postman collection المحدّثة)
- لو بديل: نعمل `BarberCartApi`/`BarberCartRepo` جوه `features/barber/store/`، ونشيل الـ client-side state من `BarberStoreCartCubit` ونخليه بيتكلم مع `GET/PUT /barber/cart` بدل الـ local list
- السلة تبقى تتحفظ في السيرفر فعليًا (مش بس عند الـ checkout) — يبقى الـ bug القديم بتاع `openMerchant` reset (اتصلح قبل كده client-side) يتراجع مع السلوك الجديد
- نحدّث الـ Postman collection (`postman/Ayez_ahlaqBarber.postman_collection.json`) لو مش متحدّثة بالـ endpoints دي لسه

## ٥. Storefront (متجر الحلاق كبائع) — ✅ خلص
نسخة طبق الأصل من `merchant/products` + `merchant/categories` + `merchant/delivery` + `merchant/orders` — `features/barber/storefront/{products,categories,delivery,orders}/`.
- Products: `GET/POST/PUT/DELETE /barber/storefront/product` + `stock`
- Categories: `GET /barber/storefront/category` (+ `own`) · `POST/DELETE` — مفيش update endpoint، متعملش
- Delivery: `GET/PUT /barber/storefront/delivery`
- Orders (عميل بيطلب من الحلاق): `GET /barber/storefront/order` · detail · `accept`/`reject`/`status` (forward-only، مفيش cancel للحلاق)
- متوصلة من قايمة البروفايل بـ row واحدة ("متجرك") بتفتح شاشة موحدة بـ 4 tabs (منتجات/تصنيفات/توصيل/طلبات) بدل 4 صفوف منفصلة — مفيش تاب جديد في الـ bottom nav
- إضافة تصنيف جديد ممكنة من جوه فورم المنتج نفسه (زرار "+" في شيت اختيار التصنيف) بدل ما ترجع تقفل الفورم وتروح شاشة التصنيفات لوحدها
- **فجوة معروفة:** زي `barber/store`، مفيش endpoint لصور المنتجات/الفئات — أيقونة placeholder بس. الرفع (upload) شغال عادي.
- **ملاحظة تسمية:** `Store*` (الحلاق بيشتري من تاجر) و`Storefront*` (الحلاق بيبيع للعميل) كلاسات منفصلة تمامًا، اتأكد مفيش تضارب أسامي.

## ٦. Notifications + Device token — ✅ خلص
نسخة طبق الأصل من `merchant/notifications` + `merchant/device_token` — `features/barber/notifications/` + `features/barber/device_token/`.
- `GET /barber/notification` (paged) · `unseen_count` · `PUT .../seen` (all/one) · `PUT .../{id}/clicked`
- `POST/DELETE /barber/device_token` · `DELETE /barber/device_token/all` — يتسجل عند login وينمسح كله عند logout (`BarberLogoutUseCase`)
- متوصلة من قايمة البروفايل (`Routes.barberNotificationsScreen`) مع badge للعدد الغير مقروء
- **تعديل مشترك:** `sl<NotificationRouter>()` بقى `UserTypeNotificationRouter` بيوزّع حسب نوع اليوزر بدل ما يبقى `MerchantNotificationRouter` مربوط مباشر — إضافي بحت، اتأكد إن مسار التاجر شغال زي ما كان بالظبط (نفس الكلاس، نفس المنطق، مجرد indirection واحدة زيادة).

## ٧. Team & earnings — ✅ خلص
`features/barber/team/` — إدارة الفريق (owner بس) + تقرير الأرباح (أي عضو يقدر يشوفه).
- `GET /barber/team` (ranking بالـ clientsThisMonth ثم rating ثم name)
- `GET /barber/earnings` (today/last7Days/thisMonth + avgTicket + supplierSpendThisMonth + netThisMonth + dailyLast7)
- CRUD أعضاء: `POST /barber/team` (إضافة) · `GET/PUT /barber/team/{id}` (تفاصيل/تعديل) · `PUT .../availability` · `PUT .../password` (reset) · `DELETE /barber/team/{id}` (block) · `PUT .../activate` (إعادة تفعيل)
- ساعات كل عضو: `GET/PUT /barber/team/{id}/hours` — بتستخدم نفس `WorkingDay`/`WorkingDayModel`/`WorkingDayRow` من `features/barber/hours/` (مفيش تكرار)
- خدمات كل عضو: `GET /barber/team/{id}/service` · `GET .../service/catalog` · `POST .../service` · `PUT .../service/{serviceId}` · `DELETE .../service/{serviceId}` — بتستخدم نفس `BarberService`/`ServiceCatalogItem`/`ServiceFormSheet` من `features/barber/services/` (مفيش تكرار)
- إدارة الفريق مقفولة على الـ owner بس (`BarberProfileCubit.state.profile?.owner`)، الأرباح متاحة للكل
- متوصلة من قايمة البروفايل بـ 2 rows ("الفريق" / "الأرباح")

## ٨. Wallet — ✅ خلص
قراءة بس. `GET /barber/wallet` → `{ balance, transactions:[{code, direction, amount, balanceAfter, reason, by, at}] }` — `features/barber/wallet/`. متوصلة من قايمة البروفايل (`Routes.barberWalletScreen`).

## ٩. Reviews — ✅ خلص
قراءة بس. `GET /barber/review` → `{ average, count, reviews:[{id, stars, note, customerName, bookingId, createdAt}] }` — `features/barber/reviews/`. متوصلة من قايمة البروفايل (`Routes.barberReviewsScreen`).

## ١٠. Invite link — ✅ خلص
`GET /barber/invite` → `{ code, url, favoriteCount }` · `PUT /barber/invite/regenerate` — `features/barber/invite/`. رابط قابل للنسخ + عدد العملاء اللي جم من خلاله + زرار إعادة توليد (بتأكيد). متوصلة من قايمة البروفايل (`Routes.barberInviteScreen`).

---

## ملاحظات تقنية ثابتة
- كل ريكوست بتاع الحلاق لازم `X-Client: MOBILE` — متعمول بالفعل في `AuthorizationInterceptor` شرطي على `UserType.barber`.
- Owner فقط يقدر يدير الفريق (`team/*`) والمخزون؛ عضو الفريق يشوف بياناته بس.
- بعد ما auth الحلاق وبتاع التاجر يشتغلوا كويس، نراجع اللي اتكرر فعلًا ونطلّعه لـ `shared/` — متعملش abstraction من مثال واحد.
