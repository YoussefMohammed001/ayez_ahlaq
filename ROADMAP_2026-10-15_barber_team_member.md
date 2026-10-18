# شغل النهاردة (2026-10-15) — حساب عضو الفريق (Team Member / Sub Barber)

الهدف: بعد ما المستخدم يختار "حلاق" في شاشة نوع الحساب، يختار بين **صاحب محل** و**عضو فريق**، وعضو الفريق ياخد تجربة كاملة مبنية على `BARBER_TEAM_MEMBER_API.md`: يشوف حجوزاته بس، وصلاحياته (إنهاء الحجوزات، تأكيد الاستلام، الإيرادات) تتحكم فيها من صاحب المحل.

---

## النطاق المتفق عليه (قرار 2026-10-15)

عضو الفريق (`TEAM_MEMBER`) **مش بيشوف متجر ولا أي حاجة برّه** الـ APIs اللي في `BARBER_TEAM_MEMBER_API.md`. أي حاجة تانية نضيفها بعد كده بعد ما نخلّص دي.

**اللي بيشوفه ويستخدمه (من الدوك فقط):**
- الدخول، البروفايل، تغيير كلمة السر (إجباري أول مرة)، نسيت كلمة السر
- حجوزاته: الطابور، الطلبات المعلّقة، السجل/القادمة، التفاصيل، غير المدفوع، غير المحسوم
- شغل الحجز: تأكيد، رفض، تغيير الحالة، الفاتورة (`canCloseBookings`)، تسوية (`canCloseBookings`)، Walk-in على نفسه، تأكيد الاستلام (`canMarkPaid`)
- إيراده: `earnings` و`earnings/chart` (`canViewRevenue`)
- الفريق (ترتيب فقط، من غير فلوس)، الإشعارات، device token، تقييماته
- مواعيد الشغل والخدمات: **قراءة فقط**

**اللي مش بيشوفه خالص:** المتجر والمبيعات، المشتريات، المالية (محفظة/مدير الأموال/اشتراك/رعاية)، إدارة الفريق، تعديل الخدمات والمواعيد، بث الإشعارات، الخدمة المنزلية، المستندات، الموقع، حذف الحساب.

## اللي اتفحص فعليًا (سيرفر dev، حساب الأونر `01008451421`)

- `GET /api/barber` **بيرجّع دلوقتي** `role` (`OWNER` / `TEAM_MEMBER`) و`permissions {canViewRevenue, canCloseBookings, canMarkPaid}` — والأونر كل الصلاحيات عنده `true`. الـ model عندنا في [barber_profile.dart](lib/features/barber/profile/domain/entities/barber_profile.dart) بيقرأ `owner` بس، **مش بيقرأ `role` ولا `permissions`**.
- `GET /api/barber/booking/unpaid` شغال (PageResponse: `content, page, size, totalElements, totalPages`).
- `GET /api/barber/booking?status=DONE` شغال وراجع `shopInvoiceNumber`.
- لوجين الأونر والعضو **نفس الـ endpoint** (`POST barber/login` + `X-Client: MOBILE`). الدور بييجي من البروفايل بعد اللوجين، مش من اللوجين.
- `GET /api/barber/team` بيرجّع أعضاء بدون `phoneNumber` (لازم نعمل عضو جديد للاختبار، شوف المرحلة 0).

## اللي موجود بالفعل في التطبيق (نبني عليه، مش نعيده)

- `BarberProfile.owner` مستخدم في: شاشة البروفايل (عنوان "صاحب المحل / عضو فريق")، `serves_clients_card`، شاشة الفريق، شاشة الخدمات، `walk_in_sheet_launcher`.
- شاشة تغيير كلمة السر الإجبارية [barber_force_change_password_screen.dart](lib/features/barber/profile/presentation/pages/barber_force_change_password_screen.dart) + `BlockingGate` في [barber_shell.dart](lib/features/barber/presentation/pages/barber_shell.dart).
- الحجوزات: `BookingsCubit` (pending / queue / history / unresolved)، و`BookingActions` بيرسم الأزرار من `nextStatuses`، وفيه `edit_bill_sheet` و`settle_bookings_bar` و`walk_in`.
- الإيرادات: `EarningsCubit` + شاشة earnings.
- `X-Client: MOBILE` متضاف تلقائي للحلاق في [authorization_interceptor.dart](lib/core/network/interceptors/authorization_interceptor.dart).

