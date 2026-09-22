# رودماب مراجعة فلو الحلاق (زي مراجعة التاجر بالظبط)

مرجع تنفيذي لسيشن جديدة — الهدف: نفس عمق مراجعة `MERCHANT_ROADMAP.md` (قسم "مراجعة شاملة تالتة") بس لكل `lib/features/barber/`، قبل ما التطبيق يتبعت لأي تيستر حقيقي. **متنفّذش حاجة من غير ما تتأكد منها بالكود أو باختبار حي فعلي — المراجعة اللي فاتت طلعت فيها 4 "بقات" من أدوات آلية اتفحصوا وطلعوا غلط (موثّقين في آخر `MERCHANT_ROADMAP.md`)، فمتوثقش نتيجة أداة آلية من غير تحقق يدوي.**

هذا الملف بيوصف **إيه اللي نراجعه وليه**، مش قائمة "افعل كذا" جاهزة — لازم تتفحص كل نقطة بالكود الفعلي (وباختبار حي على production فين ما يلزم) قبل ما تتسجل كـ "خلص".

---

## 0. طريقة الشغل (نفس اللي اتبعت مع التاجر)

1. **مراجعة كود يدوية + agents متوازية** لكل فولدر تحت `lib/features/barber/` — طبقة data/domain/presentation كاملة لكل فيتشر.
2. **أي finding من agent لازم يتفحص بالكود مباشرة** قبل ما يتسجل كباج حقيقي — الأدوات الآلية بتغلط في حاجات زي:
   - قراءة `copyWith` غلط (فاكرة إن حقل من غير `?? this.x` معناه باج، مع إنه أحيانًا ده القصد)
   - الاعتماد على وصف الـ Postman collection بدل اختبار حي فعلي (الـ collection ممكن يبقى قديم/غلط — زي ما حصل مع تسجيل التاجر)
   - افتراض إن فيه UI لحاجة (زي منتج هدية منفصل) من غير ما يتأكد إنها موجودة أصلًا في الشاشة
3. **أي باج مالي أو بيغيّر سلوك ظاهر للمستخدم** (زي حالة اشتراك غلط، أو خصم مش متطبق) لازم يتأكد منه بـ **curl حي على production**، مش بس بقراءة الكود.
4. حط `[x]` جنب كل بند لما يخلص، وسيب سطر تحته يقول اتصلح إزاي بالظبط (نفس أسلوب `MERCHANT_ROADMAP.md`).

---

## 1. الفولدرات المطلوب مراجعتها (22 فولدر)

راجع كل واحد فيهم بالكامل (data/domain/presentation)، بالترتيب المقترح ده (الأهم/الأكتر استخدام الأول):

- [x] `store/` — شراء الحلاق من تاجر (الأكتر تعقيدًا؛ فيه سلة server-side، خصومات، checkout)
  - اتصلح: `_mapOrder`/`_mapCart`/`_mapQuote` في `barber_store_repo.dart` كانوا بيعملوا `response['data'] as Map<String, dynamic>` من غير حماية — بدلناهم بـ `requireDataMap` + `flatMap` زي باقي الـ repos.
  - اتصلح: `StoreOrder.props` كان ناقص معظم الحقول (`items`, `merchantId/Name`, `fulfillmentType`, الخصم، بيانات التوصيل، كل التواريخ) — كملناها كلها.
  - باقي كل حاجة اتفحصت (الموديلات، الكاش، الـ navigation، الحالات النصية، الكود الميت) سليمة.
- [x] `storefront/{products,categories,delivery,orders}/` — متجر الحلاق كبائع للعميل
  - اتصلح: نفس باج `requireDataMap` (كراش عند رد غير متوقع) في `barber_storefront_products_repo.dart` (create/update/setStock)، `barber_storefront_orders_repo.dart` (get/accept/reject/advance)، `barber_storefront_categories_repo.dart` (create/update).
  - اتصلح: `ActiveDiscountModel.discountId` كان `as int` من غير حماية — بقت `(json[...] as num?)?.toInt() ?? 0`.
  - اتصلح: `ActiveDiscountLabel.valueLabel` كان بيفترض إن أي حاجة مش PERCENT لازم تتعرض كمبلغ فلوس — لو الخصم نوعه FREE كان هيعرض رقم غلط بدل "مجانًا". دلوقتي بيتفحص `isFree` الأول.
  - اتصلح: `StorefrontOrder.props` و`StorefrontOrderItem.props` كانوا ناقصين معظم الحقول (زي `StoreOrder` بتاع `store/`) — كملناهم.
  - اتصلح: تعديل صورة منتج المتجر (`storefront_product_form_screen.dart`) مكنش بيعمل `AuthorizedNetworkImage.evict` بعد الحفظ زي التاجر — بقت بتعمل evict لو فيه صور جديدة.
  - اتصلح: `BarberStorefrontProductsCubit.removeProduct` كان بيرجع لـ snapshot قديم كامل لو الحذف فشل (نفس باج `MerchantProductsCubit.removeProduct` قبل ما يتصلح) — بقى بيرجع بس المنتج المحذوف لو لسه مش موجود.
  - **ملاحظة مش مصلحة**: نفس نمط الـ snapshot القديم موجود في `BarberStorefrontCategoriesCubit.deleteCategory` و`setStock` في الكوبيتس بتاعة المنتجات (تاجر وحلاق) — مش اتصلحوا لأن النسخة المرجعية عند التاجر نفسها لسه فيها نفس النمط في `setStock`؛ محتاجين قرار منفصل لو عايزين نعمم الفيكس.
  - **ملاحظة مش مصلحة**: `storefront_product_row.dart` (ليستة منتجات الحلاق بتاعته) بتعرض السعر بعد الخصم بس من غير خط فوق السعر الأصلي، على عكس شاشة التفاصيل — الحلاق مايقدرش يعرف من الليستة إن فيه خصم شغال إلا لو دخل تفاصيل المنتج.
  - باقي كل حاجة اتفحصت (الموديلات، cross-cubit staleness بين categories/products، الـ navigation، الحالات النصية) سليمة.
