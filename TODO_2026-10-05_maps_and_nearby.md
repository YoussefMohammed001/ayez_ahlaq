# TODO (2026-10-05) — الخرائط (Apple/Google) + القريب مني (Nearby)

## الوضع الحالي (اتفحص في الكود)

- `google_maps_flutter` و`geolocator` و`geocoding` موجودين في pubspec. `apple_maps_flutter` **مش موجود**.
- شاشة الاختيار الحالية: [map_location_picker_screen.dart](lib/shared/location/presentation/pages/map_location_picker_screen.dart) — شاشة كاملة بـ `GoogleMap` ودبوس في النص، بتتفتح بـ `context.push` على `Routes.mapLocationPickerScreen` وبترجع `PickedLocation`.
- نقطة الدخول الوحيدة: [location_picker_field.dart](lib/shared/widgets/location_picker_field.dart) وبتتستخدم في 6 أماكن (تسجيل الحلاق، لوكيشن الحلاق، لوكيشن التاجر، توصيل متجر الحلاق، توصيل متجر العميل، طلب خدمة منزلية). **تعديل واحد فيها بيغطي الكل.**
- `LocationPickerField` بيعرض `lat, lng` للمستخدم (`toStringAsFixed(5)`) — ده اللي عاوزين نشيله.
- `CurrentPositionResolver.resolve()` بيرجع `null` في أي فشل (الخدمة مقفولة / الإذن مرفوض / timeout) من غير ما يفرق بينهم. `CustomerShopsCubit` و`HomeServiceShopsCubit` بيحطوا `sortedByDistance = position != null` بس، والعميل مبيعرفش ليه مفيش ترتيب بالقرب.
- ملف الإعدادات الموجود: [customer_app_settings_menu_screen.dart](lib/features/customer/profile/presentation/pages/customer_app_settings_menu_screen.dart).

---

## القرارات المتفق عليها

1. **نبسطها**: Apple Maps على iOS، Google Maps على Android، ورا widget واحد. باقي الكود ميعرفش النظام.
2. التصميم يطابق الـ screenshot بالظبط: **bottom sheet** (مش شاشة كاملة).
3. المستخدم **مايشوفش lat/lng أبدًا**. بنعرض اسم المكان بس. الإحداثيات بتتبعت للسيرفر وبتتخزن في الـ state بس.
4. لو العميل قافل الموقع: القريب مني مش هيشتغل، ونوضحله ده بوضوح مع طريقة التفعيل (بانر + إعداد في الإعدادات).

---

## الجزء 1: الخريطة

### 1.1 الباكدج والإعدادات
- [ ] إضافة `apple_maps_flutter` في [pubspec.yaml](pubspec.yaml) (مفيش API key لـ Apple Maps).
- [ ] `flutter pub get` و`pod install` والتأكد إن الـ build على iOS بيشتغل.
- [ ] التأكد إن `NSLocationWhenInUseUsageDescription` في `Info.plist` نصها عربي واضح.
- [ ] **مراجعة أمنية**: الـ Google Maps API key مكتوب صريح في `ios/Runner/AppDelegate.swift` و`AndroidManifest.xml` (والـ iOS مش هيحتاجه بعد التغيير). تقييد الـ key في Google Cloud بالـ bundle id / package + SHA-1، وشيله من iOS لو مبقاش مستخدم.

### 1.2 Widget الخريطة المشترك (`AppMap`)
- [ ] ملف `lib/shared/location/presentation/widgets/app_map.dart` — `Platform.isIOS ? AppleMap : GoogleMap`.
- [ ] نفس الـ API للاتنين: `initialTarget`, `zoom`, `onCameraMove(LatLng)`, `onCameraIdle`, `onMapCreated`، و`animateTo(LatLng)` عن طريق controller صغير.
- [ ] تحويل `LatLng` بين المكتبتين جوه الـ widget بس. ممنوع يتسرب نوع `google_maps_flutter` لبره. (حاليًا `DeviceLocationService` بيرجع `LatLng` من جوجل — يتغير لـ `PickedLocation`/record بسيط.)
- [ ] ملف واحد لكل class، وكل ملف أقل من 150 سطر.