## الفجوات (اللي ناقص)

| # | الفجوة |
|---|---|
| 1 | مفيش شاشة اختيار "صاحب محل / عضو فريق" بعد اختيار حلاق |
| 2 | البروفايل مش بيقرأ `role` و`permissions` |
| 3 | الشيل بيعرض تاب **المتجر (Storefront)** وزرار **سلة المتجر (FAB)** لكل الحلاقين — دول للأونر بس (403 للعضو) |
| 4 | قايمة البروفايل كلها معروضة للعضو: المتجر والمبيعات، المشتريات، المالية (محفظة، مدير الأموال، اشتراك، رعاية)، فريق، خدمات/مواعيد تعديل، بث إشعارات، خدمة منزلية، حذف حساب… ومعظمها `403` للعضو |
| 5 | `BookingActions` بيعرض `DONE` و`NO_SHOW` حتى لو العضو معندوش `canCloseBookings` |
| 6 | تعديل الفاتورة (`/billing`) و`settle` مش متحكم فيهم بصلاحية |
| 7 | مفيش `PUT booking/{id}/paid` ولا شاشة `booking/unpaid` ولا عرض "بانتظار تأكيد الاستلام" |
| 8 | الإيرادات (`/earnings`) ظاهرة للكل، المفروض `canViewRevenue` |
| 9 | شاشة الدخول فيها "مفيش حساب؟ سجّل"، وده للأونر بس (العضو الأونر هو اللي بيعمله) |
| 10 | `BarberDocumentsCubit` / `loadServices` / `loadStorefront*` / `loadSubscription` بيتنادوا في الشيل لكل الحلاقين، وهتفشل 403 للعضو وتطلّع أخطاء |
| 11 | الـ 403 مفيش لها معاملة موحدة (المفروض رسالة الباك اند العربي تظهر زي ما هي) |

---

## قرارات التصميم (مقترحة، اعترض لو مش مناسبة)

1. **الدور الحقيقي = `profile.role`** (مش اختيار المستخدم). شاشة الاختيار بتحدد بس شكل شاشة الدخول (إخفاء "سجّل" للعضو + نص توضيحي). لو اختار "عضو" ودخل بحساب أونر (أو العكس) → نكمّل بالدور الحقيقي ونعرض تنبيه صغير.
2. **مفيش feature جديدة بالكامل.** نضيف في `barber/profile`: `BarberPermissions` (entity) و`BarberRole`، ونضيف `BarberAccess` (helper واحد بيشتق `isOwner / canCloseBookings / canMarkPaid / canViewRevenue` من البروفايل). كل الشاشات تسأل `BarberAccess` بدل ما كل واحدة تقرأ البروفايل بنفسها (من غير تكرار).
3. **الأونر كل صلاحياته `true`** (الباك اند بيرجّعها كده)، فمفيش فرع خاص للأونر في الكود.
4. **إخفاء بدل 403:** أي زرار/تاب/صف قايمة محتاج صلاحية يتخفي من البروفايل. الـ 403 fallback بس (صلاحية اتغيرت والعضو لسه مفتوح)، وبتظهر رسالة الباك اند زي ما هي عن طريق `Failure.message`.
5. **صلاحية بتتغير والعضو مفتوح:** نعيد تحميل البروفايل (`loadProfile`) عند فتح التطبيق/الرجوع من الخلفية، ولو جه 403 على إجراء نعمل refresh للبروفايل مرة.
6. **تابات العضو:** الرئيسية، الحجوزات، حسابي. **الإيرادات** صف في قايمة الحساب لو `canViewRevenue` (بدل تاب، لأن شاشة الإيرادات ليها PIN وAppBar). بدون تاب المتجر وبدون FAB السلة.
7. الإنتاج: شاشة اختيار الدور = `UserTypeScreen` ← (حلاق) ← `BarberRoleScreen` الجديدة ← `BarberLoginScreen`. لو المستخدم اختار قبل كده نخزّن الاختيار في `PreferencesKeys` عشان الـ splash يفتح شاشة الدخول الصح.

