# شغل جاي (2026-11-10) — فريق التاجر (Sub-Merchant / Merchant Team Member)

الهدف: التاجر (`MERCHANT`) يدير فريق (`SUB_MERCHANT`) بنفس فكرة فريق الحلاق (نفس منطق الـ APIs: إضافة، مرتب، مواعيد، حضور وانصراف، صلاحيات)، والـ sub-merchant يدخل من **نفس لوجين التاجر** ويشوف **شاشات مختلفة** عن التاجر.

المصدر: Postman "Merchant + Sub-Merchants (full cycle)" + كلام Omar Kortam (2026-11-10): الـ login بيرجّع `type` = `MERCHANT` أو `SUB_MERCHANT`، وعلى أساسه نعمل شاشتين مختلفتين. الـ sub-merchant هيبقى عنده شوية حاجات بس (check in / check out + حاجات تانية هيقولها).

---

## اللي اتفحص فعليًا (dev: `https://gobeeeg.com/ayezAhlaqApi/api/`، حساب التاجر `01001234599`)

- `POST /merchant/login` رجّع `type: "MERCHANT"`, `canManageProducts`, `canSell`, `merchantId: null`, `mustChangePassword`. الـ sub هيرجّع `type: "SUB_MERCHANT"` + `merchantId` (التاجر) + `actorId >= 4,000,000`. **مفيش حساب sub متجرّب لسه** (لازم نعمل واحد، المرحلة 0).
- شغالة على dev وبترد صح: `GET merchant/member` (paginated)، `GET merchant/member/attendance/team`، `GET merchant/member/attendance/setting`، `GET merchant/paymentMethod` (`WALLET`, `CASH`)، `GET merchant/sale`.
- `GET merchant/subscription` فيه `attendanceEnabled` (حاليًا `false` للتاجر التجريبي) و`employees {cap, used, remaining}` (الـ cap بـ `null` = بلا حد). **التطبيق مش بيقرأ `attendanceEnabled`** (الـ `employees` موجود فعلًا في الـ model).
- مش موجودة للتاجر (404): `merchant/attendanceFeature`، `merchant/salaryDeduction`، `merchant/salary`. يعني **مفيش خصومات ولا عمولة ولا طلب تفعيل الحضور (مدفوع)** للتاجر لحد دلوقتي — سؤال لـ Omar تحت.

## اللي موجود بالفعل في التطبيق (نبني عليه)

- `MerchantShell` ([merchant_shell.dart](lib/features/merchant/presentation/pages/merchant_shell.dart)): بيحمّل في `initState` كل بيانات التاجر (categories, discounts, documents, subscription…) — دول هيرجعوا 403 للـ sub، لازم نقسم التحميل.
- بوابات `BlockingGate` (تغيير كلمة السر، الموقع، المستندات): الموقع والمستندات للتاجر بس.
- `MerchantProfile` مفيهوش `type` ولا صلاحيات. `AuthSession` ([auth_session.dart](lib/shared/auth/domain/entities/auth_session.dart)) فيه `role` بس.
- `UserType` فيه `merchant` بس — الـ sub **مش user type جديد** (نفس اختيار "تاجر" في الشاشة الأولى)، الفرق بييجي من الـ login.
- فريق الحلاق كله جاهز كمرجع: [barber/team](lib/features/barber/team)، [barber/attendance](lib/features/barber/attendance)، [barber/salary](lib/features/barber/salary)، ومنطق المواعيد الليلية (الإغلاق بعد منتصف الليل).
- `BarberProfile` فيه `owner` + `isTeamMember` + getters للصلاحيات — نفس الأسلوب نطبّقه على التاجر.

---

## قرارات لازم تتاخد قبل الكود

1. **منع التكرار (قاعدة 3 في CLAUDE.md):** شاشات الحضور/المرتب/المواعيد/الإضافة موجودة للحلاق. الـ endpoints مختلفة (`merchant/member/...` مقابل `barber/team/...`)، فالحل: نطلّع الـ presentation المشتركة (status card, shift row, history, settings form, team attendance, correct sheet, worked hours, hours section, member rows/sheets) لـ `lib/shared/team/`، وتتغذى من `IXxxRepo` (واجهات)، وكل نوع (حلاق/تاجر) له `data/` خاص بيه وتسجيل DI خاص. **ده أكبر بند في الشغل**، ومحتاج نفكر فيه قبل ما نبدأ (نعمل refactor للحلاق من غير ما نكسره).
2. **الدور الحقيقي = `type` من الـ login** (مش اختيار المستخدم)، يتخزن في `PreferencesKeys` (زي `barberAccountKind`) عشان الـ splash يفتح الشيل الصح بدون ما ينتظر البروفايل.
3. **الـ sub بياخد شيل منفصل** `SubMerchantShell` (مش `MerchantShell` بإخفاء)، وحمولته الابتدائية بس اللي يحتاجها.