- [x] `bookings/` — الحجوزات والطابور (queue) والـ walk-in
  - اتصلح: نفس باج `requireDataMap` في `barber_booking_repo.dart` — بيأثر على كل الـ mutations (confirm/reject/advance/createWalkIn/updateBilling)، وده أكتر فيتشر فيه عمليات مالية (تعديل الفاتورة).
  - اتصلح: `Booking.props` كان ناقص كل حاجة تقريبًا (`addons`, `adjustments`, `adjustmentsTotal`, `billingLocked`, ...) — كملناه بالكامل.
  - اتصلح: شاشة تفاصيل الحجز (`booking_info_card.dart`) كانت بتعرض الإجمالي النهائي بس من غير ما توضح لو فيه `adjustments` (خصم أو إضافة يدوية) اتطبقت — ضفنا سكشن جديد (`booking_adjustments_section.dart`) يوضح كل تعديل ولونه (أخضر للخصم).
  - اتصلح باج كراش حقيقي: `AddWalkInSheet._confirm` كان بيعمل `_barberId!` من غير ضمان — لو الحلاق فتح شيت "إضافة ولك-إن" وضغط تأكيد قبل ما بروفايله يخلص تحميل (`BarberProfileCubit.loadProfile()` بتتنادى async في `initState` بتاع الـ shell)، الابليكيشن كان بيكراش. دلوقتي بيرجع رسالة خطأ بدل الكراش.
  - باقي كل حاجة اتفحصت (enum الحالات، الموديلات، الـ navigation، race conditions في الـ cubit، الكود الميت) سليمة — الـ cubit هنا مختلف عن باقي الفيتشرز إنه مايعملش optimistic update قبل الـ await خالص، فمفيش باج الـ stale snapshot هنا.
## 1.1. مهمتين إضافيتين اتعملوا زي ما هما (مش جزء من الـ 22 فولدر، طلب منفصل)

- [x] **مراجعة الـ pagination في كل barber (22 فولدر) + merchant**: اتفحص live على production (مش بس قراءة الـ Postman collection اللي طلع منها إنها مش موثوقة حتى لحاجات موثقة فعلاً كـ paginated زي `walletRequests`). النتيجة: **مفيش أي gap** — الفيتشرز التلاتة بس اللي فيهم pagination فعلي من السيرفر (`notification`, `walletRequests`, `broadcast`) already متطبقين صح على الكلاينت في barber وmerchant. باقي كل الـ list endpoints (orders, bookings, reviews, team, drinks, services, products, discounts...) اتأكد إنها flat array حقيقي من السيرفر (اتبعت `page=0&size=1` واتقارنت بالنتيجة من غير باراميترز، ورجعوا نفس العدد بالظبط).
- [x] **إضافة `showLoading`/error feedback لكل عملية create/update/delete حساسة (barber + merchant)**: استخدمنا الـ widget الموجود بالفعل `BusyErrorListener` (كان متطبق على شاشة واحدة بس قبل كده). المعيار: لو الشاشة عندها indicator محلي كافي (زرار بيعمل spin/disable + بيعرض error) ماتتلمسش؛ لو مفيش أي feedback عند الفشل، تتضاف.
  - لقينا وصلحنا **باج حقيقي منفصل** في `team_member_detail_screen.dart`: `_block`/`_activate` كانوا بيعرضوا "تم الحظر/التفعيل بنجاح" **حتى لو العملية فشلت فعلاً** (مفيش check على النتيجة أصلاً).
  - لقينا وصلحنا باج تاني في `merchant/products/product_details_screen.dart`: حذف منتج فاشل كان لسه بيعمل `context.pop()` وكأنه نجح.
  - صلحنا غياب أي error feedback في: `barber/store` (cancel order)، `barber/storefront` (categories delete، products delete، orders accept/reject/advance)، `barber/bookings` (confirm/reject/advance/edit-bill)، `barber/drinks` (delete)، `barber/discounts` (close)، `barber/team` (member services edit/delete/toggle)، `barber/wallet` (cancel request)، وأشباهها في merchant (`categories`, `discounts`, `products`, `phones`, `orders`, `wallet`).
  - **درس مهم اتعلمناه أثناء الشغل**: كل من barber shell وmerchant shell بيستخدموا `IndexedStack` للتابز — يعني الشاشة تفضل mounted لما تتنقل لتاب تاني. فلو حطينا `BusyErrorListener` جديد على شاشة، ولازم نتأكد إن مفيش شاشة تانية already listening على نفس الـ cubit/`errorMessage` (زي `barber_wallet_requests_screen.dart` اللي عنده `listenWhen` مخصص لـ pagination بس بيتفعل كمان مع أي error تاني) — عشان كده استخدمنا one-time check (`cubit.state.errorMessage` بعد الـ await) بدل listener جديد في الحالتين دول (`wallet_request_detail_screen.dart` بتاع barber وmerchant) عشان نتجنب toast مكرر.