### 1.3 الـ bottom sheet (مطابق للصورة)
الترتيب من فوق لتحت:
- [ ] هيدر: زر إغلاق (X) على الطرف، عنوان في النص «تحديد الموقع على الخريطة».
- [ ] حقل بحث بأيقونة بحث وزر مسح (X). `AppSearchField` موجود في `core/widgets/`، يتعاد استخدامه أو يتوسع.
- [ ] كارد الخريطة بحواف دايرية (مش full screen) ودبوس في النص، وتتحرك الخريطة تحت الدبوس.
- [ ] كارد «الموقع المحدد»: اسم المكان بخط كبير + المدينة/المحافظة تحته، وعلى الطرف زر «موقعي الحالي».
- [ ] زر تأكيد كبير في الآخر.
- [ ] فتحه بـ `showModalBottomSheet` (`isScrollControlled`) بدل `context.push`، وإزالة `Routes.mapLocationPickerScreen` والـ route في `app_routes.dart` لو مبقاش مستخدم.
- [ ] تحويل `MapLocationPickerScreen` لـ `MapLocationPickerSheet`. الـ Cubit الحالي يفضل زي ما هو مع تعديلات الأسماء.
- [ ] الألوان من الثيم (`context.colorScheme` و`context.semantic`)، والأحجام `.w .h .sp .r`، والنصوص `AppText` وستايلات `styles.dart`. وكل الجمل في ملفات `l10n`.

### 1.4 البحث
- [ ] البحث بـ `geocoding` (`locationFromAddress`) عشان ببلاش وشغال على النظامين. يتعمل جوه `ILocationRepo`/use case مش جوه الـ widget.
- [ ] Debounce حوالي 500ms، ونتايج بتتعرض تحت حقل البحث، وعند الاختيار الخريطة تتحرك للمكان.
- [ ] لو الـ autocomplete طلع ضعيف، نقيّم Google Places كمرحلة تانية (محتاجة key وفاتورة، فمش دلوقتي).

### 1.5 عرض الاسم بدون إحداثيات
- [ ] [location_picker_field.dart](lib/shared/widgets/location_picker_field.dart): شيل سطر `lat, lng` واعرض `addressController.text` (اسم المكان) تحت العنوان.
- [ ] تحسين `DeviceLocationService.addressOf`: يرجع `name` (اسم المكان/الشارع) و`city` منفصلين عشان الكارد في الصورة (اسم كبير + مدينة صغيرة). `PickedLocation` يتوسع بحقل `city` أو `placeName`.
- [ ] لو الـ geocoding فشل: نعرض نص بديل مترجم زي «موقع محدد على الخريطة» وبرضه مش نعرض أرقام.
- [ ] مراجعة باقي الأماكن اللي ممكن تعرض الإحداثيات: `barber_location_screen`, `merchant_location_screen`, `home_service_request_detail_card`, `store_fulfillment_section` (باربر وعميل). **أي مكان بيعرض lat/lng يتغير لاسم المكان.**

---

## الجزء 2: القريب مني لما الموقع مقفول

الإجابة على السؤال: **لأ، القريب مني مش هيشتغل لو الموقع مقفول.** المطلوب إننا نكون صريحين مع العميل ونوريه إزاي يفعله.

### 2.1 نتيجة واضحة بدل `null`
- [ ] `CurrentPositionResolver.resolve()` يرجع نتيجة بحالة (sealed class أو enum + position) بدل `null`:
  - `available(position)`
  - `serviceDisabled` (GPS مقفول من الجهاز)
  - `permissionDenied` (ممكن نسأل تاني)
  - `permissionDeniedForever` (لازم يروح إعدادات الجهاز)
  - `timeout/error`
- [ ] تحديث `CustomerShopsCubit` و`HomeServiceShopsCubit` و`DeviceLocationService` (وتوحيدهم لأن فيهم تكرار في منطق الإذن) على النتيجة الجديدة.
- [ ] state فيها `locationStatus` بدل `sortedByDistance` بس.

### 2.2 بانر في شاشات القريب
- [ ] widget مشترك في `lib/shared/location/presentation/widgets/location_disabled_banner.dart`: «فعّل الموقع عشان نوريك الحلاقين القريبين منك» مع زر «تفعيل».
- [ ] الزر حسب الحالة: `requestPermission` لو `permissionDenied`، `Geolocator.openLocationSettings()` لو الخدمة مقفولة، `Geolocator.openAppSettings()` لو `deniedForever`.
- [ ] يتحط في `browse_shops_screen` وشاشة قايمة الخدمة المنزلية.
- [ ] لما الموقع مقفول القايمة تتعرض عادي (من غير ترتيب بالمسافة) وماتتكسرش.
- [ ] بعد ما المستخدم يفعّل ويرجع للتطبيق، نعيد التحميل تلقائيًا (`WidgetsBindingObserver` على `resumed`).

