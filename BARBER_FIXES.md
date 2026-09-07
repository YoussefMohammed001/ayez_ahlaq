# تعديلات وتحسينات الحلاق — أول جولة

مش رود ماب مستقبلي، ده تجميع لملاحظات/باجات/تحسينات لازم تتعمل أو نتأكد منها. حط `[x]` لما يخلص. المرجع الكامل لمطالب الباك إند في `BACKEND_NEEDS.md` — البنود هنا اللي معتمدة على حاجة من هناك متعلّمة بـ ⛔.

الحلاق عنده اتجاهين للمنتجات لازم الاتنين يتظبطوا:
- `features/barber/store/` — الحلاق **بيشتري** من تاجر
- `features/barber/storefront/` — الحلاق **بيبيع** للعميل

---

## ٠. باج حرج: منتجات الحلاق (Storefront) كانت بتظهر "خلصت من المخزن" دايمًا — ✅ اتصلح

`StorefrontProductModel.fromJson` كان بيقرا `json['stock']` و`json['hasImage']`، لكن رد السيرفر الحقيقي (`GET /barber/storefront/product`) بيرجع نفس شكل `merchant/product` بالظبط: `totalStock`, `hasOwnImage`, `imageSource`, `imageIds`, `effectivePrice`, `activeDiscount` — مش `stock`/`hasImage`. النتيجة: `stock` كانت دايمًا صفر (fallback) بغض النظر عن المخزون الحقيقي، يعني:
- كل منتجات الحلاق كانت شكلها "خلصت من المخزون" في الليستة والتفاصيل، حتى لو فيها كمية فعلية.
- **فورم التعديل كان بيملأ حقل الكمية بـ "0"** (`product?.stock.toString()`) بدل الكمية الحقيقية — لو الحلاق فتح يعدّل منتج وحفظ من غير ما ينتبه، كان هيصفّر مخزونه فعليًا. باج خطير على البيانات.
- عند العميل (بيشوف متجر الحلاق: `customer/shop/{shopId}/storefront`) نفس الباج بالظبط في `StoreProductModel` — العميل كان شايف كل منتجات الحلاق "خلصت من المخزون" ومش قادر يطلب حاجة خالص.

**الحل:** `StorefrontProduct`/`StorefrontProductModel` (جانب الحلاق) اتصلحوا بالكامل ليطابقوا شكل `MerchantProduct` (`effectivePrice`, `activeDiscount`, `imageSource`, `imageIds` اتضافوا، `hasImage` اتشالت لأنها مش مستخدمة أصلاً هنا). تفاصيل المنتج (`storefront_product_detail_info.dart`) بقى فيها نفس عرض السعر الأصلي/بعد الخصم اللي في التاجر. جانب العميل (`StoreProductModel`) اتصلح بـ fallback آمن (`totalStock` ولو مش موجودة يرجع لـ `stock` القديمة) عشان الشاشة دي بتعرض `hasImage` فعليًا وبتجيب صورة حقيقية (`customerShopStorefrontProductImage`)، فمكانتش زيها زي جانب الحلاق تمامًا.

## ١. تطبيق إصلاحات طلبات التاجر على `barber/store` (الحلاق بيشتري) — ✅ خلص جزء كبير