---

## الخطة (Checklist)

### المرحلة 0 — تجهيز بيانات الاختبار
- [x] أنشئ عضو فريق تجريبي من حساب الأونر (`POST /api/barber/team` بالاسم والموبايل → كلمة السر المؤقتة `123456`، `mustChangePassword = true`) — الأونر وصل لحد الباقة (1 عضو)، فاستخدمنا العضو الموجود `كريم` (id 10): `01114151413` / `123456`
- [x] اضبط صلاحيات العضو من الأونر (`/api/barber/team/{id}/permissions`) على 3 حالات للاختبار: **الكل false**، **canCloseBookings فقط**، **الكل true** (مع مراعاة إن `canMarkPaid` محتاجة `canCloseBookings`) — `PUT /api/barber/team/10/permissions` شغال، الحالي: `canCloseBookings` بس
- [ ] اعمل حجز عميل على العضو ده (العميل `01555555555`) عشان يظهر في الطابور
- [ ] سجّل بيانات العضو التجريبي هنا بعد ما نعمله: `<phone> / <password>`

### المرحلة 1 — الـ Domain / Data (البروفايل)
- [x] `BarberRole` enum (`owner`, `teamMember`) مع `fromApi` (`OWNER` / `TEAM_MEMBER`) — اتعوّض بـ `owner` الموجود + `isTeamMember`
- [x] `BarberPermissions` entity (`canViewRevenue`, `canCloseBookings`, `canMarkPaid`)
- [x] إضافة `role` و`permissions` لـ `BarberProfile` + `BarberProfileModel` (مع افتراضي آمن لو الحقل مش موجود: كله `false` للعضو، `true` للأونر)
- [ ] إضافة `documentsPending` و`locationPending` و`overQuota` لو لسه مش متقرية (الباك اند بيرجّعهم، و`needsLocation` الحالي محسوب من الإحداثيات)
- [x] `BarberAccess` helper (قيم مشتقة من البروفايل، بدون منطق في الـ widgets) — getters على `BarberProfile` (`canCloseBookings`...)
- [x] تحديث الـ unit tests للـ model (أونر / عضو / حقول ناقصة)

### المرحلة 2 — اختيار الدور والدخول
- [x] `BarberRoleScreen` (كارتين: صاحب محل / عضو فريق) — نستخدم `UserTypeCard` الموجود، مش widget جديد
- [x] `PreferencesKeys.barberAccountKind` + تخزين/قراءة (في `UserHelpers`)
- [x] تعديل [user_type_screen.dart](lib/features/user_type/presentation/pages/user_type_screen.dart): حلاق ← `Routes.barberRoleScreen` بدل الدخول المباشر
- [x] `Routes.barberRoleScreen` + route في [app_routes.dart](lib/core/routes/app_routes.dart)
- [x] [barber_login_screen.dart](lib/features/barber/auth/presentation/pages/barber_login_screen.dart): للعضو نخفي "مفيش حساب؟ سجّل" ونعرض سطر "حسابك بيتعمل من صاحب المحل. كلمة السر المؤقتة بتوصلك منه" + زرار "غيّر نوع الحساب"
- [ ] [splash_screen.dart](lib/features/splash/presentation/pages/splash_screen.dart): لو حلاق من غير token → شاشة الدخول (مع الدور المخزّن)، ولو الدور مش متخزن → `BarberRoleScreen`
- [x] بعد اللوجين: تحميل البروفايل، لو الدور الحقيقي ≠ المختار → تنبيه + نحدّث `barberAccountKind` — المزامنة بتحصل في `BarberShell` بعد تحميل البروفايل (بدون تنبيه حاليًا)
- [x] نصوص جديدة في `intl_ar.arb` / `intl_en.arb` (ثم `dart run intl_utils:generate`)

