# Analytics + In-App Review (2026-10-05)

الأداة: **Firebase Analytics (GA4)**. موجود في المشروع، ومفيش أداة جديدة تتفتح.

## ١. الـ In-App Review

- الكود: [review_prompt_service.dart](lib/core/review/review_prompt_service.dart) (باكدج `in_app_review`، نافذة التقييم الأصلية بتاعة iOS/Android).
- بيطلب التقييم بعد **٣ إجراءات إيجابية**:
  - **عميل**: قيّم حجز بـ ٤ نجوم أو أكتر.
  - **حلاق**: أنهى حجز (حالة `DONE`).
  - **تاجر**: قبل طلب، أو سلّم طلب (`DELIVERED`).
- مرة كل **٩٠ يوم** على الأقل، وبحد أقصى **٣ مرات** على الجهاز.
- كل ظهور بيتسجل بحدث `review_prompt_shown`.
- ملاحظات:
  - Apple وGoogle هما اللي بيقرروا فعلاً يظهروا النافذة، ومفيش ضمان إنها تظهر كل مرة (حصة سنوية).
  - على TestFlight / debug النافذة مش بتظهر بشكل حقيقي.
  - زر «قيّم التطبيق» يدوي في الإعدادات محتاج `appStoreId` (iOS) ومعرفه بعد النشر على المتجر.

## ٢. المستخدمين النشطين والمحافظات

- **Active users (DAU / WAU / MAU)**: GA4 بيحسبها تلقائي من أول يوم، من غير أي كود. بتلاقيها في Reports ← Engagement.
- **حسب المحافظة**: عندنا طريقتين:
  1. تلقائي من GA4: Reports ← Demographics ← **Region/City** (من الـ IP). بتبان بأسماء المحافظات بالإنجليزي، والدقة متوسطة.
  2. **User property اسمها `governorate`** بنحطها من موقع الجهاز بعد الـ reverse geocoding (اسم المحافظة بس، مش الإحداثيات). أدق، وتقدر تعمل بيها Audience أو Filter.
     - ما بتتحط إلا لو المستخدم **مدّى إذن الموقع بالفعل** (التطبيق مابيطلبش الإذن لأجل الـ analytics).
     - بعد أول ظهور للـ property، لازم تسجلها في GA4: Admin ← Custom definitions ← Create custom dimension: Scope = **User**، User property = `governorate`. وبرضه `user_type`.
- **نوع المستخدم**: user property اسمها `user_type` (`customer` / `barber` / `merchant`)، بتتحط عند الدخول وعند فتح التطبيق وهو مسجل.
- **User ID**: `customer_5` / `barber_12` (نوع + رقم من غير أي بيانات شخصية).

## ٣. الأحداث (Events)

### أوتوماتيك
| الحدث | المصدر |
|---|---|
| `screen_view` | كل شاشة في التطبيق (اسم الشاشة = مسار الـ route) |
| `first_open`, `session_start`, `app_remove`... | Firebase |

### أحداث مسماة (تتسجل عند نجاح طلب POST/PUT/DELETE)
| الحدث | المعنى |
|---|---|
| `login` / `sign_up` / `otp_verified` | دخول وتسجيل جديد وتأكيد الرقم (لكل الأنواع) |
| `booking_created` / `booking_cancelled` / `booking_rated` | رحلة الحجز عند العميل (`booking_rated` معاه `rating`) |
| `home_service_requested` | طلب حلاقة منزلية |
| `store_order_placed` | طلب من المتجر (عميل أو حلاق) |
| `favorite_added` / `favorite_removed` | المفضلة |
| `barber_booking_accepted` / `rejected` / `completed` | شغل الحلاق على الحجوزات |
| `barber_service_added` / `barber_location_saved` | إعداد المحل |
| `merchant_product_added` / `merchant_order_updated` | شغل التاجر |
| `shop_viewed` / `shop_view_on_map` | فتح محل وزر «شوف على الخريطة» (معاهم `shop_id`) |
| `review_prompt_shown` | ظهور نافذة التقييم |

كل حدث معاه `user_type`.

### حدث عام لأي إجراء تاني
`app_action` مع باراميتر `action` (مثلاً `put_barber_hours`، `post_merchant_discount`) و`user_type`.
- ده بيغطي **أي** عملية كتابة في التطبيق لأي نوع، حتى لو ماتسمّتش.
- لو حدث منهم مهم للماركتينج، أضيفه في [api_action_mapper.dart](lib/core/analytics/api_action_mapper.dart) باسم واضح (سطر واحد).

## ٣-ب. تغطية كل الإجراءات (2026-11-06)

كل عملية كتابة ناجحة (POST/PUT/DELETE) في التطبيق ليها **اسم حدث واضح**: 119 اسم، ومحمية بتست بيتأكد إن **كل** الـ endpoints الكتابية (175 endpoint) مسمّية، وإن كل الأسماء صالحة لـ GA4 (≤40 حرف، حروف وأرقام و`_`). الكتالوج في [lib/core/analytics/catalog/](lib/core/analytics/catalog/)، وإضافة إجراء جديد = سطر واحد في الملف المناسب.

