// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(limit) =>
      "Global categories are set by the admin, and you can add up to ${limit} of your own.";

  static String m1(amount) => "${amount} EGP";

  static String m2(days) => "${days} days ago";

  static String m3(status) => "Move status to \"${status}\"";

  static String m4(count, limit) => "My categories (${count}/${limit})";

  static String m5(price, stock, min) =>
      "${price} EGP · stock ${stock} · min ${min}";

  static String m6(name) => "Responsible barber: ${name}";

  static String m7(count) => "The offer applies to ${count} salons";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutApp": MessageLookupByLibrary.simpleMessage("About the app"),
    "aboutAppBody": MessageLookupByLibrary.simpleMessage(
      "Ayez Ahlaq — a wholesale platform connecting barber supply merchants with salons.",
    ),
    "acceptOrder": MessageLookupByLibrary.simpleMessage("Accept order"),
    "activeDiscount": MessageLookupByLibrary.simpleMessage("Active offer"),
    "activeProducts": MessageLookupByLibrary.simpleMessage("Active products"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addAction": MessageLookupByLibrary.simpleMessage("+ Add"),
    "addPhoneTitle": MessageLookupByLibrary.simpleMessage("New number"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("Add photo"),
    "addWholesaleProduct": MessageLookupByLibrary.simpleMessage(
      "Add wholesale product",
    ),
    "address_required": MessageLookupByLibrary.simpleMessage(
      "Address is required",
    ),
    "allOrders": MessageLookupByLibrary.simpleMessage("All orders"),
    "allShops": MessageLookupByLibrary.simpleMessage("All salons"),
    "already_have_account": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("Ayez Ahlaq"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "arabic_full_name_required": MessageLookupByLibrary.simpleMessage(
      "Please enter your full name in Arabic",
    ),
    "arabic_name_required": MessageLookupByLibrary.simpleMessage(
      "Name must be in Arabic",
    ),
    "avatarFallback": MessageLookupByLibrary.simpleMessage("?"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "backOnline": MessageLookupByLibrary.simpleMessage("Back online"),
    "barber": MessageLookupByLibrary.simpleMessage("Barber"),
    "barberHint": MessageLookupByLibrary.simpleMessage(
      "Manage your queue, schedule and earnings",
    ),
    "barberOrders": MessageLookupByLibrary.simpleMessage("Barber orders"),
    "barberOrdersSubtitle": MessageLookupByLibrary.simpleMessage(
      "All the orders you received from salons",
    ),
    "birthdate_does_not_match_national_id":
        MessageLookupByLibrary.simpleMessage(
          "Birthdate does not match the national ID:",
        ),
    "brand": MessageLookupByLibrary.simpleMessage("Brand"),
    "brandHint": MessageLookupByLibrary.simpleMessage("e.g. Wahl"),
    "businessName": MessageLookupByLibrary.simpleMessage("Business name"),
    "businessNameHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Golden Supplies",
    ),
    "businessNameRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the business name",
    ),
    "businessOwner": MessageLookupByLibrary.simpleMessage("Business owner"),
    "buyQuantityLabel": MessageLookupByLibrary.simpleMessage(
      "How many to buy?",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("Camera"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "categoriesNote": m0,
    "category": MessageLookupByLibrary.simpleMessage("Category"),
    "categoryGlobal": MessageLookupByLibrary.simpleMessage("Global"),
    "categoryImage": MessageLookupByLibrary.simpleMessage("Category image"),
    "categoryOwn": MessageLookupByLibrary.simpleMessage("Mine"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change password"),
    "chooseAccountType": MessageLookupByLibrary.simpleMessage(
      "Choose your account type",
    ),
    "chooseCategory": MessageLookupByLibrary.simpleMessage("Choose a category"),
    "chooseLanguage": MessageLookupByLibrary.simpleMessage("Choose language"),
    "chooseProduct": MessageLookupByLibrary.simpleMessage("Choose the product"),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Choose theme"),
    "choose_image_source": MessageLookupByLibrary.simpleMessage(
      "Choose image source",
    ),
    "closeAction": MessageLookupByLibrary.simpleMessage("Close"),
    "closeDiscount": MessageLookupByLibrary.simpleMessage("Close offer"),
    "closeDiscountConfirm": MessageLookupByLibrary.simpleMessage(
      "A closed offer cannot be reopened. Are you sure?",
    ),
    "closedDiscounts": MessageLookupByLibrary.simpleMessage("Closed offers"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "confirmReject": MessageLookupByLibrary.simpleMessage("Confirm rejection"),
    "confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "contact": MessageLookupByLibrary.simpleMessage("Contact"),
    "contain_number_and_special": MessageLookupByLibrary.simpleMessage(
      "Contains a number and a special character",
    ),
    "contain_uppercase": MessageLookupByLibrary.simpleMessage(
      "Contains an uppercase letter",
    ),
    "could_not_launch": MessageLookupByLibrary.simpleMessage(
      "Could not open the link",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
    "createDiscount": MessageLookupByLibrary.simpleMessage("Create offer"),
    "currencyEgp": m1,
    "currentPassword": MessageLookupByLibrary.simpleMessage("Current password"),
    "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Enter your current password",
    ),
    "customer": MessageLookupByLibrary.simpleMessage("Customer"),
    "customerHint": MessageLookupByLibrary.simpleMessage(
      "Book a haircut and buy care products",
    ),
    "daysAgo": m2,
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("Delete category"),
    "deleteCategoryConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this category?",
    ),
    "deletePhone": MessageLookupByLibrary.simpleMessage("Delete number"),
    "deletePhoneConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this number?",
    ),
    "deleteProduct": MessageLookupByLibrary.simpleMessage("Delete product"),
    "deleteProductConfirm": MessageLookupByLibrary.simpleMessage(
      "It will be removed from the barbers\' store. Are you sure?",
    ),
    "deliveryFeeHint": MessageLookupByLibrary.simpleMessage("e.g. 25"),
    "deliveryFeeLabel": MessageLookupByLibrary.simpleMessage("Delivery fee"),
    "deliveryFeeOrderLabel": MessageLookupByLibrary.simpleMessage(
      "Delivery fee",
    ),
    "deliveryFeeRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the delivery fee",
    ),
    "deliveryFreeOverHint": MessageLookupByLibrary.simpleMessage(
      "Leave empty for no free delivery",
    ),
    "deliveryFreeOverLabel": MessageLookupByLibrary.simpleMessage(
      "Free delivery over",
    ),
    "deliveryFreeOverNote": MessageLookupByLibrary.simpleMessage(
      "When the goods total reaches this amount, delivery is free.",
    ),
    "deliveryNote": MessageLookupByLibrary.simpleMessage(
      "When delivery is on, salons can order delivery and the fee is added to the order total. When off, pickup from your shop only.",
    ),
    "deliveryOffLabel": MessageLookupByLibrary.simpleMessage(
      "Delivery is off — pickup only",
    ),
    "deliveryOffered": MessageLookupByLibrary.simpleMessage("I offer delivery"),
    "deliverySaved": MessageLookupByLibrary.simpleMessage(
      "Delivery settings saved",
    ),
    "deliveryTitle": MessageLookupByLibrary.simpleMessage("Delivery"),
    "discountClosed": MessageLookupByLibrary.simpleMessage("Closed"),
    "discountLive": MessageLookupByLibrary.simpleMessage("Live"),
    "discountName": MessageLookupByLibrary.simpleMessage("Offer name"),
    "discountNameHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Summer offer",
    ),
    "discountNameRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the offer name",
    ),
    "discountType": MessageLookupByLibrary.simpleMessage("Offer type"),
    "discountValue": MessageLookupByLibrary.simpleMessage("Discount value"),
    "discountsTitle": MessageLookupByLibrary.simpleMessage(
      "Offers and discounts",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "dont_have_account": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "editCategory": MessageLookupByLibrary.simpleMessage("Edit category"),
    "editDiscount": MessageLookupByLibrary.simpleMessage("Edit offer"),
    "editMyInfo": MessageLookupByLibrary.simpleMessage("Edit my info"),
    "editProduct": MessageLookupByLibrary.simpleMessage("Edit product"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailOptional": MessageLookupByLibrary.simpleMessage("Email (optional)"),
    "email_invalid": MessageLookupByLibrary.simpleMessage(
      "Invalid email address",
    ),
    "email_required": MessageLookupByLibrary.simpleMessage("Email is required"),
    "emptyDefaultTitle": MessageLookupByLibrary.simpleMessage(
      "Nothing here yet",
    ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enter_password": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "errorDefaultTitle": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "extraPhones": MessageLookupByLibrary.simpleMessage("Extra phone numbers"),
    "extraPhonesNote": MessageLookupByLibrary.simpleMessage(
      "Additional contact numbers for salons to reach you. Your login number is changed by the admin.",
    ),
    "featureLockedApproval": MessageLookupByLibrary.simpleMessage(
      "This feature will be available once your account is approved.",
    ),
    "field_required": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "filterAll": MessageLookupByLibrary.simpleMessage("All"),
    "freeDelivery": MessageLookupByLibrary.simpleMessage("Free"),
    "fulfilmentDelivery": MessageLookupByLibrary.simpleMessage("Delivery"),
    "fulfilmentPickup": MessageLookupByLibrary.simpleMessage(
      "Pickup at branch",
    ),
    "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
    "globalCategories": MessageLookupByLibrary.simpleMessage(
      "Global categories",
    ),
    "goToDocuments": MessageLookupByLibrary.simpleMessage("Go to documents"),
    "grandTotalLabel": MessageLookupByLibrary.simpleMessage("Grand total"),
    "greeting": MessageLookupByLibrary.simpleMessage("Good morning,"),
    "inStock": MessageLookupByLibrary.simpleMessage("In stock"),
    "instagram_error": MessageLookupByLibrary.simpleMessage(
      "Could not open Instagram",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("Invalid number"),
    "invalidPrice": MessageLookupByLibrary.simpleMessage("Invalid price"),
    "invalid_national_id": MessageLookupByLibrary.simpleMessage(
      "Invalid national ID",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "latestOrders": MessageLookupByLibrary.simpleMessage("Latest orders"),
    "listSeparator": MessageLookupByLibrary.simpleMessage(", "),
    "liveDiscounts": MessageLookupByLibrary.simpleMessage("Live offers"),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Sign in with your merchant account to manage products and orders",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Log out"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out?",
    ),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("Log out"),
    "management": MessageLookupByLibrary.simpleMessage("Management"),
    "markAllRead": MessageLookupByLibrary.simpleMessage("Mark all as read"),
    "merchant": MessageLookupByLibrary.simpleMessage("Merchant"),
    "merchantDashboardNote": MessageLookupByLibrary.simpleMessage(
      "All your customers are barbers and salons registered on the platform — wholesale only.",
    ),
    "merchantHint": MessageLookupByLibrary.simpleMessage(
      "Sell barber supplies wholesale to salons",
    ),
    "message_required": MessageLookupByLibrary.simpleMessage(
      "Message is required",
    ),
    "message_too_short": MessageLookupByLibrary.simpleMessage(
      "Message is too short",
    ),
    "minOrderQty": MessageLookupByLibrary.simpleMessage("Minimum order"),
    "minOrderTotalLabel": MessageLookupByLibrary.simpleMessage(
      "Minimum order total (EGP)",
    ),
    "min_8_char": MessageLookupByLibrary.simpleMessage("At least 8 characters"),
    "missingDocsBody": MessageLookupByLibrary.simpleMessage(
      "Please upload the required documents to activate your account.",
    ),
    "missingDocsTitle": MessageLookupByLibrary.simpleMessage(
      "Missing documents",
    ),
    "monthRevenue": MessageLookupByLibrary.simpleMessage("Month revenue"),
    "moveStatusTo": m3,
    "myCategories": MessageLookupByLibrary.simpleMessage("My categories"),
    "myCategoriesCount": m4,
    "myDocuments": MessageLookupByLibrary.simpleMessage("My documents"),
    "name_invalid_characters": MessageLookupByLibrary.simpleMessage(
      "Name contains invalid characters",
    ),
    "name_invalid_spacing": MessageLookupByLibrary.simpleMessage(
      "Name has invalid spacing",
    ),
    "name_required": MessageLookupByLibrary.simpleMessage("Name is required"),
    "name_too_long": MessageLookupByLibrary.simpleMessage("Name is too long"),
    "name_too_short": MessageLookupByLibrary.simpleMessage("Name is too short"),
    "national_id_must_be_14_digits": MessageLookupByLibrary.simpleMessage(
      "National ID must be 14 digits",
    ),
    "national_id_required": MessageLookupByLibrary.simpleMessage(
      "National ID is required",
    ),
    "newCategory": MessageLookupByLibrary.simpleMessage("New category"),
    "newCategoryHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Premium offers",
    ),
    "newDiscount": MessageLookupByLibrary.simpleMessage("New offer"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
    "noAccountRegister": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? Register as a merchant",
    ),
    "noDiscountsYet": MessageLookupByLibrary.simpleMessage("No offers yet"),
    "noExtraPhones": MessageLookupByLibrary.simpleMessage(
      "No extra numbers yet",
    ),
    "noInternet": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "noOrdersYet": MessageLookupByLibrary.simpleMessage("No orders yet"),
    "noOwnCategories": MessageLookupByLibrary.simpleMessage(
      "No custom categories yet",
    ),
    "noProductsYet": MessageLookupByLibrary.simpleMessage("No products yet"),
    "notNow": MessageLookupByLibrary.simpleMessage("Not now"),
    "notifDiscountEndedBody": MessageLookupByLibrary.simpleMessage(
      "Your \"Buy 4 get 1 free\" offer has been closed",
    ),
    "notifDiscountEndedTitle": MessageLookupByLibrary.simpleMessage(
      "Offer ended",
    ),
    "notifLowStockBody": MessageLookupByLibrary.simpleMessage(
      "Beard oil is down to 8 units",
    ),
    "notifLowStockTitle": MessageLookupByLibrary.simpleMessage("Low stock"),
    "notifNewOrderBody": MessageLookupByLibrary.simpleMessage(
      "Salon Al Malek sent an order worth 2880 EGP",
    ),
    "notifNewOrderTitle": MessageLookupByLibrary.simpleMessage("New order"),
    "notifOrderCancelledBody": MessageLookupByLibrary.simpleMessage(
      "Barber House cancelled order #PO-2170",
    ),
    "notifOrderCancelledTitle": MessageLookupByLibrary.simpleMessage(
      "Order cancelled",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
      "No notifications",
    ),
    "notificationsEmptyHint": MessageLookupByLibrary.simpleMessage(
      "New orders and updates will show up here",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "or": MessageLookupByLibrary.simpleMessage("or"),
    "orderDiscountLabel": MessageLookupByLibrary.simpleMessage(
      "Order discount",
    ),
    "orderTotal": MessageLookupByLibrary.simpleMessage("Total"),
    "orderedItems": MessageLookupByLibrary.simpleMessage("Ordered items"),
    "outOfStock": MessageLookupByLibrary.simpleMessage("Out of stock"),
    "ownerName": MessageLookupByLibrary.simpleMessage("Owner name"),
    "ownerNameHint": MessageLookupByLibrary.simpleMessage("e.g. Ahmed Ali"),
    "ownerNameRequired": MessageLookupByLibrary.simpleMessage(
      "Enter your name",
    ),
    "passport_format_invalid": MessageLookupByLibrary.simpleMessage(
      "Invalid passport number format",
    ),
    "passport_length_invalid": MessageLookupByLibrary.simpleMessage(
      "Invalid passport number length",
    ),
    "passport_required": MessageLookupByLibrary.simpleMessage(
      "Passport number is required",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage("Password changed"),
    "passwordMatches": MessageLookupByLibrary.simpleMessage("Passwords match"),
    "passwordMinHint": MessageLookupByLibrary.simpleMessage(
      "At least 6 characters",
    ),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Password is too short",
    ),
    "pendingApprovalTitle": MessageLookupByLibrary.simpleMessage(
      "Account under review",
    ),
    "pendingOrders": MessageLookupByLibrary.simpleMessage("Pending orders"),
    "phoneLabel": MessageLookupByLibrary.simpleMessage("Label (optional)"),
    "phoneLabelHint": MessageLookupByLibrary.simpleMessage("e.g. Sales line"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone number"),
    "phone_number_cannot_start_with_double_zero":
        MessageLookupByLibrary.simpleMessage(
          "Phone number cannot start with 00",
        ),
    "phone_number_is_required": MessageLookupByLibrary.simpleMessage(
      "Phone number is required",
    ),
    "phone_number_must_contain_only_digits":
        MessageLookupByLibrary.simpleMessage(
          "Phone number must contain digits only",
        ),
    "pleaseCheckYourConnectionAndTryAgain":
        MessageLookupByLibrary.simpleMessage(
          "Please check your connection and try again",
        ),
    "please_enter_a_valid_phone_number": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid phone number",
    ),
    "product": MessageLookupByLibrary.simpleMessage("Product"),
    "productDescription": MessageLookupByLibrary.simpleMessage(
      "Product description",
    ),
    "productDescriptionHint": MessageLookupByLibrary.simpleMessage(
      "Write a short description and its benefits for barbers",
    ),
    "productDetails": MessageLookupByLibrary.simpleMessage("Product details"),
    "productFormNote": MessageLookupByLibrary.simpleMessage(
      "This product appears only in the supplies store inside the barbers\' app, not to regular customers.",
    ),
    "productImages": MessageLookupByLibrary.simpleMessage("Product images"),
    "productMetaLine": m5,
    "productName": MessageLookupByLibrary.simpleMessage("Product name"),
    "productNameHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Strong hold wax - salon pack",
    ),
    "productNameRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the product name",
    ),
    "productRequired": MessageLookupByLibrary.simpleMessage("Choose a product"),
    "productsNote": MessageLookupByLibrary.simpleMessage(
      "What you list here is only visible to barbers in their supplies store",
    ),
    "publishProduct": MessageLookupByLibrary.simpleMessage("Publish product"),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "registerMerchant": MessageLookupByLibrary.simpleMessage(
      "Register a new merchant",
    ),
    "registerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Register your business and start selling barber supplies wholesale.",
    ),
    "rejectOrder": MessageLookupByLibrary.simpleMessage("Reject order"),
    "rejectReason": MessageLookupByLibrary.simpleMessage("Rejection reason"),
    "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
      "e.g. item is out of stock",
    ),
    "remove_leading_zero": MessageLookupByLibrary.simpleMessage(
      "Remove the leading zero",
    ),
    "resend_code": MessageLookupByLibrary.simpleMessage("Resend code"),
    "responsibleBarber": m6,
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "rewardAmount": MessageLookupByLibrary.simpleMessage("Fixed amount"),
    "rewardFree": MessageLookupByLibrary.simpleMessage("Free"),
    "rewardPercent": MessageLookupByLibrary.simpleMessage("Percent %"),
    "rewardQuantityLabel": MessageLookupByLibrary.simpleMessage(
      "How many do they get?",
    ),
    "rewardTypeLabel": MessageLookupByLibrary.simpleMessage("Reward type"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Save changes"),
    "scopeBuyXGetY": MessageLookupByLibrary.simpleMessage("Buy X get Y"),
    "scopeBuyXGetYHint": MessageLookupByLibrary.simpleMessage(
      "Buy a quantity and get items free or discounted",
    ),
    "scopeOrderTotal": MessageLookupByLibrary.simpleMessage(
      "Order total discount",
    ),
    "scopeOrderTotalHint": MessageLookupByLibrary.simpleMessage(
      "When the order reaches an amount, discount the whole order",
    ),
    "scopeProduct": MessageLookupByLibrary.simpleMessage("Product discount"),
    "scopeProductHint": MessageLookupByLibrary.simpleMessage(
      "A percentage or amount off a single product",
    ),
    "seats": MessageLookupByLibrary.simpleMessage("Seats"),
    "shops": MessageLookupByLibrary.simpleMessage("Salons"),
    "shopsAllHint": MessageLookupByLibrary.simpleMessage(
      "Selecting none = the offer applies to all salons",
    ),
    "shopsAllNote": MessageLookupByLibrary.simpleMessage(
      "The offer will apply to all salons",
    ),
    "shopsSelectedHint": m7,
    "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
    "snapchat_error": MessageLookupByLibrary.simpleMessage(
      "Could not open Snapchat",
    ),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "statusAccepted": MessageLookupByLibrary.simpleMessage("Accepted"),
    "statusCancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "statusDelivered": MessageLookupByLibrary.simpleMessage("Delivered"),
    "statusOutForDelivery": MessageLookupByLibrary.simpleMessage(
      "Out for delivery",
    ),
    "statusPending": MessageLookupByLibrary.simpleMessage("Awaiting response"),
    "statusPreparing": MessageLookupByLibrary.simpleMessage("Preparing"),
    "statusReadyForPickup": MessageLookupByLibrary.simpleMessage(
      "Ready for pickup",
    ),
    "statusRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "stockQuantity": MessageLookupByLibrary.simpleMessage("Available stock"),
    "tabAccount": MessageLookupByLibrary.simpleMessage("Account"),
    "tabDashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "tabOrders": MessageLookupByLibrary.simpleMessage("Orders"),
    "tabProducts": MessageLookupByLibrary.simpleMessage("Products"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "tiktok_error": MessageLookupByLibrary.simpleMessage(
      "Could not open TikTok",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
    "twitter_error": MessageLookupByLibrary.simpleMessage("Could not open X"),
    "underDevelopment": MessageLookupByLibrary.simpleMessage(
      "This app is still under development",
    ),
    "underReview": MessageLookupByLibrary.simpleMessage("Under review"),
    "unitPrice": MessageLookupByLibrary.simpleMessage("Unit price (EGP)"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "updateRequired": MessageLookupByLibrary.simpleMessage("Update required"),
    "updateRequiredBody": MessageLookupByLibrary.simpleMessage(
      "A new version of the app is available. Please update to continue.",
    ),
    "vehicleType": MessageLookupByLibrary.simpleMessage("Vehicle type"),
    "verifiedMerchant": MessageLookupByLibrary.simpleMessage(
      "Verified merchant",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "weak_password": MessageLookupByLibrary.simpleMessage(
      "Password is too weak",
    ),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome 👋"),
    "welcome_message": MessageLookupByLibrary.simpleMessage("Welcome"),
    "whatsapp_error": MessageLookupByLibrary.simpleMessage(
      "Could not open WhatsApp",
    ),
    "wholesaleSupplier": MessageLookupByLibrary.simpleMessage(
      "Wholesale barber supplies",
    ),
    "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "your_session_has_been_expired": MessageLookupByLibrary.simpleMessage(
      "Your session has expired",
    ),
  };
}