- [x] **`GetStoreOrderUseCase` كانت موجودة بس مش متستخدمة** — اتضافت للـ `BarberStoreOrdersCubit` (DI + constructor) + method `refreshOrder(id)` بنفس نمط التاجر (`_replace` بيحدّث لو موجود أو يضيف لو مش موجود).
- [x] **تفاصيل الطلب مكنتش بتعمل refetch بالـ id** — `BarberStoreOrderDetailsScreen` بقت `StatefulWidget`، بتعمل `refreshOrder` في `initState` + `RefreshIndicator` على الشاشة كلها.
- [x] **مفيش وحدة سعر ولا خصم لكل صنف** — اتأكد إن `unitDiscount`/`gift` فعليًا بيرجعوا من `GET barber/order` (رد حقيقي شفناه) بس مكانوش موجودين في `StoreOrderItem`/الـ model — اتضافوا + `hasUnitDiscount`/`effectiveUnitPrice` getters. `store_order_items_card.dart` بقى بيعرض `qty × unitPrice` (مش `lineTotal`)، مع السعر الأصلي بخط عليه لو فيه خصم، ونفس إصلاح إشارة الخصم في RTL (`textDirection: TextDirection.ltr`).
- [x] **خصم الطلب بيتعرض بدون نسبة** — `orderDiscountPercent` اتضاف كـ getter على `StoreOrder` (نفس حساب التاجر: `orderDiscount / (total + orderDiscount) * 100`).
- [x] **حقول ناقصة** — `acceptedAt`/`rejectedAt`/`deliveredAt`/`deliveryAddress`/`deliveryLat`/`deliveryLng` اتضافوا للـ entity/model (موجودين فعليًا في رد حقيقي شفناه، بس `null`). `StoreOrderInfoCard` widget جديد بيعرضهم شرطيًا + نوع الاستلام كصف واضح ثابت (نفس تصميم التاجر).
- [ ] **الحالة النهائية مش واعية بنوع الاستلام** — لسه معلّق، لأن `StoreOrder` مفيهاش `nextStatuses` أصلاً (الحلاق هنا مشتري بس، بيلغي الطلب مش بيقدّم حالته) فمفهوم "الحالة النهائية" مختلف. `StoreOrderStatusBadge`/`StoreOrderStatusLabel` لسه محتاجين مراجعة لو فيه حالة "تم الاستلام" مقابل "تم التسليم".
- [x] **مفيش loading واضح على تحديث الكمية في المنتجات** — اتضاف `disabled` param لـ `QuantityStepper` المشتركة (`lib/shared/`، افتراضي `false` عشان الاستخدامات التانية متتأثرش)، بتعرض spinner صغير بدل زراير +/- وقت التحميل. `StoreProductRow` بقت بتاخد `isUpdating` وتمررها، وشاشة المنتجات بتبعتها من `state.isUpdatingCart` (نفس الـ boolean العام الموجود، بيغطي كل السلة مش صنف بمفرده — كل الصفوف بتوقف وقت أي تحديث، وده مقبول لأنه بيمنع تعارض الطلبات).
- [x] **زرار "تأكيد الطلب" شغال صح** — `submitOrder()`/`isSubmitting` متوصلين بالـ `PrimaryCtaButton` بالفعل. مفيش حاجة هنا.

## ٢. تطبيق نفس الإصلاحات على `barber/storefront` (الحلاق بيبيع للعميل) — ✅ خلص

- [x] **مفيش use case لجلب طلب واحد بالـ id** — اتضاف `GetStorefrontOrderUseCase` (كان الـ repo/API بيعملوها بالفعل) + DI + `refreshOrder(id)` في الـ cubit.
- [x] **تفاصيل الطلب مكنتش بتعمل refetch ولا refresh** — الشاشة بقت `StatefulWidget`، `refreshOrder` في `initState` + `RefreshIndicator`.
- [x] **`nextStatuses` من غير فلترة نوع الاستلام** — اتضاف `StorefrontOrderStatus.isValidFor(StorefrontFulfillmentType)` + `StorefrontOrder.validNextStatuses` بنفس منطق التاجر بالظبط، و`StorefrontOrderActions` بقت بتلف على النسخة المفلترة مش الخام.
- [x] **زرارات تغيير الحالة من غير loading** — `StorefrontOrderActions` بقت `BlocBuilder` بتقرا `state.updatingOrderId` وتمرره كـ `isLoading` للأزرار (قبول/رفض/تقدّم الحالة) بنفس نمط التاجر.
- [x] **الحالة النهائية مش واعية بنوع الاستلام** — اتضاف `StorefrontOrderStatusLabel.labelFor(fulfillmentType)` بيرجّع "تم الاستلام من الفرع" للـ pickup، مطبّق في الزرار/الملاحظة النهائية/الـ badge (تفاصيل + كارت الليستة).
- [x] **نوع الاستلام كان مدفون في نص صغير** — `StorefrontOrderInfoCard` widget جديد بيعرضه كصف واضح وثابت (زي التاجر). ملاحظة: `note`/عنوان التوصيل/تايم لاين الحالات معملتش لأن `barber/storefront/order` مش موثّق إنه بيرجعهم (على عكس `barber/order` اللي شفنا فيه ردود حقيقية بيها) — مش هخترع حقول مش متأكد منها.
- [x] **وحدة السعر لكل صنف** — `qty ×` كانت بتعرض `lineTotal` بدل `unitPrice`، اتصلحت بنفس نمط التاجر. مفيش خصم على مستوى الصنف هنا أصلًا (`StorefrontOrderItem` مفيهاش الحقل، ومتوقع طالما `StorefrontProduct` نفسها مفيهاش خصم — بند ١٠ في `BACKEND_NEEDS.md`).

