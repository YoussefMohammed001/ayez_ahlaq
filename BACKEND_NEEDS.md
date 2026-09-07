# مطلوب من الباك إند

مرجع دايم — لسه بنراجع كل الفلوز، هيتزاد عليه لما نكتشف حاجات جديدة. حط `[x]` لما يتأكد إنه اتحل من عند الباك.

اتأكد بالكود الفعلي (مش تخمين) إن كل البنود دي فجوات حقيقية — تفاصيل الملفات والـ endpoints في التعليق تحت كل بند.

---

## ١. صور المنتجات — ٣ فجوات منفصلة، ولا واحدة فيهم موجودة

الصور شغالة فعليًا في مكانين بس: العميل وهو بيشوف متجر الحلاق (`customer/shop/{shopId}/storefront/product/{productId}/image`)، والتاجر ومنتجاته هو (`merchant/product/{id}/image`). الثلاث فجوات دول لسه من غيرهم:

- [ ] **صورة منتج التاجر من ناحية الحلاق وهو بيشتري** — `GET /api/barber/store/merchant/{merchantId}/product/{productId}/image` مش موجود لا في الكود ولا في التوثيق. `StoreProduct` عندها `hasImage: bool` بس بيرجع من غيره فايدة — الصف بيعرض أيقونة placeholder ثابتة.
- [ ] **صورة منتج/تصنيف الحلاق نفسه (Storefront، البيع للعميل)** — نفس الفجوة، `barber/storefront/product` و`barber/storefront/category` عندهم `hasImage: bool` بس مفيش endpoint فعلي للصورة (`barberStorefrontProduct`/`barberStorefrontCategory` في `endpoints.dart` معندهمش نسخة `.../image`). الرفع (upload) شغال، العرض لأ.
- [ ] **الشكل المتوقع** يبقى زي الموجود بالفعل: `GET .../product/{id}/image` و`GET .../category/{id}/image` — نفس pattern الـ merchant/customer.

## ٢. الخصم بيتلغّم جوه السعر من غير ما يتوضح — في ٣ أماكن

`GET /merchant/product` بيرجع شكل كامل وموثّق: `price` (الأصلي) + `effectivePrice` (بعد الخصم) + `activeDiscount: {discountId, name, rewardType, rewardValue}`. **نفس الشكل ده مش موجود في جانب الحلاق خالص:**

- [ ] `GET /barber/store/merchant/{mid}/product` (ليستة منتجات التاجر اللي الحلاق بيشتري منها) — التوثيق نفسه بيرجع `{ id, name, brand, categoryName, price, effectivePrice, minOrderQty, hasImage }` بس، **مفيش `activeDiscount` خالص**. الحلاق شايف "قبل/بعد" (strikethrough) بس مش شايف نسبة الخصم ولا اسمه.
- [ ] `GET/PUT /barber/cart` — `CartLine` فيها `unitPrice` بس (مفيش `unitDiscount` ولا original price منفصل) — الخصم متلغّم جوه `unitPrice` نفسه من غير أي إشارة إنه موجود أصلاً.
- [ ] `StorefrontProduct` (منتجات الحلاق نفسه اللي بيبيعها للعميل) **مفيش فيها مفهوم خصم خالص** — لا `effectivePrice` ولا `activeDiscount`. لو المفروض الحلاق يقدر يعمل خصومات على منتجاته زي التاجر، الـ API لسه مش موجودة.

**مطلوب:** نفس شكل `activeDiscount`/`effectivePrice` بتاع `merchant/product` يتطبّق على الثلاثة دول.

## ٣. خصم مستوى الطلب (`orderDiscount`) مش موجود في رد السلة قبل الـ checkout

`GET/PUT /barber/cart` بترجع `subtotal`/`deliveryFee` لكن **مفيش `orderDiscount` خالص** — رغم إن نفس الخصم بيظهر لاحقًا في `GET /barber/order/{id}` بعد إتمام الطلب (`orderDiscount: 2625` مثلاً في رد حقيقي). **مطلوب:** رد السلة يرجّع `orderDiscount` قبل الـ checkout، عشان الحلاق يشوفه قبل ما يأكد مش بعده بس.

## ٤. توثيق/تطبيق متضاربين — `POST /barber/store/quote`