## سلوك الـ API المتحقق منه للفريق (dev، 2026-11-10)

- القايمة `GET member?page&size` → `{content,page,size,totalElements,totalPages}`؛ الصف: `id, merchantId, name, phoneNumber, active, mustChangePassword, salary, canManageProducts, canSell, createdByMerchantId, createdByAdminId, createdAt`. نفس الشكل في get/update/salary/permissions/block/activate.
- المواعيد بترجع `"09:00:00"` (ثواني) بينما بنبعت `"09:00"`؛ الليلي `22:00`→`02:00` اتحفظ صح؛ يوم من غير صف = إجازة.
- `POST member` بباسورد مبعوت → `mustChangePassword:false`، وبدونه → `123456` + `mustChangePassword:true`. `resetPassword` → الباسورد الافتراضي (`data:null`) والعضو يتجبر يغيّره.
- `DELETE member/{id}` → `member deleted`، والعضو بعدها 404 ومش في القايمة، ورقمه يتفك (إعادة إنشاء بنفس الرقم نجحت) والباسورد القديم مش بيدخل.
- `PUT member/me/password`: أقل طول 6 (400 برسالة عربية)، وبيقبل نفس الباسورد القديم.
- ⚠️ **باك اند:** `PUT member/{id}` **مبيعملش validation للموبايل** (حفظ `"0abc"`). لازم الـ validation في التطبيق، ونبلّغ Omar. (رجّعت رقم الحساب التجريبي لأصله.)
- الـ sub ممكن يغيّر باسورده بـ `member/me/password` فقط (`merchant/password` 403).

## سلوك `merchant/sale` المتحقق منه (dev، 2026-11-11)

- الرد: `{id, code "MS-000005", soldByMemberId, soldByName, customerName, customerPhone, paymentMethod, subtotal, discount, total, status DONE|CANCELLED, note, createdAt, cancelledAt, items[{productId, productName, unitPrice, quantity, lineTotal}]}`. القايمة page `{content,page,size,totalElements,totalPages}`.
- التاجر يشوف كل المبيعات (بتاعته وبتاعة الأعضاء، `soldByName` للعضو)، والـ sub **بيشوف بتاعته بس** وغيرها 404. بدون `canSell` حتى القراءة 403 "ليس لديك صلاحية البيع".
- الإلغاء (`PUT sale/{id}/cancel`): للتاجر بس، للـ sub 403 "إلغاء البيع لصاحب الحساب فقط"؛ المخزون بيرجع (اتأكدت 43→44)؛ الإلغاء التاني 400 "هذه العملية ملغاة بالفعل".
- `unitPrice` = السعر الأساسي `price` **مش** `effectivePrice` (خصم المنتج مش بيتطبق على البيع المباشر)، و`minOrderQty` مش بيتطبق.
- أخطاء 400 برسائل عربي: مخزون غير كافٍ (بيذكر المتاح)، `items` فاضية، كمية < 1، منتج غير متاح، طريقة دفع غير مدعومة، الخصم أكبر من الإجمالي، خصم سالب.
- ⚠️ **باك اند:** `customerPhone` مبيتحققش منه (قبل `"abc"`). الـ validation في التطبيق (اختياري، رقم مصري).
- `paymentMethod` اختياري. `GET merchant/paymentMethod` → `[{code,label,enabled,sortOrder}]` (WALLET, CASH).
- أثناء الفحص عملت 3 مبيعات على dev وألغيتهم كلهم (المخزون رجع 44 و143) وسحبت صلاحية `canSell` من الحساب التجريبي.

## قرارات اتحسمت (2026-11-10)

