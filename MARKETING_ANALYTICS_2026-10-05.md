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

نسخة الـ prod بتتصل افتراضياً بـ `https://gobeeeg.com/ayezAhlaqProdApi/api/`.

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
