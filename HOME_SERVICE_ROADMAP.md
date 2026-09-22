# رود ماب — الحلاقة المنزلية (Home Service)

مرجع دايم — حط `[x]` جنب أي بند لما يخلص، وسيب ملاحظة تحته لو فيه تفاصيل تنفيذ يستاهل حد يعرفها بعدين.

**حسابات تجربة:**
- عميل: `01555555555` / `cust1234`
- حلاق: `01008451421` / `123456`

**المرجع الكامل للـ API:** `Ayez_ahlaq-HomeService-UseCase.postman_collection.json` (سيناريو كامل عميل+حلاق بالترتيب). راجعه قبل أي خطوة تحتها شك في الـ request/response shape.

**تم التحقق فعليًا من كل الـ endpoints دي على `https://gobeeeg.com/ayezAhlaqApi/api` (الـ base URL الحقيقي — `strings.dart`, مش الـ `localhost:8082` الموجود في الـ collection) بتاريخ 2026-09-16. الشكل الحقيقي للردود موثق تحت في كل قسم، منه اتعملت الـ models.**

---

## نظرة عامة على الـ state machine

```
PENDING ──(barber: price/adjustments)──▶ PENDING + priceConfirmationPending:true
   │                                              │
   │                                    (customer: confirmPrice)
   │                                              ▼
   │◀─────────────────────────────── PENDING + priceConfirmationPending:false
   │
   ├──(barber: accept)──▶ ACCEPTED ──(barber: status=ON_THE_WAY)──▶ ON_THE_WAY ──(barber: status=DONE)──▶ DONE
   ├──(barber: reject)──▶ REJECTED
   └──(customer: cancel, only while PENDING)──▶ CANCELLED
```

قواعد مهمة:
- التسعير (`PUT .../price`) شغّال بس وهو `PENDING`، وبيتقفل تمامًا بعد `ACCEPTED` (409 لو اتحاول).
- لو الحلاق ملمسش السعر خالص، الـ `accept` بيشتغل على طول من غير ما يستنى تأكيد العميل.
- الـ `accept` بيترفض بـ 400 لو `priceConfirmationPending == true`.
- مفيش endpoint منفصل لـ "رفض السعر" من العميل — الرفض بيبقى إما `cancel` (وهو بس وهو PENDING) أو الحلاق يعمل `reject`.
- كل `/api/barber/**` محتاج هيدر `X-Client: DESKTOP` أو `MOBILE` ثابت من وقت اللوجن، وإلا 401.

---

## 1) الطبقة المشتركة (Shared enums/status)

- [x] **`HomeServiceRequestStatus` enum** — ✅ اتعمل **مرتين، مش واحدة مشتركة**: نسخة عند `customer/home_service/domain/entities/home_service_request_status.dart` ونسخة عند `barber/home_service_requests/domain/entities/home_service_request_status.dart`. القرار (موثق في قسم 2.3 و 3.2): كل فيتشر له الـ entities بتاعته زي باقي الكود (`booking_status.dart` عند الحلاق مختلف عن `customer_booking_status.dart` عند العميل بالظبط بنفس المنطق)، فمفيش تكرار حقيقي — دول نموذجين مستقلين بيمثلوا حالة السيرفر نفسها من منظورين مختلفين.
- [x] **`HomeServiceAdjustment` entity/model** — ✅ اتعمل مرتين برضو لنفس السبب: `customer/home_service/domain/entities/home_service_adjustment.dart` (id+label+amount) و`barber/home_service_requests/domain/entities/home_service_request_adjustment.dart` (id nullable+label+amount، عشان الحلاق بيقدر يضيف سطر جديد محليًا قبل ما يتبعت للسيرفر).

---

## 2) Feature: `barber/home_service` (إعداد الخدمة من طرف الحلاق)

مسار الفولدر: `lib/features/barber/home_service/`