- ✅ الـ sub **بيستقبل إشعارات** (+ device token).
- ✅ الـ sub **ليه حضور تلقائي** (geofence) زي الحلاق.
- ✅ الـ sub **بيشوف مرتبه** و**الخصومات كلها عليه** (تأخير/غياب/انصراف مبكر، زي نظام الحلاق بالظبط).
- ✅ الـ sub **ياخد الطلبات (orders)** لو الـ APIs شغالة معاه — **اتفحصت وشغالة** (تحت).

## اللي اتفحص بحساب sub حقيقي (dev، 2026-11-10)

حساب تجريبي اتعمل تحت التاجر `01001234599`: **`01077777701` / `123456`** (id `4000014`، `mustChangePassword: true`، `canManageProducts` و`canSell` = false، مرتب 4000). الرد `type: "SUB_MERCHANT"` لكن `role` لسه `"MERCHANT"` — **التفرقة بالـ `type` بس مش بالـ `role`**.

| المجموعة | النتيجة للـ sub |
|---|---|
| الطلبات: `GET merchant/order`, `order/{id}`، و`PUT order/{id}/accept\|reject\|status` | **مسموحة** (الـ PUT رجّعت 404 "الطلب غير موجود" على id وهمي، يعني مفيش حجب صلاحيات). بتشوف طلبات التاجر كلها |
| `merchant/dashboard`, `category`, `category/own`, `product` (قراءة), `customer`, `profile` (محل التاجر), `paymentMethod` | **مسموحة** |
| `merchant/notification` + `unseenCount` + `seen`، و`deviceToken` | **مسموحة** — لكن **الـ inbox هو inbox التاجر نفسه** (شفت إشعارات تقييم التاجر)، مش inbox خاص بالـ sub |
| `merchant/sale` | **403 "ليس لديك صلاحية البيع"** حتى للقراءة بدون `canSell` |
| `attachment`, `broadcast`, `sponsorship`, `wallet`, `subscription`, `delivery`, `discount`, `documents` | **403 "هذه الميزة متاحة لصاحب الحساب فقط"** |
| `merchant/salary`, `merchant/salaryDeduction` | **403 owner-only للـ sub** (والتاجر نفسه بيجيله 404) → **مش موجودين في الباك اند** |
| `member/me/attendance/current` | `enabled: false` (الباقة VIP `attendanceEnabled=false`) |
| `member/me` | فيه `salary` بس (مفيش شغل/خصومات/ساعات) |

⚠️ أثناء الفحص عملت `PUT merchant/notification/seen` بالغلط بحساب الـ sub، وده علّم **إشعارين للتاجر التجريبي كمقروءين** (`updated: 2`). تأثيره صفر (إشعارات تقييم قديمة على dev) — بس التنبيه إن الـ inbox مشترك.

## مطلوب من Omar (باك اند) — بيعطّل المرتب والخصومات

- [ ] **مرتب/خصومات/عمولة للتاجر:** مفيش أي endpoint لحد دلوقتي. المطلوب نسخة من نظام الحلاق: للـ sub `GET` مرتبه الشهري (مواعيد/ساعات/تأخير/غياب/خصومات/صافي، `?month=yyyy-MM`)، وللتاجر `GET/PUT/DELETE member/{id}/salary` بنوع `DAILY|MONTHLY`، و`salaryDeduction` (قايمة + `pendingCount` + `PUT {waive,note}` + `setting {graceMinutes}`) + (لو عايزينها) عمولة على الخدمات.
- [ ] **الإشعارات:** inbox خاص بالـ sub (إشعارات خصم/مرتب/حضور بتاعته) بدل inbox التاجر المشترك. وإشعارات خصم جديد للتاجر (`salary_deduction_*`) زي الحلاق.
- [ ] **الحضور التلقائي:** قيمة `method` المقبولة في `checkIn/checkOut` للتلقائي (الحلاق بيبعت `AUTO` غالبًا — الـ Postman للتاجر فيه `MANUAL` بس). ولازم الباك اند يرجّع `attendanceConfig` فيه موقع المحل والنطاق (موجود فعلًا: `merchantLat/Lng`, `rangeMeters`).
- [ ] تفعيل `attendanceEnabled` على باقة التاجر التجريبي (VIP) عشان نختبر الحضور.

## أسئلة لسه مفتوحة