الـ Postman بيوثّق فلو: `GET merchants` → `GET products` → **`POST /api/barber/store/quote`** (بيقول "with discounts") → `POST /api/barber/order`. لكن **الكود الفعلي مبنى على سلة دايمة (`GET/PUT barber/cart` + `POST barber/cart/checkout`) ومفيش أي استدعاء لـ `barber/store/quote` في المشروع خالص.** لازم يتحدد:
- [ ] التوثيق قديم وباين (السلة هي الصح)، ولو كده يتشال من الـ Postman، أو
- [ ] فيه فلو "quote" منفصل فعلاً مطلوب يتضاف، ولو كده نعرف شكله بالظبط

## ٥. `nextStatuses` ممكن يرجع حالة متضاربة مع نوع الاستلام

اتأكد من رد حقيقي (`GET /merchant/order/{id}`) إن `nextStatuses` رجعت فيها `OUT_FOR_DELIVERY` و`READY_FOR_PICKUP` مع بعض على نفس الطلب رغم إن `fulfillmentType` كانت `PICKUP_AT_BRANCH` بس. اتعمل فلترة client-side مؤقتة على جانب التاجر (`OrderStatus.isValidFor(FulfilmentType)`) لحد ما يتصلح من عند السيرفر. **مطلوب:** `nextStatuses` ترجع بس الحالات المنطقية فعليًا حسب `fulfillmentType` الطلب — وده بيتكرر في **كل** أماكن الطلبات (`merchant/order`, `barber/order`, `barber/storefront/order`).

## ٦. `StoreOrder` (طلبات الحلاق وهو بيشتري) ناقصها حقول موجودة في باقي الطلبات

بالمقارنة بـ `merchant/order` اللي بقى موثّق ومكتمل بالكامل (نتيجة المراجعة دي)، رد `barber/order` ناقصه:
- [ ] `nextStatuses` — مش موجودة خالص في `StoreOrder`/رد الـ API، يعني حتى لو فيه حالات تانية بعد `PENDING`/`DELIVERED` مفيش طريقة نعرضها.
- [ ] `acceptedAt` / `deliveredAt` / `rejectedAt` / `cancelledAt` — مفيش تايم لاين للطلب خالص، بس `orderDate`/`createdAt`.
- [ ] `cancellationNote` / `cancelledByAdminName` — لو فيه سيناريو إلغاء من الإدمن زي جانب التاجر.
- [ ] `deliveryAddress` / `deliveryLat` / `deliveryLng` — موجودة فعليًا في رد حقيقي شفناه (`null` كلهم) لكن مش موثّقة في الـ Postman.
- [ ] كل حقول الخصم على مستوى الصنف (`unitDiscount`, `discountId`, `currentUnitPrice`, `currentUnitDiscount`, `currentEffectivePrice`, `priceChangedSinceOrder`, `gift`) — `StoreOrderItem` فيها `unitPrice`/`lineTotal` بس.

## ٧. `StorefrontOrder` (طلبات العميل من الحلاق) نفس الفجوة تقريبًا

- [ ] `note`, `deliveryAddress`/`deliveryLat`/`deliveryLng`, `acceptedAt`/`deliveredAt`/`rejectedAt`+سبب مفيش حاجة منهم موجودة.
- [ ] `nextStatuses` موجودة (على عكس `StoreOrder`) بس برضو محتاجة نفس فلترة نوع الاستلام (بند ٥).
- [ ] `StorefrontOrderItem` مفيش فيها أي حقل خصم — متوقع طالما `StorefrontProduct` نفسها مفيهاش مفهوم خصم أصلاً (بند ٢).

## ٨. تفاصيل التوصيل وقت إنشاء منتج (منتجات الحلاق للبيع)

اتأكد من الـ Postman: `POST/PUT /barber/storefront/product` بياخد بس `name, price, stock, minOrderQty, categoryId, brand, description, images` — **مفيش أي حقل توصيل في المنتج نفسه**. التوصيل كله مُدار من `GET/PUT /barber/storefront/delivery` (إعدادات عامة للمحل: `offered`, `fee`, `freeOver`) مش لكل منتج. **مطلوب توضيح:** ده هو المفروض فعلاً (إعداد عام بس)، ولا في نية تضاف حقول توصيل لكل منتج لوحده (وزن، قابل للتوصيل من عدمه...)؟

## ١٠. الحلاق معندوش فيتشر خصومات خالص — فجوة API كاملة، مش مجرد حقل ناقص