### 2.3 إعداد في الإعدادات
- [ ] صف جديد في [customer_app_settings_menu_screen.dart](lib/features/customer/profile/presentation/pages/customer_app_settings_menu_screen.dart): «الموقع» يعرض الحالة (مفعّل / غير مفعّل) وبالضغط يفتح إعدادات الجهاز المناسبة.
- [ ] نستخدم `MenuRow` الموجود في `core/widgets/` مش widget جديد.
- [ ] الحالة تتحدث لما يرجع التطبيق للـ foreground.
- [ ] ملحوظة: التطبيق مينفعش يفعّل الـ GPS بنفسه، وأقصى حاجة نطلب الإذن أو نفتح الإعدادات.

---

## الجزء 3: Clean Architecture (عشان نلتزم بالقواعد)

- [ ] `lib/shared/location/domain/`: `i_location_repo.dart`، use cases: `GetCurrentLocationUseCase`, `SearchPlaceUseCase`, `ResolvePlaceNameUseCase`.
- [ ] `lib/shared/location/data/`: `location_repo.dart` بيغلف `geolocator` و`geocoding`، ويرجع `Either<Failure, T>`.
- [ ] تسجيلهم في [services_locator.dart](lib/core/di/services_locator.dart) (Repo = lazy singleton، Cubit = factory).
- [ ] مفيش comments في الكود، وclass واحد في الملف، وأقل من 150 سطر.
- [ ] ترتيب التنفيذ: الجزء 3 (الأساس) ← الجزء 1 ← الجزء 2.

---

## اختبار قبول

- [ ] iPhone: الخريطة Apple Maps (شعار Maps ظاهر)، Android: Google Maps.
- [ ] الـ sheet شكله مطابق للصورة في الوضع الفاتح والداكن، وRTL سليم.
- [ ] البحث عن «مدينة المستقبل» بيحرك الخريطة ويحدّث اسم المكان.
- [ ] بعد التأكيد: مفيش أي lat/lng ظاهر في أي شاشة من الـ 6 أماكن، والـ API لسه بيستلم الإحداثيات.
- [ ] الموقع مقفول: بانر ظاهر، القايمة شغالة، والزر يفتح الإعدادات الصح.
- [ ] تفعيل الموقع من الإعدادات والرجوع للتطبيق: القريب مني يتحدث لوحده.
- [ ] `flutter analyze` نضيف، و`dart run build_runner build` لو اتغير موديل.

---

## الجزء 4: Dispose وتفريغ الحقول (Auth)

### اللي اتفحص
- كل شاشات الـ auth (customer / barber / merchant: login و register) وكل الـ views المشتركة في `shared/auth/presentation/widgets/` (OTP، نسيت الباسورد، باسورد جديد، تغيير الباسورد الإجباري، مسح الحساب) **فيها `dispose()` للـ controllers بالفعل.**
- المشكلة الحقيقية: الـ listeners اللي بتتضاف على الـ controllers ومبتتشالش.

### المطلوب
- [ ] [password_form_filed.dart](lib/shared/widgets/forms/password_form_filed.dart): بيعمل `addListener(() { setState(() {}); })` في `initState` من غير `removeListener` ومن غير `dispose` override. نحفظ الـ listener في method مسماة (`_onChanged`) ونشيله في `dispose`، ونعمل check على `mounted` قبل `setState`.
- [ ] [confirm_password_form_filed.dart](lib/shared/widgets/forms/confirm_password_form_filed.dart): نفس المشكلة على controller-ين (`passwordController` و`controller`). نشيل الاتنين في `dispose`.
- [ ] التأكد إن الاتنين widgets دول مستخدمين فعلًا. في الـ grep ماظهرش استخدام برا مجلد `forms/`. لو مش مستخدمين نمسحهم (قاعدة "مفيش كود مكرر": فيه `AppPasswordField` في `core/widgets/` بيعمل نفس الشغل).
- [ ] مراجعة `otp_verification_view.dart` و`location_picker_field.dart`: أي `Timer` أو `StreamSubscription` أو `FocusNode` بيتعمل فيهم `dispose`/`cancel`.

