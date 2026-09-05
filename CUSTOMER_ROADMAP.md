# رود ماب العميل (Customer)

مرجع دايم — عدّل الحالة هنا كل ما نخلّص حاجة. الترتيب مقصود، متتخطاش خطوة إلا لو فيه سبب. نفس أسلوب [BARBER_ROADMAP.md](BARBER_ROADMAP.md).

**الحالة الحالية:** ٠، ١، ٢، ٣، ٤، ٦، ٧ ✅ خلصوا (٦ اتعملت بعد ٧ بطلب المستخدم؛ ٥. ratings لسه). `features/customer/auth/`، `shops/`، `booking/`، `store/`، `favorites/`، `notifications/`، `device_token/`، `profile/` جاهزين.

**✅ خلص (٦. Notifications + Device token):** `features/customer/notifications/` + `features/customer/device_token/` — نسخة طبق الأصل من نمط الحلاق (`GET customer/notification` paged + `unseen_count` + `PUT seen` (all/one) + `PUT clicked`، و`POST/DELETE customer/device_token` + `DELETE .../all`). اتوصلت في التلات أماكن اللي كانت `UserType.customer: break;` بس: `UserTypeNotificationRouter`، و`NotificationService._saveFcmToken`/`_refreshUnseenNotifications`/`handleNotificationTap`. `CustomerLogoutUseCase` بقى بيمسح device tokens قبل الـ logout (زي الحلاق). أيقونة الإشعارات + الـ badge اتحطوا جوه قايمة البروفايل.

**✅ تعديلات بعد مراجعة المستخدم على تاب المتجر والـ Home:**
- **تاب "المتجر" كان بيستخدم `S().storeOrdersTitle`** ("طلبات التوريد الخاصة بي" — نص خاص بتوريدات الحلاق من التاجر بالجملة) — ده كان غلط تمامًا لطلبات عميل عادي بيشتري منتجات. اتغير لـ `S().customerOrdersTitle` ("طلباتي") جديد، والتاب نفسه بقى بيستخدم `tabOrders` ("الطلبات") بدل `tabStore`.
- **الـ Home تاب بقى Dashboard حقيقي** بدل ما يكون نفس ليستة المحلات. `CustomerDashboardScreen` (`features/customer/presentation/pages/`) فيه ٣ سكاشن: `UpcomingBookingsSection` (أقرب حجزين من `MyBookingsCubit.upcoming`)، `NearestShopsSection` (أقرب ٣ محلات — الـ API بيديك أقرب **محلات** مش حلاقين لوحدهم، فالقرار كان نعرض المحلات القريبة بدل ما نفكك كل محل لحلاقينه)، `DashboardOrdersSection` (آخر طلبين لو موجودين). كل سكشن فيه "عرض الكل" بيودي للشاشة الكاملة. ليستة المحلات الكاملة (اللي كانت هي الـ Home قبل كده) اتنقلت لشاشة منفصلة `BrowseShopsScreen` (`/customer/shops`)، بتتفتح من "عرض الكل" في سكشن أقرب المحلات.
- `MyBookingsCubit` بقى متوفر على مستوى الـ shell كله (كان قبل كده بس جوه شاشة الحجوزات المستقلة) عشان الـ dashboard يقدر يوصله.
- **ملحوظة معلّقة (محتاجة تأكيد API):** المستخدم طلب إن الحلاقين اللي بيظهروا في `ShopBarberRow` ماتشملش الـ owner (صاحب المحل)، وإن زرار المفضلة يستهدف الـ owner مش أي حلاق. الـ Postman description لـ `GET customer/shop/{id}` بيقول صراحة إن كل barber بيرجع بس `(services, favorite, viaInvite)` — **مفيش حقل `owner` مذكور ولا sample response محفوظ نتأكد منه**. اتقرر إننا منعملش تخمين هنا ونستنى تأكيد فعلي من السيرفر إن الحقل موجود قبل ما نبني عليه فلتر أو تغيير في الـ favorites API call.

**🐛 باج اتصلح أثناء الشغل على ٧:** `AuthLocalDataSource` كان متسجل مرتين في `services_locator.dart` (مرة في `_customerAuth()` ومرة في `_merchantAuth()`) — ده كان بيخلي التطبيق يعمل crash على `GetIt: Type AuthLocalDataSource is already registered` بمجرد ما `_customerAuth()` بقت تتسجل قبل `_merchantAuth()` في ترتيب الـ init. الباج ده كان موجود قبل شغل العميل خالص (مش حاجة اتعملت في الفيتشرز دي) بس ظهر دلوقتي. الحل: شيل التسجيل المكرر من `_merchantAuth()`، سيبه بس في `_customerAuth()` لأنها بتتسجل الأول.