### 2.1 الإعدادات (تفعيل + سعر + ملاحظة) — ✅ منفّذ 2026-09-16
- [x] `data/apis/barber_home_service_api.dart` — `getSettings()` (GET) و`updateSettings()` (PUT) على `barber/homeService`.
- [x] `data/models/home_service_settings_model.dart` — `{enabled, price, note}`.
- [x] `domain/entities/home_service_settings.dart`
- [x] `domain/repos/i_barber_home_service_repo.dart`
- [x] `data/repos/barber_home_service_repo.dart`
- [x] `domain/use_cases/get_home_service_settings_use_case.dart`
- [x] `domain/use_cases/update_home_service_settings_use_case.dart`
- [x] `presentation/manager/home_service_settings_cubit.dart` + `_state.dart`
- [x] `presentation/pages/home_service_settings_screen.dart` — توجل (`HomeServiceToggleCard`) + `AppTextField` للسعر والملاحظة (زي `storefront_delivery_fee_fields.dart` بالظبط، مش `AppFormField`). Validation عميل-سايد: السعر لازم يبقى رقم أكبر من صفر لو الخدمة مفعّلة، قبل ما يتبعت للسيرفر.
  - ملاحظة: partial update — لو `enabled:false`، بيتبعت `price:null, note:null` (السيرفر ساعتها مش محتاج القيم دي).
  - **رد حقيقي (GET/PUT) `barber/homeService`:** `{enabled, price, note}` — بالظبط زي الموثق، مفيش حقول زيادة.
  - نقطة دخول: كارت `HomeServiceCard` جديد في `barber_home_screen.dart` (بعد كارت طلبات المتجر، قبل قسم الحجوزات) — بيوري الحالة (مفعّلة/غير مفعّلة) ويودي لـ `barberHomeServiceSettingsScreen`.

### 2.2 مواعيد التوفر الأسبوعية (Home Service Hours) — ✅ منفّذ 2026-09-16
- [x] **القرار المتخذ:** الـ `WorkingDay` entity + `WorkingDayModel` اتستخدموا **بالاستيراد المباشر** من `barber/hours/domain/entities/working_day.dart` و`barber/hours/data/models/working_day_model.dart` — من غير نسخ ولا نقلهم لمكان مشترك. الـ entity عامة أصلاً (مش مربوطة بأي endpoint)، فاستيرادها من فيتشر لفيتشر تاني بيحقق "no duplicated code" من غير ما يكسر استقلالية الفيتشرين في حاجة تانية.
- [x] `data/apis/barber_home_service_hours_api.dart` + `domain/use_cases`: `GetHomeServiceHoursUseCase` / `UpdateHomeServiceHoursUseCase` على `barber/homeService/hours`.
- [x] `presentation`: الشاشة والـ cubit بيستوردوا `WorkingDayRow` من `barber/hours/presentation/widgets/working_day_row.dart` مباشرة (نفس منطق الاستيراد فوق) — الشاشة نفسها (`home_service_hours_screen.dart`) نسخة مستقلة (Cubit + Scaffold + Routes مختلفين) لأن دي شاشة منفصلة فعليًا، مش نفس الشاشة.
- [x] كارت الإعدادات فيه زرار "مواعيد الحلاقة المنزلية" يودي لـ `barberHomeServiceHoursScreen`.
  - **رد حقيقي (GET/PUT) `barber/homeService/hours`:** `[{dayOfWeek, off, opensAt, closesAt}]` × 7 — مطابق تمامًا لشكل `barber/hours` العادي.

### 2.3 طابور الطلبات (Home Service Requests) — مرآة لـ `barber/bookings` — ✅ منفّذ 2026-09-16
هنا التعقيد الحقيقي. مرّ على `lib/features/barber/bookings/` كامل قبل ما تبدأ — هو نفس الـ state machine (pending → price adjustments → accept/reject → status progression) وبنفس شكل الـ endpoints تقريبًا.

**قرار تنظيمي:** اتعمل الفيتشر ده في فولدر مستقل `lib/features/barber/home_service_requests/` (مش جوه `home_service/`) — زي إزاي `barber/bookings` مستقل عن `barber/hours` في الكود الحالي. الأسماء (`HomeServiceRequest`, `HomeServiceRequestsCubit`, ...) بتتشابك مع نظائرها عند العميل، فاتحل التعارض بـ import alias (`as barber_hsr`) في `services_locator.dart` و`app_routes.dart` بدل ما الكلاسين يتسموا بأسامي مختلفة تكسر الاتساق مع باقي الكود.