- [ ] الـ sub يشوف **الداشبورد/العملاء/الأقسام/المنتجات (قراءة)**؟ الـ APIs شغالة له، لكن مش مطلوبة بالاسم — الافتراضي المقترح: **الطلبات + المنتجات (قراءة) + الحضور + المرتب + الإشعارات**، من غير داشبورد/عملاء/أقسام. (الداشبورد فيه أرقام إيراد التاجر، فالأفضل نخفيه.)
- [x] **اتحسم (2026-11-11):** الـ sub يشوف الطلبات ويقبلها (`accept`) ويغيّر حالتها (`status`). الـ API بيسمح، ومفيش صلاحية `canManageOrders` في الباك اند فالتحكم كله من اللي الـ API بيسمح بيه. الرفض (`reject`) متاح برضو لأنه نفس الـ API، ونتأكد مع Omar لو عايزه مقفول.
- [ ] واجهة البيع (`merchant/sale`): خصم وملاحظة واسم/موبايل عميل اختياري — تأكيد إن ده كل المطلوب.

---

## الخطة (Checklist)

### المرحلة 0 — بيانات الاختبار والتحقق من الـ API
- [x] نعمل sub تجريبي على dev (`01077777701` / `123456`، id 4000014) — محفوظ في memory
- [x] لوجين الـ sub: `type: SUB_MERCHANT`, `role: MERCHANT`, `merchantId: 6`, `mustChangePassword: true`
- [x] `member/me`, `member/me/hours`, `member/me/attendance/current`, `member/me/attendance` اتجرّبوا (الحضور `enabled:false` لحد التفعيل)
- [x] `merchant/sale` كـ sub بدون `canSell` → 403 "ليس لديك صلاحية البيع"
- [x] خريطة الـ 403 للـ sub (الجدول فوق): الطلبات والداشبورد والأقسام والمنتجات والعملاء والإشعارات مسموحة
- [ ] نجرّب check in/out (داخل/خارج النطاق، من غير لوكيشن، تكرار) و`method` التلقائي — **بعد التفعيل**
- [ ] نجرّب `merchant/sale` بعد منح `canSell`، وقبول/رفض/تغيير حالة طلب حقيقي (بطلب تجريبي) ونسجّل الـ quirks في memory
- [ ] نفعّل `attendanceEnabled` للتاجر التجريبي (من الأدمن/باك اند) عشان نقدر نختبر الحضور
- [ ] نحفظ الـ Postman collection في `postman/` (الأسماء: `Ayez_ahlaqMerchantTeam...`)

### المرحلة 1 — الـ Login والدور (Auth)
- [x] `MerchantAccountKind` enum (`owner`, `subMerchant`) مع `fromApi` (`MERCHANT` / `SUB_MERCHANT`)
- [x] توسيع جلسة الدخول: `AuthSession`/`AuthSessionModel` ياخدوا `type`, `merchantId`, `mustChangePassword` (قيم افتراضية آمنة). `canManageProducts`/`canSell` **مش بنخزّنهم من اللوجين**: بنجيبهم من `member/me` (المرحلة 2) عشان يتحدّثوا
- [x] `MerchantAuthRepo._persist` يخزّن `MerchantAccountKind` (`PreferencesKeys.merchantAccountKind` + `UserHelpers.merchantAccountKind`)، و`clearSession` بيرجّعه `owner`
- [x] `splash_screen.dart` + `merchant_login_screen.dart` + `app_top_bar.dart`: توجيه عبر `merchantHomeRoute` ([merchant_home_route.dart](lib/core/routes/merchant_home_route.dart)) → `Routes.subMerchantShell` أو `Routes.merchantShell`
- [x] `MerchantLoginScreen`: يشتغل للاتنين (نفس الشاشة)، "مفيش حساب؟ سجّل" يفضل (مفيش اختيار دور في الأول)
- [x] تغيير كلمة السر الإجباري للـ sub (`MemberForceChangePasswordScreen` + `MyMerchantMemberCubit` + بوابة في `SubMerchantShell`): `PUT member/me/password` (`merchant/password` بيرجّع 403 للـ sub) — نعمل use case/screen بنفس الـ `merchant_force_change_password_screen` بدل نسخة جديدة
- [ ] لوجين حساب محظور/محذوف: رسالة الباك اند (400) كما هي
- [ ] نصوص جديدة في `intl_ar.arb` / `intl_en.arb` ثم `dart run intl_utils:generate`

