# شغل النهاردة (2026-09-23) — صورة المحل (Shop Profile Image)

## الـ API اللي بعتها الباك اند (اتفحصت فعليًا على السيرفر اللايف)

```
POST   /api/barber/profileImage    multipart, field name "file", owner فقط
GET    /api/barber/profileImage    raw bytes (image/png), أي بارْبر مسجل دخول
DELETE /api/barber/profileImage    owner فقط
```

جربتهم دلوقتي على السيرفر اللايف بحساب البارْبر التجريبي، والنتايج:

- **مفيش صورة أصلًا** → `GET` بيرجع **404** JSON عادي: `{"data":null,"message":"لا توجد صورة شخصية","status":false}` — زي أي error envelope عادي، مش استثناء.
- **رفع صورة** → `POST` بيرجع **200** بس `data: null` (`{"data":null,"message":"تم تحديث الصورة الشخصية","status":true}`) — **مفيش رابط صورة راجع في الـ response**. لازم تعمل GET تاني عشان تجيب الصورة، أو تعرض نفس الملف اللي رفعته محليًا (optimistic) بدل ما تستنى رد فيه URL مش هيجيلك.
- **بعد الرفع** → `GET` بيرجع **200** و`Content-Type: image/png` — bytes خام، مش JSON envelope.
- **مسح الصورة** → `DELETE` بيرجع **200**, `data: null`.
- **بعد المسح** → `GET` يرجع تاني 404 زي الحالة الأولى.

ده **نفس الـ pattern بالظبط** الموجود دلوقتي في `barber/documents` (`barber/attachment/{id}/file`) — الفرق الوحيد إن مفيش `{id}` هنا، الصورة شخصية مربوطة بالتوكن (owner واحد لكل محل).

---

## قرار التصميم: مكانها فين في الكود

- **مش feature جديدة منفصلة.** هي جزء من `lib/features/barber/profile/` الموجود بالفعل، لأنها خاصية على نفس البروفايل (زي `barberLocation`, `barberPassword`).
- الشاشة اللي هتستخدمها: [barber_profile_screen.dart](lib/features/barber/profile/presentation/pages/barber_profile_screen.dart) — فيها `_buildHeader` بيعرض `AvatarCircle` من غير صورة حالية دلوقتي. ده المكان الطبيعي لصورة المحل.
- إعادة استخدام: `AppImagePicker.pickSingle()` (core/helpers) لاختيار الصورة، و`NetworkService.uploadFile` + `getImageData` (موجودين ومُستخدمين بالفعل في `barber_documents_api.dart`) — **بدون أي كود جديد في core**.

---

## خطوات التنفيذ (بترتيب الطبقات، Clean Architecture)

### 1. Endpoints
أضف في [endpoints.dart](lib/core/network/constants/endpoints.dart) بجوار `barberAttachment`:
```dart
static const String barberProfileImage = 'barber/profileImage';
```

### 2. Data layer
- `lib/features/barber/profile/data/apis/barber_profile_api.dart` (الملف الموجود) — أضف 3 methods:
  - `uploadProfileImage(String filePath)` → `uploadFile` بـ `FormData` field `file`
  - `getProfileImage()` → `getImageData` (يرجع bytes)
  - `deleteProfileImage()` → `deleteData`
- الريبو `barber_profile_repo.dart` يعكسهم بنفس التوقيع اللي في `i_barber_profile_repo.dart`.

### 3. Domain layer
- 3 use cases جداد في `domain/use_cases/`:
  - `upload_barber_profile_image_use_case.dart`
  - `get_barber_profile_image_use_case.dart`
  - `delete_barber_profile_image_use_case.dart`
- (مفيش entity جديدة — الصورة bytes مش object، فمفيش حاجة تتضاف لـ `BarberProfile` entity نفسها إلا لو حبينا نضيف فلاج `hasProfileImage` بعدين لو الباك اند وفره).

### 4. Presentation layer
- `barber_profile_cubit.dart` / `barber_profile_state.dart`: أضف state لتخزين الصورة (`Uint8List?` أو cache كـ `File?` محلي بعد الرفع) + حالة تحميل/خطأ منفصلة عشان ميعطلش باقي البروفايل.
- عدّل `_buildHeader` في `barber_profile_screen.dart` (أو widget فرعي جديد لو الملف هيقرب من 150 سطر) بحيث:
  - عند فتح الشاشة: استدعِ `getProfileImage`، لو 404 اعرض `AvatarCircle` افتراضي زي دلوقتي.
  - عند الضغط على الأفاتار (owner فقط — استخدم `profile.owner`): افتح `AppImagePicker.pickSingle()` → ارفع → بعد نجاح الرفع اعرض الصورة المختارة محليًا فورًا (مش من الـ response لأنه `data: null`) وبالتوازي أعد الـ GET في الخلفية للتأكيد.
  - خيار مسح الصورة (icon صغير أو long-press) يستدعي `deleteProfileImage` ويرجع للـ avatar الافتراضي.

### 5. DI
سجّل أي use case جديد في `services_locator.dart` بنفس نمط باقي الـ profile use cases الموجودة (لو الـ Api/Repo مسجلين بالفعل، مفيش حاجة تتغير غيرهم).

### 6. اختبار
- اختبر بحساب owner (`01008451421` / `123456`) الرفع والمسح والعرض.
- اختبر بحساب team member (مش owner) إن زرار الرفع/المسح مختفي أو معطّل — الباك اند بيرفض بـ owner-only بس الـ UI يفضل يمنعها من الأساس.
- اختبر حالة offline (لازم NetworkService يتعامل معاها زي أي endpoint تاني — متأكد إنها بترجع Either بشكل صحيح، من غير ما ندخل كود جديد لايت).

---

## حاجات لازم تتأكد منها بعدين (مش دلوقتي)

- الباك اند مش راجع رابط/id للصورة في أي response تاني (زي شاشة تفاصيل المحل عند الكاستمر) — يعني الكاستمر مش هيشوف صورة المحل لسه غير لو فيه endpoint تاني منفصل. لو محتاجينها في شاشة الكاستمر، لازم تتسأل الباك اند صراحة.
- مفيش validation موثقة على نوع/حجم الملف من الباك اند في اللي بعتوه — جرّبت PNG بس ونجح. لو حابب تتأكد من حدود الحجم/الامتداد قبل ما تعتمد على validation في الـ UI بس، اسأل الباك اند أو جرّب JPEG/حجم كبير.