- [x] `data/apis/barber_home_service_request_api.dart`:
  - `getRequests({status})` → `GET barber/homeService/request?status=PENDING`
  - `getRequest(id)` → `GET barber/homeService/request/{id}`
  - `updatePrice(id, adjustments)` → `PUT barber/homeService/request/{id}/price`
  - `accept(id)` → `PUT barber/homeService/request/{id}/accept`
  - `reject(id, reason)` → `PUT barber/homeService/request/{id}/reject`
  - `updateStatus(id, status)` → `PUT barber/homeService/request/{id}/status` (`ON_THE_WAY` / `DONE`)
- [x] `data/models/home_service_request_model.dart` — **شكل حقيقي متحقق منه (barber side, من `GET .../request` و`.../request/{id}` و`.../accept` و`.../status` و`.../price`):**
  ```json
  {
    "id": 1, "code": "HS-000001", "status": "PENDING",
    "customerName": "سمير", "customerPhone": "01555555555",
    "price": 150, "finalPrice": 200, "priceConfirmationPending": true,
    "address": "...", "lat": 30.0561000, "lng": 31.3272000,
    "distanceKm": 49.0, "note": "...",
    "createdAt": "2026-09-16T11:18:25",
    "acceptedAt": null, "onTheWayAt": null, "completedAt": null,
    "rejectedAt": null, "rejectionReason": null,
    "cancelledAt": null, "cancelReason": null,
    "adjustments": [{"id": 1, "label": "...", "amount": 50}],
    "nextStatuses": ["ON_THE_WAY"]
  }
  ```
  ملاحظات مهمة:
  - `nextStatuses` سيرفر-درفن زي `barber/bookings` بالظبط — الـ UI لازم يلف عليها بدل ما يفترض ترتيب ثابت (نفس نمط `order_actions.dart`/`booking_actions.dart`).
  - `finalPrice` بيفضل `null` لحد ما يتعمل أول تعديل سعر، وبعدها بيبقى `price + sum(adjustments)`.
  - كل عنصر في `adjustments` له `id` فعلي من السيرفر (مش بس label/amount محليين).
  - الشكل ده مختلف عن اللي بيشوفه العميل (تحت) — `customerName/customerPhone` بدل `shopId/shopName`. **موديلين منفصلين لازم، مش موديل واحد مشترك.**
- [x] `domain/entities/home_service_request.dart` (+ `home_service_request_adjustment.dart`, `home_service_request_status.dart`)
- [x] `domain/repos/i_barber_home_service_request_repo.dart` + `data/repos/...`
- [x] use cases: `GetHomeServiceRequestsUseCase`, `GetHomeServiceRequestUseCase`, `UpdateHomeServiceRequestPriceUseCase`, `AcceptHomeServiceRequestUseCase`, `RejectHomeServiceRequestUseCase`, `UpdateHomeServiceRequestStatusUseCase`
- [x] `presentation/manager/home_service_requests_cubit.dart` + `_state.dart` — نسخة أبسط من `bookings_cubit.dart` (لستة PENDING بس + `refreshRequest(id)` للتفاصيل + `_mutate`/`updatingRequestId` بنفس منطق `updatingBookingId`) — مفيش queue/history splits لأن مفيش داعي ليهم هنا.
- [x] `presentation/pages/home_service_requests_screen.dart` — لستة PENDING بس (زي ما اتحدد بالـ scope الأصغر، مفيش تبويبات "الكل/الجارية/المنتهية" — ممكن تتضاف لو المنتج طلبها بعدين).
- [x] `presentation/pages/home_service_request_detail_screen.dart` — العنوان + الملاحظة + `distanceKm` + الـ adjustments + السعر النهائي + الأزرار، بنفس منطق `booking_actions.dart` بالظبط (`BusyErrorListener` + `nextStatuses` من السيرفر).
- [x] `presentation/widgets/`:
  - `home_service_adjustments_field.dart` + `home_service_adjustment_row.dart` (نسخة مطابقة لـ `bill_adjustments_field.dart`/`bill_adjustment_row.dart`)
  - `edit_home_service_price_sheet.dart` (bottom sheet للتعديل، زي `edit_bill_sheet.dart`)
  - `reject_home_service_sheet.dart` (زي `reject_booking_sheet.dart`)
  - `home_service_request_actions.dart` (زي `booking_actions.dart` — بس مع الـ guard الإضافي: لو `priceConfirmationPending == true` يعرض رسالة "بانتظار موافقة العميل" بدل زراير القبول/الرفض)
  - `home_service_request_row.dart`, `home_service_request_info_card.dart`, `home_service_adjustments_section.dart`
  - `home_service_status_tone.dart` / `_label.dart`
  - `reject_home_service_sheet.dart` (سبب الرفض، زي `reject_booking_sheet.dart`)
  - Guard UI: زرار "قبول" لازم يتعطل (أو يتخفي) لو `priceConfirmationPending == true`، مع رسالة توضح إن الطلب مستني موافقة العميل على السعر الجديد.