### المرحلة 2 — Domain/Data للفريق (جهة التاجر)
- [x] `lib/features/merchant/team/` (data + domain، والـ presentation في المرحلة 3) — endpoints في [endpoints.dart](lib/core/network/constants/endpoints.dart):
  - `merchant/member` (list paginated, create), `merchant/member/{id}` (get, update جزئي, delete = soft)
  - `.../{id}/salary`, `.../{id}/permissions`, `.../{id}/hours` (get/put), `.../{id}/block`, `.../{id}/activate`, `.../{id}/resetPassword`
  - `merchant/member/me`, `me/hours`, `me/password`
- [x] `MerchantMember` entity + model (`name, phoneNumber, salary, canManageProducts, canSell, active/blocked, mustChangePassword`) — شكل الرد الحقيقي من المرحلة 0
- [x] use cases (15 use case، DI في `merchant_team_di.dart`): `GetMembers`, `GetMember`, `AddMember`, `UpdateMember` (يبعت الحقول المتغيرة بس), `SetMemberSalary`, `UpdateMemberPermissions`, `Get/UpdateMemberHours`, `Block/Activate`, `ResetMemberPassword`, `DeleteMember`
- [x] خطأ 409 لو الموبايل مستخدم بيمر برسالة الباك اند كما هي (متجرّب)؛ 400 لحد الباقة (`employees.cap`) **لسه مش متجرّب** لأن الباقة التجريبية بلا حد
- [x] `attendanceEnabled` اتضاف لـ `Subscription` entity/model بتاع التاجر

### المرحلة 3 — شاشات التاجر لإدارة الفريق
- [x] صف "الفريق" في قايمة حساب التاجر ([profile_admin_menu.dart](lib/features/merchant/profile/presentation/widgets/profile_admin_menu.dart)) + `Routes.merchantTeamScreen` / `merchantTeamMemberScreen`
- [x] قايمة الأعضاء (pagination + سحب للتحديث) + إضافة عضو (اسم، موبايل، باسورد اختياري، مرتب، صلاحيتين) + عداد الباقة `used/cap`
- [x] تفاصيل العضو: بيانات، مرتب شهري، صلاحيات (`canManageProducts`, `canSell` — بتتطبق من الطلب الجاي بدون re-login)، حظر/تفعيل، إعادة تعيين الباسورد، حذف
- [x] جدول مواعيد الأسبوع للعضو (نفس `MemberHoursSection` و`WorkingDayRow` بتوع الحلاق، بعد ما `MemberHoursCubit` اتعمّم يقبل أي مصدر بيانات) (`dayOfWeek` 0=الأحد…6=السبت، يوم بدون صف = إجازة، `closesAt <= opensAt` = الوردية بتنتهي بكرة) — نعيد استخدام قسم المواعيد الليلية بتاع الحلاق
- [x] قفل الإضافة لما `remaining == 0` برسالة `teamLimitReached` (لسه مش متجرّب على باقة بحد حقيقي)

### المرحلة 4 — الحضور والانصراف (جهة التاجر) — `attendanceEnabled`
- [ ] إعدادات النطاق: `GET/PUT member/attendance/setting` (`rangeMeters` 1–5000، `enforced`) — محتاجة موقع التاجر محفوظ (`PUT merchant/location`، الشيل بيطلبه أصلًا)
- [ ] سجل تغييرات الإعدادات `setting/log` (paginated)
- [ ] فريق اليوم `attendance/team` (على الوردية/الدقائق) + سجل عضو `member/{id}/attendance`
- [ ] تعديل وردية (`PUT member/attendance/{id}`، الملاحظة إجبارية، مفيش وقت مستقبلي، الخروج بعد الدخول، الحالة `ADJUSTED`)
- [ ] لو `attendanceEnabled == false`: الشاشات تعرض حالة "غير مفعّل" (زي `attendance_feature_locked_view`) بدل ما تفشل
- [ ] إشعارات التاجر: `attendance_check_in`, `attendance_check_out`, `attendance_auto_closed`, `merchant_sale` في [merchant_notification_tap_router.dart](lib/features/merchant/notifications/presentation/services/merchant_notification_tap_router.dart)

