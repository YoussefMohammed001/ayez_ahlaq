# رود ماب التاجر — تعديلات مطلوبة

مرجع دايم — حط `[x]` جنب أي بند لما يخلص، وسيب ملاحظة تحته لو فيه تفاصيل تنفيذ يستاهل حد يعرفها بعدين.

**حساب تجربة:** `01234567890` / `12345Aa@`

---

- [x] **تأكيد الباسورد في التسجيل**
  اتضاف حقل "تأكيد كلمة السر" في `merchant_register_screen.dart` بنفس `AppPasswordField` المستخدم للباسورد الأساسي (بدل `ConfirmPasswordFormFiled` القديمة اللي كانت شكلها/قواعدها مختلفة عن باقي الشاشة). بيتأكد إنه مطابق لحقل الباسورد قبل الإرسال.

- [x] **التاج الأخضر كان بيقول "تاجر" حتى في بروفايل الحلاق**
  السبب الحقيقي: شاشة بروفايل الحلاق (`barber_profile_screen.dart`) كانت بتستخدم نفس المفتاح `S().verifiedMerchant` ("حساب تاجر موثّق") بدل نص خاص بيه. اتضاف مفتاح جديد `verifiedBarber` ("حساب حلاق موثّق") في الـ arb files (ar/en) واتربط بشاشة الحلاق. شاشة التاجر فضلت زي ما هي (صح أصلًا).
  بروفايل التاجر نفسه (`merchant_profile_screen.dart`) مراجع — الأقسام في `ProfileAdminMenu` منظمة أصلاً (إدارة / حساب / إعدادات / دعم)، مفيش تكرار أو تشتت واضح.

- [x] **أيقونة البروفايل في الهوم**
  الأفاتار في `DashboardGreeting` مكنش قابل للـ tap خالص. اتضاف `onProfileTap` كـ callback من `MerchantShell._goToTab(3)` → `MerchantDashboardScreen` → `DashboardGreeting` (نفس نمط `onGoToOrders`/`onGoToProducts` الموجود بالفعل)، ولف الأفاتار بـ `GestureDetector`.

- [x] **تأكيد قبل السحب أو الإيداع (Wallet)**
  `ConfirmCancelDialog` مكانتش موجودة أصلًا في الكود — الـ API الحقيقي هو `showConfirmDialog(context, {title, message, confirmLabel, icon, isDestructive})` من `core/helpers/show_confirm_dialog.dart` (مستخدم في ٢٠+ مكان زي الاشتراكات). اتضاف قبل استدعاء `cubit.submit(...)` في `create_merchant_wallet_request_screen.dart` — العنوان والرسالة بيتغيروا حسب النوع (إيداع/سحب)، والسحب معمول `isDestructive: true`.