**✅ خلص (٠. Auth):** `POST /customer/register` + `POST /customer/login` (`identifier`+`password`) — نسخة من نمط `merchant/auth` (فيه register) بدل `barber/auth`. `AuthorizationInterceptor` اتصلح عشان يبعت `X-Client: MOBILE` لـ `UserType.customer` برضو (كان barber بس). الـ OTP اتشال خالص، مفيش في الـ API. مفيش `main_shell` لسه — بعد اللوجين بيروح على `customer/shops` (الشاشة الرئيسية).

**✅ خلص (١. Browse shops + Home):** `GET /customer/shop?lat=&lng=` (مع geolocator، فيه fallback لو الصلاحية مرفوضة) و`GET /customer/shop/{id}` — `features/customer/shops/`. شاشة الليستة (`CustomerHomeScreen`) + شاشة التفاصيل (`CustomerShopDetailScreen` بتعرض الحلاقين/الخدمات/طرق الدفع). زرار logout + زرار الحجوزات مؤقتين في الـ app bar لحد ما البروفايل (مرحلة ٧) والـ bottom nav يتعملوا.

**✅ خلص (٢. Haircut booking flow):** `features/customer/booking/` — `GET /customer/booking/slots` + `POST /customer/booking` (auto-select أو حلاق معين) + `GET /customer/booking` (my bookings، تابين جاية/سابقة) + `GET /customer/booking/{id}` + `PUT /customer/booking/{id}/cancel`. الفلو: `CustomerShopDetailScreen` (زرار "احجز دلوقتي") → `ChooseServiceScreen` → `ChooseStyleScreen` (اختياري) → `ChooseBarberScreen` (auto-select أو محدد) → `ChooseTimeScreen` (تاريخ + سلوتات) → `BookingSummaryScreen` (طريقة الدفع من `shop.paymentMethods` بدل endpoint منفصل، ملاحظة اختيارية) → `SuccessScreen` المشترك. حالة الفلو كله في `BookingFlowCubit` (singleton، بيتصفر بـ `startFlow(shopDetail)` كل ما حد يبدأ حجز جديد). الـ refresh لـ queuePosition بـ pull-to-refresh بس، مفيش auto-polling. **الـ addons اتشالت من الفلو ده مؤقتًا** (لسه storefront customer مش موجود وقتها، مرحلة ٣) — `POST /customer/booking` بيتبعت بـ `addons: []` دايمًا. ممكن نرجعله بعدين لو حبينا نربطه بمنتجات `features/customer/store/`.

**✅ خلص (٣. Storefront browsing + orders):** `features/customer/store/` — `GET /customer/shop/{id}/storefront` (منتجات/فئات/توصيل) + صور المنتج والفئة عبر `AuthorizedNetworkImage` (core widget، مشترك مع صور منتجات التاجر) + `POST /customer/store/quote` + `POST /customer/order` + `GET /customer/order` (تابين مش موجودين هنا، ليستة واحدة) + `GET /customer/order/{id}` + `PUT /customer/order/{id}/cancel`. الكارت **client-side بالكامل** زي ما القرار كان (`Map<productId, quantity>` جوه `StoreCartCubit`، مفيش سلة محفوظة على السيرفر) — الفلو: `CustomerShopDetailScreen` (زرار المتجر في الـ app bar) → `StoreProductsScreen` (ليستة منتجات + quantity stepper + شريط سلة سفلي) → `StoreCartScreen` (طريقة الاستلام delivery/pickup، ملاحظة، quote حي، تأكيد) → `SuccessScreen` المشترك. `StoreCartCubit` singleton زي `BookingFlowCubit`، بيتصفر بـ `openShop(shopId)`.

**تنظيف أثناء المرحلة دي:** `QuantityStepper` و`CartSummaryBar` كانوا مكررين جوه `barber/store/presentation/widgets/` من غير أي منطق خاص بالحلاق — اتنقلوا لـ `shared/widgets/` واستخدمهم الاتنين (حلاق وعميل) دلوقتي بدل التكرار.