---

## 3) Feature: `customer/home_service` (اكتشاف + طلب من طرف العميل) — ✅ منفّذ 2026-09-16

مسار الفولدر: `lib/features/customer/home_service/`

### 3.1 دليل المحلات اللي بتقدم خدمة منزلية — ✅ منفّذ
- [x] `data/apis`: `getHomeServiceShops(lat, lng)` → `GET customer/homeService/shop?lat=&lng=`.
  - **شكل حقيقي متحقق منه:**
    ```json
    {"id":3,"name":"Men's Club","area":"El shourok","address":"...",
     "latitude":30.3378945,"longitude":31.7195757,
     "rating":0.0,"reviewCount":0,"opensAt":null,"closesAt":null,
     "distanceKm":49.0,"favorite":true,"sponsored":true,
     "homeServiceAvailable":true,"homeServicePrice":150,"homeServiceNote":"...",
     "hasProfileImage":false}
    ```
    **قرار محسوم:** الشكل ده مختلف كفاية عن `ShopModel` العادي (`shops/data/models/shop_model.dart` — بيستخدم `address/distanceKm/favorite/rating/ratingCount` بس) — فيه `area`, `latitude/longitude` (مش `lat/lng`), `sponsored`, `hasProfileImage`, `opensAt/closesAt`, `homeServiceAvailable/Price/Note`. اعمل `HomeServiceShopModel`/`HomeServiceShop` entity مستقلة في الفيتشر الجديد بدل ما تحاول تمطط الموديل القديم.
- [x] `getHomeServiceHours(shopId)` → `GET customer/homeService/hours/{shopId}` (نفس شكل `WorkingDay[]` المتحقق منه فوق) — الـ use case والـ repo method جاهزين (`GetHomeServiceShopHoursUseCase`)، لكن مفيش شاشة/UI بتستدعيها لسه (بند مؤجل، شوف الملاحظة تحت).
- [x] `presentation/pages/home_service_shop_list_screen.dart` — بيستخدم `Geolocator` بنفس منطق `customer_shops_cubit.dart` بالظبط (نفس الـ permission handling، من غير تكرار منطق جديد).
- [ ] **مؤجل:** شاشة/bottom sheet لعرض مواعيد المحل قبل الطلب (لتفادي الـ 400 وقت الإنشاء لو خارج المواعيد). الـ use case جاهز (`GetHomeServiceShopHoursUseCase`) بس لسه مش متربط بأي شاشة — ينفع يتضاف كخطوة قبل شاشة الطلب أو كتحقق عميل-سايد وقت الإرسال.
  - **نقطة دخول ثانية اتأجلت:** بادج/زرار "الحلاقة المنزلية متاحة" جوه شاشة تفاصيل المحل العادية (`customer_shop_detail_screen.dart`) — الـ `Shop`/`ShopDetail` entities الحالية معندهاش `homeServiceAvailable/Price` خالص (دول جايين بس من endpoint الدليل المخصص `customer/homeService/shop`)، فالبادج ده كان محتاج نداء API إضافي أو تعديل الموديل العادي، ومكانوش من الأولويات. المدخل الأساسي (كارت في الداشبورد) شغال بالكامل ويغطي الاكتشاف.

