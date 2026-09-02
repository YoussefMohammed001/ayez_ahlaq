# Ayez Ahlaq — سياق الجلسة الجاية

انسخ الملف ده (أو قوله "اقرا NEXT_SESSION.md") في أول الجلسة الجديدة.

---

## القواعد (مقدسة — متكسرهاش)

1. Clean Architecture كامل: `data/` → `domain/` → `presentation/`
2. SOLID — الاعتماد على abstractions (`IXxxRepo`) مش implementations
3. **مفيش كود مكرر** — دوّر في `lib/core/widgets/` و `lib/shared/` الأول
4. **مفيش comments في الكود**
5. **كلاس واحد في كل ملف** (الـ extension برضو ملف لوحده)
6. **أقصى ١٥٠ سطر في الملف**
7. **مفيش نص hardcoded** — كل حاجة في `lib/l10n/intl_en.arb` + `intl_ar.arb` ثم `S().key`
8. Flavors: `main_dev.dart` / `main_prod.dart`
9. اقرا `lib/core/` قبل ما تكتب أي حاجة جديدة

**قبل ما تخلص أي شغل، شغّل:**
```bash
flutter analyze --no-pub 2>&1 | grep -cE "error •"          # لازم 0
find lib/features lib/core/widgets -name '*.dart' | xargs wc -l | awk '$1>150'   # لازم فاضي
python3 -c "import json;en=set(json.load(open('lib/l10n/intl_en.arb')));ar=set(json.load(open('lib/l10n/intl_ar.arb')));print(en^ar)"  # لازم set()
flutter test
```

---

## حالة المشروع

**تطبيق واحد، ٣ أنواع** (customer / barber / merchant) — شاشة اختيار النوع قبل الدخول.
**التاجر بس هو اللي متعمل.** الحلاق والعميل لسه.

### API
- Base (متأكد منه بالتجربة): `https://gobeeeg.com/ayezAhlaqApi/api/`
  ⚠️ الـ Postman collection مكتوب فيه `ayezAhlaq-api` وده **غلط** (nginx 405)
- Envelope: `{data, message, status}` — `NetworkService` بيتعامل معاه أصلًا
- Auth: `Bearer`, صلاحية ٢٤ ساعة
- حساب تجربة (متأكد منه ٢٠٢٦/٠٩/٠٢): `0123456` / `123456`

### فروق مهمة بين الأنواع (مكتشفة بالتجربة على السيرفر)
| النوع | حقل الدخول | header |
|---|---|---|
| merchant | `phoneNumber` | — |
| barber | `identifier` | **`X-Client` مطلوب (DESKTOP أو MOBILE)** |
| customer | `identifier` | — |

**يعني `LoginRequest` لازم يفضل منفصل لكل نوع. الـ response بس هو المشترك.**

---

## اللي خلص (التاجر)

`lib/features/merchant/` — auth · dashboard · products · categories · discounts · orders · profile · notifications

**١٩ شاشة**، كلها API حقيقي **ماعدا:**
- **الطلبات = mock** → `MerchantOrdersMock.enabled = true`
- **الإشعارات = mock** (بطلب من المستخدم) → `NotificationsMock.enabled = true`

كلاهما: الـ API مكتوب وجاهز، غيّر الـ bool بس.

### `lib/core/widgets/` (استخدمهم، متعملش جداد)
`AppCard` · `StatusBadge`+`BadgeTone` · `AvatarCircle` · `StatTile` · `ToggleSwitch` · `SectionTitle` · `AppBottomNavBar` · `AppTopBar` · `PrimaryCtaButton` · `AppTextField` · `AppInputDecoration` · `InfoRow` · `MenuRow` · `AppEmptyState` · `AppErrorState` · `AppStateView` · `RefreshableStateView` · `ImagePickerRow` · `FilterChipRow<T>` · `ShimmerBox` · `ListSkeleton`

### `lib/shared/auth/` (اتنقل هنا عشان يتشارك)
`AuthSession` · `AuthSessionModel` · `AuthLocalDataSource`

### الثيم
dark هو الافتراضي. `AppDarkColors`: ink950 `#14120F` · ink900 `#1C1916` · ink800 `#262119` · hairline `#3C3327` · brass500 `#C6982F` · brass300 `#E3C273` · ivory100 `#F3ECDD` · ivory500 `#8C8270` · moss500 `#7CA37C` · rust400 `#D97355` · sky500 `#6E93A8`
خطوط: ReemKufi للعناوين، Cairo للنص. RTL. `HeadingStyles.h1..h5` + `styles.dart`.

---

## الفاضل — بالترتيب

### ~~١. المستندات (`/attachment`)~~ — ✅ خلصت
`lib/features/merchant/documents/` — عرض · رفع · استبدال · مسح · فتح الملف.
الـ contract متأكد منه بالتجربة على السيرفر:
- `GET /merchant/attachment` → list
- `POST /merchant/attachment/{id}/file` → **اسم الحقل `file`**، بيرجّع الـ attachment المحدّث
- `DELETE /merchant/attachment/{id}/file` → `{"message":"file removed"}`
- `GET /merchant/attachment/{id}/file` → bytes خام + `Content-Disposition` (مش JSON) — لو مفيش ملف بيرجّع 404 `no file uploaded for this attachment`
- الرفع بيرفض أي حاجة غير صور/PDF بـ 400 `only images or PDF files are allowed`
- الأدمن ممكن يكون رافع الملف بنفسه (`uploadedByType: ADMIN`) والتاجر لسه يقدر يستبدله

الصور بتتعرض جوه التطبيق بـ `AuthorizedNetworkImage`، والـ PDF بيتفتح بـ `share_plus` + `path_provider`
(اتضافت `path_provider` كـ direct dependency).

### ٢. الطلبات الحقيقية
محتاج **response حقيقي واحد** من `GET /api/merchant/order` (لازم حلاق يعمل طلب).
شوف `nextStatuses` و `items` وقارنهم بـ `PurchaseOrderModel`، وبعدين `enabled = false`.

### ٣. الحلاق والعميل (لما الـ APIs تجهز)
**مهم:** ابنِ auth الحلاق **جنب** بتاع التاجر بتكرار مؤقت.
بعد ما الاتنين يشتغلوا، شوف اللي اتكرر **فعلًا** وطلّعه لـ `shared/`.
متعملش abstraction من مثال واحد.

اللي متوقع يتشارك: `IAuthRepo` · `LoginScreen(userType)`
اللي متوقع يفضل منفصل: `LoginRequest` · `RegisterRequest` · `Profile` entity · شاشات التسجيل

### ٤. حاجات صغيرة
- تعديل المخزون من شاشة المنتجات (`SetProductStockUseCase` جاهز، مفيش UI)
- الـ `X-Client` header للحلاق في `AuthorizationInterceptor`

---

## مشاكل معروفة
- `flutter run` لازم `--flavor dev -t lib/main_dev.dart` (مش `lib/main.dart` لوحده)
- `lib/app_idea_prototype/` = مرجع تصميم بس، مستثنى من الـ analyzer، **متستوردش منه** — يتمسح لما الشاشات كلها تتنقل
- ٣ ملفات في `core/widgets/` فوق ١٥٠ سطر (`app_form_field` · `full_screen_image_viewer` · `app_button`) — قديمة من قبل الشغل ده، سيبها