- [x] **بوتوم شيت اختيار الصورة (منتج/تصنيف) موحّد**
  اتأكد الأول إن `product_form_fields.dart` و`add_category_sheet.dart` الاتنين بيستخدموا نفس `ImagePickerRow` — تكرار مفيش. لكن الشكل نفسه كان iOS `CupertinoActionSheet` بـ Camera/Gallery بس (جوه `AppImagePicker.showMultiPickerSheet`)، مش الشيت الموحّد المطلوب (زي رفع المستندات: Material bottom sheet بـ Camera/Gallery/**Files**). اتصلح `core/helpers/app_image_picker.dart` يستخدم نفس `AttachmentSourceSheet` المستخدمة في `documents/` — بقى فيه خيار "من الملفات" كمان (بيفلتر امتدادات صور بس عبر `file_picker`)، وده انعكس تلقائيًا على المنتج والتصنيف من غير ما يتعمل أي تغيير في `ImagePickerRow` نفسها أو الشاشتين.

- [x] **مراجعة التوصيل المجاني والخصومات في طلبات التاجر**
  اتأكد من توثيق الـ API نفسه: `freeDeliveryOver` مش field على الطلب — هو إعداد التاجر بس (`features/merchant/delivery/` → `DeliverySettings.freeOver`)، والسيرفر بيطبّقه ويرجع `deliveryFee` النهائي جاهز في الطلب. عرض "مجاني" لما `deliveryFee == 0` صح ومكفي، ومفيش حاجة إضافية تتعمل هنا. شاشة `merchant_delivery_screen.dart` (اللي بتعدّل الإعداد ده) اتفحصت ومفيهاش باج.

- [x] **تحديث (refresh) الطلبات + تفاصيل الطلب من الـ API بالـ id**
  قائمة الطلبات كانت أصلًا فيها pull-to-refresh كامل (loading/error/empty/success). الفجوة الحقيقية كانت في شاشة التفاصيل:
  - اتضاف `GetOrderUseCase` (كان موجود بالفعل على مستوى الـ repo/api بس من غير use case) + اتسجل في `services_locator.dart`.
  - `MerchantOrdersCubit` بقى فيه `refreshOrder(id)` بيعمل `GET /merchant/order/{id}` ويحدّث الطلب في الـ state (وبيضيفه للّيستة لو مش موجود أصلًا بدل ما يتجاهله).
  - `OrderDetailsScreen` بقت `StatefulWidget` — بتعمل `refreshOrder` تلقائيًا أول ما تفتح، وفيها `RefreshIndicator` لسحب التحديث يدويًا.

- [x] **شاشة الطلب — عرض السعر والخصم كان غلط + تحسينات شاملة**
  - `order_items_card.dart`: كل صنف كان بيعرض `qty ×` وجنبه **الإجمالي** بدل سعر الوحدة — دلوقتي بيعرض `qty × سعر الوحدة` في سطر، والإجمالي (`lineTotal`) في سطر منفصل تحته.
  - إشارة الخصم كانت بتتبني كـ string واحد (`'-${currencyEgp}'`) جوه سياق RTL فبتتلخبط بصريًا — دلوقتي الإشارة والرقم في `Text` بـ `textDirection: TextDirection.ltr` صريح، زي ما متبع فعلاً في أماكن تانية بالكود (`phone_row.dart`).
  - اتضاف مؤشر "السعر اتغيّر" لكل صنف لما `priceChangedSinceOrder == true` (field كان موجود في الـ model بس مش متعروض خالص) — موثّق في الـ API إنه بيوضح "ordered at X, now Y".
  - اتضاف `OrderInfoCard` جديدة (`presentation/widgets/order_info_card.dart`) بتعرض أي حقول إضافية موجودة فعليًا في رد السيرفر ومكنتش متعروضة خالص قبل كده: `orderDate`, `note`, `deliveryAddress` (لطلبات التوصيل بس), `acceptedAt`, `deliveredAt`, `rejectedAt` + `rejectionReason`, `cancelledAt` + `cancellationNote`/`cancelledByAdminName` (الأخيرين admin-only وهيفضلوا فاضيين في رد التاجر حسب توثيق الـ API، بس الكود جاهز لو اتغيرت الصلاحية). الكارت بيختفي تلقائيًا (وعنوان القسم معاه) لو مفيش أي حقل من دول موجود.
  - `PurchaseOrder` entity/model اتوسّعوا بكل الحقول دي (كانت ناقصة خالص من قبل).

- [x] **الحالة الجاية للطلب حسب نوع التوصيل**
  اتأكد من الـ Postman collection الحقيقي: الحالات (`PREPARING`, `READY_FOR_PICKUP`, `OUT_FOR_DELIVERY`, `DELIVERED`) وterminal `nextStatuses` من السيرفر كانوا أصلًا متطبّقين صح (`order_actions.dart` بيلف على `order.nextStatuses` القادمة من الباك اند، مفيش ترتيب ثابت في الكود — نفس نمط `barber/bookings`).
  الفجوة الوحيدة: الحالة النهائية `DELIVERED` كانت بتتعرض بنفس التسمية "تم التسليم" لطلبات الاستلام من الفرع كمان. اتضاف `OrderStatus.labelFor(FulfilmentType)` بيرجّع "تم الاستلام من الفرع" (مفتاح جديد `statusPickedUpAtBranch`) لما يكون `pickupAtBranch` + `delivered`، ومتطبّق في الزرار وملاحظة الحالة النهائية والـ badge (تفاصيل + كارت الليستة).

- [x] **زرار تغيير حالة الطلب مكنش بيظهر عليه لودينج**
  `MerchantOrdersCubit._mutate` كان بيحط `updatingOrderId` في الـ state صح، بس مفيش حد بيقراه خالص — `OrderActions` كانت `StatelessWidget` عادية مبنية على الـ `order` الممرر بس من غير `BlocBuilder`. اتضاف `BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>` (بـ `buildWhen` على `updatingOrderId` بس عشان مايعملش rebuild زيادة) في `_buildDecisionButtons` و`build` الرئيسية، وبقى فيه `isLoading: state.updatingOrderId == order.id` بيتمرر لـ `PrimaryCtaButton` (اللي أصلاً بيعرض spinner ويقفل نفسه وقت التحميل). زرار "رفض" (`OutlinedButton`) بقى معطّل برضو وقت التحميل. الـ flag بيتصفّر لوحده تلقائيًا بعد أي `emit` تانية في `_mutate` (مفيش `?? this.updatingOrderId` في الـ `copyWith`).

- [x] **زرارين "تغيير الحالة" ظهروا مع بعض على أوردر استلام من الفرع (واحد "في الطريق" وواحد "جاهز للاستلام")**
  السيرفر رجّع `nextStatuses` فيها `OUT_FOR_DELIVERY` (توصيل) و`READY_FOR_PICKUP` (استلام) مع بعض على نفس الطلب رغم إن نوع الاستلام `PICKUP_AT_BRANCH` — الكود كان بيعرض أي حاجة السيرفر يرجّعها من غير تحقق. اتضاف `OrderStatus.isValidFor(FulfilmentType)` (`readyForPickup` صالحة لـ pickup بس، `outForDelivery` صالحة لـ delivery بس، الباقي صالح دايمًا) و`PurchaseOrder.validNextStatuses` بيفلتر عليها — الزرارات والـ `canAdvance` دلوقتي بيعتمدوا على النسخة المفلترة، فحتى لو السيرفر رجّع حالة متضاربة مع نوع الطلب متتعرضش للتاجر.

- [x] **تأكيد قبل تغيير الباقة + تحديث شاشة الباقات صح**
  التأكيد كان موجود بالفعل (`showConfirmDialog` قبل `_subscribe`). المشكلة الحقيقية كانت في `MerchantSubscriptionCubit.subscribe()`: بعد نجاح الاشتراك كان بيحدّث `state.subscription` بس من غير ما يعيد تحميل `state.plans` — دلوقتي بيعمل `load()` كامل (subscription + plans) بعد أي اشتراك ناجح عشان الشاشة تبقى محدّثة بالكامل.

---

## بجات إضافية اتبلّغ عنها أثناء الشغل

- [x] **Crash عند فتح منتج من الهوم**
  `type 'MerchantProductModel' is not a subtype of type 'int'` — `dashboard_product_list.dart` و`dashboard_top_products.dart` كانوا بيبعتوا الـ `product` كامل كـ `extra` لـ `Routes.merchantProductDetailsScreen`، لكن الراوت (`app_routes.dart`) بيعمل `state.extra as int` (متوقع الـ id بس، زي `merchant_products_screen.dart` الأصلي). اتصلح الاتنين يبعتوا `product.id`.

- [x] **"handle all cases in orders and order details" — كل الحقول اللي بترجع من السيرفر ومكنتش متعروضة**
  الحقول اللي ظهرت في الـ log (`note`, `deliveryAddress`, `deliveryLat/Lng`, `acceptedAt`, `rejectedAt`, `deliveredAt`, `cancelledAt`, `cancellationNote`, `cancelledByAdminName`, `orderDate`) كانت مش موجودة خالص في الـ `PurchaseOrder` entity/model. اتضافوا كلهم + `OrderInfoCard` لعرضهم شرطيًا (تفاصيل في البند اللي فوق "شاشة الطلب — عرض السعر والخصم").

- [x] **`unitDiscount` على مستوى الصنف كان متجاهل خالص**
  رد حقيقي من السيرفر وضّح الباج: `unitPrice: 1500`, `unitDiscount: 1350`, `lineTotal: 750` لـ ٥ قطع — يعني السعر الفعلي للوحدة هو `unitPrice - unitDiscount = 150`، مش `unitPrice` الخام. الصف كان بيعرض `٥ × ١٥٠٠` (رقم غلط تمامًا) فوق إجمالي `٧٥٠` (متناقضين بصريًا). اتضاف `OrderItem.effectiveUnitPrice` getter + `hasUnitDiscount`، والصف دلوقتي بيعرض السعر الأصلي بخط عليه (line-through) جنب السعر الفعلي `qty × effectiveUnitPrice` اللي بيطابق `lineTotal` فعليًا. اتضاف كمان `discountId`/`currentUnitPrice`/`currentUnitDiscount` للـ `OrderItem` entity/model اللي كانوا ناقصين.

- [x] **إظهار/إخفاء كلمة السر في شاشة تغيير الباسورد**
  `change_password_screen.dart` كانت بتستخدم `AppTextField` بـ `obscure: true` ثابت — مفيش زرار عين خالص. اتبدلت بـ `AppPasswordField` (نفس الويدجت المستخدم في التسجيل، فيه toggle جاهز). نفس الباج كان في `barber_change_password_screen.dart` واتصلح كمان بطلب من اليوزر. شاشة "تغيير الباسورد الإجباري" المشتركة (`ForceChangePasswordView`) كانت أصلًا بتستخدم `AppPasswordField` صح من غير ما تتلمس.

- [x] **نوع الاستلام (توصيل / استلام من المحل) كان صغير وغير واضح في تفاصيل الطلب**
  كان نص صغير (11sp) لونه خافت مدفون بين اسم الحلاق والهيدر. اتشال من الهيدر واتحط كأول صف واضح وثابت في `OrderInfoCard` (عنوان "طريقة الاستلام" + أيقونة مميزة لكل نوع) — بيظهر دايمًا مش شرطي زي باقي الصفوف.

- [x] **"السعر اتغيّر" كانت رسالة مضلِّلة + مفيش نسبة خصم متعروضة خالص**
  رد حقيقي من طلب قديم وضّح المشكلة: `unitDiscount: 0` وقت الطلب (يعني اتدفع السعر كامل) بس دلوقتي فيه خصم جديد على نفس المنتج (`currentUnitDiscount: 1350`) — رسالة "السعر اتغيّر" كانت غلط لأنها موحية إن السعر الأساسي نفسه اتغيّر، مع إن السعر الأساسي (`currentUnitPrice`) فعليًا زي ما هو، اللي اتغيّر إنه بقى عليه خصم لسه ماكانش موجود وقت الطلب.
  - اتضاف تمييز في `OrderItem`: `basePriceChangedSinceOrder` (السعر الأساسي فعلًا اتغيّر) لوحده عن `newDiscountAppliedSinceOrder` (خصم جديد اتضاف من بعد الطلب) — كل حالة ليها رسالتها الصح دلوقتي.
  - اتضاف نسبة الخصم فعليًا في كل مكان: `unitDiscountPercent` (لصنف اتخصم عليه وقت الطلب — badge "خصم X%" جنب السعر المشطوب)، `currentUnitDiscountPercent` (للخصم الجديد اللي اتضاف بعدين)، و`orderDiscountPercent` على مستوى الطلب كله (`orderDiscountWithPercentLabel` بدل "خصم الطلب" بس من غير رقم).

---

## مراجعة شاملة تانية (بعد الروادماب القديم)

- [x] **مفيش شاشة تعرض سجل الـ Broadcast (حالة الموافقة)**
  `GET /api/merchant/broadcast` ("My broadcasts with status") كان موجود في الـ Postman ومش متنادى عليه خالص — التاجر كان بيبعت إشعار (يدخل قائمة موافقة الأدمن كـ `PENDING`) ومفيش أي طريقة يشوف بيها اتوافق عليه ولا اترفض ولا لسه معلّق. الحلاق عنده نفس الميزة بالظبط (`GetBroadcastsUseCase` + `BroadcastListScreen`) فاتعمل نفس الشيء للتاجر حرفيًا:
  - `Broadcast`/`BroadcastPage`/`BroadcastScope`/`BroadcastStatus` entities جديدة في `merchant/broadcast/domain/entities/`.
  - `MerchantBroadcastApi.list()` + `MerchantBroadcastRepo.list()` + `IMerchantBroadcastRepo.list()` + `GetMerchantBroadcastsUseCase`.
  - `MerchantBroadcastListCubit`/`State` (pagination بنفس نمط الحلاق: `loadBroadcasts()` + `loadMore()` على scroll).
  - `MerchantBroadcastListScreen` + `MerchantBroadcastRow` + `MerchantBroadcastStatusChip` (نفس الـ widgets البصرية للحلاق، بس مسمّاة بادئة `Merchant` عشان معندناش تكرار اسم كلاس بين الفيتشرين).
  - راوت جديد `/merchant/broadcast/list` مسجّل في `app_routes.dart` + DI في `services_locator.dart`.
  - `profile_admin_menu.dart`: زرار "إرسال إشعار" بقى بيفتح شاشة الليستة (بدل شاشة الإنشاء مباشرة) — زي الحلاق بالظبط — والليستة هي اللي فيها زرار "+" يفتح شاشة الإنشاء.

- [x] **Validator رقم الموبايل متعلّق كومنت في شاشة اللوجين**
  `merchant_login_screen.dart` فيه كومنت 3 سطور لـ validator متعلّق (مخالف لقاعدة "no comments"). اتأكد إن باقي شاشات اللوجين في المشروع (حلاق/عميل) كمان حقل الموبايل عندهم من غير validator أصلًا — يعني مفيش سلوك تاني لازم يترجع، الكومنت الميت بس اتشال.

- [x] **الـ mock (`MerchantOrdersMock`) كان لسه متوصّل في `merchant_orders_repo.dart`**
  6 فروع `if (MerchantOrdersMock.enabled)` في الـ repo كانت كود ميت (الـ flag `false` دايمًا). اتشالوا كلهم + الملف `data/local/merchant_orders_mock.dart` نفسه اتمسح.

---

## ملاحظات تقنية
- التأكيد قبل أي "تنفيذ" (سحب/إيداع/تغيير باقة... إلخ) بيتعمل بـ `showConfirmDialog(context, {title, message, confirmLabel, icon, isDestructive})` من `core/helpers/show_confirm_dialog.dart` — مفيش `ConfirmCancelDialog` في الكود، ده اسم مكنش موجود أصلًا.
- قبل ما تعمل بوتوم شيت اختيار صورة جديد، دوّر كويس على اللي اتعمل قبل كده (`AppImagePicker`/`ImagePickerRow`) — الهدف ماكنش يتكرر.
- أي endpoint هتحتاجه اتأكد منه في `postman/*.json` قبل ما تخمّن الشكل — فيه description كامل لكل endpoint فيه تفاصيل زي الحقول الـ admin-only.
- كل navigation بـ `context.push(Routes.xxx, extra: ...)` لازم يتأكد النوع اللي متوقع في `app_routes.dart` مطابق فعلًا (زي باج المنتج اللي فوق) — الكاست بيحصل جوه الراوت نفسه ومفيش compile-time check عليه.

---

## مراجعة شاملة تالتة (كراش الـ API + Equatable + pagination + كاش الصور)

اتعملت مراجعة كاملة لكل `lib/features/merchant/` (كل فولدر: auth, dashboard, products, categories, discounts, orders, wallet, subscription, sponsorship, documents, notifications, broadcast, delivery) — نتيجتها ملخصة هنا. **مهم:** المراجعة استخدمت أدوات آلية (agents) رجّعت كذا "باج" اتفحص وطلع غلط (false positive) — الأمثلة موثّقة تحت في قسم منفصل عشان محدش يعيد اكتشافها تاني.

- [x] **كراش محتمل في 10 ملفات لو الـ API رجّع response من غير `data`**
  كل الـ repos دي كانت بتعمل `response['data'] as Map<String, dynamic>` مباشرة من غير أي null check — لو السيرفر رجّع 200 من غير `data` (نادر بس وارد)، كان هيرمي `TypeError` جوه الـ `Either` بدل ما يرجّع `Left(Failure)`. اتعمل helper مشترك `core/network/response_guard.dart` (`requireDataMap(response)` بيرجّع `Either<Failure, Map<String, dynamic>>`) واتستخدم بدل الكاست المباشر في:
  `auth/data/repos/merchant_auth_repo.dart`, `discounts/data/repos/merchant_discounts_repo.dart`, `subscription/data/repos/merchant_subscription_repo.dart` (٢ موضع), `profile/data/repos/merchant_profile_repo.dart` (٣ مواضع), `wallet/data/repos/merchant_wallet_repo.dart`, `wallet/data/repos/merchant_wallet_requests_repo.dart` (٢ موضع), `broadcast/data/repos/merchant_broadcast_repo.dart`, `notifications/data/repos/merchant_notifications_repo.dart` (٢ موضع، شامل `getUnseenCount`), `customers/data/repos/merchant_customers_repo.dart`, `categories/data/repos/merchant_categories_repo.dart`.
  النمط: `result.map(_mapOne)` بقى `result.flatMap(_mapOne)` و`_mapOne` بقى بيرجّع `Either<Failure, T>` بدل `T` خام.

- [x] **حالة الاشتراك `PAUSED` كانت بتتعرض "نشط" (أخضر) — باج حقيقي اتأكد منه لايف**
  اختبار حي على production (تاجر حقيقي بحساب `status: "PAUSED"`) أثبت الباج فعليًا: `current_subscription_card.dart` و`subscription_home_card.dart` كانوا بيحسبوا `isPending = status == 'PENDING'` بس، فأي حالة تانية غير `PENDING` (شاملة `PAUSED`) كانت بتترسم بلون النجاح ولابل "نشط". اتضاف `SubscriptionStatus` enum حقيقي (`domain/entities/subscription_status.dart`: `active/pending/paused/unknown`, `fromApi` بـ fallback لـ `unknown` مش `active`) + extension `SubscriptionStatusLabel` (`presentation/widgets/subscription_status_label.dart`) بترجّع اللابل واللون الصح لكل حالة. مفاتيح جداد `planStatusPaused`/`planStatusUnknown` في الـ arb files.

- [x] **نتيجة الاشتراك (`activate` أو `pending`) كانت بتتحدد بمقارنة نص بدل القيمة الصريحة من السيرفر**
  `MerchantSubscriptionCubit.subscribe()` كان بيرمي نتيجة `SubscribeMerchantUseCase` (اللي فيها `activated: bool` صريح من السيرفر) وبعدين الشاشة كانت بتعيد استنتاج النتيجة بـ `subscription?.status != 'PENDING'` — نفس فئة باج الـ string comparison فوق. `subscribe()` بقى بيرجّع `Future<bool?>` (`null` = فشل، وإلا القيمة الحقيقية لـ `activated`)، والشاشة بقت بتستخدمها مباشرة.

- [x] **مقارنات Equatable ناقصة حقول → الشاشة مش بتتحدّث بعد تعديل ناجح**
  5 entities كان `props` فيهم ناقص حقول فعلية بتتغيّر: `Discount` (ناقص `rewardValue/targetProductId/buyQuantity/rewardQuantity/minOrderTotal/shops` — لو التاجر عدّل الفروع المستهدفة بس الملخص مايتغيرش)، `MerchantProfile` (ناقص `email/phoneE164/userName/mustChangePassword/categoryLimit/zoneId/zoneName/createdAt/address` — تعديل الإيميل لوحده كان ممكن ميظهرش)، `MerchantNotification` (ناقص `referenceType/referenceId`)، `OrderItem` (ناقص كل حقول السعر/الخصم الفعلية)، `PurchaseOrder` (كان `[id, code, status, total, nextStatuses]` بس — ناقص `items/grandTotal/deliveryFee/rejectionReason/cancellationNote/acceptedAt/rejectedAt/deliveredAt/cancelledAt`). الخمسة اتصلحوا يقارنوا كل الحقول ذات الصلة.

- [x] **Pagination: فشل تحميل صفحة إضافية كان بيترجع "تمام" بهدوء من غير أي تنبيه**
  نمط متكرر في **9 شاشات** (مش بس التاجر): `loadMore()` عند الفشل كان بيعمل `emit(status: success)` بدل `failure`، والـ `errorMessage` كان بيتخزن بس مفيش أي widget بيقراه. النتيجة: سكرول فاشل بيوقف من غير تفسير، واليوزر مش عارف ليه. اتضاف `BlocConsumer` (بدل `BlocBuilder`) بـ `listenWhen` بيتأكد إن `status == success && errorMessage != null` (يعني تحديدًا فشل الـ "load more" مش الفشل الأساسي اللي أصلاً بيوري شاشة خطأ كاملة)، وبيعرض `showError(...)` toast. الشاشات التسعة: `merchant_customers_screen.dart`, `merchant_broadcast_list_screen.dart`, `broadcast_list_screen.dart` (حلاق), `barber_notifications_screen.dart`, `customer_notifications_screen.dart`, `merchant_notifications_screen.dart`, `barber_wallet_requests_screen.dart`, `customer_wallet_requests_screen.dart`, `merchant_wallet_requests_screen.dart`.

- [x] **حذف منتجين في نفس الوقت — لو فشل حذف الأول كان بيرجّع التاني اللي اتحذف بنجاح**
  `MerchantProductsCubit.removeProduct(id)` كان بياخد snapshot كامل من `state.products` قبل الـ await، ولو فشل الحذف كان بيرجّع الليستة **كلها** لنفس الـ snapshot القديم — لو حصل حذف تاني ناجح في نفس الوقت، بيترجع برضو وكأنه ماتحذفش. اتصلح ياخد نسخة من المنتج المحذوف بس (مش الليستة كلها)، ولو فشل بيرجّعه هو بس فوق الليستة الحالية (مش القديمة).

- [x] **كاش صورة منتج قديمة بعد تعديل الصور**
  `product_form_screen.dart` بعد نجاح التعديل كان بيعمل `evict` لـ `merchantProductImage(id)` بس — ده الـ endpoint القديم اللي `ProductThumbnail` مابيستخدموش خالص لو المنتج عنده صور (بيستخدم `merchantProductImageById(id, imageIds.first)` دايمًا في الحالة دي). فعليًا الكاش القديم مكانش بيتنضف أبدًا. اتصلح يعمل `evict` لكل الصور الحالية بـ `merchantProductImageById` بالإضافة للـ endpoint القديم.

### False positives من المراجعة الآلية (متتصلحش تاني لو ظهرت)
- **"`updatingOrderId` مش بيتصفر بعد قبول/رفض أوردر"** — غلط. `MerchantOrdersState.copyWith`'s `errorMessage`/`updatingOrderId` مفيهمش `?? this.x` زي باقي الحقول — أي `copyWith` تاني بيصفرهم تلقائيًا. اتفحص الكود بالتفصيل واتأكد إن السلوك صح فعلًا (موثّق أصلًا فوق كبند مصلّح من مراجعة سابقة).
- **"تسجيل تاجر جديد بيوصله توكن مباشر، والتطبيق غلط بيوريه شاشة OTP"** — غلط. اختبار حي فعلي (رقم جديد كليًا على production) أثبت إن التسجيل فعلًا بيتطلب OTP، وبعد التأكيد الـ API بترجع `{verified:true}` بس (من غير token) ورسالتها الصريحة "سجّل الدخول الآن" — والشاشة فعلًا بتوجّهه لـ `Routes.loginScreen` مش الـ shell، وده صح 100%. الوثيقة في الـ Postman collection غلط/قديمة هنا.
- **"خصم BUY_X_GET_Y محتاج منتج هدية منفصل (`rewardProductId`)"** — غلط. اختبار حي أثبت إن شكل الخصم في النظام ده هو "اشتري X من نفس المنتج واحصل على Y مجانًا من نفس المنتج" — مفيش UI أصلًا لاختيار منتج هدية مختلف، فمفيش حاجة ناقصة.
- **"دخل الشهر (`monthRevenue`) بيتقطع لـ `int` فيفقد كسور"** — نظري بس. كل حقول الفلوس في التطبيق (اتأكد لايف) صحيحة (بدون كسور/قروش) — مفيش سيناريو حقيقي بيحصل فيه فقدان.