### 3.2 إنشاء الطلب + متابعته — ✅ منفّذ
- [x] `data/apis`:
  - `createRequest({shopId, address, lat, lng, note})` → `POST customer/homeService`
  - `getRequest(id)` → `GET customer/homeService/{id}`
  - `confirmPrice(id)` → `PUT customer/homeService/{id}/confirmPrice`
  - `cancel(id)` → `PUT customer/homeService/{id}/cancel`
  - `getMyRequests()` → `GET customer/homeService` (من غير id) — **متحقق منه فعليًا، endpoint حقيقي شغّال**، بيرجع array بنفس شكل `GET .../{id}`. ده بيحسم القرار: هيبقى شاشة "طلبات الهوم سيرفس بتاعتي" مستقلة (`home_service_requests_screen.dart` عند العميل)، مش مدمجة جوه `my_bookings_screen.dart` — نفس الفصل الموجود أصلًا بين الحجز العادي والهوم سيرفس في كل حتة تانية.
- [x] `domain/entities/home_service_request.dart` (نسخة العميل).
  - **شكل حقيقي متحقق منه (customer side, من `POST`, `GET .../{id}`, `GET` بدون id, `confirmPrice`):**
    ```json
    {
      "id": 1, "code": "HS-000001", "status": "PENDING",
      "shopId": 3, "shopName": "Men's Club",
      "price": 150, "finalPrice": 200, "priceConfirmationPending": true,
      "adjustments": [{"id": 1, "label": "...", "amount": 50}],
      "address": "...", "lat": 30.0561, "lng": 31.3272, "note": "...",
      "createdAt": "2026-09-16T11:18:25",
      "acceptedAt": null, "onTheWayAt": null, "completedAt": null,
      "rejectionReason": null, "cancelReason": null
    }
    ```
    فرق واضح عن نسخة الحلاق: مفيش `nextStatuses`, `distanceKm`, `customerName/Phone`, `rejectedAt`, `cancelledAt` (بس فيه `rejectionReason`/`cancelReason`). **موديل مستقل تاني، مش مشترك مع نسخة الحلاق.**
- [x] use cases: `CreateHomeServiceRequestUseCase`, `GetHomeServiceRequestUseCase`, `GetMyHomeServiceRequestsUseCase`, `ConfirmHomeServicePriceUseCase`, `CancelHomeServiceRequestUseCase`
- [x] **قرار:** بدل `home_service_flow_cubit.dart` بتصميم multi-step زي `booking_flow_cubit.dart` — اتعمل `home_service_request_form_cubit.dart` بسيط (submit واحد بس) لأن الفلو هنا شاشة واحدة (عنوان + ملاحظة، والمحل متحدد أصلًا من اللستة قبلها)، مش رحلة متعددة الخطوات زي الحجز العادي.
- [x] `presentation/manager/home_service_requests_cubit.dart` + `_state.dart` — لستة `GET customer/homeService` (my requests)، زي `my_bookings_cubit.dart` بالظبط.
- [x] `presentation/manager/home_service_request_detail_cubit.dart` + `_state.dart` — load/confirmPrice/cancel، زي `booking_detail_cubit.dart` بالظبط.
- [x] `presentation/pages/`:
  - `home_service_requests_screen.dart` (لستة طلباتي — شاشة منفصلة عن "حجوزاتي" العادية، زي ما اتقرر فوق)
  - `home_service_request_screen.dart` (فورم العنوان + لوكيشن + ملاحظة — استخدم `shared/widgets/delivery_location_field.dart` الموجودة بالفعل بدل ما يتعمل location picker جديد)
  - `home_service_request_detail_screen.dart` (عرض الحالة، السعر، الـ adjustments، بانر السعر الجديد، وزرار الإلغاء)