**✅ خلص (٤. Favorites):** `features/customer/favorites/` — `GET/POST/DELETE /customer/favorite[/{barberId}]` + `POST /customer/favorite/invite/{code}` + `GET /invite/{code}` (بدون auth). زرار المفضلة (قلب) بقى تفاعلي جوه `ShopBarberRow` في شاشة تفاصيل الصالون (optimistic update مع revert لو الـ API فشل) بدل ما يكون أيقونة ثابتة بس. شاشة `FavoritesScreen` (ليستة) + `EnterInviteCodeScreen` (إدخال كود يدوي) + `InvitePreviewScreen` (معاينة الحلاق قبل الإضافة، بتشتغل من غير تسجيل دخول). **الـ deep linking الحقيقي (فتح رابط دعوة فعلي من بره التطبيق) اتأجل عمدًا** — محتاج قرارات infra (domain/scheme، app_links package، Android intent-filters، iOS associated domains) مش جزء من الشغل ده. حاليًا كود الدعوة بيتدخل يدوي بس. **ملحوظة ناقصة:** لو المستخدم مسجّلش دخول وضغط "إضافة للمفضلة" من شاشة المعاينة، بيتوجّه لصفحة اللوجين لكن بعد اللوجين بيرجع للشاشة الرئيسية مش لمعاينة الدعوة تاني — يحتاج "return to" route لو حبينا نظبطها بعدين.

**✅ خلص (٧. Profile + الـ bottom nav الحقيقي):** `features/customer/profile/` — **مفيش `GET/PUT customer/profile` ولا `customer/password` في الـ Postman خالص** (اتأكد فعليًا، زي ما الملحوظة القديمة قالت). شاشة البروفايل بتعرض بس الاسم/التليفون المحفوظين محليًا (`AuthLocalDataSource.getCachedIdentity()`، من بيانات اللوجين) — **من غير edit ولا تغيير باسورد** لحد ما endpoint حقيقي يتوفر. قايمة البروفايل فيها: الحجوزات (`customerBookingsScreen`)، الثيم، اللغة، عن التطبيق، تسجيل خروج — الإشعارات اتشالت من القايمة لحد ما مرحلة ٦ تتعمل.

**الـ bottom nav الحقيقي اتبنى دلوقتي** بدل الأيقونات المؤقتة في الـ app bar (كانت من مرحلة ٠-٤): `CustomerShell` (`features/customer/presentation/pages/customer_shell.dart`) — ٤ تابز (الرئيسية / المتجر (طلباتي) / المفضلة / حسابي) + **زرار حجز عائم مدمج (docked) في نص الـ bottom bar بلون مختلف** (`context.semantic.accentStrong`، دائري، `CustomerBookingFab`) باستخدام `Scaffold.floatingActionButtonLocation: centerDocked` و`BottomAppBar` بـ notch (`CustomerBottomNavBar`). الدوس على الزرار بيرجّع لتاب الرئيسية (مفيش شاشة "اختار محل" منفصلة، ليستة المحلات هي نفسها البداية). تاب "المتجر" بيعرض `MyStoreOrdersScreen` (مش تصفح محل معين — التصفح لسه بيبدأ من تفاصيل المحل). "الحجوزات" اتحطت جوه قايمة البروفايل مش تاب مستقل عشان الأربع تابز يفضلوا زي ما اتطلب بالظبط.

**ملحوظة ناقصة (UX، مش باج):** الدوس على "إضافة للمفضلة" من `InvitePreviewScreen` وهو مش مسجل دخول بيوديك لصفحة اللوجين، لكن بعد اللوجين مفيش رجوع لمعاينة الدعوة تاني (نفس الملحوظة القديمة من مرحلة ٤).

**مرجع دايم للـ API:** الـ Postman collection الكاملة محفوظة في [postman/Ayez_ahlaqCustomer.postman_collection.json](postman/Ayez_ahlaqCustomer.postman_collection.json) — اقرأها قبل أي feature جديدة بدل التخمين. الـ base URL والـ auth (`identifier` + `password`، بدون OTP فعلي في الـ API رغم إن البروتوتايب فيه شاشة OTP وهمية) مطابقين لباقي التطبيق.

**البروتوتايب المرجعي:** `lib/app_idea_prototype/Ayez_ahlaq/ayez_ahlaq_customer/lib/` — يتقرا للـ UI/UX بس، **ممنوع الاستيراد منه**. الشاشات فيه بتستخدم `provider` + mock data بالكامل، إحنا هنستبدلها بـ Cubit + API حقيقي.

---

## الترتيب المقترح

## ٠. Auth — أول حاجة
`features/customer/auth/`
- `POST /customer/register` (`userName`, `phoneNumber`, `password`, `email`)
- `POST /customer/login` (`identifier`, `password`) → `token`
- نسخة من نمط `barber/auth` أو `merchant/auth` (نفس الـ `AuthorizationInterceptor` + `X-Client: MOBILE`، اتأكد إنه شرطي شغال على `UserType.customer` برضو)
- بروتوتايب فيه `login_screen.dart` + `otp_screen.dart` — الـ OTP مش موجود في الـ API، يتشال أو يتسيب كـ UI بس لو الباك إند هيضيفه بعدين (اتأكد الأول، متبنيش عليه)
- بعد اللوجين: `main_shell.dart` (بروتوتايب) بيحدد الـ bottom nav — homes / bookings / store / favorites / profile (يترتب حسب الأولوية بالأسفل)