### المرحلة 5 — شيل الـ Sub-Merchant (الشاشة التانية)
- [x] **لوحتي (الهوم) للـ sub** (أول تاب، اتجرّبت على simulator): تحية + جرس الإشعارات، عدّادين للطلبات (بانتظار ردّك / قيد التنفيذ)، كارت الحضور، مواعيد النهارده (بتختفي لو مفيش مواعيد متحددة)، مبيعات اليوم + زرار بيع جديد (لو `canSell`)، آخر 3 طلبات بتفتح التفاصيل، منتجات على وشك النفاد، وسحب للتحديث. كله من بيانات التطبيق الحالية من غير API جديد ([sub_merchant_home_screen.dart](lib/features/merchant/sub_merchant/presentation/pages/sub_merchant_home_screen.dart)). التابات بقت: لوحتي، الحضور، الطلبات، المنتجات، [المبيعات]، حسابي (`SubMerchantTab` enum)
- [x] مواعيدي في حسابي: رسالة واحدة لو مفيش مواعيد متحددة، وإلا سطر مواعيد النهارده + "جدول الأسبوع" قابل للفتح
- [x] `SubMerchantShell` + تابات: **الحضور، الطلبات، المنتجات، حسابي** ([sub_merchant_tabs.dart](lib/features/merchant/sub_merchant/presentation/widgets/sub_merchant_tabs.dart)). تاب **المبيعات** هييجي مع `canSell` في المرحلة 6، والمرتب لما الباك اند يجهز (المرحلة 7). الداشبورد/العملاء/الأقسام مخفية
- [x] تحميل ابتدائي للـ sub بس: `member/me` + `attendance/current` + الطلبات + المنتجات (من غير dashboard/categories/discounts/documents/subscription)
- [x] **الطلبات للـ sub:** نفس `MerchantOrdersScreen` و`MerchantOrdersCubit` من غير نسخة (قبول/رفض/تغيير الحالة متاحة). **الـ API اتجرّب بـ id وهمي بس** (404)، لسه ماجرّبتش قبول طلب حقيقي بحساب sub عشان مغيّرش بيانات dev
- [x] إشعارات الـ sub: صف الإشعارات مع badge في حسابي بيفتح نفس شاشة إشعارات التاجر (الـ inbox لسه **مشترك مع التاجر** لحد ما Omar يفصله). تسجيل/حذف `deviceToken` شغال للـ sub (اتجرّب `DELETE deviceToken/all` → 200). الضغط على إشعار بيفتح تاب الطلبات/المنتجات/الحضور في شيل الـ sub، وإشعارات المالية/الاشتراك/الخصومات بتتجاهل للـ sub
- [x] بوابة تغيير الباسورد الإجباري فقط (من غير موقع ولا مستندات)
- [x] شاشة الحضور ([member_attendance_screen.dart](lib/features/merchant/attendance/presentation/pages/member_attendance_screen.dart)): حالة الوردية + check in/out + اللوكيشن (`method: MANUAL`) + "غير مفعّل" لو `enabled:false`، وبتعيد استخدام `AttendanceStatusCard`/`AttendanceRangeNote`. **check in/out الحقيقي ماجرّبش على dev** لأن `attendanceEnabled` مقفول (شكل رد `current` متأكد منه، وشكل رد `checkIn` مفترض إنه نفس `current`)
- [x] سجل حضوري: نفس `AttendanceHistoryScreen`/`AttendanceHistoryCubit` (من غير تصحيح) عبر نسخة مسجّلة باسم `memberAttendanceHistoryCubitName`
- [x] مواعيدي (قراءة فقط): قسم في حسابي بنفس `ScheduleDayRow` بتاع الحلاق (متجرّب API `member/me/hours`)
- [x] حسابي: الاسم + مظهر + لغة + عن التطبيق + خروج. بيانات المحل (قراءة من `GET merchant/profile`: الاسم والموبايل) + تغيير الباسورد العادي بـ `member/me/password` عبر `ChangePasswordForm` المشترك (اتفصل من شاشة التاجر)
- [x] `isMerchantActive` / `canEditMerchantIdentity` مش بتتسأل في شيل الـ sub

### المرحلة 5ب — الحضور التلقائي (متفق عليه)
- [ ] **الحضور التلقائي (geofence):** نعيد استخدام `features/barber/auto_attendance` (الـ domain/services مش معتمدة على الحلاق: zone/policy/registrar/tracker) عبر `lib/shared/`، وتغذيته من `attendanceConfig` (`merchantLat/Lng`, `rangeMeters`) في `member/me/attendance/current`، وإرسال check in/out التلقائي على `merchant/member/me/checkIn|checkOut` بـ `method` اللي Omar هيحدده. نكرر إعداد iOS/Android الـ native اللي في memory (`ayez-ahlaq-auto-attendance`) ومفيش تغيير في الـ manifest/plist غالبًا
- [ ] إعادة تسجيل الـ geofence عند تغيير نطاق التاجر/موقعه أو الدخول/الخروج من الحساب

