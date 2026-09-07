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

## ملاحظات تقنية
- التأكيد قبل أي "تنفيذ" (سحب/إيداع/تغيير باقة... إلخ) بيتعمل بـ `showConfirmDialog(context, {title, message, confirmLabel, icon, isDestructive})` من `core/helpers/show_confirm_dialog.dart` — مفيش `ConfirmCancelDialog` في الكود، ده اسم مكنش موجود أصلًا.
- قبل ما تعمل بوتوم شيت اختيار صورة جديد، دوّر كويس على اللي اتعمل قبل كده (`AppImagePicker`/`ImagePickerRow`) — الهدف ماكنش يتكرر.
- أي endpoint هتحتاجه اتأكد منه في `postman/*.json` قبل ما تخمّن الشكل — فيه description كامل لكل endpoint فيه تفاصيل زي الحقول الـ admin-only.
- كل navigation بـ `context.push(Routes.xxx, extra: ...)` لازم يتأكد النوع اللي متوقع في `app_routes.dart` مطابق فعلًا (زي باج المنتج اللي فوق) — الكاست بيحصل جوه الراوت نفسه ومفيش compile-time check عليه.
