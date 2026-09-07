# مطلوب من الباك اند — نقاط مجمّعة من مراجعة الموبايل

مصدر البنود: [REVIEW_COMMENTS_CHECKLIST.md](REVIEW_COMMENTS_CHECKLIST.md). كل نقطة هنا لسه مش مقدور عليها من الموبايل لحد ما الباك اند يوفر/يأكد الحاجة المطلوبة.

---

## 1. خصم/عرض في شاشة السلة قبل الإرسال (Customer & Barber)

**المشكلة:** الخصم (`orderDiscount`) بيظهر بس في تفاصيل الطلب بعد الإرسال، مش قبله.

**المطلوب:** إضافة حقل `discount` (أو مكافئه) في استجابة الـ **quote/cart endpoint** نفسه:
- Customer: `POST /api/customer/store/quote`
- Barber: `GET /api/barber/cart`

لازم يرجع نفس شكل الخصم اللي بيظهر في تفاصيل الطلب (`orderDiscount`)، عشان نقدر نعرضه لليوزر وهو لسه بيبني السلة، قبل ما يبعت الطلب.

---

## 2. Wallet — Transfer Account (تأكيد الـ Endpoint نفسه + Customer)

⚠️ **تصحيح مهم:** الموبايل (Barber + Merchant) اتبنى بالكامل (كود + UI) بيستهدف:
```
GET /api/barber/transferAccount
GET /api/merchant/transferAccount
```
لكن لما راجعنا الـ Postman collections التلاتة (Barber, Merchant, Customer) — **`transferAccount` مش موجود فيهم خالص، صفر نتائج**. يعني الـ endpoint ده مبني على الـ curl example اللي كان في جدول المراجعة الأصلي بس، مش على تأكيد فعلي من الباك اند أو من الـ Postman collection.

**المطلوب أولًا:** تأكيد إن الـ endpoints دي فعلاً شغالة ومعمولة على السيرفر بنفس المسار والـ response shape اللي افترضناه:
```json
{ "data": [ { "id": 1, "label": "...", "accountNumber": "...", "holderName": "..." } ] }
```
لو الـ path أو شكل الـ response مختلف، الموبايل محتاج تعديل بسيط (بس في الـ model، مش في باقي الطبقات).

**تاني حاجة:** تأكيد هل الـ **Customer** محتاج نفس الميزة أصلاً (رقم محفظة يحول عليه فلوسه)، وهل فيه wallet feature كاملة للكاستمر من ناحية الباك اند (`customer/wallet`, `customer/walletRequests`, `customer/transferAccount`) — لأن الكاستمر معندوش أي wallet UI في الموبايل حاليًا، فمحتاجين نعرف هل ده مطلوب أصلاً قبل ما نبني feature كاملة من الصفر.

---

## 3. ~~بوفيه/مشروبات الحلاق — قايمة عملاء كل عضو فريق~~ ✅ اتأكد وخلص

**تم التحقق فعليًا (2026-09-06)** بحساب حلاق حقيقي — `GET /api/barber/team/{id}/clients?from=&to=` شغال ومعمول، وبيرجع array فيه `code`, `customerName`, `customerPhone`, `bookingDate`, `slotTime`, `serviceLabel`, `styleName`, `totalPrice`. اتبنى في الموبايل بالكامل. مفيش أكشن مطلوب من الباك اند.

---

## 4. ~~أرباح كل عضو فريق~~ ✅ اتأكد — لكن فيه ملاحظة

**تم التحقق فعليًا (2026-09-06)** — `GET /api/barber/team/{id}/earnings` بيرجع بنفس شكل `GET /api/barber/earnings` العامة زي ما كان متوقع. **لكن الاتنين فيهم حقل `clientsLast7Days`** كنا مش عارفينه ومكنش موجود في الموبايل — اتضاف دلوقتي. مفيش أكشن مطلوب من الباك اند، البند ده كان تصحيح من عندنا بس.

---

## 5. Broadcast — تأكيد الـ Pagination الجديدة على Merchant

**الحالة:** اتأكد الشكل الجديد لـ Barber:
```
GET /api/barber/broadcast?page=0&size=20
→ { "data": { "content": [...], "page", "size", "totalElements", "totalPages" } }
```
كل عنصر فيه `id`, `scope`, `title`, `status`, `recipientCount`.

**المطلوب:** تأكيد إن **نفس الـ contract بالظبط** (نفس أسماء الحقول، نفس الـ pagination) متطبق على:
```
GET /api/merchant/broadcast?page=0&size=20
```

---

## 6. طريقة الدفع — سلة المتجر بتاعة الحلاق (Barber Store Checkout)

**المشكلة:** سلة المتجر بتاعة الحلاق (`barber/cart` → `barber/cart/checkout`) **مفيهاش مفهوم `paymentMethod` خالص** في الـ request بتاعها — مش بس ناقص من الـ UI، الحقل نفسه مش موجود في الـ API contract.

**المطلوب:** توضيح هل الباك اند بيدعم `paymentMethod` لطلبات checkout السلة بتاعة الحلاق، ولو أيوه:
- إيه شكل الحقل بالظبط في `POST /api/barber/cart/checkout`؟
- هل فيه endpoint زي `GET /api/customer/paymentMethod` بس للحلاق (`GET /api/barber/paymentMethod`)؟ لقينا endpoint الكاستمر ده فعلي وموجود في الـ Postman collection ("Enabled methods" — بيرجع CASH/CARD/WALLET المفعّلة من الأدمن).

---

## 7. Walk-in — تأكيد `barberId` إجباري

**الحالة:** اتصلح في الموبايل — عضو الفريق بقى إجباري للـ owner، والحلاق العادي بياخد نفسه تلقائيًا.

**المطلوب (تأكيد بس):** إن `POST /api/barber/booking/walkin` فعليًا بيرفض الطلب لو `barberId` مبعوتش (زي ما في الـ curl الأصلي "REQUIRED — from GET /api/barber/team")، عشان نتأكد إن السلوك اللي بنينا في الموبايل (إرسال `barberId` دايمًا) مطابق لتوقع الباك اند.

---

## بنود BE-only (مفيهاش أكشن من الموبايل، بس المفروض تتراجع من عندكم)

- **401 Unauthorized بعد التسجيل مباشرة** (Merchant & Barber) — كل الـ API requests بترجع 401 بعد التسجيل.
- **الـ owner بيترجع جوه قايمة الأعضاء (members list)** لما تعرض تفاصيل حلاق (Customer & Barber) — المفروض الـ owner ميترجعش ضمن قايمة الأعضاء العاديين.
