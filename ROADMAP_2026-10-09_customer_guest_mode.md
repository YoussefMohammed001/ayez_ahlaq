# شغل النهاردة (2026-10-09) — Guest Mode للعميل

الهدف: العميل يدخل التطبيق ويتصفح المحلات من غير تسجيل دخول. أي إجراء بيحتاج حساب (حجز، سلة، مفضلة، تقييم، محفظة...) بيفتح شاشة login/register.

---

## الـ API (اتفحص فعليًا على السيرفر اللايف بدون token)

### شغال بدون auth (200)

| Endpoint | ملاحظة |
|---|---|
| `GET customer/shop` | قائمة المحلات، من غير lat/lng كمان |
| `GET customer/shop?lat&lng` | مرتبة بالأقرب + `distanceKm` |
| `GET customer/shop/{id}` | `shop` + `barbers` (بخدماتهم) + `haircutStyles` + `paymentMethods` + `addons` + `drinks` |
| `GET customer/shop/{id}/storefront` | أقسام ومنتجات وتوصيل |
| `GET customer/shop/{id}/storefront/category/{cid}/image` | bytes |
| `GET customer/shop/{id}/storefront/product/{pid}/image` | bytes (لسه ما اتجربش، نفس الـ pattern) |
| `GET invite/{code}` | public أصلًا |

### لسه 401 (محتاج login)
`customer/paymentMethod`، `customer/booking/slots`، `customer/homeService/shop`، `customer/homeService/hours/{id}`، `customer/rating`، `customer/store/quote`، `customer/transferAccount`، `customer/booking`، `customer/cart`، وكل الـ wallet/favorite/order/notification.

### أسئلة مفتوحة للباك اند (نبعتها قبل ما نعتمد عليها)
1. `customer/shop/{id}/profileImage` رجّع 404 للمحل 1 (`hasProfileImage=false`) — لازم نجربه على محل عنده صورة ونتأكد إنه public.
2. `customer/booking/slots` مقفول — هل ممكن يتفتح عشان الضيف يشوف المواعيد الفاضية؟ (قرار منتج، مش مطلوب للنسخة الأولى.)
3. `customer/shop/{id}.favorite` للضيف دايمًا `false`؟ (متوقع، نتأكد.)
4. الـ feed بتاع تاب المتجر (`CustomerStoreFeedCubit`) بينادي أنهي endpoint؟ لو بيستخدم endpoint مقفول يبقى التاب ده Gated في النسخة الأولى.

---

## قرارات التصميم

- **الضيف = مفيش token + userType == customer.** `UserHelpers.isGuest()` موجودة بالفعل ([user_helpers.dart](lib/core/helpers/user_helpers.dart)) — مش هنضيف flag جديد في الـ storage. نضيف `static bool get` synchronous نسخة مخزّنة (cache) لو احتجنا نقرأها في `build`، بدل `Future` كل مرة.
- **مفيش feature جديدة.** كل الشغل تعديل على `lib/features/customer/*` + 3 ملفات في `core/`.
- **Guard واحد مركزي** لكل الإجراءات المحمية، مش `if (isGuest)` متكرر في كل شاشة (قاعدة عدم التكرار). يتعمل في `lib/shared/` (راجع `ApprovalGuard` الموجود الأول وقرر نوسّعه ولا نعمل جنبه — مش نعمل نسخة شبيهة).
- **الـ 401 للضيف مش session expired.** حاليًا [authorization_interceptor.dart](lib/core/network/interceptors/authorization_interceptor.dart) بيبعت `emitUnauthorized()` على أي 401 و`SessionManager.handleUnauthorized` بيمسح كل حاجة ويرجّع لـ `userTypeScreen` مع رسالة "الجلسة انتهت". ده لازم يتعدل عشان الضيف.

---

## خطوات التنفيذ

### 1. Core — الـ 401 مع الضيف
- [authorization_interceptor.dart](lib/core/network/interceptors/authorization_interceptor.dart) `onError`: لو مفيش token في الـ request (الـ header `Authorization` مش موجود) → **متنادّيش** `emitUnauthorized()`. يمرّر الخطأ عادي.
- النتيجة: endpoint محمي اتنادى كضيف بيرجع `Failure` عادي بدل ما يطرد المستخدم. (شبكة أمان بس، الـ UI المفروض ميوصلش لهنا أصلًا بسبب الـ guard.)

### 2. Splash + User type
- [splash_screen.dart](lib/features/splash/presentation/pages/splash_screen.dart): لو `userType == customer` ومفيش token → يروح `Routes.customerShell` بدل `customerLoginScreen`.
- barber/merchant يفضلوا زي ما هما (login إجباري).
- لو العميل ضغط logout → يرجع للشيل كضيف أو للـ userType؟ **قرار:** يرجع لـ `userTypeScreen` زي الحالي (`SessionManager.logout`)، مفيش تغيير.

### 3. Guest guard (shared)
- widget/helper واحد في `lib/shared/` اسمه مثلًا `GuestGuard` فيه:
  - `static Future<bool> ensureLoggedIn(BuildContext)` — لو ضيف: يفتح bottom sheet أو dialog (باستخدام `ConfirmCancelDialog` الموجود لو يكفي) فيه "سجّل دخول / إنشاء حساب" → `context.push(Routes.customerLoginScreen)`. يرجّع `true` بس لو بقى فيه token.