### المرحلة 3 — الشيل والتنقل للعضو
- [x] شيل تاب المتجر (`StorefrontHomeScreen`) و`BarberStoreFab` للعضو
- [ ] إضافة تاب الإيرادات للعضو لو `canViewRevenue`
- [x] إيقاف تحميلات الأونر في `initState` للعضو (`loadDocuments`, `loadServices`, `loadStorefront*`, `loadSubscription`, `loadMerchants`) — نقسم التحميل لـ `_loadCommonData` و`_loadOwnerData`
- [x] الرئيسية للعضو: طابور اليوم + عدّاد حجوزاته + (الإيراد فقط لو `canViewRevenue`) — نعيد استخدام أقسام `BarberHomeScreen` مع إخفاء المالي/المتجر
- [x] `BlockingGate` لـ`documentsPending` / `locationPending`: ده **للأونر بس** (العضو مش بيرفع مستندات ولا موقع)، نتأكد إن شرط `needsLocation` مش بيحجب العضو (لو المحل عنده موقع فمفيش مشكلة) — `needsLocation` بقت للأونر بس
- [ ] إعادة تحميل البروفايل عند الرجوع للتطبيق (`AppLifecycleState.resumed`)

### المرحلة 4 — قايمة البروفايل (إخفاء الخاص بالأونر)
- [x] [barber_profile_menu.dart](lib/features/barber/profile/presentation/widgets/barber_profile_menu.dart) للعضو يفضل: إدارة الحساب (بيانات، تغيير كلمة السر)، تقييماتي، الإشعارات، الإعدادات، الدعم، تسجيل الخروج
- [x] إخفاء: المحل (خدمات/مواعيد/موقع/مستندات/فريق/خدمة منزلية)، المتجر والمبيعات، المشتريات، المالية، بث الإشعارات
- [ ] حذف الحساب: للأونر بس (شاشة الأونر المتاحة للأونر فقط حسب الدوك — "account deletion" owner-only)
- [ ] خدمات/مواعيد: قراءة فقط للعضو لو عايزينه (`GET /hours` و`/service` متاحين) — **قرار مفتوح**، الافتراضي إخفاء
- [ ] `team` للقراءة (ترتيب الفريق: عملاء الشهر + التقييم) — شاشة قراءة فقط للعضو بدون إدارة

### المرحلة 5 — الحجوزات (قلب التجربة)
- [ ] `BookingActions`: إخفاء `DONE` و`NO_SHOW` لو `!canCloseBookings`
- [ ] `edit_bill_sheet` وزرار تعديل الفاتورة: يظهر بس مع `canCloseBookings`
- [ ] `settle_bookings_bar` و`unresolved`: بس مع `canCloseBookings`
- [ ] `walk_in`: العضو يقدر يضيف زبون واقف، `barberId` = نفسه (الأونر يختار) — نظبط `walk_in_barber_field` للعضو (مقفول على نفسه)
- [ ] إضافة endpoint `PUT booking/{id}/paid` (`{paid: true|false}`): `EndPoints.barberBookingPaid` + api + repo + `MarkBookingPaidUseCase` + method في `BookingsCubit`
- [ ] زرار "تأكيد استلام المبلغ" في تفاصيل الحجز: بس لو `DONE` و`canMarkPaid` و`!paid` و`paymentMethod != WALLET`
- [ ] إضافة `paid` و`paidAt` للـ `Booking` entity/model + عرض حالة "بانتظار تأكيد الاستلام" لحجز `DONE` غير مدفوع
- [ ] شاشة/تبويب **غير المدفوع** (`GET booking/unpaid`، PageResponse مع pagination) — `EndPoints.barberBookingUnpaid` + use case + cubit مع تحميل صفحات
- [ ] التعامل مع 409 (فاتورة مغلقة، مدفوع بالمحفظة) و400 (دفع قبل الإنهاء) برسالة الباك اند
- [ ] 404 على حجز حد تاني = شاشة "غير موجود" عادية

### المرحلة 6 — الإيرادات
- [ ] إخفاء تاب/روابط الإيرادات لو `!canViewRevenue`
- [ ] شاشة الإيرادات للعضو: `today / last7Days / thisMonth / clients… / avgTicket / dailyLast7` + `earnings/chart?period=` (بدون أرقام المنتجات والخزينة لأنها `0`)
- [ ] قفل الـ PIN (`barberEarningsPinScreen`) — نتأكد إنه مش بيتطلب للعضو (PIN بتاع الأونر للأموال)
- [ ] تمييز: الإيراد بيحسب كل حجز `DONE` مدفوع أو لأ، ونعرض "لسه للتسليم" من `booking/unpaid`