### المرحلة 6 — الصلاحيات (التاجر بيتحكم)
- [x] `canManageProducts` (الإخفاء): `MerchantPermissionGate` بيخفي الإضافة والحذف والتعديل بدون الصلاحية في القايمة والتفاصيل (المخزون `PUT product/{id}/stock` ماله واجهة أصلًا). **الإضافة والمخزون بالصلاحية لسه ماجرّبتهمش كـ sub على dev**؛ القديم: الـ sub يقرأ المنتجات دايمًا؛ الإضافة/التعديل/المخزون (`PUT product/{id}/stock`) مخفية بدون الصلاحية (403 احتياطي برسالة الباك اند)
- [x] `canSell`: شاشة بيع (POS) ([new_sale_screen.dart](lib/features/merchant/sales/presentation/pages/new_sale_screen.dart)) — `POST merchant/sale` (عميل اختياري اسم/موبايل، `paymentMethod` من `GET paymentMethod` بدون hardcode، `discount`، `note`، `items[{productId, quantity}]`)، المخزون بيتخصم (400 لو ناقص)
- [x] قايمة المبيعات `GET merchant/sale` (الـ sub بيشوف بتاعته بس، التاجر الكل) + تفاصيل البيع
- [x] إلغاء البيع للتاجر بس `PUT sale/{id}/cancel` (المخزون بيرجع، الإلغاء المتكرر 400، الـ sub 403)
- [x] الصلاحيات بتتغير والـ sub فاتح: `SubMerchantPermissionRefresher` بيعيد تحميل `member/me` لما التطبيق يرجع للمقدمة ولما أي طلب يرجع 403 (حدث `SessionEvents.forbidden` جديد من `AuthorizationInterceptor`)، بحد أدنى 5 ثواني بين كل تحميلين عشان ميعملش loop. تاب المبيعات والأزرار بتتحدّث بعدها لوحدها

### المرحلة 7 — المرتب والخصومات (متفق عليه — **معطّل بانتظار الباك اند**)
مفيش `merchant/salary` ولا `merchant/salaryDeduction` على dev لسه (404 للتاجر، 403 للـ sub). نبني بعد ما Omar يطلّعهم بنفس شكل الحلاق ([ayez-ahlaq-salary-api](/Users/youssefmohamednaeem/.claude/projects/-Users-youssefmohamednaeem-StudioProjects-ayez-ahlaq/memory/ayez-ahlaq-salary-api.md)):
- [ ] تأكيد الشكل الحقيقي للرد على dev (view + deductions + `pendingCount` + `setting`) وتسجيله في memory
- [ ] جهة الـ sub: شاشة مرتبي (شهر، ساعات، تأخير/انصراف مبكر/غياب، خصومات، صافي) — نعيد استخدام `my_salary_screen` + `salary_body` من `lib/shared/team/` بدل نسخة جديدة
- [ ] جهة التاجر: قسم المرتب في تفاصيل العضو (نوع `DAILY|MONTHLY` + مبلغ)، قايمة الخصومات بفلاتر (`PENDING|DEDUCTED|WAIVED`)، قرار تأكيد/إعفاء (`waive` + `note`)، فترة السماح `graceMinutes` 0..120، وعداد المعلّق على الصف
- [ ] إشعارات الخصومات للتاجر والـ sub وفتحها على الشاشة الصح
- [ ] لحد ما الباك اند يجهز: المرتب الشهري الأساسي (`salary` اللي في `member/me` و`POST/PUT member`) يتعرض في تفاصيل العضو بس
- [ ] العمولة (لو اتطلبت): بند منفصل بعد الخصومات

### المرحلة 8 — حالات حدّية
- [ ] 403 موحدة: نعرض `Failure.message` كما هو (زي الحلاق)
- [ ] sub اتحظر/اتحذف والتطبيق مفتوح → `SessionManager` يطلّعه لشاشة الدخول
- [ ] sub بيجرب مسارات التاجر (قسم 9 في الـ Postman) → مفيش أي ظهور ليها في الواجهة
- [ ] الباقة وقفت الحضور (`attendanceEnabled` اتقفل) والـ sub لسه فاتح → رسالة واضحة
- [ ] وردية مفتوحة عبر منتصف الليل + وردية اتقفلت تلقائيًا (`attendance_auto_closed`)
- [ ] تابلت (iPad/Android): شيل الـ sub والشاشات الجديدة تتبع التخطيط الـ adaptive الحالي