- [x] `presentation/widgets/`:
  - `home_service_price_confirmation_banner.dart`
  - `home_service_request_detail_card.dart`, `home_service_request_row.dart`, `home_service_adjustments_section.dart`, `home_service_status_tone.dart`/`_label.dart`
  - **مؤجل:** `home_service_request_status_tracker.dart` (تتبع بصري خطوة بخطوة) — الحالة متعروضة حاليًا كـ `StatusBadge` نصي بس (زي `customer_booking_row.dart`)، مفيش تتبع بصري رسومي. تحسين مستقبلي لو المنتج طلبه.
- [x] نقطة دخول: كارت `HomeServiceEntryCard` جديد في `customer_dashboard_screen.dart` يودي لـ `customerHomeServiceShopListScreen`.

---

## 4) التوجيه (Routing)

- [x] `route_paths.dart`: اتضافت كل مسارات الحلاق (`barberHomeServiceSettingsScreen`, `barberHomeServiceHoursScreen`) والعميل (`customerHomeServiceShopListScreen`, `customerHomeServiceRequestScreen`, `customerHomeServiceRequestsScreen`, `customerHomeServiceRequestDetailScreen`). مسارات طابور الحلاق (`barberHomeServiceRequestsScreen`/`RequestDetailScreen`) لسه هيتضافوا مع قسم 2.3.
- [x] `app_routes.dart`: كل الـ `GoRoute`s المسجلة فوق بتتبع نفس نمط الموديول-ليفل `sl<Cubit>()` + تمرير الـ id/entity عبر `state.extra` الموجود بالفعل لباقي الشاشات.
- [x] **نقاط الدخول (قرار محسوم 2026-09-16):**
  - **حلاق:** ✅ كارت `HomeServiceCard` في `barber_home_screen.dart` (بعد كارت طلبات المتجر) — بيوري الحالة (مفعّلة/غير مفعّلة)، وبعد ما اتعمل قسم 2.3 بقى كمان يوري عدد الطلبات PENDING (لو فيه) ويودي لـ `barberHomeServiceRequestsScreen` بدل `SettingsScreen` في الحالة دي.
  - **عميل:** ✅ كارت `HomeServiceEntryCard` في `customer_dashboard_screen.dart` يودي لـ `customerHomeServiceShopListScreen`. البادج السياقي على شاشة تفاصيل المحل اتأجل (شوف الملاحظة في قسم 3.1).

---

## 5) الـ Endpoints والـ DI

- [x] `core/network/constants/endpoints.dart`: تمت إضافة قسم `Home Service` بنفس نمط الـ booking/hours الموجود:
  ```dart
  static const String barberHomeService = 'barber/homeService';
  static const String barberHomeServiceHours = 'barber/homeService/hours';
  static const String barberHomeServiceRequests = 'barber/homeService/request';
  static String barberHomeServiceRequestById(int id) => 'barber/homeService/request/$id';
  static String barberHomeServiceRequestPrice(int id) => 'barber/homeService/request/$id/price';
  static String barberHomeServiceRequestAccept(int id) => 'barber/homeService/request/$id/accept';
  static String barberHomeServiceRequestReject(int id) => 'barber/homeService/request/$id/reject';
  static String barberHomeServiceRequestStatus(int id) => 'barber/homeService/request/$id/status';

  static const String customerHomeServiceShops = 'customer/homeService/shop';
  static String customerHomeServiceHours(int shopId) => 'customer/homeService/hours/$shopId';
  static const String customerHomeService = 'customer/homeService';
  static String customerHomeServiceById(int id) => 'customer/homeService/$id';
  static String customerHomeServiceConfirmPrice(int id) => 'customer/homeService/$id/confirmPrice';
  static String customerHomeServiceCancel(int id) => 'customer/homeService/$id/cancel';
  ```
- [x] `core/di/services_locator.dart`: اتضافت `_barberHomeService()`, `_barberHomeServiceHours()`, `_barberHomeServiceRequests()`, `_customerHomeService()` بنفس نمط `_barberHours()`/`_barberBookings()`/`_customerBooking()`. تعارض الأسامي بين نسخة الحلاق ونسخة العميل (`HomeServiceRequestsCubit`, `GetHomeServiceRequestUseCase`, ...) اتحل بـ `import ... as barber_hsr` على مستوى الملف، مش بتسمية الكلاسات بأسامي مختلفة.

