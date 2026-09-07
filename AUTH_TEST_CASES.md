# Checklist — App Review Comments

مصدر البنود: جدول الكومنتس اللي جالك من المراجعة. كل بند فيه: نوع المستخدم، الوصف، حالته الحالية، والحالة المطلوبة (To Do / In Progress / Done).

Legend للـ Status الأصلي من الجدول:
- 🟢 Green = Solved
- 🟡 Yellow = Comment (موجود بس محتاج تعديل/توضيح)
- 🔴 Red = Bug
- ⚪ Grey = Not implemented yet
- (فاضي) = لسه محدّدش لونه في الجدول الأصلي

---

## Mobile

- [ ] **[All Types]** Login screen subtitle ثابت (static) لكل أنواع المستخدمين — المفروض يتغيّر حسب نوع اليوزر (customer / barber / merchant).
- [ ] **[Barber & Customer]** لو التاجر مش بيعمل توصيل (delivery)، خيار "Delivery" يبقى disabled/dimmed مع ملاحظة واضحة ("التاجر ده مش بيوفر توصيل") بدل ما اليوزر يقدر يختاره ويطلعله error غير واضح.
- [ ] **[Barber]** Remove member — إزالة خطوة/خيار reset password للعضو، لأنه مفيهوش حساب أصلاً (no account for member).
- [ ] **[Customer & Barber]** لما تتم إضافة منتجات للسلة من تاجرين مختلفين، أو من تاجر وحلاق سوا، لو الباك اند رجّع error، الأبلكيشن لازم يعرض رسالة الخطأ بوضوح لليوزر.
- [ ] **[All Types]** Delete Account.
- [ ] **[All Types]** Forget Password.

## BE & Mobile

- [ ] **[All Types]** 🟡 Verify account / Resend OTP — API موجود بالفعل، لكن فيه ملاحظة (راجع الـ comment الأصلي؛ مرتبط بالـ fix اللي عملناه في تكرار الـ push على شاشة الـ OTP).
- [ ] **[All Types]** Terms and Conditions + Privacy Policy.
- [ ] **[All Types]** ✅ Done — Wallet: تحديد رقم المحفظة / حساب الـ InstaPay اللي المفروض اليوزر يحوّل عليه.
  - `GET /api/{customer,merchant,barber}/transferAccount`
  - `POST /api/{type}/walletRequests` (multipart: type, amount, transferAccountId, note, file)
- [ ] **[Merchant & Barber]** ⏸️ Not now — الـ Store ميتطلبش اختيار حلاق/تاجر الأول قبل التصفح، عشان ميمنعش عرض منتجات مميزة (featured) بشكل عام كجزء من استراتيجية التسويق.
- [ ] **[Barber & Customer]** ✅ Done — إضافة خيار للزبون (سواء street walk-in أو من الأبلكيشن) يحدد هل عايز مشروب ولا لأ.
  - `POST /api/customer/booking` مع `addons`
- [ ] **[Barber & Customer]** ⚪ Not implemented yet — الحلاق يقدر يضيف المشروبات المتاحة عنده (بوفيه)، والزبون يشوف القايمة ويختار.
  - `GET/POST/PUT/DELETE /api/barber/storefront/product` + `/category` + `/stock`
- [ ] **[Barber]** الحلاق يقدر يشوف الأرباح اللي كل عضو فريق جابها.
  - `GET /api/barber/team`
  - `GET /api/barber/team/{id}/earnings`
  - `GET /api/barber/team/{id}/clients?from=&to=`
- [ ] **[Barber]** ✅ Done — الحلاق يقدر يمسح (delete) عضو فريق نهائيًا مش يعمله block بس.
  - `DELETE /api/barber/team/{id}/permanent`
- [ ] **[Barber]** الحلاق يقدر يسجل مباشرة من خلال الأبلكيشن.
- [ ] **[Barber & Merchant]** الإشعارات (notifications/broadcast) اللي بيبعتها الحلاق أو التاجر لازم تتوافق عليها الإدارة (admin approval) قبل ما توصل للزباين.
  - `GET /api/{merchant,barber}/broadcast`
  - ⚠️ ده BE-only في الجدول، لكن محتاج تأكيد هل فيه تعديل مطلوب في الموبايل لعرض حالة "قيد المراجعة" للإشعار.
- [ ] **[Barber & Merchant]** طريقة الدفع (payment method) المفروض تكون محددة بوضوح لكل من: طلبات المنتجات، وأوردرات قص الشعر للزبون.

## BE فقط

- [ ] **[Merchant & Barber]** بعد التسجيل (registration)، كل الـ API requests بترجع 401 Unauthorized.
- [ ] **[Customer & Barber]** لما تعرض تفاصيل حلاق من قايمة الأعضاء (members list)، الـ owner بيترجع برضه جوه القايمة (مفروض ميترجعش).

## غير مصنّف / يحتاج توضيح مصدر

- [ ] Images — `GET /api/barber/store/merchant/{mid}/product/{pid}/image` (مذكور في آخر صف من غير تفاصيل — يحتاج توضيح إيه بالظبط المطلوب فيه).

---

## ترتيب مقترح للشغل (Mobile-first، حسب الأثر والسهولة)

1. Login subtitle الثابت لكل الأنواع.
2. Delivery option disabled/dimmed لو مفيش توصيل.
3. Remove member — شيل reset password.
4. عرض رسائل الخطأ بوضوح عند فشل إضافة منتجات من تاجرين/حلاق.
5. Delete Account + Forget Password (لو مش متوفرين فعليًا في التنقل/الشاشات).
6. باقي بنود الـ BE & Mobile اللي محتاجة ربط API (Store بدون اختيار حلاق أول — لاحقًا/Not now، الأرباح لكل عضو، تسجيل الحلاق من الأبلكيشن).
