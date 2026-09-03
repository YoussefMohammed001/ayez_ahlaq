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

  static String m3(size) => "الملف كبير أوي — أقصى حجم ${size} ميجا";

  static String m4(count) => "لسه ناقص ${count} مستندات مطلوبة";

  static String m5(size) =>
      "الأدمن هو اللي بيحدد المستندات المطلوبة. ارفع صورة أو ملف PDF لكل واحد، أقصى حجم ${size} ميجا.";

  static String m6(uploaded, total) => "اترفع ${uploaded} من ${total}";

  static String m7(clients) => "${clients} عميل";

  static String m8(status) => "تغيير الحالة إلى \"${status}\"";

  static String m9(count, limit) => "فئاتي (${count}/${limit})";

  static String m10(price, stock, min) =>
      "${price} ج · مخزون ${stock} · حد أدنى ${min}";

  static String m11(rank) => "الترتيب #${rank}";

  static String m12(name) => "الحلاق المسؤول: ${name}";

  static String m13(count) => "${count} تقييم";

  static String m14(price, duration) => "${price} جنيه · ${duration} دقيقة";

  static String m15(count) => "العرض هيبان لـ ${count} صالون";

  static String m16(count) => "${count} قطعة";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutApp": MessageLookupByLibrary.simpleMessage("عن التطبيق"),
    "aboutAppBody": MessageLookupByLibrary.simpleMessage(
      "عايز أحلق — منصة بيع بالجملة بتوصّل تجار مستلزمات الحلاقة بالصالونات.",
    ),
    "acceptOrder": MessageLookupByLibrary.simpleMessage("قبول الطلب"),
    "accountSection": MessageLookupByLibrary.simpleMessage("الحساب"),
    "activateMemberConfirm": MessageLookupByLibrary.simpleMessage(
      "السماح لهذا العضو بتسجيل الدخول مرة أخرى؟",
    ),
    "activateMemberTitle": MessageLookupByLibrary.simpleMessage(
      "إعادة تفعيل العضو",
    ),
    "activeDiscount": MessageLookupByLibrary.simpleMessage("عرض شغال"),
    "activeLabel": MessageLookupByLibrary.simpleMessage("نشط"),
    "activeOrders": MessageLookupByLibrary.simpleMessage("طلبات جارية"),
    "activeProducts": MessageLookupByLibrary.simpleMessage("منتجات نشطة"),
    "add": MessageLookupByLibrary.simpleMessage("إضافة"),
    "addAction": MessageLookupByLibrary.simpleMessage("+ إضافة"),
    "addMemberTitle": MessageLookupByLibrary.simpleMessage("إضافة عضو فريق"),
    "addPhoneTitle": MessageLookupByLibrary.simpleMessage("رقم جديد"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("إضافة صورة"),
    "addServiceTitle": MessageLookupByLibrary.simpleMessage("إضافة خدمة"),
    "addStorefrontProduct": MessageLookupByLibrary.simpleMessage("إضافة منتج"),
    "addWalkInAction": MessageLookupByLibrary.simpleMessage("إضافة العميل"),
    "addWalkInTitle": MessageLookupByLibrary.simpleMessage(
      "إضافة عميل حضر مباشرة",
    ),
    "addWholesaleProduct": MessageLookupByLibrary.simpleMessage(
      "إضافة منتج للجملة",
    ),
    "addonsLabel": MessageLookupByLibrary.simpleMessage("الإضافات"),
    "addressHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: شارع عباس العقاد، مدينة نصر",
    ),
    "addressLabel": MessageLookupByLibrary.simpleMessage("العنوان"),
    "address_required": MessageLookupByLibrary.simpleMessage("العنوان مطلوب"),
    "allOrders": MessageLookupByLibrary.simpleMessage("كل الطلبات"),
    "allShops": MessageLookupByLibrary.simpleMessage("كل الصالونات"),
    "alreadyHaveAccountLogin": MessageLookupByLibrary.simpleMessage(
      "عندك حساب بالفعل؟ سجّل دخول",
    ),
    "already_have_account": MessageLookupByLibrary.simpleMessage(
      "عندك حساب بالفعل؟",
    ),
    "amountAboveTotal": MessageLookupByLibrary.simpleMessage(
      "المبلغ لازم يكون أقل من قيمة الطلب",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("عايز أحلق"),
    "appSettings": MessageLookupByLibrary.simpleMessage("إعدادات التطبيق"),
    "appTagline": MessageLookupByLibrary.simpleMessage("حلاقتك على مزاجك"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "arabic_full_name_required": MessageLookupByLibrary.simpleMessage(
      "اكتب الاسم بالكامل بالعربي",
    ),
    "arabic_name_required": MessageLookupByLibrary.simpleMessage(
      "اكتب الاسم بالعربي",
    ),
    "availabilityLabel": MessageLookupByLibrary.simpleMessage("متاح للحجز"),
    "avatarFallback": MessageLookupByLibrary.simpleMessage("؟"),
    "avgTicketLabel": MessageLookupByLibrary.simpleMessage("متوسط الفاتورة"),
    "back": MessageLookupByLibrary.simpleMessage("رجوع"),
    "backOnline": MessageLookupByLibrary.simpleMessage("رجع الاتصال بالإنترنت"),
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
    "blockMemberConfirm": MessageLookupByLibrary.simpleMessage(
      "لن يتمكن هذا العضو من تسجيل الدخول بعد الآن. هل تريد المتابعة؟",
    ),
    "blockMemberTitle": MessageLookupByLibrary.simpleMessage("حظر العضو"),
    "blockedLabel": MessageLookupByLibrary.simpleMessage("محظور"),
    "bookingDateLabel": MessageLookupByLibrary.simpleMessage("التاريخ والوقت"),
    "bookingDetailsTitle": MessageLookupByLibrary.simpleMessage("تفاصيل الحجز"),
    "bookingStatusActive": MessageLookupByLibrary.simpleMessage("جاري الآن"),
    "bookingStatusCancelled": MessageLookupByLibrary.simpleMessage("ملغي"),
    "bookingStatusConfirmed": MessageLookupByLibrary.simpleMessage(
      "تم التأكيد",
    ),
    "bookingStatusDone": MessageLookupByLibrary.simpleMessage("منتهي"),
    "bookingStatusNext": MessageLookupByLibrary.simpleMessage("التالي"),
    "bookingStatusNoShow": MessageLookupByLibrary.simpleMessage("لم يحضر"),
    "bookingStatusPending": MessageLookupByLibrary.simpleMessage(
      "بانتظار الموافقة",
    ),
    "bookingStatusRejected": MessageLookupByLibrary.simpleMessage("مرفوض"),
    "bookingStatusUpcoming": MessageLookupByLibrary.simpleMessage("قادم"),
    "bookingsPendingTab": MessageLookupByLibrary.simpleMessage(
      "بانتظار الموافقة",
    ),
    "bookingsQueueTab": MessageLookupByLibrary.simpleMessage("طابور اليوم"),
    "bookingsTitle": MessageLookupByLibrary.simpleMessage("الحجوزات"),
    "brand": MessageLookupByLibrary.simpleMessage("الماركة"),
    "brandHint": MessageLookupByLibrary.simpleMessage("مثلاً: Wahl"),
    "businessName": MessageLookupByLibrary.simpleMessage("اسم النشاط التجاري"),
    "businessNameHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: التوريد الذهبي للمستلزمات",
    ),
    "businessNameRequired": MessageLookupByLibrary.simpleMessage(
      "اكتب اسم النشاط التجاري",
    ),
    "businessOwner": MessageLookupByLibrary.simpleMessage("صاحب النشاط"),
    "buyQuantityLabel": MessageLookupByLibrary.simpleMessage("اشتري كام قطعة؟"),
    "buySupplies": MessageLookupByLibrary.simpleMessage("المتجر"),
    "camera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cancelOrder": MessageLookupByLibrary.simpleMessage("إلغاء الطلب"),
    "cartEmpty": MessageLookupByLibrary.simpleMessage("سلتك فارغة"),
    "cartTitle": MessageLookupByLibrary.simpleMessage("السلة"),
    "categoriesNote": m0,
    "category": MessageLookupByLibrary.simpleMessage("الفئة"),
    "categoryGlobal": MessageLookupByLibrary.simpleMessage("عام"),
    "categoryImage": MessageLookupByLibrary.simpleMessage("صورة الفئة"),
    "categoryOwn": MessageLookupByLibrary.simpleMessage("خاصة"),
    "changePassword": MessageLookupByLibrary.simpleMessage("تغيير كلمة السر"),
    "chooseAccountType": MessageLookupByLibrary.simpleMessage(
      "اختار نوع الحساب اللي هتستخدمه",
    ),
    "chooseCategory": MessageLookupByLibrary.simpleMessage("اختار فئة"),
    "chooseLanguage": MessageLookupByLibrary.simpleMessage("اختار اللغة"),
    "chooseProduct": MessageLookupByLibrary.simpleMessage("اختار المنتج"),
    "chooseService": MessageLookupByLibrary.simpleMessage("اختار الخدمة"),
    "chooseTeamMember": MessageLookupByLibrary.simpleMessage(
      "اختار عضو الفريق",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("اختار المظهر"),
    "chooseUploadSource": MessageLookupByLibrary.simpleMessage(
      "اختار مصدر الملف",
    ),
    "choose_image_source": MessageLookupByLibrary.simpleMessage(
      "اختار مصدر الصورة",
    ),
    "clientsThisMonthLabel": MessageLookupByLibrary.simpleMessage("هذا الشهر"),
    "clientsTodayLabel": MessageLookupByLibrary.simpleMessage("اليوم"),
    "closeAction": MessageLookupByLibrary.simpleMessage("إيقاف"),
    "closeDiscount": MessageLookupByLibrary.simpleMessage("إيقاف العرض"),
    "closeDiscountConfirm": MessageLookupByLibrary.simpleMessage(
      "بعد إيقاف العرض مش هتقدر ترجّعه تاني. متأكد؟",
    ),
    "closeTimeLabel": MessageLookupByLibrary.simpleMessage("لحد"),
    "closedDiscounts": MessageLookupByLibrary.simpleMessage("عروض منتهية"),
    "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "confirmBooking": MessageLookupByLibrary.simpleMessage("تأكيد الحجز"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة السر",
    ),
    "confirmReject": MessageLookupByLibrary.simpleMessage("تأكيد الرفض"),
    "confirm_password": MessageLookupByLibrary.simpleMessage("تأكيد كلمة السر"),
    "contact": MessageLookupByLibrary.simpleMessage("التواصل"),
    "contain_number_and_special": MessageLookupByLibrary.simpleMessage(
      "رقم ورمز واحد على الأقل",
    ),
    "contain_uppercase": MessageLookupByLibrary.simpleMessage(
      "حرف كبير واحد على الأقل",
    ),
    "could_not_launch": MessageLookupByLibrary.simpleMessage(
      "مش قادر أفتح الرابط",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("إنشاء الحساب"),
    "createDiscount": MessageLookupByLibrary.simpleMessage("إنشاء العرض"),
    "createMerchantAccount": MessageLookupByLibrary.simpleMessage(
      "اعمل حساب تاجر",
    ),
    "currencyEgp": m1,
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة السر الحالية",
    ),
    "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "اكتب كلمة السر الحالية",
    ),
    "customer": MessageLookupByLibrary.simpleMessage("عميل"),
    "customerHint": MessageLookupByLibrary.simpleMessage(
      "احجز حلاقتك واشتري منتجات العناية",
    ),
    "customerLabel": MessageLookupByLibrary.simpleMessage("العميل"),
    "customerPhoneLabel": MessageLookupByLibrary.simpleMessage("رقم العميل"),
    "dailyBreakdownTitle": MessageLookupByLibrary.simpleMessage("آخر 7 أيام"),
    "dayFriday": MessageLookupByLibrary.simpleMessage("الجمعة"),
    "dayMonday": MessageLookupByLibrary.simpleMessage("الإتنين"),
    "daySaturday": MessageLookupByLibrary.simpleMessage("السبت"),
    "daySunday": MessageLookupByLibrary.simpleMessage("الحد"),
    "dayThursday": MessageLookupByLibrary.simpleMessage("الخميس"),
    "dayTuesday": MessageLookupByLibrary.simpleMessage("التلات"),
    "dayWednesday": MessageLookupByLibrary.simpleMessage("الأربع"),
    "daysAgo": m2,
    "decisionDeadlineLabel": MessageLookupByLibrary.simpleMessage(
      "آخر موعد للرد",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("حذف الفئة"),
    "deleteCategoryConfirm": MessageLookupByLibrary.simpleMessage(
      "متأكد إنك عايز تحذف الفئة دي؟",
    ),
    "deleteDocument": MessageLookupByLibrary.simpleMessage("امسح الملف"),
    "deleteDocumentConfirm": MessageLookupByLibrary.simpleMessage(
      "متأكد إنك عايز تمسح الملف ده؟ تقدر ترفعه تاني بعدين.",
    ),
    "deletePhone": MessageLookupByLibrary.simpleMessage("حذف الرقم"),
    "deletePhoneConfirm": MessageLookupByLibrary.simpleMessage(
      "متأكد إنك عايز تحذف الرقم ده؟",
    ),
    "deleteProduct": MessageLookupByLibrary.simpleMessage("حذف المنتج"),
    "deleteProductConfirm": MessageLookupByLibrary.simpleMessage(
      "المنتج هيتشال من متجر الحلاقين. متأكد؟",
    ),
    "deleteStorefrontProductConfirm": MessageLookupByLibrary.simpleMessage(
      "هيتشال من متجرك. متأكد؟",
    ),
    "deliveredThisMonth": MessageLookupByLibrary.simpleMessage(
      "اتسلّم الشهر ده",
    ),
    "deliveryFeeHint": MessageLookupByLibrary.simpleMessage("مثال: 25"),
    "deliveryFeeLabel": MessageLookupByLibrary.simpleMessage("رسم التوصيل"),
    "deliveryFeeOrderLabel": MessageLookupByLibrary.simpleMessage(
      "رسم التوصيل",
    ),
    "deliveryFeeRequired": MessageLookupByLibrary.simpleMessage(
      "اكتب رسم التوصيل",
    ),
    "deliveryFreeOverHint": MessageLookupByLibrary.simpleMessage(
      "اتركه فاضي لو مفيش توصيل مجاني",
    ),
    "deliveryFreeOverLabel": MessageLookupByLibrary.simpleMessage(
      "توصيل مجاني فوق",
    ),
    "deliveryFreeOverNote": MessageLookupByLibrary.simpleMessage(
      "لو إجمالي البضاعة وصل المبلغ ده، التوصيل يبقى مجاني.",
    ),
    "deliveryNote": MessageLookupByLibrary.simpleMessage(
      "لما تشغّل التوصيل، الصالون يقدر يطلب توصيل وبيتضاف رسم التوصيل على إجمالي الطلب. لو قفلته، الاستلام من المحل بس.",
    ),
    "deliveryOffLabel": MessageLookupByLibrary.simpleMessage(
      "التوصيل مقفول — استلام من المحل بس",
    ),
    "deliveryOffered": MessageLookupByLibrary.simpleMessage("بوفّر توصيل"),
    "deliverySaved": MessageLookupByLibrary.simpleMessage(
      "تم حفظ إعدادات التوصيل",
    ),
    "deliveryTitle": MessageLookupByLibrary.simpleMessage("التوصيل"),
    "discountClosed": MessageLookupByLibrary.simpleMessage("متوقف"),
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
    "discountedProducts": MessageLookupByLibrary.simpleMessage(
      "منتجات عليها خصم",
    ),
    "discountsTitle": MessageLookupByLibrary.simpleMessage("العروض والخصومات"),
    "documentAddedByAdmin": MessageLookupByLibrary.simpleMessage(
      "مرفوع من الأدمن",
    ),
    "documentDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "تم مسح الملف",
    ),
    "documentLoadFailed": MessageLookupByLibrary.simpleMessage(
      "مش قادر يفتح الملف",
    ),
    "documentNotUploadedYet": MessageLookupByLibrary.simpleMessage(
      "لسه مترفعش",
    ),
    "documentOptional": MessageLookupByLibrary.simpleMessage("اختياري"),
    "documentRequired": MessageLookupByLibrary.simpleMessage("مطلوب"),
    "documentTooLarge": m3,
    "documentUnsupportedType": MessageLookupByLibrary.simpleMessage(
      "الملفات المسموحة صور أو PDF بس",
    ),
    "documentUploaded": MessageLookupByLibrary.simpleMessage("مرفوع"),
    "documentUploadedSuccess": MessageLookupByLibrary.simpleMessage(
      "تم رفع الملف",
    ),
    "documentsAllUploaded": MessageLookupByLibrary.simpleMessage(
      "كل المستندات المطلوبة اترفعت",
    ),
    "documentsBlockedHeadline": MessageLookupByLibrary.simpleMessage(
      "ارفع مستنداتك عشان تكمّل",
    ),
    "documentsBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "الأدمن محتاج الملفات دي قبل ما تقدر تستخدم التطبيق. أول ما ترفعها هيتفتح كل حاجة على طول.",
    ),
    "documentsBlockedTitle": MessageLookupByLibrary.simpleMessage(
      "مستندات مطلوبة",
    ),
    "documentsMissingRequired": m4,
    "documentsNote": m5,
    "documentsOptionalMessage": MessageLookupByLibrary.simpleMessage(
      "اختيارية — ارفعها في أي وقت",
    ),
    "documentsOptionalTitle": MessageLookupByLibrary.simpleMessage(
      "مستندات تقدر تضيفها",
    ),
    "documentsPendingReview": MessageLookupByLibrary.simpleMessage(
      "حسابك تحت المراجعة لحد ما الأدمن يوافق على مستنداتك.",
    ),
    "documentsProgress": m6,
    "documentsRequestedMessage": MessageLookupByLibrary.simpleMessage(
      "الأدمن مستني منك ترفع ملفات",
    ),
    "documentsRequestedTitle": MessageLookupByLibrary.simpleMessage(
      "مستندات مطلوبة منك",
    ),
    "done": MessageLookupByLibrary.simpleMessage("تم"),
    "dont_have_account": MessageLookupByLibrary.simpleMessage("معندكش حساب؟"),
    "earningsClientsLine": m7,
    "earningsLast7Days": MessageLookupByLibrary.simpleMessage("آخر 7 أيام"),
    "earningsThisMonth": MessageLookupByLibrary.simpleMessage("هذا الشهر"),
    "earningsTitle": MessageLookupByLibrary.simpleMessage("الأرباح"),
    "earningsToday": MessageLookupByLibrary.simpleMessage("اليوم"),
    "editCategory": MessageLookupByLibrary.simpleMessage("تعديل الفئة"),
    "editDiscount": MessageLookupByLibrary.simpleMessage("تعديل العرض"),
    "editMemberTitle": MessageLookupByLibrary.simpleMessage("تعديل العضو"),
    "editMyInfo": MessageLookupByLibrary.simpleMessage("تعديل بياناتي"),
    "editProduct": MessageLookupByLibrary.simpleMessage("تعديل المنتج"),
    "editServiceTitle": MessageLookupByLibrary.simpleMessage("تعديل الخدمة"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "emailOptional": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني (اختياري)",
    ),
    "email_invalid": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني غير صحيح",
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
    "everythingFine": MessageLookupByLibrary.simpleMessage(
      "كل حاجة تمام، مفيش حاجة محتاجة تصرف",
    ),
    "extraPhones": MessageLookupByLibrary.simpleMessage("أرقام إضافية"),
    "extraPhonesNote": MessageLookupByLibrary.simpleMessage(
      "أرقام تواصل إضافية عشان الصالونات تقدر توصلك. رقم الدخول بيغيّره الأدمن.",
    ),
    "featureLockedApproval": MessageLookupByLibrary.simpleMessage(
      "الميزة دي هتشتغل بعد تفعيل حسابك.",
    ),
    "field_required": MessageLookupByLibrary.simpleMessage("الخانة دي مطلوبة"),
    "filesSource": MessageLookupByLibrary.simpleMessage("الملفات"),
    "filterAll": MessageLookupByLibrary.simpleMessage("الكل"),
    "freeDelivery": MessageLookupByLibrary.simpleMessage("مجاني"),
    "fulfilmentDelivery": MessageLookupByLibrary.simpleMessage("توصيل"),
    "fulfilmentPickup": MessageLookupByLibrary.simpleMessage("استلام من المحل"),
    "fulfilmentTitle": MessageLookupByLibrary.simpleMessage("طريقة الاستلام"),
    "gallery": MessageLookupByLibrary.simpleMessage("المعرض"),
    "globalCategories": MessageLookupByLibrary.simpleMessage("الفئات العامة"),
    "goToDocuments": MessageLookupByLibrary.simpleMessage("روح للمستندات"),
    "grandTotalLabel": MessageLookupByLibrary.simpleMessage(
      "الإجمالي شامل التوصيل",
    ),
    "greeting": MessageLookupByLibrary.simpleMessage("صباح الفل،"),
    "homeAllClear": MessageLookupByLibrary.simpleMessage(
      "مفيش حجوزات بانتظار الموافقة",
    ),
    "homeNeedsAttentionTitle": MessageLookupByLibrary.simpleMessage(
      "محتاج ردّك",
    ),
    "homeNoQueueToday": MessageLookupByLibrary.simpleMessage(
      "مفيش حجوزات في الطابور النهاردة",
    ),
    "hoursSaved": MessageLookupByLibrary.simpleMessage("اتحفظت مواعيد العمل"),
    "identityLockedAction": MessageLookupByLibrary.simpleMessage(
      "مش هتقدر تغيّر الاسم ولا اسم النشاط بعد تفعيل الحساب",
    ),
    "identityLockedMessage": MessageLookupByLibrary.simpleMessage(
      "بعد ما حسابك اتفعّل، مش هتقدر تغيّر اسمك ولا اسم النشاط التجاري. كلّم الدعم لو محتاج تعدّلهم.",
    ),
    "identityLockedTitle": MessageLookupByLibrary.simpleMessage(
      "بياناتك موثّقة",
    ),
    "inStock": MessageLookupByLibrary.simpleMessage("متوفر"),
    "inactiveProducts": MessageLookupByLibrary.simpleMessage("منتجات موقوفة"),
    "instagram_error": MessageLookupByLibrary.simpleMessage(
      "مش قادر أفتح إنستجرام",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("اكتب رقم صحيح"),
    "invalidPrice": MessageLookupByLibrary.simpleMessage("اكتب سعر صحيح"),
    "invalid_national_id": MessageLookupByLibrary.simpleMessage(
      "الرقم القومي غير صحيح",
    ),
    "inventoryTitle": MessageLookupByLibrary.simpleMessage("المخزن"),
    "inviteFavoritesLabel": MessageLookupByLibrary.simpleMessage(
      "عملاء من خلال الرابط ده",
    ),
    "inviteLinkCopied": MessageLookupByLibrary.simpleMessage("اتنسخ الرابط"),
    "inviteNote": MessageLookupByLibrary.simpleMessage(
      "شارك الرابط ده مع العملاء — أي حد يدخل من خلاله بيتضاف كمفضّل عندك أوتوماتيك.",
    ),
    "inviteRegenerated": MessageLookupByLibrary.simpleMessage(
      "اتعمل رابط جديد",
    ),
    "inviteTitle": MessageLookupByLibrary.simpleMessage("رابط الدعوة"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "latestOrders": MessageLookupByLibrary.simpleMessage("أحدث الطلبات"),
    "listSeparator": MessageLookupByLibrary.simpleMessage("، "),
    "liveDiscounts": MessageLookupByLibrary.simpleMessage("عروض شغالة"),
    "locationNote": MessageLookupByLibrary.simpleMessage(
      "حدّد موقع محلك عشان العملاء يقدروا يلاقوك ويشوفوا المسافة بدقة.",
    ),
    "locationPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "محتاجين إذن الوصول للموقع",
    ),
    "locationSaved": MessageLookupByLibrary.simpleMessage("اتحفظ الموقع"),
    "locationServiceDisabled": MessageLookupByLibrary.simpleMessage(
      "فعّل خدمة الموقع من إعدادات الجهاز",
    ),
    "locationTitle": MessageLookupByLibrary.simpleMessage("موقع المحل"),
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
    "markAllRead": MessageLookupByLibrary.simpleMessage("تحديد الكل كمقروء"),
    "memberActivated": MessageLookupByLibrary.simpleMessage(
      "تم إعادة تفعيل العضو",
    ),
    "memberAdded": MessageLookupByLibrary.simpleMessage("تمت إضافة عضو الفريق"),
    "memberBlocked": MessageLookupByLibrary.simpleMessage("تم حظر العضو"),
    "memberDetailTitle": MessageLookupByLibrary.simpleMessage("عضو الفريق"),
    "memberHoursTitle": MessageLookupByLibrary.simpleMessage("مواعيد العمل"),
    "memberNameHint": MessageLookupByLibrary.simpleMessage("مثال: كريم"),
    "memberNameLabel": MessageLookupByLibrary.simpleMessage("الاسم"),
    "memberPhoneHint": MessageLookupByLibrary.simpleMessage(
      "مثال: 01111111111",
    ),
    "memberPhoneLabel": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "memberSaved": MessageLookupByLibrary.simpleMessage("تم حفظ بيانات العضو"),
    "memberServicesTitle": MessageLookupByLibrary.simpleMessage("الخدمات"),
    "memberTaglineHint": MessageLookupByLibrary.simpleMessage("اختياري"),
    "memberTaglineLabel": MessageLookupByLibrary.simpleMessage("الوصف"),
    "memberTaglineOptionalLabel": MessageLookupByLibrary.simpleMessage(
      "الوصف (اختياري)",
    ),
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
    "moreSection": MessageLookupByLibrary.simpleMessage("أخرى"),
    "moveStatusTo": m8,
    "myCategories": MessageLookupByLibrary.simpleMessage("فئات منتجاتي"),
    "myCategoriesCount": m9,
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
    "needsAttention": MessageLookupByLibrary.simpleMessage("محتاج منك تصرف"),
    "netThisMonthLabel": MessageLookupByLibrary.simpleMessage(
      "الصافي هذا الشهر",
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
    "noDiscountsYet": MessageLookupByLibrary.simpleMessage("لسه مفيش عروض"),
    "noDocuments": MessageLookupByLibrary.simpleMessage("مفيش مستندات مطلوبة"),
    "noDocumentsMessage": MessageLookupByLibrary.simpleMessage(
      "الأدمن لسه مطلبش منك أي مستندات.",
    ),
    "noExtraPhones": MessageLookupByLibrary.simpleMessage(
      "لسه مفيش أرقام إضافية",
    ),
    "noInternet": MessageLookupByLibrary.simpleMessage("مفيش اتصال بالإنترنت"),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "مفيش اتصال بالإنترنت",
    ),
    "noMerchantsYet": MessageLookupByLibrary.simpleMessage(
      "لا يوجد موردين متاحين حاليًا",
    ),
    "noOrdersYet": MessageLookupByLibrary.simpleMessage("لسه مفيش طلبات"),
    "noOwnCategories": MessageLookupByLibrary.simpleMessage(
      "لسه مفيش فئات خاصة",
    ),
    "noPendingBookings": MessageLookupByLibrary.simpleMessage(
      "لا توجد حجوزات بانتظار الموافقة",
    ),
    "noProductsYet": MessageLookupByLibrary.simpleMessage("لسه مفيش منتجات"),
    "noReviewsYet": MessageLookupByLibrary.simpleMessage("لسه مفيش تقييمات"),
    "noTeamMembersYet": MessageLookupByLibrary.simpleMessage(
      "لا يوجد أعضاء في الفريق بعد",
    ),
    "noWalletTransactions": MessageLookupByLibrary.simpleMessage(
      "لسه مفيش عمليات",
    ),
    "notNow": MessageLookupByLibrary.simpleMessage("مش دلوقتي"),
    "notifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "notificationsEmpty": MessageLookupByLibrary.simpleMessage("مفيش إشعارات"),
    "notificationsEmptyHint": MessageLookupByLibrary.simpleMessage(
      "الطلبات الجديدة والتحديثات هتظهر هنا",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("تمام"),
    "openTimeLabel": MessageLookupByLibrary.simpleMessage("من"),
    "or": MessageLookupByLibrary.simpleMessage("أو"),
    "orderDiscountLabel": MessageLookupByLibrary.simpleMessage("خصم الطلب"),
    "orderNoteHint": MessageLookupByLibrary.simpleMessage("أضف ملاحظة للمورد"),
    "orderNoteTitle": MessageLookupByLibrary.simpleMessage("ملاحظة (اختياري)"),
    "orderPlaced": MessageLookupByLibrary.simpleMessage("تم إرسال الطلب"),
    "orderTotal": MessageLookupByLibrary.simpleMessage("إجمالي الطلب"),
    "orderedItems": MessageLookupByLibrary.simpleMessage("الأصناف المطلوبة"),
    "outOfStock": MessageLookupByLibrary.simpleMessage("خلص من المخزن"),
    "outOfStockProducts": MessageLookupByLibrary.simpleMessage("منتجات خلصت"),
    "outOfStockShort": MessageLookupByLibrary.simpleMessage("خلصت"),
    "overviewTitle": MessageLookupByLibrary.simpleMessage("نظرة سريعة"),
    "ownerLabel": MessageLookupByLibrary.simpleMessage("المالك"),
    "ownerName": MessageLookupByLibrary.simpleMessage("اسم صاحب النشاط"),
    "ownerNameHint": MessageLookupByLibrary.simpleMessage("مثلاً: أحمد علي"),
    "ownerNameRequired": MessageLookupByLibrary.simpleMessage(
      "اكتب اسم صاحب النشاط",
    ),
    "passport_format_invalid": MessageLookupByLibrary.simpleMessage(
      "صيغة رقم جواز السفر غير صحيحة",
    ),
    "passport_length_invalid": MessageLookupByLibrary.simpleMessage(
      "طول رقم جواز السفر غير صحيح",
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
    "passwordResetSuccess": MessageLookupByLibrary.simpleMessage(
      "تم إعادة تعيين كلمة المرور",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage("كلمة السر قصيرة"),
    "paymentMethodLabel": MessageLookupByLibrary.simpleMessage("طريقة الدفع"),
    "pendingApprovalTitle": MessageLookupByLibrary.simpleMessage(
      "حسابك تحت المراجعة",
    ),
    "pendingOrders": MessageLookupByLibrary.simpleMessage("طلبات معلقة"),
    "percentAboveMax": MessageLookupByLibrary.simpleMessage(
      "النسبة مينفعش تزيد عن ١٠٠٪",
    ),
    "phoneLabel": MessageLookupByLibrary.simpleMessage("الوصف (اختياري)"),
    "phoneLabelHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: خط المبيعات",
    ),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("رقم الموبايل"),
    "phone_number_cannot_start_with_double_zero":
        MessageLookupByLibrary.simpleMessage("رقم الموبايل مينفعش يبدأ بـ 00"),
    "phone_number_is_required": MessageLookupByLibrary.simpleMessage(
      "رقم الموبايل مطلوب",
    ),
    "phone_number_must_contain_only_digits":
        MessageLookupByLibrary.simpleMessage("رقم الموبايل لازم يكون أرقام بس"),
    "placeOrder": MessageLookupByLibrary.simpleMessage("إرسال الطلب"),
    "pleaseCheckYourConnectionAndTryAgain":
        MessageLookupByLibrary.simpleMessage(
          "اتأكد من اتصالك بالإنترنت وحاول تاني",
        ),
    "please_enter_a_valid_phone_number": MessageLookupByLibrary.simpleMessage(
      "اكتب رقم موبايل صحيح",
    ),
    "product": MessageLookupByLibrary.simpleMessage("المنتج"),
    "productDescription": MessageLookupByLibrary.simpleMessage("وصف المنتج"),
    "productDescriptionHint": MessageLookupByLibrary.simpleMessage(
      "اكتب وصف مختصر للمنتج ومميزاته للحلاقين",
    ),
    "productDetails": MessageLookupByLibrary.simpleMessage("تفاصيل المنتج"),
    "productFormNote": MessageLookupByLibrary.simpleMessage(
      "المنتج ده هيظهر للحلاقين في متجر المستلزمات، ومش هيظهر للعملاء العاديين.",
    ),
    "productImages": MessageLookupByLibrary.simpleMessage("صور المنتج"),
    "productMetaLine": m10,
    "productName": MessageLookupByLibrary.simpleMessage("اسم المنتج"),
    "productNameHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: وكس تثبيت قوي - عبوة صالونات",
    ),
    "productNameRequired": MessageLookupByLibrary.simpleMessage(
      "اكتب اسم المنتج",
    ),
    "productRequired": MessageLookupByLibrary.simpleMessage("اختار منتج"),
    "productsCount": MessageLookupByLibrary.simpleMessage("عدد المنتجات"),
    "productsNote": MessageLookupByLibrary.simpleMessage(
      "المنتجات اللي بتعرضها هنا بتظهر للحلاقين في متجر المستلزمات.",
    ),
    "publishProduct": MessageLookupByLibrary.simpleMessage("نشر المنتج"),
    "queueEmpty": MessageLookupByLibrary.simpleMessage("الطابور فارغ"),
    "queuePositionLabel": MessageLookupByLibrary.simpleMessage(
      "الترتيب في الطابور",
    ),
    "rankLabel": m11,
    "ratingLabel": MessageLookupByLibrary.simpleMessage("التقييم"),
    "regenerateInviteConfirm": MessageLookupByLibrary.simpleMessage(
      "الرابط القديم هيبقى مش شغال. متأكد؟",
    ),
    "regenerateInviteTitle": MessageLookupByLibrary.simpleMessage(
      "إعادة توليد الرابط",
    ),
    "register": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "registerMerchant": MessageLookupByLibrary.simpleMessage("تسجيل تاجر جديد"),
    "registerSubtitle": MessageLookupByLibrary.simpleMessage(
      "سجّل نشاطك التجاري وابدأ بيع مستلزمات الحلاقة للصالونات بالجملة.",
    ),
    "rejectBooking": MessageLookupByLibrary.simpleMessage("رفض الحجز"),
    "rejectOrder": MessageLookupByLibrary.simpleMessage("رفض الطلب"),
    "rejectReason": MessageLookupByLibrary.simpleMessage("سبب الرفض"),
    "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: الصنف غير متوفر حاليًا",
    ),
    "remove_leading_zero": MessageLookupByLibrary.simpleMessage(
      "امسح الصفر اللي في الأول",
    ),
    "replaceDocument": MessageLookupByLibrary.simpleMessage("استبدل"),
    "resend_code": MessageLookupByLibrary.simpleMessage("إعادة إرسال الكود"),
    "resetPasswordConfirm": MessageLookupByLibrary.simpleMessage(
      "هل تريد تعيين كلمة مرور مؤقتة جديدة لهذا العضو؟",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين كلمة المرور",
    ),
    "responsibleBarber": m12,
    "retry": MessageLookupByLibrary.simpleMessage("حاول تاني"),
    "reviewsCount": m13,
    "reviewsTitle": MessageLookupByLibrary.simpleMessage("التقييمات"),
    "rewardAmount": MessageLookupByLibrary.simpleMessage("مبلغ ثابت"),
    "rewardFree": MessageLookupByLibrary.simpleMessage("مجانًا"),
    "rewardPercent": MessageLookupByLibrary.simpleMessage("نسبة %"),
    "rewardQuantityLabel": MessageLookupByLibrary.simpleMessage("خد كام قطعة؟"),
    "rewardTypeLabel": MessageLookupByLibrary.simpleMessage("نوع المكافأة"),
    "runningLowProducts": MessageLookupByLibrary.simpleMessage("قربوا يخلصوا"),
    "save": MessageLookupByLibrary.simpleMessage("حفظ"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("حفظ التعديلات"),
    "scopeBuyXGetY": MessageLookupByLibrary.simpleMessage("اشتري وخد"),
    "scopeBuyXGetYHint": MessageLookupByLibrary.simpleMessage(
      "اشتري كمية معينة وخد قطع مجانية أو بخصم",
    ),
    "scopeOrderTotal": MessageLookupByLibrary.simpleMessage(
      "خصم على إجمالي الطلب",
    ),
    "scopeOrderTotalHint": MessageLookupByLibrary.simpleMessage(
      "لما الطلب يوصل لمبلغ معين، يتخصم منه",
    ),
    "scopeProduct": MessageLookupByLibrary.simpleMessage("خصم على منتج"),
    "scopeProductHint": MessageLookupByLibrary.simpleMessage(
      "نسبة أو مبلغ يتخصم من سعر منتج واحد",
    ),
    "seats": MessageLookupByLibrary.simpleMessage("المقاعد"),
    "serviceDurationHint": MessageLookupByLibrary.simpleMessage("مثلاً ٣٠"),
    "serviceDurationLabel": MessageLookupByLibrary.simpleMessage(
      "المدة (دقايق)",
    ),
    "serviceLabel": MessageLookupByLibrary.simpleMessage("الخدمة"),
    "serviceMetaLine": m14,
    "servicePriceHint": MessageLookupByLibrary.simpleMessage("مثلاً ١٠٠"),
    "servicePriceLabel": MessageLookupByLibrary.simpleMessage("السعر"),
    "servicesTitle": MessageLookupByLibrary.simpleMessage("الخدمات"),
    "shareDocument": MessageLookupByLibrary.simpleMessage("مشاركة"),
    "shopLabel": MessageLookupByLibrary.simpleMessage("الصالون"),
    "shopOwner": MessageLookupByLibrary.simpleMessage("صاحب الصالون"),
    "shopSection": MessageLookupByLibrary.simpleMessage("المحل"),
    "shops": MessageLookupByLibrary.simpleMessage("الصالونات"),
    "shopsAllHint": MessageLookupByLibrary.simpleMessage(
      "لو مختارتش حاجة، العرض هيكون متاح لكل الصالونات",
    ),
    "shopsAllNote": MessageLookupByLibrary.simpleMessage(
      "العرض هيبان لكل الصالونات",
    ),
    "shopsSelectedHint": m15,
    "signIn": MessageLookupByLibrary.simpleMessage("دخول"),
    "snapchat_error": MessageLookupByLibrary.simpleMessage(
      "مش قادر أفتح سناب شات",
    ),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "حصل خطأ، حاول تاني",
    ),
    "statusAccepted": MessageLookupByLibrary.simpleMessage("مقبول"),
    "statusCancelled": MessageLookupByLibrary.simpleMessage("ملغي"),
    "statusDelivered": MessageLookupByLibrary.simpleMessage("تم التسليم"),
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
    "stockUnits": m16,
    "storeAndSalesSection": MessageLookupByLibrary.simpleMessage(
      "المتجر والمبيعات",
    ),
    "storeOrdersTitle": MessageLookupByLibrary.simpleMessage(
      "طلبات التوريد الخاصة بي",
    ),
    "storeTitle": MessageLookupByLibrary.simpleMessage("متجر الموردين"),
    "storefrontCategoriesTitle": MessageLookupByLibrary.simpleMessage(
      "تصنيفات المتجر",
    ),
    "storefrontDeliveryMenuTitle": MessageLookupByLibrary.simpleMessage(
      "توصيل المتجر",
    ),
    "storefrontOrdersSubtitle": MessageLookupByLibrary.simpleMessage(
      "الطلبات اللي وصلتك من عملاء متجرك",
    ),
    "storefrontOrdersTitle": MessageLookupByLibrary.simpleMessage(
      "طلبات المتجر",
    ),
    "storefrontProductFormNote": MessageLookupByLibrary.simpleMessage(
      "المنتج ده هيبان للعملاء اللي بيتصفحوا متجرك في التطبيق.",
    ),
    "storefrontProductsNote": MessageLookupByLibrary.simpleMessage(
      "اللي هتضيفه هنا هيبان للعملاء ويقدروا يطلبوه من متجرك",
    ),
    "storefrontProductsTitle": MessageLookupByLibrary.simpleMessage("متجرك"),
    "storefrontTitle": MessageLookupByLibrary.simpleMessage("متجرك"),
    "styleLabel": MessageLookupByLibrary.simpleMessage("الموديل"),
    "supplierSpendLabel": MessageLookupByLibrary.simpleMessage(
      "مصروفات الموردين هذا الشهر",
    ),
    "supportSection": MessageLookupByLibrary.simpleMessage("الدعم"),
    "tabAccount": MessageLookupByLibrary.simpleMessage("حسابي"),
    "tabBookings": MessageLookupByLibrary.simpleMessage("الحجوزات"),
    "tabDashboard": MessageLookupByLibrary.simpleMessage("لوحتي"),
    "tabHome": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "tabOrders": MessageLookupByLibrary.simpleMessage("الطلبات"),
    "tabProducts": MessageLookupByLibrary.simpleMessage("منتجاتي"),
    "tabServices": MessageLookupByLibrary.simpleMessage("الخدمات"),
    "tabStore": MessageLookupByLibrary.simpleMessage("المتجر"),
    "teamMember": MessageLookupByLibrary.simpleMessage("عضو فريق"),
    "teamTitle": MessageLookupByLibrary.simpleMessage("الفريق"),
    "tempPasswordHint": MessageLookupByLibrary.simpleMessage(
      "مثال: newtemp123",
    ),
    "tempPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور المؤقتة",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("المظهر"),
    "themeDark": MessageLookupByLibrary.simpleMessage("غامق"),
    "themeLight": MessageLookupByLibrary.simpleMessage("فاتح"),
    "tiktok_error": MessageLookupByLibrary.simpleMessage(
      "مش قادر أفتح تيك توك",
    ),
    "today": MessageLookupByLibrary.simpleMessage("النهاردة"),
    "topProducts": MessageLookupByLibrary.simpleMessage("الأكثر مخزونًا"),
    "totalStockUnits": MessageLookupByLibrary.simpleMessage("إجمالي القطع"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("حاول تاني"),
    "twitter_error": MessageLookupByLibrary.simpleMessage("مش قادر أفتح X"),
    "underDevelopment": MessageLookupByLibrary.simpleMessage(
      "التطبيق ده لسه تحت التطوير",
    ),
    "underReview": MessageLookupByLibrary.simpleMessage("تحت المراجعة"),
    "unitPrice": MessageLookupByLibrary.simpleMessage("سعر الوحدة (جنيه)"),
    "update": MessageLookupByLibrary.simpleMessage("تحديث"),
    "updateRequired": MessageLookupByLibrary.simpleMessage("التحديث مطلوب"),
    "updateRequiredBody": MessageLookupByLibrary.simpleMessage(
      "في نسخة جديدة من التطبيق، حدّث التطبيق عشان تكمل.",
    ),
    "uploadDocument": MessageLookupByLibrary.simpleMessage("ارفع"),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "استخدام موقعي الحالي",
    ),
    "vehicleType": MessageLookupByLibrary.simpleMessage("نوع المركبة"),
    "verifiedMerchant": MessageLookupByLibrary.simpleMessage("حساب تاجر موثّق"),
    "version": MessageLookupByLibrary.simpleMessage("الإصدار"),
    "viewCart": MessageLookupByLibrary.simpleMessage("عرض السلة"),
    "viewDocument": MessageLookupByLibrary.simpleMessage("عرض"),
    "walkInAddonsLabel": MessageLookupByLibrary.simpleMessage(
      "إضافات (اختياري)",
    ),
    "walkInBarberLabel": MessageLookupByLibrary.simpleMessage(
      "لعضو الفريق (اختياري)",
    ),
    "walkInNoteHint": MessageLookupByLibrary.simpleMessage("مثال: مستعجل"),
    "walkInNoteLabel": MessageLookupByLibrary.simpleMessage("ملاحظة (اختياري)"),
    "walletBalanceLabel": MessageLookupByLibrary.simpleMessage("الرصيد الحالي"),
    "walletTitle": MessageLookupByLibrary.simpleMessage("المحفظة"),
    "weak_password": MessageLookupByLibrary.simpleMessage("كلمة السر ضعيفة"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("أهلاً بيك 👋"),
    "welcome_message": MessageLookupByLibrary.simpleMessage("أهلاً بيك"),
    "whatsapp_error": MessageLookupByLibrary.simpleMessage(
      "مش قادر أفتح واتساب",
    ),
    "wholesaleSupplier": MessageLookupByLibrary.simpleMessage(
      "توريد مستلزمات الحلاقة بالجملة",
    ),
    "workingHoursTitle": MessageLookupByLibrary.simpleMessage("مواعيد العمل"),
    "yesterday": MessageLookupByLibrary.simpleMessage("أمبارح"),
    "youLabel": MessageLookupByLibrary.simpleMessage("أنت"),
    "your_session_has_been_expired": MessageLookupByLibrary.simpleMessage(
      "الجلسة انتهت، سجّل دخول تاني",
    ),
  };
}