- [x] `discounts/` — خصومات الحلاق للعميل (فيتشر جديد اتبنى في السيشن اللي فاتت، لسه معملوش review كامل)
  - اتصلح: `BarberDiscountsRepo._mapOne` (get/create/update) كان `response['data'] as Map` من غير حماية — بقى `requireDataMap` زي الباقي.
  - اتصلح: `BarberDiscount.props` كان ناقص كل حقول الخصم الفعلية (`rewardType`, `rewardValue`, `targetProductId`, `buyQuantity`, `rewardQuantity`, `minOrderTotal`, `createdAt`) — بالظبط النوع اللي الـ checklist بند (ب) بيحذر منه. كملناها.
  - اتصلح باج cross-cubit staleness حقيقي: إنشاء/تعديل/إغلاق خصم في `barber_discounts_screen.dart`/`barber_discount_form_screen.dart` مكانش بيعمل `loadProducts()` على `BarberStorefrontProductsCubit` بعدها — يعني لو الحلاق يعدل خصم وبعدين يرجع لشاشة المنتجات، السعر المعروض (`effectivePrice`/`activeDiscount`) يفضل قديم لحد ما يعمل refresh يدوي. نفس الفيكس اللي موجود بالفعل عند التاجر (`MerchantProductsCubit.loadProducts()` بعد كل عملية خصم) — اتطبق هنا كمان.
  - **ملاحظة مش مصلحة (مش باج، فرصة مفقودة موجودة كمان عند التاجر)**: حقل `rewardProductId` موجود في الـ request DTO (`BarberDiscountRequest`/`DiscountRequest`) وموثّق في الـ API ("ORDER_TOTAL + FREE = هدية منتج مختلف")، لكن مفيش أي UI في الفورم (حلاق أو تاجر) بيسمح باختيار `RewardType.free` لسكوب `ORDER_TOTAL` أصلاً — يعني ميزة "هدية عند تجاوز حد الطلب" مش متاحة فعليًا من التطبيق رغم إن الباك اند بيدعمها. قرار منتج مش تقصير كود، محتاج قرار منفصل لو عايزين نبنيها.
  - باقي كل حاجة اتفحصت (enum الـ scope/reward type بيتشاركوا صح مع التاجر، الفورم validation بيستخدم نفس الـ `RewardValueRules`، الـ product selector بيتحمّل صح، مفيش race conditions) سليمة.
- [x] `wallet/` — المحفظة وطلبات الإيداع/السحب
  - اتصلح: `_mapWallet`/`_mapPage`/`_mapOne` في `barber_wallet_repo.dart` و`barber_wallet_requests_repo.dart` كانوا `response['data'] as Map` من غير حماية (getWallet, getWalletRequests, getWalletRequestDetail, createWalletRequest, cancelWalletRequest) — بقوا `requireDataMap`.
  - اتصلح: `WalletRequestStatusChip` كان بيعرض `other` status بلابل "Pending" لكن لون badge رمادي (`muted`) — تناقض بصري (النص بيقول حالة نشطة، اللون بيقول مقفول). بقى اللون متطابق مع اللابل.
  - اتصلح: `wallet_request_info_card.dart` (حلاق وتاجر) كان بيعرض `decidedAt` بـ `DateTime.toString()` الخام (شكل زي `2026-09-08 15:57:38.000`) بدل `AppDateTime.formatDateTime` المستخدم في كل مكان تاني.
  - **تنبيه لنفسي اتصحح في نفس السيشن**: افترضت غلط إن حقل `transferAccountId` مطلوب للإيداع بس، وعملت فيكس شاله من شاشة السحب — لكن الـ Postman doc وضّح إنه **REQUIRED للإيداع والسحب معًا** (بيمثل وسيلة الدفع اللي الأدمن هيرجع بيها الفلوس في حالة السحب). رجّعت الكود زي ما كان فورًا قبل ما أأكد الفيكس. **درس**: أي افتراض عن معنى حقل في نموذج مالي لازم يتأكد من التوثيق أو curl حي قبل التعديل، حتى لو شكله منطقي.
  - باقي كل حاجة اتفحصت (enums الحالة/النوع، الـ pagination في `barber_wallet_requests_cubit.dart` مؤكدة شغالة صح من المراجعة اللي فاتت، الـ props كاملة في `WalletRequest`/`WalletTransaction`/`TransferAccount`/`WalletRequestPage`، عرض المبلغ بالإشارة واللون الصح للإيداع/السحب، الـ navigation) سليمة.
  - **ملاحظة مش مصلحة**: استجابة `GET /wallet` فيها حقل `holds[]` (تفاصيل كل مبلغ محجوز وسببه) بيتم تجاهله بالكامل في `BarberWalletModel` — بس مفيش دليل حي على شكله (الحساب التجريبي رجّع `holds: []` فاضية) ومفيش طلب واضح لعرضه، فمتعملش UI جديد لحاجة غير مؤكدة.
- [x] `team/` — إدارة الفريق والأرباح
  - اتصلح: `_mapOne` في `barber_team_repo.dart` (add/get/update/setAvailability/block/activate — 6 عمليات) و`barber_team_services_repo.dart` (create/update) و`_mapEarnings` في `barber_earnings_repo.dart` (getEarnings/getMemberEarnings) كانوا كلهم `response['data'] as Map` من غير حماية — بقوا `requireDataMap`.
  - اتصلح باج عرض مالي حقيقي (نفس فئة باج "عملائي" التاجر المذكور في القسم 3): `earnings_summary_grid.dart` و`earnings_breakdown_card.dart` و`daily_earning_row.dart` كانوا بيعرضوا أرقام فلوس (`today`, `last7Days`, `thisMonth`, `avgTicket`, `supplierSpendThisMonth`, `netThisMonth`, `amount`) كـ raw number من غير "EGP" — بينما نفس البيانات في `home_earnings_grid.dart` (الداشبورد الرئيسي) بتتعرض صح بـ `S().currencyEgp()`. اتصلحوا الكل ليطابقوا النمط الصح. الفيكس ده بيغطي 3 شاشات مرة واحدة (`earnings_screen.dart`, `member_earnings_section.dart`, وأي حد تاني بيستخدم نفس الـ widgets) لأنها widgets مشتركة.
  - اتصلح باج سباق حالة: `MemberServicesCubit.deleteService` كان بياخد snapshot كامل قبل الـ await ويرجعله لو فشل الحذف (نفس باج `MerchantProductsCubit.removeProduct` اللي اتصلح) — بقى بيرجع بس العنصر المحذوف.
  - **تنبيه لنفسي**: افترضت غلط في نفس السيشن (فيتشر `wallet/`) إن `transferAccountId` مطلوب للإيداع بس وعملته فيكس، اكتشفت الغلط من الـ Postman doc ورجّعته فورًا. مذكور هنا للسياق مش لإنه جزء من `team/`.
  - باقي كل حاجة اتفحصت (props كاملة في كل الـ entities، الـ navigation بيبعت member id بس مش الكائن كامل زي ما لازم، الكود الميت، الـ cubits التانية زي `member_hours`/`member_clients`/`member_earnings` سليمة من غير races) تمام.