### تفريغ الحقول (Clear)
- [ ] تفريغ حقول login/register بعد نجاح العملية قبل الانتقال، وبعد الـ logout عشان الباسورد والرقم ماتفضلوش لو رجع المستخدم لنفس الشاشة (`context.push` بيسيب الشاشة الأولى في الـ stack بقيمها).
- [ ] تفريغ الباسورد (بس) عند فشل تسجيل الدخول، ويفضل الرقم عشان المستخدم ميكتبوش تاني.
- [ ] تفريغ حقل الـ OTP لما يتضغط «إعادة إرسال» أو لما الكود يطلع غلط.
- [ ] تفريغ حقول تغيير الباسورد ونسيت الباسورد بعد النجاح.
- [ ] عمل `clear()` موحد: extension صغير أو helper مرة واحدة (مثلًا `clearAll(List<TextEditingController>)` في `core/helpers/`) بدل تكرار نفس الأسطر في كل شاشة. وبعد `clear()` نعمل `_formKey.currentState?.reset()` عشان رسايل الـ validation تختفي.
- [ ] لو الـ state بتحتفظ برسالة خطأ قديمة في الـ Cubit، نصفّرها (`errorMessage = null`) وقت الدخول للشاشة.
- [ ] السؤال المتبقي: هل المقصود تفريغ الحقول عند الرجوع للشاشة (`push`/`pop`)، ولا بعد نجاح العملية، ولا الاتنين؟ المكتوب فوق بيغطي الحالات التلاتة، ونعدّل لو المقصود حاجة واحدة بس.

---

## الجزء 5: شريط التنقل في الأندرويد بيغطي على التطبيق (Edge-to-Edge)

### المشكلة
في شاشة «ملخص الحجز» على Android، شريط التنقل اللي تحت (الأزرار الثلاثة: recent / home / back) بيتحط **فوق** زر «تأكيد الحجز» وبيغطيه، والمستخدم مش قادر يضغطه بسهولة. الصورة: الزر ظاهر نصه بس ومخفي ورا الشريط.

### السبب المحتمل (يتأكد في البحث)
- من Android 15 (targetSdk 35) النظام بيفرض **edge-to-edge** تلقائيًا، والتطبيق بيترسم تحت شريط التنقل وشريط الحالة.
- `targetSdk` عندنا `flutter.targetSdkVersion` (في [build.gradle.kts](android/app/build.gradle.kts)) فبياخد قيمة الـ Flutter SDK وهي غالبًا 35 أو أعلى، فالسلوك ده مفعّل من غير ما نقرر إحنا.
- في الـ Dart مفيش أي `SystemChrome` للتحكم في الـ system bars غير في `full_screen_image_viewer.dart`، ومفيش `SafeArea`/`MediaQuery.padding.bottom` على الزر السفلي في شاشة الملخص.
- [styles.xml](android/app/src/main/res/values/styles.xml) فيه `windowLayoutInDisplayCutoutMode=shortEdges` في `LaunchTheme` ومفيش أي إعدادات للـ navigation bar.

### المطلوب
- [ ] **ابحث كويس الأول** (إنت اللي تعمل السيرش، مش تخمّن) عن الطريقة الصح لحل ده من ملفات الأندرويد. جرب الكلمات دي في Flutter docs وAndroid docs وGitHub issues:
  - `Flutter Android 15 edge-to-edge navigation bar overlaps content`
  - `enableEdgeToEdge FlutterActivity MainActivity`
  - `windowOptOutEdgeToEdgeEnforcement` (ملحوظة: بيتشال مع Android 16/targetSdk 36، فمش حل دائم)
  - `android:enforceNavigationBarContrast` و`android:navigationBarColor` في `values-v35/styles.xml`
  - `SystemChrome.setEnabledSystemUIMode edgeToEdge Flutter 3.x` و`SafeArea` / `MediaQuery.viewPadding`
- [ ] تحديد هل الحل الصح هو: (أ) ملفات الأندرويد بس (themes في `values/` و`values-v35/` و`values-night`)، ولا (ب) كود Dart (`SafeArea` / `bottomNavigationBar` / `ScreenPadding`)، ولا الاتنين. **الأفضل غالبًا الاتنين**: أندرويد يظبط لون وتباين الشريط، والـ Dart يحط padding سفلي صح، لأن opt-out بيختفي في الإصدارات الجاية.
- [ ] لو الحل أندرويد: التعديل في `styles.xml` (`LaunchTheme` و`NormalTheme`) ونسخ `values-night` و`values-v31` و`values-night-v31` عشان الاتساق، ومراجعة `AndroidManifest.xml` و`MainActivity`.
- [ ] لو الحل Dart: widget/helper واحد مشترك (بنراجع `core/helpers/screen_padding.dart` الأول) يضيف `MediaQuery.viewPaddingOf(context).bottom` للأزرار الثابتة تحت، بدل `SafeArea` متكررة في كل شاشة (قاعدة "مفيش كود مكرر").
- [ ] **مراجعة كل الشاشات اللي فيها زر/شريط ثابت تحت**، مش ملخص الحجز بس: الدفع، السلة، الـ checkout، تأكيد الطلب، الـ bottom sheets (اختيار الموقع الجديد)، والـ `bottomNavigationBar` في الشل.
- [ ] الاختبار على أكتر من شكل: جهاز بـ 3-button navigation (زي الصورة)، جهاز بـ gesture navigation، وأندرويد أقدم من 15، وكمان الوضع الداكن.
- [ ] نتأكد إن لون الشريط مع الخلفية (`#1C1916` في الوضع الداكن) مش مخلّي أيقونات الشريط مش باينة (`SystemUiOverlayStyle` + `statusBarIconBrightness`/`systemNavigationBarIconBrightness`).
- [ ] نكتب في الآخر في الـ PR أو في الملف إيه الحل اللي اخترناه وليه، عشان لو اترفع الـ targetSdk تاني نعرف نراجع.