---

## 6) التحقق العملي (قبل ما تعتبر أي جزء خلص)

- [ ] شغّل الـ Postman collection (`Ayez_ahlaq-HomeService-UseCase.postman_collection.json`) بالـ Runner من الأول للآخر على الباك اند المحلي، وسجل أي فرق بين شكل الرد الفعلي والـ models اللي اتعملت (خصوصًا أسماء الحقول زي `finalPrice`, `priceConfirmationPending`, `distanceKm`).
- [ ] اتأكد إن هيدر `X-Client` بيتبعت صح من الـ `NetworkService`/`AuthorizationInterceptor` الحالي لكل نداء `barber/homeService/**) — لو مش متطبق أصلًا لباقي طلبات الحلاق دلوقتي، ده لازم يتصلح مركزيًا مش جوه الفيتشر ده.
- [x] **تم تشغيل الـ golden path كامل فعليًا عن طريق curl على السيرفر الحقيقي (2026-09-16):** حلاق فعّل الخدمة (`enabled:true, price:150`) وحدد مواعيد (كل الأسبوع متاح) → عميل لقى المحل (`GET customer/homeService/shop`) وعمل طلب (`POST customer/homeService` → `id:1, status:PENDING`) → حلاق ضاف رسوم 50 جنيه (`priceConfirmationPending:true`) → حلاق حاول يقبل فترفض بـ 400 ("بانتظار موافقة العميل...") → عميل وافق (`confirmPrice`) → حلاق قبل (`ACCEPTED`) → حلاق حاول يعدل السعر فترفض بـ 409 ("لا يمكن تعديل السعر بعد قبول الطلب") → `ON_THE_WAY` → `DONE`. كل الردود موثقة في الأقسام فوق واتاخدت منها الـ models مباشرة. الطلب التجريبي ده (`id:1, code:HS-000001`) لسه موجود في بيانات السيرفر الحقيقية — ممكن يتمسح لاحقًا أو يتسابله.
- [ ] جرب فعليًا جوه التطبيق نفسه (مش curl بس) الـ golden path والـ alternate paths (رفض الحلاق، إلغاء العميل، قبول من غير تعديل سعر) بعد ما الشاشات تتبني.

---

## ترتيب تنفيذ مقترح — كل الأقسام (1-5) خلصت ✅ 2026-09-16

1. ✅ Endpoints + shared status enum (قسم 1، 5)
2. ✅ `barber/home_service` الإعدادات + المواعيد (قسم 2.1، 2.2) — متحقق منه فعليًا جوه التطبيق (باقة emulator يدوي)، الحفظ شغال على `PUT barber/homeService` و`PUT barber/homeService/hours` الحقيقيين.
3. ✅ `customer/home_service` الاكتشاف (قسم 3.1)
4. ✅ طلب العميل + تفاصيله (قسم 3.2)
5. ✅ طابور الحلاق وقبول/رفض/تسعير (قسم 2.3)
6. ✅ Routing + nav entry points (قسم 4)
7. ⏳ التحقق العملي الكامل جوه التطبيق (قسم 6) — الـ golden path كامل متحقق منه بـ curl + الحلاق-سايد (settings/hours) متحقق منه جوه التطبيق فعليًا. باقي: تجربة فلو العميل كامل (اكتشاف → طلب → تأكيد سعر → إلغاء) وطابور الحلاق (قبول/رفض/تعديل سعر) جوه التطبيق نفسه، مش بس عن طريق الكود والـ curl.

**الخطوة الجاية المنطقية:** تشغيل التطبيق (`flutter run --flavor dev -t lib/main_dev.dart`) وتجربة الشاشات الجديدة كلها يدويًا بحساب العميل والحلاق التجريبيين، مع مراجعة الـ RTL layout والـ l10n على شاشات حقيقية (مش تحليل كود بس).