- [x] **متابعة طلب المستخدم لاحقًا أثناء مراجعة `team/`**: تطبيق `showLoading` على تسجيل الخروج (حلاق + تاجر) — كان `onLogout` نوعه `VoidCallback` من غير `await` في السلسلة كلها (`*ProfileMenu` → `*ProfileScreen` → `*Shell` → `app_routes.dart`)، فالـ `_handleBarberLogout`/`_handleLogout` (اللي فيهم نداء شبكة حقيقي: `unregisterAllTokens()` + مسح الجلسة) كانوا بيتنفذوا fire-and-forget من غير أي مؤشر تحميل. غيّرنا النوع لـ `Future<void> Function()` في السلسلة كاملة (حلاق وتاجر، مش عميل — برا نطاق السيشن دي) وحطينا `showLoading()`/`hideLoading()` حوالين الاستدعاء في `_confirmLogout`.
  - **ملاحظة جانبية اتلاحظت وهتتصلح وقت مراجعة `auth/`**: `barber_auth_repo.dart._persist` فيه نفس باج الكاست الغير محمي (`response['data'] as Map` من غير `?`) — برا نطاق التاسك دي، هتتصلح لما نوصل لفولدر `auth/` في الروادماب.
- [x] `hours/` — ساعات العمل
  - اتصلح باج حقيقي كبير: `WorkingDayRow._dayNames` كانت مرتبة يوم الاتنين الأول (`[monday, tuesday, ..., sunday]`)، لكن الـ API موثّق ومتأكد منه live إن `dayOfWeek` بيبدأ بـ 0=الأحد لحد 6=السبت. يعني كل يوم كان بيتعرض باسم يوم غلط (إزاحة يوم كامل) — لو الحلاق قافل يوم الجمعة (`dayOfWeek: 5`)، الشاشة كانت بتعرضه كـ "السبت". اتصلح بترتيب المصفوفة تبدأ بالأحد. الفيكس ده بيغطي شاشتين مرة واحدة (`barber_hours_screen.dart` و`member_hours_section.dart`) لأنهم بيستخدموا نفس الـ widget.
  - باقي كل حاجة اتفحصت (الموديل بيقلب `off`/`isOpen` صح، الـ repo آمن، مفيش تحقق عميل-جانب على `openTime < closeTime` بس السيرفر بيتحقق منها وده قرار تصميم مقبول مش باج) سليمة.
- [x] `services/` — الخدمات والأسعار
  - اتصلح: `_mapOne`/`_mapOwnOne` في `barber_services_repo.dart` (create/update service, create own service) كانوا `response['data'] as Map` من غير حماية — بقوا `requireDataMap`.
  - اتصلح باج سباق حالة (نفس النمط اللي اتصلح 3 مرات في السيشن دي): `BarberServicesCubit.deleteService` و`OwnServicesCubit.deleteOwnService` كانوا بياخدوا snapshot كامل قبل الـ await ويرجعوله لو الحذف فشل — بقوا بيرجعوا بس العنصر المحذوف.
  - باقي كل حاجة اتفحصت (props كاملة، `serviceMetaLine` بيعرض EGP صح من جوه الـ l10n string نفسها، `CatalogPickerField` بيعمل dedup دفاعي بالـ id، مفيش كود ميت، `BusyErrorListener` في `barber_services_screen.dart` شغال صح ومطابق للنمط المرجعي) سليمة.
- [x] `documents/` — المستندات
  - اتصلح: `_mapOne` في `barber_documents_repo.dart` (uploadDocumentFile) كان `response['data'] as Map` من غير حماية.
  - اتصلح: `barber_documents_screen.dart` كان من غير `BusyErrorListener` — رفع/حذف مستند فاشل كان من غير أي رسالة خطأ (زي كل الشاشات التانية اللي اتصلحت في السيشن دي).
  - اتصلح باج parity حقيقي: `MissingDocumentsBadge` (بادج عدد المستندات الناقصة) كان موجود بالكامل جوه فولدر `barber/documents` بس **مش مستخدم في أي مكان** — بينما نفس الـ widget عند التاجر متطبق في قائمة البروفايل بتاعته. حطينا الـ badge على صف "مستنداتي" في `barber_shop_menu_sections.dart`، وضفنا `BarberDocumentsCubit.loadDocuments()` كـ eager load في `barber_shell.dart` (زي باقي الكوبيتس هناك) + ضفنا الكوبيت لقائمة الـ providers في `app_routes.dart` (كان مسجل بس مش متوفر على مستوى الـ shell، فكان `context.read` هيرمي exception لو استخدمناه من غير الإضافة دي).
  - **تأكيد false positive**: `document_actions.dart` (حلاق وتاجر) لسه فيهم `picked.path!` — بس ده *آمن فعليًا* حاليًا لأن `DocumentPickResult` (الـ shared abstraction) بتضمن إن `path` مايبقاش null إلا لو `exceedsMaxSize`/`isUnsupportedType` اللي بيتفحصوا الاتنين قبل الوصول للسطر ده. الملاحظة اللي في القسم 0 من الروادماب (نفس الملف كان فيه الباج ده في التاجر) بتتكلم عن نسخة قديمة قبل الـ refactor المشترك ده — النهاردة الكود آمن في الاتنين.
  - **ملاحظة مش مصلحة (قرار منتج مش باج)**: `BarberDocument.isLockedByAdmin` موجود وبيتستخدم بس لعرض label ("اتضاف من الأدمن") — مش بيمنع زرار "استبدال"/"حذف" في `DocumentRowActions`. الاسم بيوحي إن القصد كان قفل فعلي، لكن الـ Postman doc ماذكرش أي قيد زي ده على مين يقدر يستبدل/يمسح الملف. محتاج قرار منتج/تأكيد سيرفر مش تخمين كود.
  - باقي كل حاجة اتفحصت (props كاملة، الكوبيت من غير race conditions، `deleteFile` بيصفر الملف محليًا صح من غير إعادة تحميل كاملة) سليمة.