## ١. Browse shops + Home — الشاشة الرئيسية
`features/customer/shops/`
- `GET /customer/shop?lat=&lng=` (أقرب أول، `distanceKm` ممكن تبقى `null`) و`GET /customer/shop` (بدون location، ترتيب بالاسم)
- `GET /customer/shop/{id}` → `{ shop, barbers[] (services, favorite, viaInvite), haircutStyles[], paymentMethods[], addons[] }` — أهم endpoint، بيجهز كل بيانات شاشة تفاصيل المحل وبداية فلو الحجز
- بروتوتايب: `home_screen.dart` (ليستة محلات + بحث/فلاتر) → `shop_detail_screen.dart`
- محتاجين permission للموقع (`geolocator` — موجود بالفعل استخدامه في `barber/profile` للـ location، نفس النمط)

## ٢. Haircut booking flow — قلب التطبيق
`features/customer/booking/`
- الفلو (من البروتوتايب): `shop_detail` → `choose_service_screen.dart` → `choose_style_screen.dart` (اختياري، بيغيّر السعر بـ `priceDelta`) → `choose_barber_screen.dart` (أو auto-select) → `choose_time_screen.dart` → `booking_summary_screen.dart` → `booking_success_screen.dart`
- `GET /customer/booking/slots?shopId=&serviceTypeId=&date=` → `{ date, serviceTypeId, perBarber:[{barberId,barberName,durationMinutes,slots}], anyBarberSlots }`
- `POST /customer/booking` — بودي `{shopId, autoSelect, barberId, serviceTypeId, haircutStyleId, date, slotTime, paymentMethod, note, addons:[{productId,quantity}]}` → `PENDING`، السيرفر بيلغيها تلقائي لو المحل ملغاش خلال ٣٠ دقيقة
- الـ addons هنا منتجات من storefront المحل (زي "وكس تشكيل") بتتضاف للحجز مش سلة منفصلة — لازم تجيب منتجات المحل من `GET /customer/shop/{id}/storefront` وتديها كـ optional add-ons في `booking_summary_screen`
- `GET /customer/paymentMethod` — الطرق المفعّلة من الأدمن، تتحمّل مرة في بداية الفلو
- `GET /customer/booking` (my bookings) + `GET /customer/booking/{id}` (تفاصيل، فيها `queuePosition`/`peopleAhead`/`ratedBarber`/`ratedShop`) + `PUT /customer/booking/{id}/cancel`
- بروتوتايب: `bookings_screen.dart` (ليستة الحجوزات، tabs جاية/سابقة زي `barber/bookings`)
- الـ polling أو الـ refresh لـ `queuePosition` أثناء الانتظار — قرّر لو محتاج pull-to-refresh بس أو auto-poll (زي طابور الحلاق بالظبط، نفس المنطق من ناحية التاجر)

## ٣. Storefront browsing + orders — شراء منتجات من محل
`features/customer/store/`
- `GET /customer/shop/{id}/storefront` → `{ shopName, delivery, categories[], products[] }` — منتجات الحلاق بس، أبدًا التاجر
- صور: `GET .../storefront/product/{id}/image` و`.../storefront/category/{id}/image`
- `POST /customer/store/quote` — بودي `{shopId, fulfillmentType, items:[{productId,quantity}]}` → `{lines, subtotal, deliveryFee, total}` (`fulfillmentType`: `DELIVERY` | `PICKUP_AT_BRANCH`) — **مختلف عن نمط الحلاق** (اللي اتحول لـ server-side cart، شوف §الملاحظات التقنية تحت في barber roadmap) — هنا لسه quote-then-order، اتأكد من السلوك الفعلي على السيرفر قبل ما تبني عليه افتراض
- `POST /customer/order` → `PENDING`، صاحب المحل بيقبل/يرفض
- `GET /customer/order` (my orders) + `GET /customer/order/{id}` + `PUT /customer/order/{id}/cancel` (وهو لسه PENDING)
- الكارت نفسه client-side في البروتوتايب (`AppState.cart` عبارة عن `Map<productId, qty>`) — قرّر لو هيفضل كده أو يتبنى زي كارت الحلاق (server-side)؛ الـ API الموجود هنا بس quote+order فمفيش endpoint لسلة محفوظة على السيرفر، يبقى **client-side cart** هو الصح هنا إلا لو ظهر غير كده في الـ Postman
- بروتوتايب: `store_screen.dart` → `product_detail_screen.dart` → `cart_screen.dart` → `checkout_screen.dart` → `order_success_screen.dart` → `my_orders_screen.dart`