### المرحلة 7 — الإشعارات والجهاز
- [ ] `deviceToken` (تسجيل/حذف + `DELETE /all` عند الخروج) للعضو — نفس خدمة الحلاق الحالية
- [ ] أحداث الحجز (`booking_requested`, `booking_cancelled`, `booking_reminder`) تفتح تفاصيل الحجز الصح
- [ ] `BarberNotificationsCubit` شغال للعضو (متاح حسب الدوك)

### المرحلة 8 — الأخطاء والحالات الحدّية
- [ ] معاملة موحدة للـ 403: عرض `Failure.message` كما هو + refresh للبروفايل مرة واحدة
- [ ] 401 لو `X-Client` ناقص → إعادة تسجيل دخول (الـ interceptor الحالي)
- [ ] حساب محظور: رسالة "هذا الحساب محظور" من الباك اند عند اللوجين
- [ ] `overQuota` / `documentsPending` (قراءة فقط، الكتابة متقفلة 403): العضو بيشوف حجوزاته بس ومفيش إجراءات — نعرض بانر توضيحي
- [ ] صلاحيات اتسحبت أثناء الجلسة: الأزرار تختفي بعد الـ refresh

### المرحلة 9 — الاختبار
- [ ] unit tests: `BarberRole.fromApi`, `BarberPermissions`, `BarberProfileModel` (أونر/عضو/ناقص)، `BarberAccess`
- [ ] اختبار يدوي كعضو (3 حالات صلاحيات من المرحلة 0): دخول أول مرة ← تغيير كلمة السر إجباري ← الطابور ← تأكيد حجز ← تقدّم الحالة ← محاولة إنهاء بدون صلاحية (الزرار مخفي) ← مع `canCloseBookings` ← فاتورة ← `DONE` ← مع `canMarkPaid` تأكيد استلام
- [ ] التأكد إن الأونر مش اتأثر (كل التابات والقوايم زي ما هي) — حساب `01008451421`
- [ ] التأكد إن العميل/التاجر مش اتأثروا
- [ ] `flutter analyze` نضيف، وكل ملف ≤ 150 سطر، ومفيش تعليقات في الكود

---

## الملفات المتأثرة (متوقع)

| ملف | تغيير |
|---|---|
| `features/user_type/.../user_type_screen.dart` | حلاق ← شاشة اختيار الدور |
| `features/barber/auth/.../barber_role_screen.dart` (جديد) | اختيار صاحب محل / عضو فريق |
| `features/barber/auth/.../barber_login_screen.dart` | وضع العضو |
| `features/barber/profile/domain/entities/` | `BarberRole`, `BarberPermissions`, `BarberProfile` |
| `features/barber/profile/data/models/barber_profile_model.dart` | قراءة `role` و`permissions` |
| `features/barber/profile/domain/barber_access.dart` (جديد) | helper الصلاحيات |
| `features/barber/presentation/pages/barber_shell.dart` | تابات وتحميل حسب الدور |
| `features/barber/profile/presentation/widgets/barber_profile_menu.dart` + قوايم البروفايل | إخفاء الخاص بالأونر |
| `features/barber/bookings/**` | صلاحيات الإنهاء/الفاتورة/الدفع، شاشة unpaid |
| `core/network/constants/endpoints.dart` | `barberBookingPaid`, `barberBookingUnpaid` |
| `core/routes/route_paths.dart` + `app_routes.dart` + `core/di/services_locator.dart` | route + DI |
| `core/cache/preferences_storage/preferences_storage_keys.dart` + `core/helpers/user_helpers.dart` | `barberAccountKind` |
| `features/splash/.../splash_screen.dart` | التوجيه |
| `lib/l10n/intl_ar.arb` / `intl_en.arb` | نصوص جديدة |

## القرارات النهائية للأسئلة

1. الخدمات والمواعيد: **قراءة فقط** (في الدوك، قسم 8).
2. شاشة الفريق: **قراءة فقط**، من غير فلوس.
3. Walk-in: **أيوه** على نفسه.
4. اختار "عضو" ودخل بحساب أونر: **نكمل بالدور الحقيقي مع تنبيه**.
5. غير المدفوع: **تبويب جديد في الحجوزات**.