- [x] `notifications/` + `device_token/`
  - اتصلح: `getNotifications`/`getUnseenCount` في `barber_notifications_repo.dart` كانوا `response['data'] as Map` من غير حماية.
  - اتصلح: `BarberNotification.props` كان ناقص `referenceType`/`referenceId` (حقول الـ deep-link الوحيدة المهمة في الكيان ده).
  - **باج حقيقي مكتشف بس هيتأجل لمهمة منفصلة (اتفق عليه مع المستخدم)**: مفيش أي deep-linking فعلي — `BarberNotificationRouter.route()` بيتجاهل `type`/`typeId` تمامًا ودايمًا بيروح لشاشة الإشعارات العامة، وفي شاشة الإشعارات نفسها الضغط على إشعار بيعمل `markRead` بس من غير أي navigation للحجز/الطلب/الطلب المالي اللي الإشعار بيتكلم عنه. نفس القصور بالظبط موجود عند التاجر (مش رجريشن، تبسيط متعمد وموجود من الأول في الاتنين). محتاج مهمة منفصلة تتأكد الأول من كل قيم `referenceType` الحقيقية live قبل بناء الـ mapping.
  - **ملاحظة كوزمتيك مش مصلحة**: `NotificationKind.fromType` منطقها مبني على مصطلحات تاجر (order/stock/discount) مش حلاق (booking/wallet/team) — يعني كل إشعارات الحلاق الحقيقية (`booking_requested`, `admin_announcement`) بترجع `general` وتاخد أيقونة جرس عامة. مش باج وظيفي (العنوان والنص من السيرفر بيوضحوا المحتوى)، بس أيقونة غير دقيقة. يحتاج قائمة أنواع حقيقية للحلاق قبل ما نظبطها.
  - **ملاحظة صغيرة مش مصلحة**: `markRead` بيعمل optimistic update لحالة "مقروء" من غير ما يتأكد إن `_markClicked` نجح فعلاً — لو فشلت، الشاشة تفضل عارضة "مقروء" محليًا بس السيرفر لسه شايفها "غير مقروءة". خطورة منخفضة (مفيش فقد بيانات أو مبلغ مالي)، مش هيتصلح دلوقتي.
  - باقي كل حاجة اتفحصت (الـ pagination في `loadMore` صح ومطابق للنمط الموثق، `NotificationPage`/`BarberNotificationModel` آمنين، `device_token` سليم) تمام.
- [x] `broadcast/` — إرسال إشعار جماعي
  - اتصلح: `list` في `barber_broadcast_repo.dart` كان `response['data'] as Map` من غير حماية.
  - اتصلح: `BroadcastStatusChip` كان فيه نفس تناقض label/tone بتاع `WalletRequestStatusChip` (`other` بيتعرض بلابل "قيد المراجعة" بس بلون رمادي مقفول). لقينا نفس الباج بالظبط في **4 نسخ تانية** وصلحناهم كلهم: `merchant/wallet/wallet_request_status_chip.dart`، `merchant/broadcast/merchant_broadcast_status_chip.dart` (الاتنين برا نطاق الحلاق بس نفس الملف بالظبط اتصلح فيه بالفعل مرة، فطبقنا نفس الفيكس المتأكد منه). `customer/wallet/wallet_request_status_chip.dart` فيه نفس الباج بالظبط بس **متأجل عمدًا** لأن العميل برا نطاق السيشن دي.
  - اتصلح باج حقيقي كبير (بعد تأكيد من المستخدم): `Broadcast` (حلاق) كان ناقص `body`, `decisionNote`, `decidedAt`, `sentAt`, `createdAt` بالكامل — مش بس من الـ props، من الكيان والموديل نفسهم. يعني لو الأدمن رفض broadcast الحلاق، الحلاق كان شايف بس badge "مرفوض" من غير أي سبب. ضفنا الحقول دي للـ entity/model، وضفنا سطر "سبب الرفض: ..." في `broadcast_row.dart` لما الحالة تبقى rejected وفيه `decisionNote`. ضفنا مفتاح l10n جديد `broadcastRejectionReasonLabel` (عربي/إنجليزي) وعملنا regenerate بـ `dart run intl_utils:generate` (المشروع بيستخدم `intl_utils` مش `flutter gen-l10n`).
  - **ملاحظة**: نفس الـ gap (`body`/`decisionNote`/timestamps) موجود بالظبط عند التاجر (`merchant/broadcast/domain/entities/broadcast.dart`) — اتفق مع المستخدم إننا نصلحه للحلاق بس دلوقتي ونسيب التاجر كـ gap موثق لمراجعة منفصلة.
  - باقي كل حاجة اتفحصت (الـ pagination في `loadMore` صح، `barber_broadcast_cubit.dart`/`_screen.dart` بيغطوا أخطائهم بنفسهم، `BroadcastScope` مش متعروض في الصف بس ده مش باج) سليمة.