**عام (كل الأنواع)** (27):
`login` · `sign_up` · `otp_verified` · `otp_resent` · `password_reset_requested` · `password_reset_otp_verified` · `password_reset` · `password_changed` · `account_deleted` · `wallet_request_created` · `wallet_request_cancelled` · `wallet_request_proof_added` · `store_order_placed` · `store_cart_updated` · `store_order_cancelled` · `notification_opened` · `notifications_all_seen` · `broadcast_sent` · `sponsorship_requested` · `subscription_requested` · `discount_created` · `discount_updated` · `discount_closed` · `document_uploaded` · `document_removed` · `profile_image_changed` · `profile_image_removed`

**العميل** (12):
`booking_created` · `booking_cancelled` · `booking_rated` · `store_order_rated` · `visit_rated` · `home_service_requested` · `home_service_cancelled` · `home_service_price_confirmed` · `home_service_retried` · `favorite_added` · `favorite_removed` · `favorite_added_via_invite`

**الحلاق: التشغيل اليومي** (37):
`barber_check_in` · `barber_check_out` · `barber_attendance_settings_saved` · `barber_attendance_corrected` · `attendance_feature_requested` · `attendance_feature_request_cancelled` · `barber_booking_accepted` · `barber_booking_rejected` · `barber_booking_completed` · `barber_booking_billed` · `barber_bookings_settled` · `barber_walkin_added` · `barber_home_service_toggled` · `barber_home_service_hours_saved` · `barber_hs_broadcast_accepted` · `barber_hs_broadcast_rejected` · `barber_hs_request_accepted` · `barber_hs_request_rejected` · `barber_hs_request_priced` · `barber_hs_request_status_updated` · `barber_hours_saved` · `barber_location_saved` · `barber_invite_regenerated` · `barber_serves_clients_changed` · `merchant_rated` · `barber_money_entry_added` · `barber_money_item_added` · `barber_money_item_updated` · `barber_money_item_deleted` · `barber_money_occurrence_confirmed` · `barber_money_occurrence_dismissed` · `barber_money_pin_set` · `barber_money_pin_changed` · `barber_money_pin_reset_requested` · `barber_drink_added` · `barber_drink_updated` · `barber_drink_deleted`

**الحلاق: المحل والفريق والمتجر** (29):
`barber_service_added` · `barber_service_updated` · `barber_service_deleted` · `barber_own_service_added` · `barber_own_service_deleted` · `barber_haircut_style_updated` · `barber_team_member_added` · `barber_team_member_updated` · `barber_team_member_removed` · `barber_team_member_activated` · `barber_team_member_availability` · `barber_team_hours_saved` · `barber_team_password_reset` · `barber_team_member_deleted` · `barber_team_permissions_saved` · `barber_team_service_added` · `barber_team_service_updated` · `barber_team_service_removed` · `barber_storefront_category_added` · `barber_storefront_category_updated` · `barber_storefront_category_deleted` · `barber_storefront_delivery_saved` · `barber_storefront_product_added` · `barber_storefront_product_updated` · `barber_storefront_product_deleted` · `barber_storefront_stock_updated` · `barber_storefront_order_accepted` · `barber_storefront_order_rejected` · `barber_storefront_order_status`

**التاجر** (14):
`merchant_product_added` · `merchant_product_updated` · `merchant_product_deleted` · `merchant_product_stock_updated` · `merchant_product_image_removed` · `merchant_category_added` · `merchant_category_updated` · `merchant_category_deleted` · `merchant_order_updated` · `merchant_delivery_saved` · `merchant_location_saved` · `merchant_profile_updated` · `merchant_phone_added` · `merchant_phone_removed`

**اللي بنتجاهله عمدًا** (ضجيج مش إجراءات): تسجيل جهاز الإشعارات (`deviceToken`)، وتعليم إشعار كـ «مقروء»، وطلبات التسعير/المعاينة (`quote`)، والتحقق من PIN المال. فتح إشعار (`clicked`) بيتسجل كـ `notification_opened`.

أي endpoint جديد من غير قاعدة بيتسجل تحت `app_action` زي الأول (والتست بيفشل لو حد أضاف endpoint كتابي من غير ما يتسمّى).