اتأكد (grep كامل على `postman/Ayez_ahlaqBarber.postman_collection.json`): **مفيش أي `barber/discount` endpoint موجود خالص.** التاجر عنده فيتشر كامل (`merchant/discounts/`) بيقدر بيه يعمل خصومات على منتجاته، الحلاق معندوش أي حاجة مقابلة — لا إنشاء ولا تعديل ولا حتى عرض. البنود ٢ و٥ و٦ فوق بتتكلم عن إن الحلاق مش شايف تفاصيل خصم (لأن مفيش `activeDiscount` بترجع له)، لكن الفجوة الحقيقية أعمق: **مفيش endpoint يخلي الحلاق يعمل خصم من الأساس.**

شكل الـ API بتاع التاجر (كمرجع للمطلوب المكافئ عند الحلاق):
```
GET    /api/merchant/discount              — ليستة خصومات التاجر
GET    /api/merchant/discount/{id}         — تفاصيل خصم واحد
POST   /api/merchant/discount              — إنشاء خصم جديد
PUT    /api/merchant/discount/{id}         — تعديل خصم
PUT    /api/merchant/discount/{id}/close   — قفل خصم (مش حذف)
POST   /api/merchant/discount/quote        — معاينة السلة بعد تطبيق الخصومات
```
جسم الطلب بيدعم ٣ أنواع (`scope`):
- `PRODUCT` — خصم % أو مبلغ ثابت على منتج واحد (`targetProductId` + `rewardType: PERCENT|AMOUNT` + `rewardValue`)
- `BUY_X_GET_Y` — اشتري كمية واحصل على تانية مجانًا/بخصم (`buyQuantity`, `rewardQuantity`, `rewardType: FREE|PERCENT|AMOUNT`)
- `ORDER_TOTAL` — خصم لما إجمالي الطلب يوصل حد معين (`minOrderTotal` + `rewardType` + `rewardValue`)

عند التاجر فيه كمان `shopIds` لتحديد صالونات معينة يتطبق عليها الخصم — المفهوم ده مش منطقي عند الحلاق (مفيش "محلات" يستهدفها، بيبيع للعملاء مباشرة)، فمن المتوقع الحقل ده يتشال عند الحلاق أو يبقى مش موجود خالص.

**مطلوب:**
- [ ] تأكيد إن الحلاق المفروض يقدر يعمل خصومات على منتجاته من الأساس (قرار منتج/بيزنس قبل أي حاجة تقنية).
- [ ] لو الإجابة أيوه، endpoints مكافئة تحت `barber/discount` (أو `barber/storefront/discount`) بنفس الشكل فوق بس من غير `shopIds`.
- [ ] `GET /barber/storefront/product` يرجّع `effectivePrice`/`activeDiscount` بعد كده (مرتبط ببند ٢).

## ٩. Endpoint مشروبات (Drinks) منفصل عن المنتجات

مفيش أي حاجة موجودة دلوقتي — اتأكد بالـ grep الكامل على الكود والـ Postman، صفر نتائج. مفيش حتى حقل "نوع" (type) يميّز المشروبات عن باقي المنتجات في أي مكان (لا `MerchantCategory` ولا `StorefrontCategory` عندهم discriminator). **مطلوب من الباك توضيح:**
- [ ] المشروبات هتبقى تصنيف عادي (category) جوه نفس `barber/storefront/product`/`category`، ولا
- [ ] كيان منفصل بالكامل بـ endpoints خاصة بيه

القرار ده هيحدد شكل الـ Clean Architecture عندنا (feature منفصل تمامًا ولا مجرد فلتر جوه الموجود).

---

## ملاحظات
- كل البنود دي لازم تتأكد بطلب حقيقي (curl) على الـ production API قبل ما نبني عليها أي كود، مش بس نتفق عليها كلام.
- `cancellationNote`/`cancelledByAdminName` بترجع `null` دايمًا في ردود التاجر (admin-only) — موثّق فعليًا، مش فجوة، الفرونت بيتعامل معاها صح.
- لو ظهر أي endpoint جديد أو اتغير شكل رد موجود، حدّث الـ Postman collection (`postman/Ayez_ahlaqBarber.postman_collection.json` / `Ayez_ahlaqMerchant.postman_collection.json`) فورًا.