- [x] `subscription/` — الاشتراك
  - اتصلح: `getSubscription`/`subscribe` في `barber_subscription_repo.dart` كانوا `response['data'] as Map` من غير حماية.
  - اتصلح: `SubscriptionPlanModel.id` كان `json['id'] as int` من غير حماية.
  - اتصلح باج حقيقي كبير (مؤكد live): نفس باج `PAUSED` بتاع التاجر بالظبط، موجود في الحلاق كمان ومتأكد إنه قابل للتكرار — `current_subscription_card.dart` و`subscription_home_card.dart` كانوا بيقارنوا `status == 'PENDING'` وأي حاجة تانية (`PAUSED`, أو أي قيمة غير متوقعة) كانت بتتعرض "نشط" باللون الأخضر. اتأكد live إن `ACTIVE` قيمة حقيقية (الحساب التجريبي راجع بيها)، ومن التاجر اتأكد إن `PAUSED` قيمة حقيقية للنظام. أنشأنا `SubscriptionStatus` enum مطابق تمامًا لنسخة التاجر (`active`/`pending`/`paused`/`unknown`) مع label/color extensions، وربطناهم في الشاشتين + في `barber_subscription_screen.dart` (كان فيها `status != 'PENDING'` كمان بنفس الباج في رسالة النجاح بعد الاشتراك).
  - اتصلح باج بيانات ناقصة مؤكد live (بعد موافقة المستخدم): `Subscription` و`SubscriptionPlan` كانوا ناقصين `ownServices`/`ownServiceCap` و`drinks`/`drinkCap` بالكامل رغم إن الـ API الحي بيرجعهم فعلاً لكل الخطط والاشتراك الحالي. ضفنا الحقول للـ entities والموديلات، وضفناهم لعرض الكوتة في `current_subscription_card.dart` و`subscription_plan_card.dart`. ضفنا مفتاحين l10n جداد (`quotaOwnServices`, `quotaDrinks`) عربي/إنجليزي وعملنا regenerate بـ `dart run intl_utils:generate`.
  - باقي كل حاجة اتفحصت (`SubscriptionRequest`/`subscription_request_row.dart` بيتعامل مع الحالة صح بـ switch متسق label+color مع بعض، `SubscriptionQuota` كامل، الكاش unlimited صح لما `cap == null`) سليمة.
- [x] `sponsorship/` — الترويج
  - مفيش باج اتلاقى. الفيتشر ده كامل بيستخدم `shared/sponsorship/` (Entity, Model, State, View) مشترك مع التاجر — الكاست في الـ repo آمن بالفعل (`as Map<String, dynamic>? ?? const {}`)، الـ props كاملة، `daysLeft`/`missingAmount` بيتعاملوا صح مع القيم السالبة، كل عرض فلوس بيستخدم `currencyEgp`، الشاشة بتغطي أخطائها بنفسها. `flutter analyze` نضيف من غير أي warning.
- [x] `reviews/` — التقييمات (قراءة بس)
  - اتصلح: `_mapSummary` في `barber_reviews_repo.dart` كان `response['data'] as Map` من غير حماية.
  - باقي كل حاجة اتفحصت (props كاملة، عرض النجوم صح، `average`/`count` من السيرفر مباشرة مش محسوبة عميل-جانب، الشاشة قراءة بس من غير أي gap) سليمة.
- [x] `invite/` — رابط الدعوة
  - اتصلح: `_mapInvite` في `barber_invite_repo.dart` كان `response['data'] as Map` من غير حماية (get/regenerate).
  - باقي كل حاجة اتفحصت (props كاملة، الشاشة بتغطي أخطائها بنفسها مع confirm dialog قبل الـ regenerate، النسخ للحافظة بيعرض نجاح) سليمة.
- [x] `drinks/` — المشروبات
  - اتصلح: `_mapOne` في `barber_drinks_repo.dart` كان `response['data'] as Map` من غير حماية (create/update).
  - اتصلح قبل كده في نفس السيشن (أثناء تطبيق `showLoading`): `barber_drinks_screen.dart` مكانش فيه `BusyErrorListener`، و`drink_form_sheet.dart` كان بيعمل نفس رسالة الخطأ مرتين — اتصلحوا الاتنين.
  - **ملاحظة مش مؤكدة كباج**: `Drink.sortOrder` بيتقرا من الـ API بس مش بيتستخدم لأي ترتيب عميل-جانب في الشاشة — ممكن يبقى السيرفر بيرجع الليستة مرتبة بالفعل (مش باج)، محتاج تأكيد لو عايزين نضيف `.sort()`.
  - باقي كل حاجة اتفحصت (props كاملة، عرض السعر بـ `currencyEgp`، الستايلز من `styles.dart` مش raw TextStyle) سليمة.
- [ ] `payment_methods/` — طرق الدفع (قراءة بس)
  - مفيش باج. الـ repo آمن بالفعل (بيتعامل مع أكتر من شكل استجابة محتمل من غير كراش). فيتشر كامل (`BarberPaymentMethodsCubit` + repo + use case) مسجل في الـ DI بس **مش متستخدم في أي حتة فعليًا**.
  - **false positive اتصحح جوه نفس المحادثة**: افترضت في الأول إن `add_walk_in_sheet.dart` (اللي بيبعت `paymentMethod: 'CASH'` ثابت) ده باج لازم يتصلح بربط الـ picker ده، اعتمادًا على وصف الـ Postman "استخدم ده بدل ما تعمل hardcode لـ CASH". المستخدم صحح: الـ walk-in زبون مالوش حساب في التطبيق أصلًا (مفيش محفظة)، فـ CASH ثابت هو الصح فعليًا، مش باج. عملت الفيكس (widget جديد + provider) وبعدين رجعته بالكامل فورًا لما اتصحح. الـ cubit اليتيم اتسيب زي ما هو بقرار من المستخدم (مفيش حاجة بتستخدمه دلوقتي بس مفيش ضرر من سيبه لحد ما يحتاجوه).