### اللي اتنفذ في الجزء 5
- [x] السبب اتأكد: `targetSdk` الفعلي = 36 (من Flutter 3.47.5)، فالنظام بيفرض edge-to-edge ومفيش opt-out. وكمان `Scaffold` مبيعملش padding للـ body، وفيه حوالي 100 `PrimaryCtaButton` (شاشات وsheets) فتعديل كل شاشة مش عملي.
- [x] ~~حل مركزي في Dart (SafeArea عام)~~ **اتلغى**: كسر iPhone (مسافة تحت الـ nav bar). الحل الفعلي بقى في ملف الأندرويد [MainActivity.kt](android/app/src/main/kotlin/com/ayezAhlaq/app/ayez_ahlaq/MainActivity.kt) (padding للـ content بارتفاع شريط التنقل، ومعطّل وقت الكيبورد). اتبنى Android debug بنجاح، لسه محتاج تجربة على جهاز. القديم:  `SystemBarsSafeArea` (`SafeArea(top: false)` + لون الخلفية) ملفوف حوالين الـ Navigator في `builder` بتاع `MaterialApp` في [app.dart](lib/app.dart). الشاشات اللي فيها `SafeArea` لوحدها مش هتتضاعف، لأن الـ padding بيتستهلك من أول واحد.
- [ ] **لسه يتجرب على الجهاز**: ملخص الحجز بـ 3-button nav، وgesture nav، والـ shells الثلاثة (شكل الـ bottom nav بعد التغيير)، والـ bottom sheets (الـ barrier مش هيغطي شريط النظام السفلي)، والوضع الداكن.

---

## حالة التنفيذ (نهاية اليوم)

**اتنفذ في الكود (`flutter analyze` بدون errors):**
- الجزء 3 + 1: `shared/location/` بقى domain/data/presentation (`ILocationRepo` و`LocationRepo` و5 use cases)، و`DeviceLocationService` و`CurrentPositionResolver` اتشالوا. `apple_maps_flutter` اتضاف، و`AppMap` بيختار Apple على iOS وGoogle على Android.
- الـ sheet الجديد (`MapLocationPickerSheet`) بالشكل اللي في الصورة، بدل الشاشة والـ route القديم. البحث بـ `geocoding` مع debounce. `LocationPickerField` بقى يعرض اسم المكان بدل lat/lng.
- الجزء 2: `LocationStatusCubit` + `NearbyLocationBanner` في شاشة المحلات وشاشة الخدمة المنزلية، وصف «الموقع» في إعدادات العميل، وتحديث تلقائي عند الرجوع من إعدادات الجهاز.
- الجزء 4: الـ views المشتركة (OTP، باسورد جديد، تغيير باسورد إجباري، مسح الحساب) بتفرّغ حقولها بعد كل submit (mixin `ClearFieldsAfterSubmit`). الـ OTP بيتفرّغ كمان عند إعادة الإرسال. شاشات الدخول (3) بتمسح الباسورد عند الفشل. الـ widgets المكررة `PasswordFormFiled` و`ConfirmPasswordFormFiled` اتمسحت لأنها مكانتش مستخدمة وكان فيها listener leak.
- الجزء 5: `SystemBarsSafeArea` (اتعمل قبل كده).

**لسه محتاج جهاز:**
- [ ] تجربة الـ sheet على iPhone وAndroid (الخريطة، البحث، زر موقعي، الوضع الداكن).
- [ ] `pod install` وبناء iOS بعد إضافة `apple_maps_flutter`.
- [ ] تجربة القريب مني: الموقع مقفول / الإذن مرفوض / مرفوض نهائيًا، والرجوع من الإعدادات.
- [ ] مراجعة مفتاح Google في `AppDelegate.swift` (iOS مبقاش بيستخدم GoogleMap).