## ٤. Favorites — حلاقين مفضّلين
`features/customer/favorites/`
- `GET /customer/favorite` (بيرجع shop, rating, viaInvite, since)
- `POST /customer/favorite/{barberId}` · `DELETE /customer/favorite/{barberId}`
- `POST /customer/favorite/invite/{inviteCode}` — `viaInvite=true`، بيبلّغ الحلاق
- بروتوتايب: `favorites_screen.dart`
- شاشة الـ invite العامة (بدون auth): `GET /invite/{code}` — `{code, barberId, barberName, tagline, shopId, shopName, area, address, rating, ratingCount}` — لازم deep link handling (لو حد فتح رابط الدعوة وهو مش عامل تسجيل دخول، يوريه preview الأول ثم يطلب تسجيل دخول/تسجيل قبل إضافة المفضلة)

## ٥. Ratings — تقييم بعد الحجز
`features/customer/ratings/`
- `POST /customer/rating` — بودي `{bookingId, target, stars, note?}` (`target`: `BARBER` | `SHOP`) — الحجز لازم يكون `DONE` وبتاعك، وتقييم واحد لكل `(booking, target)`
- `GET /customer/rating` (my ratings)
- في البروتوتايب التقييم بيظهر جوه تفاصيل الحجز بعد ما يخلص (`bookings_screen.dart` بيعرض `rating` جوه الـ `Booking` نفسها) — يتحط كـ bottom sheet أو inline من `booking_detail`، متحتاجش شاشة منفصلة كبيرة

## ٦. Notifications + Device token — نسخة طبق الأصل من الحلاق/التاجر
`features/customer/notifications/` + `features/customer/device_token/`
- `GET /customer/notification` (paged) · `unseen_count` · `PUT .../seen` (all/one) · `PUT .../{id}/clicked`
- `POST/DELETE /customer/device_token` · `DELETE /customer/device_token/all` — يتسجل عند login وينمسح عند logout
- استخدم `UserTypeNotificationRouter` الموجود بالفعل (اتعمل أصلاً بشكل عام في مرحلة الحلاق، هيحتاج بس يضيفله مسار العميل)

## ٧. Profile — آخر حاجة
`features/customer/profile/`
- مفيش endpoint صريح لـ `GET/PUT /customer/profile` أو `password` في الـ Postman الحالي — لازم تتأكد من السيرفر مباشرة (زي ما اتعمل مع `barber/location` و`barber/password`) قبل البناء، ماتبنيش على افتراض إنه هيبقى نفس شكل الحلاق
- بروتوتايب: `profile_screen.dart` — بسيطة (اسم، تليفون، لوجاوت، رابط للمفضلة/الحجوزات/الطلبات)
- لوجاوت لازم يمسح device tokens (زي باقي الأنواع)

---

## ملاحظات تقنية ثابتة
- كل ريكوست بتاع العميل لازم `X-Client: MOBILE` زي الباقي — اتأكد من `AuthorizationInterceptor` إنه شامل `UserType.customer` بالفعل (مش بس barber).
- الألوان/الثيم متشاركة من `core/theme/` — البروتوتايب بتاعه `app_colors.dart`/`app_theme.dart` خاصة بيه بس **مايتاخدش**، استخدم `AppLightColors`/`AppDarkColors`/`styles.dart` الموجودين.
- `main_shell.dart` + `bottom_nav_bar.dart` (بروتوتايب) بيوريوا شكل التابز المفروضة — قارن بعدين مع شكل الـ bottom nav بتاع الحلاق (٣ تابز: حجوزات/متجر/حسابي) لو العميل هيتماشى مع نفس الفلسفة (تقليل التابز، حجات ثانوية تتحط تحت البروفايل).
- `Storefront*` (تصفح/شراء من محل حلاق) هنا زي `barber/store` بالظبط من ناحية التسمية والمفهوم — لكن الـ API مختلف (quote+order مش server cart). خليها مسميات واضحة زي التاجر/الحلاق عشان محتفضش تلخبط.
- بعد ما فلو العميل الأساسي (auth → shops → booking) يشتغل، نراجع اللي اتكرر مع الحلاق (شاشات notifications، device_token، rating لو فيه حاجة شبه) ونطلّعه لـ `shared/` — متعملش abstraction من مثال واحد.