- [x] `profile/` — البروفايل والإعدادات
  - اتصلح: `_mapProfile` في `barber_profile_repo.dart` كان `response['data'] as Map` من غير حماية (getProfile/updateLocation/updateServesClients).
  - اتصلح باج حقيقي مؤثر أمنيًا/UX: `BarberProfile.props` كان ناقص `mustChangePassword` و`address`. `mustChangePassword` بالذات بيتحكم في `BlockingGate` جوه `barber_shell.dart` اللي فيه `buildWhen: previous.profile != current.profile` — يعني لو الحلاق غيّر الباسورد بنجاح (اللي بيستدعي `loadProfile()` تاني)، ولو باقي حقول البروفايل متغيرتش، الـ `BlockingGate` كان مش هيعمل rebuild أبدًا لأن Equatable هيعتبر البروفايل القديم والجديد "متساويين" رغم إن `mustChangePassword` اتغيّر من true لـ false. النتيجة: الحلاق يفضل عالق في شاشة "لازم تغيّر الباسورد" حتى بعد ما يغيّره بنجاح، لحد ما يعمل قفل وفتح كامل للتطبيق. اتصلح بإضافة الحقلين للـ props.
  - باقي كل حاجة اتفحصت (الموديل آمن، الكوبيت من غير races، شاشات location/delete-account/serves-clients كلها بتغطي أخطائها بنفسها) سليمة.
- [x] `auth/` — تسجيل الدخول/التسجيل
  - اتصلح: `_persist` في `barber_auth_repo.dart` (تسجيل الدخول) كان `response['data'] as Map` من غير حماية — أهم مسار في التطبيق كله (login).
  - اتصلح باج كبير مؤكد live (اتطبق على الحلاق والتاجر مع بعض بعد قرار المستخدم): تأكيد الـ OTP بعد التسجيل (`/register/verifyOtp`) بيرجع token كامل زي الـ login بالظبط (اتأكد بعمل تسجيل حساب تجريبي حي كامل وتأكيد الـ OTP بتاعه)، لكن الكود كان بيرمي الـ token ده (`Future<Either<Failure, Unit>>` بدل `AuthSession`) وبعدين يودي الحلاق/التاجر لشاشة تسجيل الدخول يكتب نفس بيانات الدخول اللي لسه كاتبها تاني بدل ما يدخله التطبيق على طول زي الـ login بالظبط. اتصلح بتغيير الـ interface/use case لإرجاع `AuthSession` واستخدام نفس `_persist` بتاع الـ login، وتصحيح الـ navigation في `barber_verify_otp_screen.dart`/`merchant_verify_otp_screen.dart` من `context.go(loginScreen)` لـ `context.go(barberShell/merchantShell)`.
  - **تصحيح افتراض غلط في نفس المحادثة**: افترضت الأول (من وصف الـ Postman) إن كل تسجيل جديد بيتسجل دخول فورًا من غير OTP خالص — ده غلط، اتأكد live إن التسجيل الفعلي بيرجع `activated:false` ويطلب OTP حتى لرقم جديد تمامًا في البيئة دي، فوصف الـ Postman مش دقيق 100%. الباج الحقيقي كان بس في تجاهل الـ token بعد التحقق من الـ OTP، مش في مسار التسجيل نفسه.
  - باقي كل حاجة اتفحصت (`forgotPassword`/`resetPassword` flow صح، الفورم validation كامل، الملاحظة الوحيدة إن `identifier` في اللوجن من غير validator بس السيرفر هيرفض القيمة الفاضية أصلًا) سليمة.
- [ ] `home/` + `presentation/` (الـ shell والداشبورد)

---

## 2. الحاجات المحددة اللي لازم تتفحص في كل فولدر (checklist لكل فيتشر)

انسخ الليستة دي وطبّقها على كل فولدر من فوق:

### أ. كراش محتمل (زي كراش الـ API اللي اتصلح للتاجر)
- [ ] كل `response['data'] as Map<String, dynamic>` (أو `as List`) من غير `?` أو fallback — ده بيرمي `TypeError` بدل `Failure` لو السيرفر رجّع شكل غير متوقع.
  - **الحل الجاهز موجود بالفعل**: `core/network/response_guard.dart` (`requireDataMap`) — استخدمه بدل ما تعمل حل جديد. لو الملف مش موجود لسه وقت ما تقرا الملف ده، يبقى اتشال بالغلط — رجّعه.
- [ ] أي `as int`/`as String` (من غير `?`) على حقل جاي من الـ API مباشرة، خصوصًا `id` — لو الحقل غاب أو اتغير نوعه، الكراش بيحصل جوه الـ `fromJson` مش في مكان متوقع.
- [ ] `!` (force unwrap) على نتيجة `image_picker`/`file_picker` أو أي حاجة برا تحكم السيرفر (زي `document_actions.dart` بتاع التاجر اللي كان فيه `picked.path!` من غير ضمان حقيقي إنه مش null).

### ب. Equatable ناقصة حقول
- [ ] لكل `Entity extends Equatable`، قارن `props` بكل الحقول الفعلية في الكلاس. أي حقل بيتغيّر فعليًا (مش بس id/status) ولازم يظهر في الشاشة عند تغييره، لازم يبقى موجود في `props` — وإلا `BlocBuilder` مش هيعمل rebuild لما يتغيّر.
- [ ] ركّز خصوصًا على أي entity فيها حقول زي `unitPrice`/`unitDiscount`/تفاصيل خصم — دي أكتر حاجة بتتنسى.

### ج. Pagination (لو موجود)
- [ ] `loadMore()` عند الفشل: هل بيرجع `status: failure` صح، ولا بيرجع `success` بهدوء وهو فعليًا فشل؟
  - **الحل متطبق فعلًا في 3 كوبيتس تحت barber** (`barber_wallet_requests_cubit.dart`, `broadcast_list_cubit.dart`, `barber_notifications_cubit.dart`) — الشاشات بتاعتهم فيها `BlocConsumer` بيعرض toast للخطأ. تأكد إن نفس النمط ده متطبق في أي شاشة pagination جديدة (لو الحلاق عنده أي pagination تاني معملوش، زي orders/bookings لو كبرت الليستة).