### أحداث من التطبيق نفسه (مفيش API وراها)
| الحدث | الباراميترات | المعنى |
|---|---|---|
| `tour_started` | `source`: `first_run` / `requested` | بدأت الجولة التعريفية |
| `tour_completed` / `tour_skipped` | — | خلّصها أو تخطّاها |
| `setup_step_opened` | `step`: `hours` / `services` / `photo` / `documents` | ضغط على خطوة في checklist الإعداد |
| `setup_completed` | — | أكمل كل خطوات الإعداد (مرة عند الإكمال) |
| `help_opened` / `help_question_opened` / `help_tour_requested` | `question_index` | شاشة المساعدة |
| `auto_attendance_toggled` | `enabled`, `result` | تشغيل أو إيقاف الحضور التلقائي ونتيجته (`enabled`, `permissionDenied`, `permissionBlocked`, `needsAlwaysPermission`, `rangeTooSmall`, `noShopLocation`, `failed`, `disabled`, `permission_revoked`) |
| `auto_attendance_triggered` | `transition`: `entered`/`exited`، `outcome`: `checkedIn`/`checkedOut`/`failed` | سجّل الحضور أو الانصراف تلقائيًا (من الخلفية، بيوصل لـ GA4 **عند أول فتح للتطبيق بعدها**) |
| `shop_viewed` | `shop_id` | فتح صفحة محل (مرة لكل فتح) |
| `location_picked` | `source` | اختار موقع من الخريطة |
| `language_changed` / `theme_changed` | `language` / `theme` | تغيير اللغة والمظهر |
| `external_link_opened` | `target`: `whatsapp`/`phone`/`maps`/`email`/`web` | فتح رابط خارجي |
| `logout` | `user_type` | تسجيل الخروج |

### باراميترات بتتضاف أوتوماتيك على أحداث الـ API
من جسم الطلب، وبس لو القيمة آمنة (حروف وأرقام و`_`/`-` وأقل من 40 حرف، يعني مفيش نص حر ولا أسماء ولا إحداثيات):

| الباراميتر | يظهر مع |
|---|---|
| `method` (`MANUAL` / `AUTO`) | `barber_check_in`, `barber_check_out` |
| `status` | تحديثات حالة الحجز والطلب والحلاقة المنزلية |
| `payment_method` | `booking_created`, `store_order_placed` |
| `type` | `wallet_request_created` (شحن أو سحب) |
| `rating` | التقييمات |

### تسجيل الـ custom dimensions في GA4 (مرة واحدة)
عشان تقدر تفلتر بالباراميترات دي في Reports: Admin ← Custom definitions ← Create custom dimension، Scope = **Event** لكل واحد من:
`method`, `status`, `payment_method`, `type`, `step`, `result`, `enabled`, `transition`, `outcome`, `language`, `theme`, `target`, `question_index`, `source`, `shop_id`, `action`.
(الحد الأقصى 50 event-scoped dimension في الحساب المجاني، فده بيستهلك 16.)

**أحداث تنفع تعلّمها Key events (Conversions):** `sign_up`, `booking_created`, `barber_booking_completed`, `store_order_placed`, `barber_check_in`, `setup_completed`, `subscription_requested`.

**لو عايز تتأكد:** DebugView زي ما فوق. جرّب `barber_check_in` وشوف `method=MANUAL`، وبعد ما تجرب الحضور التلقائي افتح التطبيق وشوف `auto_attendance_triggered`.

## ٤. مش بنجمعه
- مفيش إحداثيات، ولا أرقام تليفون، ولا أسماء، ولا محتوى الطلبات في الأحداث.
- اسم المحافظة والموقع التقريبي فقط.
- **لازم تحدّث Privacy Label في App Store و Data Safety في Google Play** (Analytics: Device ID / Usage Data / Coarse Location)، وتذكر ده في سياسة الخصوصية.

## ٥. للتجربة
- Firebase Console ← Analytics ← **DebugView**.
- iOS: شغّل التطبيق بـ `-FIRDebugEnabled` من Xcode scheme. Android: `adb shell setprop debug.firebase.analytics.app com.ayezAhlaq.app.dev`.
- الأحداث العادية بتظهر في Reports بعد ٢٤-٤٨ ساعة.

---

# إعداد الـ API للمراجعة (Remote Config)

نسخة الـ prod بتتصل افتراضياً بـ `https://ayezahlaq.com/ayezAhlaqProdApi/api/`.

للمراجعة (App Store / Google Play) نقدر نخليها تتصل بالـ dev بس **للنسخة اللي بتتراجع**:

1. في Firebase Console (مشروع `ayez-ahlaq` الـ prod) ← Remote Config، أضف مفتاحين من نوع **Number**:
   - `review_dev_api_build_ios`
   - `review_dev_api_build_android`
2. القيمة الافتراضية: `0` (يعني مقفول).
3. قبل ما ترفع النسخة للمراجعة، حط رقم الـ **build number** بتاعها (الرقم بعد الـ `+` في `pubspec.yaml`) في المفتاح بتاع المنصة.
4. التطبيق بيستخدم الـ dev **بس لو** رقم الـ build المنزّل = القيمة في المفتاح. أي نسخة تانية (قديمة أو جديدة) بتفضل على الـ prod حتى لو المفتاح اتحط غلط.
5. بعد ما المراجعة تخلص رجّع المفتاح لـ `0`.

## السلوك
- الافتراضي دايماً prod.
- لو الـ fetch فشل أو اتأخر عن ٣ ثواني، بيستخدم آخر قيمة محفوظة، ولو مفيش، prod.
- التبديل بيحصل عند فتح التطبيق (قبل أي طلب).
- حسابات الـ dev مختلفة عن الـ prod، فالتبديل بيطلّع المستخدم من الجلسة (ده لمراجعي المتجر بس).