- نصوص الـ dialog في `lib/l10n/*.arb` (ar + en) — مفيش نص hardcoded. بعد الإضافة: `dart run intl_utils:generate` (مش `flutter gen-l10n`).

### 4. Customer shell
[customer_shell.dart](lib/features/customer/presentation/pages/customer_shell.dart) `initState` بينادي دلوقتي كل ده مرة واحدة:
`loadOrders`, `loadFavorites`, `loadProfile`, `refreshUnseenCount`, `loadBookings` — كلهم محمية.
- للضيف: ينادي `loadShops()` بس.
- بعد login ناجح (الرجوع للشيل): يكمل باقي الـ loads. الأنسب: method `_loadAccountData()` تتنادى من `initState` لو مسجل، ومن callback بعد الـ login لو كان ضيف.
- التابات:
  - Home ✅ (تتعدل، شوف 5)
  - Store (`CustomerStoreFeedScreen`) — ✔ تتحقق من السؤال 4 فوق.
  - Orders / Favorites / Account → للضيف تظهر **empty state بدعوة login** (نستخدم `FirstRunEmptyState` أو `AppEmptyState` الموجود، مش widget جديد) بدل ما يحمّل ويفشل.

### 5. Dashboard
[customer_dashboard_screen.dart](lib/features/customer/presentation/pages/customer_dashboard_screen.dart):
- `CustomerHomeGreeting`: للضيف "أهلًا بيك" بدل الاسم، وأيقونة الإشعارات مخفية أو بتعدي على الـ guard، والأفاتار يوديه لتاب الحساب (اللي هو login CTA).
- `UpcomingBookingsSection` و`DashboardOrdersSection`: مخفيين للضيف.
- `QuickActionsSection`: كل action محمي يعدي على `GuestGuard`.
- `NearestShopsSection`: شغال زي ما هو.
- `_refresh`: للضيف `loadShops` بس.

### 6. شاشة تفاصيل المحل
[customer_shop_detail_screen.dart](lib/features/customer/shops/presentation/pages/customer_shop_detail_screen.dart):
- العرض (الحلاقين، الخدمات، الـ addons، المشروبات) شغال زي ما هو.
- زرار "احجز" → `GuestGuard.ensureLoggedIn` قبل `BookingFlowCubit`.
- زرار المفضلة (`toggleFavorite`) → guard.
- أيقونة المتجر (`customerStoreProductsScreen`) مفتوحة للضيف لأن الـ storefront public. الإضافة للسلة جوّه → guard.

### 7. الـ Deep link / invite
`customer/favorite/invite/{code}` محمي. معاينة `invite/{code}` public → الضيف يشوف المعاينة وعند "أضف للمفضلة" → guard.

---

## الملفات المتأثرة (متوقع)

| ملف | تغيير |
|---|---|
| `core/network/interceptors/authorization_interceptor.dart` | تجاهل 401 لو مفيش token |
| `core/helpers/user_helpers.dart` | (اختياري) getter متزامن للضيف |
| `features/splash/.../splash_screen.dart` | ضيف → customerShell |
| `shared/guest_guard.dart` (جديد) | guard مركزي |
| `features/customer/presentation/pages/customer_shell.dart` | loads مشروطة + empty states |
| `features/customer/presentation/pages/customer_dashboard_screen.dart` | refresh + sections |
| `features/customer/presentation/widgets/{customer_home_greeting,quick_actions_section}.dart` | وضع الضيف |
| `features/customer/shops/presentation/pages/customer_shop_detail_screen.dart` | guards |
| `lib/l10n/intl_ar.arb` / `intl_en.arb` | نصوص الـ guard والـ empty states |

كل ملف ≤ 150 سطر، وأي widget هيطلع من التعديل يتفصل في ملف لوحده.

---

## ترتيب الشغل المقترح

1. أسئلة الباك اند (فوق) — بالتوازي مع كل اللي بعده.
2. Core 401 fix.
3. `GuestGuard` + النصوص.
4. Splash + Shell + Dashboard.
5. شاشة المحل + الـ storefront.
6. اختبار يدوي كضيف (انظر تحت).
7. `flutter analyze` نضيف.

## الاختبار

- **كضيف (فريش install):** user type = customer → يدخل الشيل مباشرة بدون login → المحلات تظهر (مع وبدون صلاحية الموقع) → تفاصيل محل → الـ storefront والصور.
- كل إجراء محمي (احجز، مفضلة، سلة، طلبات، حساب، إشعارات) يفتح الـ guard، **ومفيش** رسالة "الجلسة انتهت" ولا رجوع لـ userType.
- من الـ guard → login → يرجع لنفس الشاشة وبيانات الحساب تتحمّل.
- تأكد إن barber و merchant لسه بيتطردوا لـ login لما الـ token يخلص (الـ 401 fix ما كسرش الـ session expiry لما فيه token).
- logout عميل مسجل → يرجع لـ userType زي ما كان.

## خارج النطاق (دلوقتي)
- مواعيد الحجز للضيف (`booking/slots` مقفول).
- Guest mode للـ barber/merchant.
- حفظ سلة محلية للضيف.