## ٣. عرض الخصم على المنتجات (كل الاتجاهات)

- [ ] **منتجات التاجر (الحلاق بيشتري)** — `StoreProductRow` بتعرض السعر الأصلي بخط عليه + السعر بعد الخصم (موجود بالفعل، تمام)، **بس من غير نسبة الخصم ولا اسمه** لأن ⛔ `StoreProduct`/الـ API مفيهومش `activeDiscount` أصلاً (بند ٢ في `BACKEND_NEEDS.md`). لما الحقل يتضاف من الباك، نعرضه بنفس الشكل اللي في تفاصيل منتج التاجر (`ActiveDiscountLabel`).
- [ ] **سلة الحلاق (`CartLineRow`)** — بتعرض `unitPrice` واحد بس من غير ما توضح إن فيه خصم مطبّق. ⛔ (`CartLine` مفيهاش `unitDiscount`/original price منفصلين — بند ٢ في `BACKEND_NEEDS.md`).
- [ ] **منتجات الحلاق نفسه (Storefront)** — مفيش مفهوم خصم خالص لا في الـ entity ولا الـ API. ⛔ لو المفروض الحلاق يقدر يعمل عروض على منتجاته، محتاجين الـ API الأول (بند ٢).

## ٤. صور المنتجات (كل الاتجاهات) ⛔

- [ ] منتجات التاجر وقت شراء الحلاق منها — `hasImage: bool` من غير endpoint فعلي، placeholder بس.
- [ ] منتجات/تصنيفات الحلاق نفسه (Storefront) — نفس الفجوة.
كل التفاصيل في `BACKEND_NEEDS.md` بند ١. لما الـ endpoints تتأكد، الربط في الفرونت بسيط (زي `AuthorizedNetworkImage` المستخدمة في أماكن تانية).

## ٥. مميزات جديدة مطلوبة

- [ ] **API منفصل لفلو المشروبات (Drinks)** — بعيد عن المنتجات والتصنيفات الحالية. ⛔ لازم قرار من الباك الأول (شكل الـ API — تصنيف عادي ولا كيان منفصل) قبل ما نبدأ أي كود، عشان القرار ده بيغيّر شكل الـ feature بالكامل. راجع بند ٩ في `BACKEND_NEEDS.md`.
- [ ] **تفاصيل توصيل وقت إنشاء منتج** — دلوقتي التوصيل إعداد عام بس (`storefront/delivery`)، مفيش حقول توصيل لكل منتج لوحده وقت الإنشاء. ⛔ محتاجين تأكيد من الباك الأول (بند ٨) هل المطلوب فعلاً حقول إضافية على مستوى المنتج.

---

## ملاحظات تقنية
- كل مكان فيه "مفيش use case لجلب بالـ id رغم الـ repo بيعملها" هو نمط متكرر — الأفضل نصلحهم مع بعض بنفس الطريقة اللي اتعملت في `merchant/orders/domain/use_cases/get_order_use_case.dart` عشان الاتساق.
- فلترة `nextStatuses` (`isValidFor(FulfilmentType)`) لازم تتحط كـ extension قابلة لإعادة الاستخدام لو الحالات (`OrderStatus` variants) متشابهة بين التاجر والحلاق — لو مش متطابقة تمامًا يفضل كل واحدة لوحدها.
- **الأولوية:** إصلاحات ١ و٢ (تفاصيل الطلب/refresh/loading) client-side بالكامل ومينفعش نستناها — تتعمل فورًا. إصلاحات ٣ و٤ و٥ متوقفة على تأكيد الباك إند (`BACKEND_NEEDS.md`) قبل أي كتابة كود.