### المرحلة 9 — الاختبار
- [ ] unit tests: `MerchantAccountKind.fromApi`، `AuthSessionModel` (تاجر/sub/ناقص)، `MerchantMember` model، حساب مدة الوردية الليلية
- [ ] اختبار يدوي كـ sub: لوجين أول مرة ← تغيير باسورد إجباري ← check in خارج النطاق ← من غير لوكيشن ← داخل النطاق ← check in تاني (400) ← check out ← السجل ← منع/سماح المنتجات ← منع/سماح البيع ← حظر ← لوجين وهو محظور ← تفعيل
- [ ] اختبار يدوي كتاجر: إضافة/تعديل/حذف عضو، مرتب، مواعيد ليلية، إعدادات النطاق، فريق اليوم، تعديل وردية، إشعارات الحضور والبيع، حد الباقة
- [ ] التأكد إن التاجر العادي والحلاق والعميل مش اتأثروا (خصوصًا لو عملنا refactor لـ `lib/shared/team/`)
- [ ] `flutter analyze` نضيف، كل ملف ≤ 150 سطر، ملف/كلاس، مفيش تعليقات، مفيش نصوص hardcoded، `dart run build_runner build` لو فيه models جديدة

---

## الملفات المتأثرة (متوقع)

| ملف | تغيير |
|---|---|
| `shared/auth/**` (`auth_session*`, local data source) | `type` + صلاحيات الـ sub |
| `core/helpers/user_helpers.dart` + `PreferencesKeys` | `merchantAccountKind` |
| `features/splash/.../splash_screen.dart` | توجيه لشيل التاجر/الـ sub |
| `features/merchant/auth/**` | تخزين الدور بعد اللوجين |
| `shared/widgets/logout_menu_row.dart` | اتنقل من `barber_logout.dart` (`BarberLogout` → `LogoutMenuRow`) للاستخدام المشترك |
| `features/merchant/team/**` (جديد) | data/domain/presentation لإدارة الفريق |
| `features/merchant/presentation/pages/merchant_shell.dart` + `sub_merchant_shell.dart` (جديد) | شيلين منفصلين وتحميل حسب الدور |
| `features/merchant/sales/**` (جديد) | POS وقايمة المبيعات والإلغاء |
| `features/merchant/products/**` | إخفاء الكتابة بدون `canManageProducts` |
| `features/merchant/subscription/**` | `attendanceEnabled` |
| `features/merchant/profile/**` | قايمة الـ sub، `member/me/password` |
| `features/merchant/notifications/**` | أنواع إشعارات الحضور والبيع |
| `lib/shared/widgets/form_sheet_frame.dart` (جديد) | إطار الـ bottom sheet للفورم، مستخدم في 3 sheets للتاجر |
| `lib/shared/team/**` (جديد) | presentation مشتركة بين الحلاق والتاجر (حضور، مواعيد، مرتب) |
| `features/barber/team|attendance|salary/**` | ينقل الـ presentation المشتركة (بدون تغيير سلوك) |
| `core/network/constants/endpoints.dart` | endpoints الـ `merchant/member/**` و`merchant/sale/**` |
| `core/routes/route_paths.dart` + `modules/merchant_shell_routes.dart` + `core/di/services_locator.dart` | routes + DI |
| `lib/l10n/intl_ar.arb` / `intl_en.arb` | نصوص جديدة |

## ملاحظة على الـ base URL

الـ dev الجديد `https://ayezahlaq.com/ayezAhlaqApi/api/` **لسه مش متوجّه للباك اند** (nginx 405 على كل POST، وGET بيرجّع موقع Angular) — اتأجّل تغييره، والتطبيق على `gobeeeg.com` للـ dev. الـ prod اتحوّل لـ `ayezahlaq.com/ayezAhlaqProdApi/api/` واتـpush. لازم نرجع نغيّر الـ dev أول ما Omar يصلّح الـ route (سطر `devBaseUrl` في [strings.dart](lib/core/constants/strings.dart)).
