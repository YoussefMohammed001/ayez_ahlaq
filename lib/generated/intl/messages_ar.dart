// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(limit) =>
      "الفئات العامة بيحددها الأدمن، وتقدر تضيف لحد ${limit} فئات خاصة بيك.";

  static String m1(amount) => "${amount} ج";

  static String m2(days) => "قبل ${days} أيام";

  static String m3(status) => "نقل الحالة لـ \"${status}\"";

  static String m4(count, limit) => "فئاتي (${count}/${limit})";

  static String m5(price, stock, min) =>
      "${price} ج · مخزون ${stock} · حد أدنى ${min}";

  static String m6(name) => "الحلاق المسؤول: ${name}";

  static String m7(count) => "العرض هيبان لـ ${count} صالون";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutApp": MessageLookupByLibrary.simpleMessage("عن التطبيق"),
    "aboutAppBody": MessageLookupByLibrary.simpleMessage(
      "عايز أحلق — منصة بيع بالجملة بتوصّل تجار مستلزمات الحلاقة بالصالونات.",
    ),
    "acceptOrder": MessageLookupByLibrary.simpleMessage("قبول الطلب"),
    "activeProducts": MessageLookupByLibrary.simpleMessage("منتج نشط"),
    "add": MessageLookupByLibrary.simpleMessage("إضافة"),
    "addAction": MessageLookupByLibrary.simpleMessage("+ إضافة"),
    "addPhoneTitle": MessageLookupByLibrary.simpleMessage("رقم جديد"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("إضافة صورة"),
    "addWholesaleProduct": MessageLookupByLibrary.simpleMessage(
      "إضافة منتج للجملة",
    ),
    "address_required": MessageLookupByLibrary.simpleMessage("العنوان مطلوب"),
    "allOrders": MessageLookupByLibrary.simpleMessage("كل الطلبات"),
    "allShops": MessageLookupByLibrary.simpleMessage("كل الصالونات"),
    "already_have_account": MessageLookupByLibrary.simpleMessage(
      "عندك حساب بالفعل؟",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("عايز أحلق"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "arabic_full_name_required": MessageLookupByLibrary.simpleMessage(
      "اكتب الاسم بالكامل بالعربي",
    ),
    "arabic_name_required": MessageLookupByLibrary.simpleMessage(
      "اكتب الاسم بالعربي",
    ),
    "avatarFallback": MessageLookupByLibrary.simpleMessage("؟"),
    "back": MessageLookupByLibrary.simpleMessage("رجوع"),
    "backOnline": MessageLookupByLibrary.simpleMessage("رجع الاتصال"),
    "barber": MessageLookupByLibrary.simpleMessage("حلاق"),
    "barberHint": MessageLookupByLibrary.simpleMessage(
      "إدارة الطابور والمواعيد والأرباح",
    ),
    "barberOrders": MessageLookupByLibrary.simpleMessage("طلبات الحلاقين"),
    "barberOrdersSubtitle": MessageLookupByLibrary.simpleMessage(
      "كل الطلبات اللي وصلتك من الصالونات",
    ),
    "birthdate_does_not_match_national_id":
        MessageLookupByLibrary.simpleMessage(
          "تاريخ الميلاد مش مطابق للرقم القومي:",
        ),
    "brand": MessageLookupByLibrary.simpleMessage("الماركة"),
    "brandHint": MessageLookupByLibrary.simpleMessage("مثلاً: Wahl"),
    "businessName": MessageLookupByLibrary.simpleMessage("اسم النشاط التجاري"),
    "businessNameHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: التوريد الذهبي للمستلزمات",
    ),
    "businessNameRequired": MessageLookupByLibrary.simpleMessage(
      "اكتب اسم النشاط",
    ),
    "businessOwner": MessageLookupByLibrary.simpleMessage("صاحب النشاط"),
    "buyQuantityLabel": MessageLookupByLibrary.simpleMessage("اشتري كام قطعة؟"),
    "camera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "categoriesNote": m0,
    "category": MessageLookupByLibrary.simpleMessage("الفئة"),
    "categoryGlobal": MessageLookupByLibrary.simpleMessage("عام"),
    "categoryImage": MessageLookupByLibrary.simpleMessage("صورة الفئة"),
    "categoryOwn": MessageLookupByLibrary.simpleMessage("بتاعتي"),
    "changePassword": MessageLookupByLibrary.simpleMessage("تغيير كلمة السر"),
    "chooseAccountType": MessageLookupByLibrary.simpleMessage(
      "اختار نوع الحساب اللي هتستخدمه",
    ),
    "chooseCategory": MessageLookupByLibrary.simpleMessage("اختار فئة"),
    "chooseLanguage": MessageLookupByLibrary.simpleMessage("اختار اللغة"),
    "chooseProduct": MessageLookupByLibrary.simpleMessage("اختار المنتج"),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("اختار المظهر"),
    "choose_image_source": MessageLookupByLibrary.simpleMessage(
      "اختار مصدر الصورة",
    ),
    "closeAction": MessageLookupByLibrary.simpleMessage("إقفال"),
    "closeDiscount": MessageLookupByLibrary.simpleMessage("إقفال العرض"),
    "closeDiscountConfirm": MessageLookupByLibrary.simpleMessage(
      "العرض المقفول مينفعش يترجع تاني، متأكد؟",
    ),
    "closedDiscounts": MessageLookupByLibrary.simpleMessage("عروض مقفولة"),
    "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة السر",
    ),
    "confirmReject": MessageLookupByLibrary.simpleMessage("تأكيد الرفض"),
    "confirm_password": MessageLookupByLibrary.simpleMessage("تأكيد كلمة السر"),
    "contact": MessageLookupByLibrary.simpleMessage("التواصل"),
    "contain_number_and_special": MessageLookupByLibrary.simpleMessage(
      "فيها رقم ورمز",
    ),
    "contain_uppercase": MessageLookupByLibrary.simpleMessage("فيها حرف كبير"),
    "could_not_launch": MessageLookupByLibrary.simpleMessage(
      "مش قادر يفتح الرابط",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("إنشاء الحساب"),
    "createDiscount": MessageLookupByLibrary.simpleMessage("إنشاء العرض"),
    "currencyEgp": m1,
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة السر الحالية",
    ),
    "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "اكتب كلمة السر الحالية",
    ),
    "customer": MessageLookupByLibrary.simpleMessage("عميل"),
    "customerHint": MessageLookupByLibrary.simpleMessage(
      "احجز حلاقة واشتري منتجات العناية",
    ),
    "daysAgo": m2,
    "delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("حذف الفئة"),
    "deleteCategoryConfirm": MessageLookupByLibrary.simpleMessage(
      "متأكد إنك عايز تمسح الفئة دي؟",
    ),
    "deletePhone": MessageLookupByLibrary.simpleMessage("حذف الرقم"),
    "deletePhoneConfirm": MessageLookupByLibrary.simpleMessage(
      "متأكد إنك عايز تمسح الرقم ده؟",
    ),
    "deleteProduct": MessageLookupByLibrary.simpleMessage("حذف المنتج"),
    "deleteProductConfirm": MessageLookupByLibrary.simpleMessage(
      "هيتشال من متجر الحلاقين، متأكد؟",
    ),
    "discountClosed": MessageLookupByLibrary.simpleMessage("مقفول"),
    "discountLive": MessageLookupByLibrary.simpleMessage("شغال"),
    "discountName": MessageLookupByLibrary.simpleMessage("اسم العرض"),
    "discountNameHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: عرض الصيف",
    ),
    "discountNameRequired": MessageLookupByLibrary.simpleMessage(
      "اكتب اسم العرض",
    ),
    "discountType": MessageLookupByLibrary.simpleMessage("نوع العرض"),
    "discountValue": MessageLookupByLibrary.simpleMessage("قيمة الخصم"),
    "discountsTitle": MessageLookupByLibrary.simpleMessage("العروض والخصومات"),
    "done": MessageLookupByLibrary.simpleMessage("تم"),
    "dont_have_account": MessageLookupByLibrary.simpleMessage("معندكش حساب؟"),
    "editCategory": MessageLookupByLibrary.simpleMessage("تعديل الفئة"),
    "editDiscount": MessageLookupByLibrary.simpleMessage("تعديل العرض"),
    "editMyInfo": MessageLookupByLibrary.simpleMessage("تعديل بياناتي"),
    "editProduct": MessageLookupByLibrary.simpleMessage("تعديل المنتج"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "emailOptional": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني (اختياري)",
    ),
    "email_invalid": MessageLookupByLibrary.simpleMessage(
      "بريد إلكتروني غير صحيح",
    ),
    "email_required": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني مطلوب",
    ),
    "emptyDefaultTitle": MessageLookupByLibrary.simpleMessage(
      "مفيش حاجة هنا لسه",
    ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enter_password": MessageLookupByLibrary.simpleMessage("اكتب كلمة السر"),
    "errorDefaultTitle": MessageLookupByLibrary.simpleMessage("حصل خطأ"),
    "extraPhones": MessageLookupByLibrary.simpleMessage("أرقام إضافية"),
    "extraPhonesNote": MessageLookupByLibrary.simpleMessage(
      "أرقام تواصل إضافية عشان الصالونات توصلك. رقم الدخول بيغيّره الأدمن.",
    ),
    "featureLockedApproval": MessageLookupByLibrary.simpleMessage(
      "الميزة دي هتشتغل بعد ما حسابك يتفعّل.",
    ),
    "field_required": MessageLookupByLibrary.simpleMessage("الحقل ده مطلوب"),
    "filterAll": MessageLookupByLibrary.simpleMessage("الكل"),
    "fulfilmentDelivery": MessageLookupByLibrary.simpleMessage("توصيل"),
    "fulfilmentPickup": MessageLookupByLibrary.simpleMessage("استلام من المحل"),
    "gallery": MessageLookupByLibrary.simpleMessage("المعرض"),
    "globalCategories": MessageLookupByLibrary.simpleMessage("الفئات العامة"),
    "goToDocuments": MessageLookupByLibrary.simpleMessage("روح للمستندات"),
    "greeting": MessageLookupByLibrary.simpleMessage("صباح الفل،"),
    "instagram_error": MessageLookupByLibrary.simpleMessage(
      "مش قادر يفتح إنستجرام",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("رقم غلط"),
    "invalidPrice": MessageLookupByLibrary.simpleMessage("سعر غلط"),
    "invalid_national_id": MessageLookupByLibrary.simpleMessage(
      "رقم قومي غير صحيح",
    ),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "latestOrders": MessageLookupByLibrary.simpleMessage("أحدث الطلبات"),
    "listSeparator": MessageLookupByLibrary.simpleMessage("، "),
    "liveDiscounts": MessageLookupByLibrary.simpleMessage("عروض شغالة"),
    "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "سجّل دخولك بحساب التاجر عشان تدير منتجاتك وطلباتك",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "متأكد إنك عايز تسجّل خروج؟",
    ),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "management": MessageLookupByLibrary.simpleMessage("الإدارة"),
    "markAllRead": MessageLookupByLibrary.simpleMessage("تعليم الكل كمقروء"),
    "merchant": MessageLookupByLibrary.simpleMessage("تاجر"),
    "merchantDashboardNote": MessageLookupByLibrary.simpleMessage(
      "كل عملاؤك هنا حلاقين وصالونات مسجلة على المنصة — البيع بالجملة بس.",
    ),
    "merchantHint": MessageLookupByLibrary.simpleMessage(
      "بيع مستلزمات الحلاقة بالجملة للصالونات",
    ),
    "message_required": MessageLookupByLibrary.simpleMessage("الرسالة مطلوبة"),
    "message_too_short": MessageLookupByLibrary.simpleMessage("الرسالة قصيرة"),
    "minOrderQty": MessageLookupByLibrary.simpleMessage("الحد الأدنى للطلب"),
    "minOrderTotalLabel": MessageLookupByLibrary.simpleMessage(
      "الحد الأدنى للطلب (جنيه)",
    ),
    "min_8_char": MessageLookupByLibrary.simpleMessage("٨ حروف على الأقل"),
    "missingDocsBody": MessageLookupByLibrary.simpleMessage(
      "ارفع المستندات المطلوبة عشان نفعّل حسابك.",
    ),
    "missingDocsTitle": MessageLookupByLibrary.simpleMessage("مستندات ناقصة"),
    "monthRevenue": MessageLookupByLibrary.simpleMessage("إيرادات الشهر"),
    "moveStatusTo": m3,
    "myCategories": MessageLookupByLibrary.simpleMessage("فئات منتجاتي"),
    "myCategoriesCount": m4,
    "myDocuments": MessageLookupByLibrary.simpleMessage("مستنداتي"),
    "name_invalid_characters": MessageLookupByLibrary.simpleMessage(
      "الاسم فيه حروف غير مسموحة",
    ),
    "name_invalid_spacing": MessageLookupByLibrary.simpleMessage(
      "في مسافات زيادة في الاسم",
    ),
    "name_required": MessageLookupByLibrary.simpleMessage("الاسم مطلوب"),
    "name_too_long": MessageLookupByLibrary.simpleMessage("الاسم طويل"),
    "name_too_short": MessageLookupByLibrary.simpleMessage("الاسم قصير"),
    "national_id_must_be_14_digits": MessageLookupByLibrary.simpleMessage(
      "الرقم القومي لازم يكون ١٤ رقم",
    ),
    "national_id_required": MessageLookupByLibrary.simpleMessage(
      "الرقم القومي مطلوب",
    ),
    "newCategory": MessageLookupByLibrary.simpleMessage("فئة جديدة"),
    "newCategoryHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: عروض النخبة",
    ),
    "newDiscount": MessageLookupByLibrary.simpleMessage("عرض جديد"),
    "newPassword": MessageLookupByLibrary.simpleMessage("كلمة السر الجديدة"),
    "noAccountRegister": MessageLookupByLibrary.simpleMessage(
      "معندكش حساب؟ سجّل تاجر جديد",
    ),
    "noDiscountsYet": MessageLookupByLibrary.simpleMessage("لسه مضفتش عروض"),
    "noExtraPhones": MessageLookupByLibrary.simpleMessage("لسه مضفتش أرقام"),
    "noInternet": MessageLookupByLibrary.simpleMessage("مفيش اتصال بالإنترنت"),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "مفيش اتصال بالإنترنت",
    ),
    "noOrdersYet": MessageLookupByLibrary.simpleMessage("لسه مفيش طلبات"),
    "noOwnCategories": MessageLookupByLibrary.simpleMessage(
      "لسه مضفتش فئات خاصة",
    ),
    "noProductsYet": MessageLookupByLibrary.simpleMessage("لسه مضفتش منتجات"),
    "notNow": MessageLookupByLibrary.simpleMessage("مش دلوقتي"),
    "notifDiscountEndedBody": MessageLookupByLibrary.simpleMessage(
      "عرض \"اشتري ٤ والخامس مجانا\" اتقفل",
    ),
    "notifDiscountEndedTitle": MessageLookupByLibrary.simpleMessage(
      "عرض انتهى",
    ),
    "notifLowStockBody": MessageLookupByLibrary.simpleMessage(
      "زيت لحية طبيعي فاضل منه ٨ قطع",
    ),
    "notifLowStockTitle": MessageLookupByLibrary.simpleMessage(
      "المخزون قرب يخلص",
    ),
    "notifNewOrderBody": MessageLookupByLibrary.simpleMessage(
      "صالون الملك بعتلك طلب بقيمة ٢٨٨٠ ج",
    ),
    "notifNewOrderTitle": MessageLookupByLibrary.simpleMessage("طلب جديد"),
    "notifOrderCancelledBody": MessageLookupByLibrary.simpleMessage(
      "Barber House لغى الطلب #PO-2170",
    ),
    "notifOrderCancelledTitle": MessageLookupByLibrary.simpleMessage(
      "طلب اتلغى",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "notificationsEmpty": MessageLookupByLibrary.simpleMessage("مفيش إشعارات"),
    "notificationsEmptyHint": MessageLookupByLibrary.simpleMessage(
      "الطلبات الجديدة والتحديثات هتظهر هنا",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("حسنًا"),
    "or": MessageLookupByLibrary.simpleMessage("أو"),
    "orderDiscountLabel": MessageLookupByLibrary.simpleMessage("خصم الطلب"),
    "orderTotal": MessageLookupByLibrary.simpleMessage("الإجمالي"),
    "orderedItems": MessageLookupByLibrary.simpleMessage("الأصناف المطلوبة"),
    "ownerName": MessageLookupByLibrary.simpleMessage("اسم صاحب النشاط"),
    "ownerNameHint": MessageLookupByLibrary.simpleMessage("مثلاً: أحمد علي"),
    "ownerNameRequired": MessageLookupByLibrary.simpleMessage("اكتب اسمك"),
    "passport_format_invalid": MessageLookupByLibrary.simpleMessage(
      "صيغة رقم الجواز غير صحيحة",
    ),
    "passport_length_invalid": MessageLookupByLibrary.simpleMessage(
      "طول رقم الجواز غير صحيح",
    ),
    "passport_required": MessageLookupByLibrary.simpleMessage(
      "رقم جواز السفر مطلوب",
    ),
    "password": MessageLookupByLibrary.simpleMessage("كلمة السر"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "تم تغيير كلمة السر",
    ),
    "passwordMatches": MessageLookupByLibrary.simpleMessage(
      "كلمتا السر متطابقتين",
    ),
    "passwordMinHint": MessageLookupByLibrary.simpleMessage("٦ حروف على الأقل"),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "كلمتا السر مش متطابقتين",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage("كلمة السر قصيرة"),
    "pendingApprovalTitle": MessageLookupByLibrary.simpleMessage(
      "حسابك تحت المراجعة",
    ),
    "pendingOrders": MessageLookupByLibrary.simpleMessage("طلبات معلقة"),
    "phoneLabel": MessageLookupByLibrary.simpleMessage("الوصف (اختياري)"),
    "phoneLabelHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: خط المبيعات",
    ),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("رقم الموبايل"),
    "phone_number_cannot_start_with_double_zero":
        MessageLookupByLibrary.simpleMessage("رقم الموبايل مايبدأش بـ 00"),
    "phone_number_is_required": MessageLookupByLibrary.simpleMessage(
      "رقم الموبايل مطلوب",
    ),
    "phone_number_must_contain_only_digits":
        MessageLookupByLibrary.simpleMessage("رقم الموبايل لازم يكون أرقام بس"),
    "pleaseCheckYourConnectionAndTryAgain":
        MessageLookupByLibrary.simpleMessage("اتأكد من الاتصال وحاول تاني"),
    "please_enter_a_valid_phone_number": MessageLookupByLibrary.simpleMessage(
      "اكتب رقم موبايل صحيح",
    ),
    "product": MessageLookupByLibrary.simpleMessage("المنتج"),
    "productDescription": MessageLookupByLibrary.simpleMessage("وصف المنتج"),
    "productDescriptionHint": MessageLookupByLibrary.simpleMessage(
      "اكتب وصف قصير للمنتج ومميزاته للحلاقين",
    ),
    "productFormNote": MessageLookupByLibrary.simpleMessage(
      "المنتج ده هيبان بس في متجر المستلزمات جوه تطبيق الحلاقين، مش لعملاء عاديين.",
    ),
    "productImages": MessageLookupByLibrary.simpleMessage("صور المنتج"),
    "productMetaLine": m5,
    "productName": MessageLookupByLibrary.simpleMessage("اسم المنتج"),
    "productNameHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: وكس تثبيت قوي - عبوة صالونات",
    ),
    "productNameRequired": MessageLookupByLibrary.simpleMessage(
      "اكتب اسم المنتج",
    ),
    "productRequired": MessageLookupByLibrary.simpleMessage("اختار منتج"),
    "productsNote": MessageLookupByLibrary.simpleMessage(
      "اللي بتعرضه هنا بيبان بس للحلاقين في متجر المستلزمات بتاعهم",
    ),
    "publishProduct": MessageLookupByLibrary.simpleMessage("نشر المنتج"),
    "register": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "registerMerchant": MessageLookupByLibrary.simpleMessage("تسجيل تاجر جديد"),
    "registerSubtitle": MessageLookupByLibrary.simpleMessage(
      "سجّل نشاطك التجاري وابدأ تبيع مستلزمات الحلاقة للصالونات بالجملة.",
    ),
    "rejectOrder": MessageLookupByLibrary.simpleMessage("رفض الطلب"),
    "rejectReason": MessageLookupByLibrary.simpleMessage("سبب الرفض"),
    "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: الصنف غير متوفر حاليًا",
    ),
    "remove_leading_zero": MessageLookupByLibrary.simpleMessage(
      "امسح الصفر اللي في الأول",
    ),
    "resend_code": MessageLookupByLibrary.simpleMessage("إعادة إرسال الكود"),
    "responsibleBarber": m6,
    "retry": MessageLookupByLibrary.simpleMessage("حاول تاني"),
    "rewardAmount": MessageLookupByLibrary.simpleMessage("مبلغ ثابت"),
    "rewardFree": MessageLookupByLibrary.simpleMessage("مجانًا"),
    "rewardPercent": MessageLookupByLibrary.simpleMessage("نسبة %"),
    "rewardQuantityLabel": MessageLookupByLibrary.simpleMessage(
      "ياخد كام قطعة؟",
    ),
    "rewardTypeLabel": MessageLookupByLibrary.simpleMessage("نوع المكافأة"),
    "save": MessageLookupByLibrary.simpleMessage("حفظ"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("حفظ التعديلات"),
    "scopeBuyXGetY": MessageLookupByLibrary.simpleMessage("اشتري واحصل على"),
    "scopeBuyXGetYHint": MessageLookupByLibrary.simpleMessage(
      "اشتري كمية معينة وخد قطع مجانًا أو بخصم",
    ),
    "scopeOrderTotal": MessageLookupByLibrary.simpleMessage(
      "خصم على إجمالي الطلب",
    ),
    "scopeOrderTotalHint": MessageLookupByLibrary.simpleMessage(
      "لما الطلب يوصل مبلغ معين، خصم على الطلب كله",
    ),
    "scopeProduct": MessageLookupByLibrary.simpleMessage("خصم على منتج"),
    "scopeProductHint": MessageLookupByLibrary.simpleMessage(
      "نسبة أو مبلغ يتخصم من سعر منتج واحد",
    ),
    "seats": MessageLookupByLibrary.simpleMessage("المقاعد"),
    "shops": MessageLookupByLibrary.simpleMessage("الصالونات"),
    "shopsAllHint": MessageLookupByLibrary.simpleMessage(
      "مختارش حاجة = العرض لكل الصالونات",
    ),
    "shopsAllNote": MessageLookupByLibrary.simpleMessage(
      "العرض هيبان لكل الصالونات",
    ),
    "shopsSelectedHint": m7,
    "signIn": MessageLookupByLibrary.simpleMessage("دخول"),
    "snapchat_error": MessageLookupByLibrary.simpleMessage(
      "مش قادر يفتح سناب شات",
    ),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "حصل خطأ، حاول تاني",
    ),
    "statusAccepted": MessageLookupByLibrary.simpleMessage("اتقبل"),
    "statusCancelled": MessageLookupByLibrary.simpleMessage("ملغي"),
    "statusDelivered": MessageLookupByLibrary.simpleMessage("اتسلم"),
    "statusOutForDelivery": MessageLookupByLibrary.simpleMessage("في الطريق"),
    "statusPending": MessageLookupByLibrary.simpleMessage("في انتظار الرد"),
    "statusPreparing": MessageLookupByLibrary.simpleMessage("جاري التجهيز"),
    "statusReadyForPickup": MessageLookupByLibrary.simpleMessage(
      "جاهز للاستلام",
    ),
    "statusRejected": MessageLookupByLibrary.simpleMessage("مرفوض"),
    "stockQuantity": MessageLookupByLibrary.simpleMessage(
      "الكمية المتاحة في المخزن",
    ),
    "tabAccount": MessageLookupByLibrary.simpleMessage("حسابي"),
    "tabDashboard": MessageLookupByLibrary.simpleMessage("لوحتي"),
    "tabOrders": MessageLookupByLibrary.simpleMessage("الطلبات"),
    "tabProducts": MessageLookupByLibrary.simpleMessage("منتجاتي"),
    "theme": MessageLookupByLibrary.simpleMessage("المظهر"),
    "themeDark": MessageLookupByLibrary.simpleMessage("غامق"),
    "themeLight": MessageLookupByLibrary.simpleMessage("فاتح"),
    "tiktok_error": MessageLookupByLibrary.simpleMessage(
      "مش قادر يفتح تيك توك",
    ),
    "today": MessageLookupByLibrary.simpleMessage("النهاردة"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("حاول تاني"),
    "twitter_error": MessageLookupByLibrary.simpleMessage("مش قادر يفتح X"),
    "underDevelopment": MessageLookupByLibrary.simpleMessage(
      "التطبيق ده لسه تحت التطوير",
    ),
    "underReview": MessageLookupByLibrary.simpleMessage("تحت المراجعة"),
    "unitPrice": MessageLookupByLibrary.simpleMessage("سعر الوحدة (جنيه)"),
    "update": MessageLookupByLibrary.simpleMessage("تحديث"),
    "updateRequired": MessageLookupByLibrary.simpleMessage("لازم تحديث"),
    "updateRequiredBody": MessageLookupByLibrary.simpleMessage(
      "في نسخة جديدة من التطبيق، حدّثها عشان تكمل.",
    ),
    "vehicleType": MessageLookupByLibrary.simpleMessage("نوع المركبة"),
    "verifiedMerchant": MessageLookupByLibrary.simpleMessage("حساب تاجر موثّق"),
    "version": MessageLookupByLibrary.simpleMessage("الإصدار"),
    "weak_password": MessageLookupByLibrary.simpleMessage("كلمة السر ضعيفة"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("أهلاً بيك 👋"),
    "welcome_message": MessageLookupByLibrary.simpleMessage("أهلاً بيك"),
    "whatsapp_error": MessageLookupByLibrary.simpleMessage(
      "مش قادر يفتح واتساب",
    ),
    "wholesaleSupplier": MessageLookupByLibrary.simpleMessage(
      "توريد مستلزمات حلاقة بالجملة",
    ),
    "yesterday": MessageLookupByLibrary.simpleMessage("أمبارح"),
    "your_session_has_been_expired": MessageLookupByLibrary.simpleMessage(
      "انتهت الجلسة، سجّل دخول تاني",
    ),
  };
}