### د. الخصومات والأسعار (نفس فئة باج الحلاق الأصلي اللي بدأنا بيه السيشن)
- [ ] أي مكان بيعرض سعر منتج/خدمة عليها خصم — هل بيوضح إن فيه خصم (سعر أصلي مشطوب + سعر بعد الخصم)، ولا بيرجع سعر الخصم مباشرة من غير ما يبين؟
- [ ] لو فيه BUY_X_GET_Y أو أي خصم مركّب — اختبره حي (curl) وتأكد إن الحساب صح، **متفترضش من قراءة الكود بس**.
- [ ] راجع `discounts/` (فيتشر الحلاق الجديد بتاع خصومات العميل) بالكامل — هل الـ product selector بتاعه بيحمّل المنتجات صح؟ هل فيه cross-cubit staleness زي اللي اتصلح للتاجر (تعديل خصم مايحدّثش سعر المنتج في شاشة تانية)؟

### هـ. الكاش (صور، بيانات)
- [ ] أي `AuthorizedNetworkImage.evict(...)` بعد تعديل صورة — تأكد إن الـ endpoint اللي بيتعمله evict هو **نفسه** اللي بيتعرض فعليًا في الـ thumbnail/gallery (زي باج `merchant/products` اللي كان بيمسح كاش endpoint قديم مش مستخدم).
- [ ] أي cubit مشترك بين شاشتين (زي `BarberStorefrontProductsCubit`) — لو حاجة في شاشة التانية بتأثر على بيانات الأولى، هل فيه `loadX()` بيتنادى تاني ولا الشاشة الأولى بتفضل بالداتا القديمة؟

### و. سباقات الحالة (race conditions) في العمليات المتزامنة
- [ ] أي `removeX(id)`/`deleteX(id)` بياخد snapshot من الليستة كاملة قبل الـ await عشان يرجّعها لو فشلت — لو اتنين عمليات حصلوا في نفس الوقت، هل ممكن نتيجة ناجحة تترجع لحالة قديمة؟ (نفس باج `MerchantProductsCubit.removeProduct` اللي اتصلح).

### ز. حالات نصية (string status) بتتقارن غلط
- [ ] أي `status == 'X'` (مقارنة نص مباشرة) بدل enum حقيقي — لو فيه أكتر من قيمة ممكنة، هل كل قيمة متعاملة صح، ولا كل حاجة "مش X" بتترجم غلط لحالة تانية؟ (نفس باج `PAUSED` اللي كان بيتعرض "نشط" في اشتراك التاجر).

### ح. كود ميت
- [ ] أي mock class أو flag دايمًا `false`/معطّل (زي `MerchantOrdersMock` اللي اتشال من التاجر) — دوّر بـ `grep -rn "mock\|Mock\|TODO\|FIXME"`.
- [ ] أي comment متعلّق (مخالف لقاعدة "no comments" في `CLAUDE.md`) باقي من كود قديم.
- [ ] أي import أو ملف مش متستخدم خالص (`flutter analyze` هيوريهم كـ warnings).

### ط. Navigation/routing
- [ ] كل `context.push(Routes.xxx, extra: ...)` — النوع اللي بيتبعت مطابق فعلًا لـ `state.extra as T` في `app_routes.dart`؟ (الكاست بيحصل جوه الراوت، مفيش compile-time check — نفس باج `dashboard_product_list.dart` اللي كان بيبعت المنتج كامل بدل الـ id بس).

---

## 3. حاجات محددة نعرفها مسبقًا محتاجة تتفحص (من كلام سابق في المحادثات)

- **`barber/discount`** (خصومات الحلاق للعميل) فيتشر جديد كامل اتبنى في آخر سيشن — معملوش عليه أي مراجعة "بعد البناء" لسه. راجعه بنفس عمق مراجعة `merchant/discounts`.
- **صفحة "عملائي" للتاجر** (`merchant/customers`) اتعملها فيكس ديزاين (labels واضحة للأرقام) — تأكد مفيش حاجة مشابهة عند الحلاق (لو فيه شاشة إحصائيات/عملاء بأرقام من غير سياق).
- الحلاق عنده **صفحتين "متجر" منفصلتين تمامًا** (`store/` = شراء من تاجر، `storefront/` = بيع للعميل) — أعلى احتمال لتضارب أسامي كلاسات أو استخدام غلط لـ cubit من التاني بالغلط. راجع الاستيرادات كويس.
- فيه **مرجع API كامل** في `postman/Ayez_ahlaqBarber.postman_collection.json` — **لكنه مش موثوق 100%** (زي ما ثبت مع تسجيل التاجر)، فاي شك في شكل response لازم يتحسم بـ curl حي مش بقراءة الـ collection بس.

---

## 4. حسابات تجربة جاهزة (من نفس المحادثة)

```
barber:   identifier "01008451421", password "123456"
customer: identifier "01555555555", password "cust1234"
merchant: phoneNumber "01001234599", password "secret123"
```

`X-Client: MOBILE` header لازم يتبعت مع أي طلب حلاق.

---

## 5. بعد ما تخلص

- حدّث `BARBER_ROADMAP.md` (الملف الأصلي، مش ده) بنفس الأسلوب اللي اتحدث بيه `MERCHANT_ROADMAP.md` — قسم جديد "مراجعة شاملة" فيه كل باج اتلاقى واتصلح، + قسم "false positives" لأي حاجة الأدوات الآلية قالت عليها باج وطلعت مش كده.
- امسح الملف ده (`BARBER_CODE_REVIEW.md`) بعد ما تدمج نتايجه في `BARBER_ROADMAP.md` — ده ملف خطة عمل مؤقت مش مرجع دايم.
