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

  static String m0(count) => "${count} recipients";

  static String m1(limit) =>
      "Global categories are set by the admin, and you can add up to ${limit} of your own.";

  static String m2(planName, price) =>
      "You\'re subscribing to the \"${planName}\" plan for ${price} EGP. Are you sure?";

  static String m3(amount) =>
      "You\'re about to submit a request for ${amount} EGP. Are you sure?";

  static String m4(amount) => "${amount} EGP";

  static String m5(days) => "${days} days ago";

  static String m6(size) => "The file is too large — maximum ${size} MB";

  static String m7(count) => "${count} required documents are still missing";

  static String m8(size) =>
      "The admin sets which documents are needed. Upload an image or a PDF for each one, up to ${size} MB.";

  static String m9(uploaded, total) => "${uploaded} of ${total} uploaded";

  static String m10(clients) => "${clients} clients";

  static String m11(status) => "Move status to \"${status}\"";

  static String m12(count, limit) => "My categories (${count}/${limit})";

  static String m13(percent, price) =>
      "This product now has a ${percent}% discount, priced at ${price}";

  static String m14(count) => "You have ${count} new orders on your store";

  static String m15(percent) => "Order discount (${percent}%)";

  static String m16(price) => "Product price changed, now ${price}";

  static String m17(price, stock, min) =>
      "${price} EGP · stock ${stock} · min ${min}";

  static String m18(used, cap) => "${used} of ${cap}";

  static String m19(rank) => "Rank #${rank}";

  static String m20(barberName) =>
      "How was your experience with ${barberName}?";

  static String m21(shopName) => "How was your experience with ${shopName}?";

  static String m22(name) => "Responsible barber: ${name}";

  static String m23(count) => "${count} reviews";

  static String m24(price, duration) => "${price} EGP · ${duration} min";

  static String m25(count) => "The offer applies to ${count} salons";

  static String m26(amount) =>
      "${amount} will be charged from your wallet and you stay promoted for 30 days.";

  static String m27(days) => "${days} days left";

  static String m28(amount) =>
      "Your wallet is short by ${amount}, top up first";

  static String m29(count) => "${count} units";

  static String m30(percent) => "${percent}% off";

  static String m31(amount) => "Available: ${amount} EGP";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutApp": MessageLookupByLibrary.simpleMessage("About the app"),
    "aboutAppBody": MessageLookupByLibrary.simpleMessage(
      "Ayez Ahlaq — a wholesale platform connecting barber supply merchants with salons.",
    ),
    "acceptOrder": MessageLookupByLibrary.simpleMessage("Accept order"),
    "accountDeleted": MessageLookupByLibrary.simpleMessage("Account deleted"),
    "accountSection": MessageLookupByLibrary.simpleMessage("Account"),
    "activateMemberConfirm": MessageLookupByLibrary.simpleMessage(
      "Allow this member to log in again?",
    ),
    "activateMemberTitle": MessageLookupByLibrary.simpleMessage(
      "Re-activate member",
    ),
    "activeDiscount": MessageLookupByLibrary.simpleMessage("Active offer"),
    "activeLabel": MessageLookupByLibrary.simpleMessage("Active"),
    "activeOrders": MessageLookupByLibrary.simpleMessage("Active orders"),
    "activeProducts": MessageLookupByLibrary.simpleMessage("Active products"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addAction": MessageLookupByLibrary.simpleMessage("+ Add"),
    "addAdjustment": MessageLookupByLibrary.simpleMessage("Add a line"),
    "addDrink": MessageLookupByLibrary.simpleMessage("Add a drink"),
    "addMemberTitle": MessageLookupByLibrary.simpleMessage("Add team member"),
    "addOwnServiceTitle": MessageLookupByLibrary.simpleMessage(
      "Add custom service",
    ),
    "addPhoneTitle": MessageLookupByLibrary.simpleMessage("New number"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("Add photo"),
    "addServiceTitle": MessageLookupByLibrary.simpleMessage("Add service"),
    "addStorefrontProduct": MessageLookupByLibrary.simpleMessage("Add product"),
    "addToFavorites": MessageLookupByLibrary.simpleMessage("Add to favorites"),
    "addWalkInAction": MessageLookupByLibrary.simpleMessage("Add walk-in"),
    "addWalkInTitle": MessageLookupByLibrary.simpleMessage("Add a walk-in"),
    "addWholesaleProduct": MessageLookupByLibrary.simpleMessage(
      "Add wholesale product",
    ),
    "addedToFavorites": MessageLookupByLibrary.simpleMessage(
      "Added to favorites",
    ),
    "addonsLabel": MessageLookupByLibrary.simpleMessage("Add-ons"),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "addressHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Abbas El Akkad St, Nasr City",
    ),
    "addressLabel": MessageLookupByLibrary.simpleMessage("Address"),
    "addressRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the address",
    ),
    "address_required": MessageLookupByLibrary.simpleMessage(
      "Address is required",
    ),
    "adjustmentAmount": MessageLookupByLibrary.simpleMessage("Amount"),
    "adjustmentAmountHint": MessageLookupByLibrary.simpleMessage(
      "30, or -20 for a discount",
    ),
    "adjustmentAmountRequired": MessageLookupByLibrary.simpleMessage(
      "Enter a valid amount",
    ),
    "adjustmentLabel": MessageLookupByLibrary.simpleMessage("Reason"),
    "adjustmentLabelHint": MessageLookupByLibrary.simpleMessage(
      "Extra beard trim, discount…",
    ),
    "adjustmentLabelRequired": MessageLookupByLibrary.simpleMessage(
      "Enter a reason for the line",
    ),
    "allOrders": MessageLookupByLibrary.simpleMessage("All orders"),
    "allShops": MessageLookupByLibrary.simpleMessage("All salons"),
    "alreadyHaveAccountLogin": MessageLookupByLibrary.simpleMessage(
      "Already have an account? Sign in",
    ),
    "alreadyRatedBarber": MessageLookupByLibrary.simpleMessage(
      "You already rated the barber",
    ),
    "alreadyRatedShop": MessageLookupByLibrary.simpleMessage(
      "You already rated the shop",
    ),
    "already_have_account": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "amountAboveTotal": MessageLookupByLibrary.simpleMessage(
      "Amount must be less than the order value",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("Ayez Ahlaq"),
    "appSettings": MessageLookupByLibrary.simpleMessage("App settings"),
    "appTagline": MessageLookupByLibrary.simpleMessage("Your cut, your way"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "arabic_full_name_required": MessageLookupByLibrary.simpleMessage(
      "Please enter your full name in Arabic",
    ),
    "arabic_name_required": MessageLookupByLibrary.simpleMessage(
      "Name must be in Arabic",
    ),
    "area": MessageLookupByLibrary.simpleMessage("Area"),
    "areaHint": MessageLookupByLibrary.simpleMessage("Nasr City"),
    "areaRequired": MessageLookupByLibrary.simpleMessage("Enter the area"),
    "attachReceiptPhoto": MessageLookupByLibrary.simpleMessage(
      "Attach a receipt photo",
    ),
    "autoChargeOff": MessageLookupByLibrary.simpleMessage(
      "Auto-renewal is off",
    ),
    "autoChargeOn": MessageLookupByLibrary.simpleMessage("Auto-renewal is on"),
    "autoSelectBarber": MessageLookupByLibrary.simpleMessage(
      "Any available barber",
    ),
    "autoSelectBarberHint": MessageLookupByLibrary.simpleMessage(
      "The least busy barber will be picked automatically",
    ),
    "availabilityLabel": MessageLookupByLibrary.simpleMessage(
      "Available for booking",
    ),
    "availablePlansTitle": MessageLookupByLibrary.simpleMessage(
      "Available plans",
    ),
    "avatarFallback": MessageLookupByLibrary.simpleMessage("?"),
    "avgTicketLabel": MessageLookupByLibrary.simpleMessage("Average ticket"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "backOnline": MessageLookupByLibrary.simpleMessage("Back online"),
    "barber": MessageLookupByLibrary.simpleMessage("Barber"),
    "barberHint": MessageLookupByLibrary.simpleMessage(
      "Manage your queue, schedule and earnings",
    ),
    "barberLabel": MessageLookupByLibrary.simpleMessage("Barber"),
    "barberName": MessageLookupByLibrary.simpleMessage("Barber name"),
    "barberNameRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the barber name",
    ),
    "barberOrders": MessageLookupByLibrary.simpleMessage("Barber orders"),
    "barberOrdersSubtitle": MessageLookupByLibrary.simpleMessage(
      "All the orders you received from salons",
    ),
    "barbersSectionTitle": MessageLookupByLibrary.simpleMessage("Barbers"),
    "billAdjustments": MessageLookupByLibrary.simpleMessage(
      "Extras and discounts",
    ),
    "billLocked": MessageLookupByLibrary.simpleMessage("This bill is locked"),
    "billSaved": MessageLookupByLibrary.simpleMessage(
      "The bill has been updated",
    ),
    "billTotal": MessageLookupByLibrary.simpleMessage("Total"),
    "birthdate_does_not_match_national_id":
        MessageLookupByLibrary.simpleMessage(
          "Birthdate does not match the national ID:",
        ),
    "blockMemberConfirm": MessageLookupByLibrary.simpleMessage(
      "This member will no longer be able to log in. Continue?",
    ),
    "blockMemberTitle": MessageLookupByLibrary.simpleMessage("Block member"),
    "blockedLabel": MessageLookupByLibrary.simpleMessage("Blocked"),
    "bookNow": MessageLookupByLibrary.simpleMessage("Book now"),
    "bookingCancelledMessage": MessageLookupByLibrary.simpleMessage(
      "Booking cancelled",
    ),
    "bookingCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Your booking request was sent, the salon will confirm within 30 minutes",
    ),
    "bookingDateLabel": MessageLookupByLibrary.simpleMessage("Date and time"),
    "bookingDetailsTitle": MessageLookupByLibrary.simpleMessage(
      "Booking details",
    ),
    "bookingStatusActive": MessageLookupByLibrary.simpleMessage("In progress"),
    "bookingStatusCancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "bookingStatusConfirmed": MessageLookupByLibrary.simpleMessage("Confirmed"),
    "bookingStatusDone": MessageLookupByLibrary.simpleMessage("Done"),
    "bookingStatusNext": MessageLookupByLibrary.simpleMessage("Next"),
    "bookingStatusNoShow": MessageLookupByLibrary.simpleMessage("No show"),
    "bookingStatusPending": MessageLookupByLibrary.simpleMessage(
      "Awaiting confirmation",
    ),
    "bookingStatusRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "bookingStatusUpcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "bookingSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Booking summary",
    ),
    "bookingsHistoryTab": MessageLookupByLibrary.simpleMessage("History"),
    "bookingsPastTab": MessageLookupByLibrary.simpleMessage("Past"),
    "bookingsPendingTab": MessageLookupByLibrary.simpleMessage(
      "Awaiting confirmation",
    ),
    "bookingsQueueTab": MessageLookupByLibrary.simpleMessage("Today\'s queue"),
    "bookingsTitle": MessageLookupByLibrary.simpleMessage("Bookings"),
    "bookingsUpcomingTab": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "brand": MessageLookupByLibrary.simpleMessage("Brand"),
    "brandHint": MessageLookupByLibrary.simpleMessage("e.g. Wahl"),
    "broadcastBodyFieldHint": MessageLookupByLibrary.simpleMessage(
      "Notification message",
    ),
    "broadcastListEmpty": MessageLookupByLibrary.simpleMessage(
      "You haven\'t sent any notification yet",
    ),
    "broadcastListTitle": MessageLookupByLibrary.simpleMessage(
      "Sent notifications",
    ),
    "broadcastNote": MessageLookupByLibrary.simpleMessage(
      "Send a push notification to your customers.",
    ),
    "broadcastRecipientCount": m0,
    "broadcastScopeAll": MessageLookupByLibrary.simpleMessage("All customers"),
    "broadcastScopeMine": MessageLookupByLibrary.simpleMessage(
      "My customers only",
    ),
    "broadcastScopeZone": MessageLookupByLibrary.simpleMessage("My zone only"),
    "broadcastSendAction": MessageLookupByLibrary.simpleMessage("Send"),
    "broadcastSentSuccess": MessageLookupByLibrary.simpleMessage(
      "Notification sent successfully",
    ),
    "broadcastStatusApproved": MessageLookupByLibrary.simpleMessage("Approved"),
    "broadcastStatusPending": MessageLookupByLibrary.simpleMessage(
      "Pending review",
    ),
    "broadcastStatusRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "broadcastTitle": MessageLookupByLibrary.simpleMessage("Send notification"),
    "broadcastTitleFieldHint": MessageLookupByLibrary.simpleMessage(
      "Notification title",
    ),
    "broadcastZoneUnavailable": MessageLookupByLibrary.simpleMessage(
      "Your zone is not set yet, so this will be sent to all customers",
    ),
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
    "buySupplies": MessageLookupByLibrary.simpleMessage("Buy supplies"),
    "camera": MessageLookupByLibrary.simpleMessage("Camera"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelBooking": MessageLookupByLibrary.simpleMessage("Cancel booking"),
    "cancelOrder": MessageLookupByLibrary.simpleMessage("Cancel order"),
    "cancelWalletRequestAction": MessageLookupByLibrary.simpleMessage(
      "Cancel request",
    ),
    "cancelWalletRequestConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to cancel this request?",
    ),
    "cancelWalletRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Cancel request",
    ),
    "cartEmpty": MessageLookupByLibrary.simpleMessage("Your cart is empty"),
    "cartTitle": MessageLookupByLibrary.simpleMessage("Cart"),
    "categoriesNote": m1,
    "category": MessageLookupByLibrary.simpleMessage("Category"),
    "categoryGlobal": MessageLookupByLibrary.simpleMessage("Global"),
    "categoryImage": MessageLookupByLibrary.simpleMessage("Category image"),
    "categoryOwn": MessageLookupByLibrary.simpleMessage("Mine"),
    "changeAccountType": MessageLookupByLibrary.simpleMessage(
      "Not you? Change account type",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change password"),
    "changePlanAction": MessageLookupByLibrary.simpleMessage(
      "Switch to this plan",
    ),
    "chooseAccountType": MessageLookupByLibrary.simpleMessage(
      "Choose your account type",
    ),
    "chooseBarberTitle": MessageLookupByLibrary.simpleMessage(
      "Choose a barber",
    ),
    "chooseCategory": MessageLookupByLibrary.simpleMessage("Choose a category"),
    "chooseLanguage": MessageLookupByLibrary.simpleMessage("Choose language"),
    "chooseProduct": MessageLookupByLibrary.simpleMessage("Choose the product"),
    "chooseService": MessageLookupByLibrary.simpleMessage("Choose a service"),
    "chooseServiceRequired": MessageLookupByLibrary.simpleMessage(
      "You must choose a service",
    ),
    "chooseServiceTitle": MessageLookupByLibrary.simpleMessage(
      "Choose a service",
    ),
    "chooseStyleTitle": MessageLookupByLibrary.simpleMessage("Choose a style"),
    "chooseTeamMember": MessageLookupByLibrary.simpleMessage(
      "Choose a team member",
    ),
    "chooseTeamMemberRequired": MessageLookupByLibrary.simpleMessage(
      "You must choose a team member",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Choose theme"),
    "chooseTimeTitle": MessageLookupByLibrary.simpleMessage("Choose a time"),
    "chooseUploadSource": MessageLookupByLibrary.simpleMessage(
      "Choose upload source",
    ),
    "choose_image_source": MessageLookupByLibrary.simpleMessage(
      "Choose image source",
    ),
    "clientsLast7DaysLabel": MessageLookupByLibrary.simpleMessage(
      "Last 7 days",
    ),
    "clientsThisMonthLabel": MessageLookupByLibrary.simpleMessage("This month"),
    "clientsTodayLabel": MessageLookupByLibrary.simpleMessage("Today"),
    "closeAction": MessageLookupByLibrary.simpleMessage("Close"),
    "closeDiscount": MessageLookupByLibrary.simpleMessage("Close offer"),
    "closeDiscountConfirm": MessageLookupByLibrary.simpleMessage(
      "A closed offer cannot be reopened. Are you sure?",
    ),
    "closeTimeLabel": MessageLookupByLibrary.simpleMessage("Closes at"),
    "closedDiscounts": MessageLookupByLibrary.simpleMessage("Closed offers"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmBooking": MessageLookupByLibrary.simpleMessage("Confirm booking"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "confirmReject": MessageLookupByLibrary.simpleMessage("Confirm rejection"),
    "confirmSubscribeMessage": m2,
    "confirmSubscribeTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm subscription",
    ),
    "confirmWalletRequestDepositTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm deposit",
    ),
    "confirmWalletRequestMessage": m3,
    "confirmWalletRequestWithdrawTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm withdrawal",
    ),
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
    "continueLabel": MessageLookupByLibrary.simpleMessage("Continue"),
    "could_not_launch": MessageLookupByLibrary.simpleMessage(
      "Could not open the link",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
    "createBarberAccount": MessageLookupByLibrary.simpleMessage(
      "Create barber account",
    ),
    "createCustomerAccount": MessageLookupByLibrary.simpleMessage(
      "Create your account",
    ),
    "createDiscount": MessageLookupByLibrary.simpleMessage("Create offer"),
    "createMerchantAccount": MessageLookupByLibrary.simpleMessage(
      "Create a merchant account",
    ),
    "createWalletRequestTitle": MessageLookupByLibrary.simpleMessage(
      "New wallet request",
    ),
    "currencyEgp": m4,
    "currentPassword": MessageLookupByLibrary.simpleMessage("Current password"),
    "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Enter your current password",
    ),
    "currentPlanBadge": MessageLookupByLibrary.simpleMessage(
      "Your current plan",
    ),
    "currentPlanLabel": MessageLookupByLibrary.simpleMessage(
      "Your current plan",
    ),
    "customer": MessageLookupByLibrary.simpleMessage("Customer"),
    "customerHint": MessageLookupByLibrary.simpleMessage(
      "Book a haircut and buy care products",
    ),
    "customerLabel": MessageLookupByLibrary.simpleMessage("Customer"),
    "customerLabelOptional": MessageLookupByLibrary.simpleMessage(
      "Customer (optional)",
    ),
    "customerOrdersTitle": MessageLookupByLibrary.simpleMessage("My Orders"),
    "customerPhoneLabel": MessageLookupByLibrary.simpleMessage(
      "Customer phone",
    ),
    "customerPhoneLabelOptional": MessageLookupByLibrary.simpleMessage(
      "Customer phone (optional)",
    ),
    "customerShellPlaceholder": MessageLookupByLibrary.simpleMessage(
      "You\'re in! The rest of the app is coming soon.",
    ),
    "dailyBreakdownTitle": MessageLookupByLibrary.simpleMessage("Last 7 days"),
    "dashboardTitle": MessageLookupByLibrary.simpleMessage("Home"),
    "dayFriday": MessageLookupByLibrary.simpleMessage("Friday"),
    "dayMonday": MessageLookupByLibrary.simpleMessage("Monday"),
    "daySaturday": MessageLookupByLibrary.simpleMessage("Saturday"),
    "daySunday": MessageLookupByLibrary.simpleMessage("Sunday"),
    "dayThursday": MessageLookupByLibrary.simpleMessage("Thursday"),
    "dayTuesday": MessageLookupByLibrary.simpleMessage("Tuesday"),
    "dayWednesday": MessageLookupByLibrary.simpleMessage("Wednesday"),
    "daysAgo": m5,
    "decisionDeadlineLabel": MessageLookupByLibrary.simpleMessage("Respond by"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete account"),
    "deleteAccountConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirm deletion",
    ),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage(
      "Permanently delete account",
    ),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "Your account and all your data will be permanently deleted. Enter your password to confirm.",
    ),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("Delete category"),
    "deleteCategoryConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this category?",
    ),
    "deleteDocument": MessageLookupByLibrary.simpleMessage("Delete file"),
    "deleteDocumentConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this file? You can upload it again later.",
    ),
    "deleteDrink": MessageLookupByLibrary.simpleMessage("Delete drink"),
    "deleteDrinkConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to remove this drink from the menu?",
    ),
    "deleteMemberPermanentlyConfirm": MessageLookupByLibrary.simpleMessage(
      "This member will be permanently deleted and this cannot be undone. Continue?",
    ),
    "deleteMemberPermanentlyTitle": MessageLookupByLibrary.simpleMessage(
      "Delete member permanently",
    ),
    "deleteOwnServiceConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this custom service?",
    ),
    "deleteOwnServiceTitle": MessageLookupByLibrary.simpleMessage(
      "Delete custom service",
    ),
    "deletePhone": MessageLookupByLibrary.simpleMessage("Delete number"),
    "deletePhoneConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this number?",
    ),
    "deleteProduct": MessageLookupByLibrary.simpleMessage("Delete product"),
    "deleteProductConfirm": MessageLookupByLibrary.simpleMessage(
      "It will be removed from the barbers\' store. Are you sure?",
    ),
    "deleteServiceConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this service? Past bookings won\'t be affected.",
    ),
    "deleteServiceTitle": MessageLookupByLibrary.simpleMessage(
      "Delete service",
    ),
    "deleteStorefrontProductConfirm": MessageLookupByLibrary.simpleMessage(
      "It will be removed from your storefront. Are you sure?",
    ),
    "deliveredThisMonth": MessageLookupByLibrary.simpleMessage(
      "Delivered this month",
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
    "deliveryNotOfferedReason": MessageLookupByLibrary.simpleMessage(
      "This merchant does not offer delivery",
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
    "discountedProducts": MessageLookupByLibrary.simpleMessage(
      "Discounted products",
    ),
    "discountsTitle": MessageLookupByLibrary.simpleMessage(
      "Offers and discounts",
    ),
    "documentAddedByAdmin": MessageLookupByLibrary.simpleMessage(
      "Added by the admin",
    ),
    "documentDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "File deleted",
    ),
    "documentLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Could not load the file",
    ),
    "documentNotUploadedYet": MessageLookupByLibrary.simpleMessage(
      "Not uploaded yet",
    ),
    "documentOptional": MessageLookupByLibrary.simpleMessage("Optional"),
    "documentRequired": MessageLookupByLibrary.simpleMessage("Required"),
    "documentTooLarge": m6,
    "documentUnsupportedType": MessageLookupByLibrary.simpleMessage(
      "Only images or PDF files are allowed",
    ),
    "documentUploaded": MessageLookupByLibrary.simpleMessage("Uploaded"),
    "documentUploadedSuccess": MessageLookupByLibrary.simpleMessage(
      "File uploaded",
    ),
    "documentsAllUploaded": MessageLookupByLibrary.simpleMessage(
      "All required documents are uploaded",
    ),
    "documentsBlockedHeadline": MessageLookupByLibrary.simpleMessage(
      "Upload your documents to continue",
    ),
    "documentsBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "The admin needs these files before you can use the app. Once they\'re uploaded, everything unlocks right away.",
    ),
    "documentsBlockedTitle": MessageLookupByLibrary.simpleMessage(
      "Required documents",
    ),
    "documentsMissingRequired": m7,
    "documentsNote": m8,
    "documentsOptionalMessage": MessageLookupByLibrary.simpleMessage(
      "Optional — upload them whenever you like",
    ),
    "documentsOptionalTitle": MessageLookupByLibrary.simpleMessage(
      "Documents you can add",
    ),
    "documentsPendingReview": MessageLookupByLibrary.simpleMessage(
      "Your account is under review until the admin approves your documents.",
    ),
    "documentsProgress": m9,
    "documentsRequestedMessage": MessageLookupByLibrary.simpleMessage(
      "The admin is waiting for files from you",
    ),
    "documentsRequestedTitle": MessageLookupByLibrary.simpleMessage(
      "Documents requested",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "dont_have_account": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "drinkActive": MessageLookupByLibrary.simpleMessage(
      "Available to customers",
    ),
    "drinkInactive": MessageLookupByLibrary.simpleMessage("Off"),
    "drinkName": MessageLookupByLibrary.simpleMessage("Drink name"),
    "drinkNameHint": MessageLookupByLibrary.simpleMessage(
      "Tea, coffee, water…",
    ),
    "drinkNameRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the drink name",
    ),
    "drinkPrice": MessageLookupByLibrary.simpleMessage("Price in EGP"),
    "drinkPriceHint": MessageLookupByLibrary.simpleMessage("10"),
    "drinkPriceRequired": MessageLookupByLibrary.simpleMessage(
      "Enter a valid price",
    ),
    "drinksSubtitle": MessageLookupByLibrary.simpleMessage(
      "Your shop\'s drink menu, added to the customer\'s bill",
    ),
    "drinksTitle": MessageLookupByLibrary.simpleMessage("Drinks"),
    "earningsClientsLine": m10,
    "earningsLast7Days": MessageLookupByLibrary.simpleMessage("Last 7 days"),
    "earningsThisMonth": MessageLookupByLibrary.simpleMessage("This month"),
    "earningsTitle": MessageLookupByLibrary.simpleMessage("Earnings"),
    "earningsToday": MessageLookupByLibrary.simpleMessage("Today"),
    "editBillAction": MessageLookupByLibrary.simpleMessage("Edit the bill"),
    "editBillTitle": MessageLookupByLibrary.simpleMessage("Edit the bill"),
    "editCategory": MessageLookupByLibrary.simpleMessage("Edit category"),
    "editDiscount": MessageLookupByLibrary.simpleMessage("Edit offer"),
    "editDrink": MessageLookupByLibrary.simpleMessage("Edit drink"),
    "editMemberTitle": MessageLookupByLibrary.simpleMessage("Edit member"),
    "editMyInfo": MessageLookupByLibrary.simpleMessage("Edit my info"),
    "editProduct": MessageLookupByLibrary.simpleMessage("Edit product"),
    "editServiceTitle": MessageLookupByLibrary.simpleMessage("Edit service"),
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
    "enterInviteCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Enter invite code",
    ),
    "enterOtpCode": MessageLookupByLibrary.simpleMessage(
      "Enter the verification code",
    ),
    "enter_password": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "errorDefaultTitle": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "everythingFine": MessageLookupByLibrary.simpleMessage(
      "All good — nothing needs action",
    ),
    "extraPhones": MessageLookupByLibrary.simpleMessage("Extra phone numbers"),
    "extraPhonesNote": MessageLookupByLibrary.simpleMessage(
      "Additional contact numbers for salons to reach you. Your login number is changed by the admin.",
    ),
    "favoritesTitle": MessageLookupByLibrary.simpleMessage("Favorites"),
    "featureLockedApproval": MessageLookupByLibrary.simpleMessage(
      "This feature will be available once your account is approved.",
    ),
    "field_required": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "filesSource": MessageLookupByLibrary.simpleMessage("Files"),
    "filterAll": MessageLookupByLibrary.simpleMessage("All"),
    "financialSection": MessageLookupByLibrary.simpleMessage("Financials"),
    "forceChangePasswordMessage": MessageLookupByLibrary.simpleMessage(
      "You signed in with a temporary password. Choose a new one to continue.",
    ),
    "forceChangePasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Password change required",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "forgotPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number and we\'ll send a code",
    ),
    "forgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Recover password",
    ),
    "freeDelivery": MessageLookupByLibrary.simpleMessage("Free"),
    "fulfilmentDelivery": MessageLookupByLibrary.simpleMessage("Delivery"),
    "fulfilmentPickup": MessageLookupByLibrary.simpleMessage(
      "Pickup at branch",
    ),
    "fulfilmentTitle": MessageLookupByLibrary.simpleMessage("Fulfilment"),
    "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
    "globalCategories": MessageLookupByLibrary.simpleMessage(
      "Global categories",
    ),
    "goToDocuments": MessageLookupByLibrary.simpleMessage("Go to documents"),
    "grandTotalLabel": MessageLookupByLibrary.simpleMessage("Grand total"),
    "greeting": MessageLookupByLibrary.simpleMessage("Good morning,"),
    "haircutStylesSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Haircut styles",
    ),
    "homeAllClear": MessageLookupByLibrary.simpleMessage("No pending bookings"),
    "homeNeedsAttentionTitle": MessageLookupByLibrary.simpleMessage(
      "Needs your attention",
    ),
    "homeNoQueueToday": MessageLookupByLibrary.simpleMessage(
      "No bookings queued for today",
    ),
    "hoursSaved": MessageLookupByLibrary.simpleMessage("Working hours saved"),
    "identityLockedAction": MessageLookupByLibrary.simpleMessage(
      "Your name and business name can\'t be changed after activation",
    ),
    "identityLockedMessage": MessageLookupByLibrary.simpleMessage(
      "Your name and business name can\'t be changed after your account is activated. Contact support if you need to update them.",
    ),
    "identityLockedTitle": MessageLookupByLibrary.simpleMessage(
      "Your details are verified",
    ),
    "inStock": MessageLookupByLibrary.simpleMessage("In stock"),
    "inactiveProducts": MessageLookupByLibrary.simpleMessage("Paused products"),
    "instagram_error": MessageLookupByLibrary.simpleMessage(
      "Could not open Instagram",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("Invalid number"),
    "invalidPrice": MessageLookupByLibrary.simpleMessage("Invalid price"),
    "invalid_national_id": MessageLookupByLibrary.simpleMessage(
      "Invalid national ID",
    ),
    "inventoryTitle": MessageLookupByLibrary.simpleMessage("Inventory"),
    "inviteCodeHint": MessageLookupByLibrary.simpleMessage("e.g. ABC123"),
    "inviteCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the invite code",
    ),
    "inviteFavoritesLabel": MessageLookupByLibrary.simpleMessage(
      "Customers via this link",
    ),
    "inviteLinkCopied": MessageLookupByLibrary.simpleMessage("Link copied"),
    "inviteNote": MessageLookupByLibrary.simpleMessage(
      "Share this link with customers — anyone who joins through it becomes your favorite automatically.",
    ),
    "inviteRegenerated": MessageLookupByLibrary.simpleMessage(
      "Link regenerated",
    ),
    "inviteTitle": MessageLookupByLibrary.simpleMessage("Invite link"),
    "inviteePreviewTitle": MessageLookupByLibrary.simpleMessage(
      "Barber invite",
    ),
    "kmUnit": MessageLookupByLibrary.simpleMessage("km"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "latestOrders": MessageLookupByLibrary.simpleMessage("Latest orders"),
    "listSeparator": MessageLookupByLibrary.simpleMessage(", "),
    "liveDiscounts": MessageLookupByLibrary.simpleMessage("Live offers"),
    "locationBlockedHeadline": MessageLookupByLibrary.simpleMessage(
      "Set your shop location to continue",
    ),
    "locationBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "We need your shop\'s location before you can use the app. Once it\'s saved, everything unlocks right away.",
    ),
    "locationNote": MessageLookupByLibrary.simpleMessage(
      "Pin your shop\'s location so customers can find you and see accurate distance.",
    ),
    "locationPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "Location permission is required",
    ),
    "locationSaved": MessageLookupByLibrary.simpleMessage("Location saved"),
    "locationServiceDisabled": MessageLookupByLibrary.simpleMessage(
      "Please enable location services",
    ),
    "locationTestVersionNote": MessageLookupByLibrary.simpleMessage(
      "Test version: for now you can only send your current device location. Picking a location on the map is coming soon.",
    ),
    "locationTitle": MessageLookupByLibrary.simpleMessage("Shop location"),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Sign in with your merchant account to manage products and orders",
    ),
    "loginSubtitleBarber": MessageLookupByLibrary.simpleMessage(
      "Sign in with your barber account to manage your bookings and shop",
    ),
    "loginSubtitleCustomer": MessageLookupByLibrary.simpleMessage(
      "Sign in to book your barber and order your favorite products",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Log out"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out?",
    ),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("Log out"),
    "management": MessageLookupByLibrary.simpleMessage("Management"),
    "markAllRead": MessageLookupByLibrary.simpleMessage("Mark all as read"),
    "memberActivated": MessageLookupByLibrary.simpleMessage(
      "Member re-activated",
    ),
    "memberAdded": MessageLookupByLibrary.simpleMessage("Team member added"),
    "memberBlocked": MessageLookupByLibrary.simpleMessage("Member blocked"),
    "memberClientsDateRangeAction": MessageLookupByLibrary.simpleMessage(
      "Change period",
    ),
    "memberClientsEmpty": MessageLookupByLibrary.simpleMessage(
      "No clients in this period",
    ),
    "memberClientsTitle": MessageLookupByLibrary.simpleMessage(
      "Member clients",
    ),
    "memberDeletedPermanently": MessageLookupByLibrary.simpleMessage(
      "Member deleted permanently",
    ),
    "memberDetailTitle": MessageLookupByLibrary.simpleMessage("Team member"),
    "memberEarningsTitle": MessageLookupByLibrary.simpleMessage(
      "Member earnings",
    ),
    "memberHoursTitle": MessageLookupByLibrary.simpleMessage("Working hours"),
    "memberNameHint": MessageLookupByLibrary.simpleMessage("e.g. Karim"),
    "memberNameLabel": MessageLookupByLibrary.simpleMessage("Name"),
    "memberPhoneHint": MessageLookupByLibrary.simpleMessage("e.g. 01111111111"),
    "memberPhoneLabel": MessageLookupByLibrary.simpleMessage("Phone number"),
    "memberSaved": MessageLookupByLibrary.simpleMessage("Member details saved"),
    "memberServicesTitle": MessageLookupByLibrary.simpleMessage("Services"),
    "memberTaglineHint": MessageLookupByLibrary.simpleMessage("Optional"),
    "memberTaglineLabel": MessageLookupByLibrary.simpleMessage("Tagline"),
    "memberTaglineOptionalLabel": MessageLookupByLibrary.simpleMessage(
      "Tagline (optional)",
    ),
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
    "minutesUnit": MessageLookupByLibrary.simpleMessage("min"),
    "missingDocsBody": MessageLookupByLibrary.simpleMessage(
      "Please upload the required documents to activate your account.",
    ),
    "missingDocsTitle": MessageLookupByLibrary.simpleMessage(
      "Missing documents",
    ),
    "monthRevenue": MessageLookupByLibrary.simpleMessage("Month revenue"),
    "moreSection": MessageLookupByLibrary.simpleMessage("More"),
    "moveStatusTo": m11,
    "myCategories": MessageLookupByLibrary.simpleMessage("My categories"),
    "myCategoriesCount": m12,
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
    "nearestShopsTitle": MessageLookupByLibrary.simpleMessage(
      "Nearest salons to you",
    ),
    "needsAttention": MessageLookupByLibrary.simpleMessage(
      "Needs your attention",
    ),
    "netThisMonthLabel": MessageLookupByLibrary.simpleMessage("Net this month"),
    "newCategory": MessageLookupByLibrary.simpleMessage("New category"),
    "newCategoryHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Premium offers",
    ),
    "newDiscount": MessageLookupByLibrary.simpleMessage("New offer"),
    "newDiscountSinceOrderLabel": m13,
    "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
    "newStorefrontOrdersCount": m14,
    "nextRenewalLabel": MessageLookupByLibrary.simpleMessage("Next renewal"),
    "noAccountRegister": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? Register as a merchant",
    ),
    "noAccountRegisterBarber": MessageLookupByLibrary.simpleMessage(
      "No account? Register as barber",
    ),
    "noAccountRegisterCustomer": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? Register now",
    ),
    "noActivePlan": MessageLookupByLibrary.simpleMessage(
      "No active plan right now",
    ),
    "noBarbersYet": MessageLookupByLibrary.simpleMessage(
      "No barbers available at this salon right now",
    ),
    "noBookingHistory": MessageLookupByLibrary.simpleMessage("No bookings yet"),
    "noBookingsYet": MessageLookupByLibrary.simpleMessage(
      "You haven\'t made any bookings yet",
    ),
    "noDiscountsYet": MessageLookupByLibrary.simpleMessage("No offers yet"),
    "noDocuments": MessageLookupByLibrary.simpleMessage(
      "No documents requested yet",
    ),
    "noDocumentsMessage": MessageLookupByLibrary.simpleMessage(
      "The admin has not requested any documents from you yet.",
    ),
    "noDrinks": MessageLookupByLibrary.simpleMessage("No drinks yet"),
    "noDrinksHint": MessageLookupByLibrary.simpleMessage(
      "Add tea, coffee and water so you can put them on the bill.",
    ),
    "noExtraPhones": MessageLookupByLibrary.simpleMessage(
      "No extra numbers yet",
    ),
    "noFavoritesYet": MessageLookupByLibrary.simpleMessage(
      "You haven\'t favorited any barber yet",
    ),
    "noInternet": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "noMerchantsYet": MessageLookupByLibrary.simpleMessage(
      "No suppliers available yet",
    ),
    "noOrdersYet": MessageLookupByLibrary.simpleMessage("No orders yet"),
    "noOwnCategories": MessageLookupByLibrary.simpleMessage(
      "No custom categories yet",
    ),
    "noOwnServicesYet": MessageLookupByLibrary.simpleMessage(
      "No custom services yet",
    ),
    "noPendingBookings": MessageLookupByLibrary.simpleMessage(
      "No bookings awaiting confirmation",
    ),
    "noProductsYet": MessageLookupByLibrary.simpleMessage("No products yet"),
    "noReviewsYet": MessageLookupByLibrary.simpleMessage("No reviews yet"),
    "noShopsYet": MessageLookupByLibrary.simpleMessage(
      "No salons available right now",
    ),
    "noSlotsAvailable": MessageLookupByLibrary.simpleMessage(
      "No slots available on this day",
    ),
    "noSubscriptionRequests": MessageLookupByLibrary.simpleMessage(
      "No requests yet",
    ),
    "noTeamMembersYet": MessageLookupByLibrary.simpleMessage(
      "No team members yet",
    ),
    "noUpcomingBookingsHint": MessageLookupByLibrary.simpleMessage(
      "You have no upcoming bookings right now",
    ),
    "noWalletTransactions": MessageLookupByLibrary.simpleMessage(
      "No transactions yet",
    ),
    "notNow": MessageLookupByLibrary.simpleMessage("Not now"),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
      "No notifications",
    ),
    "notificationsEmptyHint": MessageLookupByLibrary.simpleMessage(
      "New orders and updates will show up here",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "openTimeLabel": MessageLookupByLibrary.simpleMessage("Opens at"),
    "or": MessageLookupByLibrary.simpleMessage("or"),
    "orderAcceptedAtLabel": MessageLookupByLibrary.simpleMessage("Accepted at"),
    "orderCancellationNoteLabel": MessageLookupByLibrary.simpleMessage(
      "Cancellation reason",
    ),
    "orderCancelledAtLabel": MessageLookupByLibrary.simpleMessage(
      "Cancelled at",
    ),
    "orderCancelledByLabel": MessageLookupByLibrary.simpleMessage(
      "Cancelled by",
    ),
    "orderDateLabel": MessageLookupByLibrary.simpleMessage("Order date"),
    "orderDeliveredAtLabel": MessageLookupByLibrary.simpleMessage(
      "Delivered at",
    ),
    "orderDeliveryAddressLabel": MessageLookupByLibrary.simpleMessage(
      "Delivery address",
    ),
    "orderDiscountLabel": MessageLookupByLibrary.simpleMessage(
      "Order discount",
    ),
    "orderDiscountWithPercentLabel": m15,
    "orderFulfilmentTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Fulfilment type",
    ),
    "orderInfoTitle": MessageLookupByLibrary.simpleMessage("Order details"),
    "orderNoteHint": MessageLookupByLibrary.simpleMessage(
      "Add a note for the supplier",
    ),
    "orderNoteLabel": MessageLookupByLibrary.simpleMessage("Order note"),
    "orderNoteTitle": MessageLookupByLibrary.simpleMessage("Note (optional)"),
    "orderPlaced": MessageLookupByLibrary.simpleMessage("Order placed"),
    "orderRejectedAtLabel": MessageLookupByLibrary.simpleMessage("Rejected at"),
    "orderRejectionReasonLabel": MessageLookupByLibrary.simpleMessage(
      "Rejection reason",
    ),
    "orderTotal": MessageLookupByLibrary.simpleMessage("Total"),
    "orderedItems": MessageLookupByLibrary.simpleMessage("Ordered items"),
    "otpRequired": MessageLookupByLibrary.simpleMessage("Enter the full code"),
    "otpResentMessage": MessageLookupByLibrary.simpleMessage(
      "A new code has been sent",
    ),
    "otpSentTo": MessageLookupByLibrary.simpleMessage("Code sent to"),
    "outOfStock": MessageLookupByLibrary.simpleMessage("Out of stock"),
    "outOfStockProducts": MessageLookupByLibrary.simpleMessage("Out of stock"),
    "outOfStockShort": MessageLookupByLibrary.simpleMessage("Out of stock"),
    "overviewTitle": MessageLookupByLibrary.simpleMessage("Overview"),
    "ownServiceDescriptionHint": MessageLookupByLibrary.simpleMessage(
      "Write a short description",
    ),
    "ownServiceDescriptionLabel": MessageLookupByLibrary.simpleMessage(
      "Description",
    ),
    "ownServiceNameHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Signature cut",
    ),
    "ownServiceNameLabel": MessageLookupByLibrary.simpleMessage("Service name"),
    "ownServicesTitle": MessageLookupByLibrary.simpleMessage(
      "Your custom services",
    ),
    "ownerLabel": MessageLookupByLibrary.simpleMessage("Owner"),
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
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "passwordResetSuccess": MessageLookupByLibrary.simpleMessage(
      "Password reset",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Password is too short",
    ),
    "paymentMethodCard": MessageLookupByLibrary.simpleMessage("Card"),
    "paymentMethodCash": MessageLookupByLibrary.simpleMessage(
      "Cash on delivery",
    ),
    "paymentMethodLabel": MessageLookupByLibrary.simpleMessage(
      "Payment method",
    ),
    "paymentMethodWallet": MessageLookupByLibrary.simpleMessage("Wallet"),
    "paymentMethodsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Available payment methods",
    ),
    "pendingApprovalTitle": MessageLookupByLibrary.simpleMessage(
      "Account under review",
    ),
    "pendingOrders": MessageLookupByLibrary.simpleMessage("Pending orders"),
    "peopleAheadLabel": MessageLookupByLibrary.simpleMessage(
      "People ahead of you",
    ),
    "percentAboveMax": MessageLookupByLibrary.simpleMessage(
      "Percentage cannot exceed 100%",
    ),
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
    "placeOrder": MessageLookupByLibrary.simpleMessage("Place order"),
    "planStatusActive": MessageLookupByLibrary.simpleMessage("Active"),
    "planStatusPending": MessageLookupByLibrary.simpleMessage(
      "Awaiting approval",
    ),
    "pleaseCheckYourConnectionAndTryAgain":
        MessageLookupByLibrary.simpleMessage(
          "Please check your connection and try again",
        ),
    "please_enter_a_valid_phone_number": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid phone number",
    ),
    "priceChangedSinceOrderLabel": m16,
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
    "productMetaLine": m17,
    "productName": MessageLookupByLibrary.simpleMessage("Product name"),
    "productNameHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Strong hold wax - salon pack",
    ),
    "productNameRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the product name",
    ),
    "productRequired": MessageLookupByLibrary.simpleMessage("Choose a product"),
    "productsCount": MessageLookupByLibrary.simpleMessage("Products"),
    "productsNote": MessageLookupByLibrary.simpleMessage(
      "What you list here is only visible to barbers in their supplies store",
    ),
    "publishProduct": MessageLookupByLibrary.simpleMessage("Publish product"),
    "purchasesSection": MessageLookupByLibrary.simpleMessage("Purchases"),
    "queueEmpty": MessageLookupByLibrary.simpleMessage("The queue is empty"),
    "queuePositionLabel": MessageLookupByLibrary.simpleMessage(
      "Queue position",
    ),
    "quotaEmployees": MessageLookupByLibrary.simpleMessage("Employees"),
    "quotaNotificationsAll": MessageLookupByLibrary.simpleMessage(
      "Notifications (all)",
    ),
    "quotaNotificationsZone": MessageLookupByLibrary.simpleMessage(
      "Notifications (zone)",
    ),
    "quotaOwnCategories": MessageLookupByLibrary.simpleMessage(
      "Own categories",
    ),
    "quotaProducts": MessageLookupByLibrary.simpleMessage("Products"),
    "quotaUnlimited": MessageLookupByLibrary.simpleMessage("Unlimited"),
    "quotaUsedOfCap": m18,
    "quoteAllShops": MessageLookupByLibrary.simpleMessage("All shops"),
    "quoteAppliedTitle": MessageLookupByLibrary.simpleMessage(
      "Discounts that fired",
    ),
    "quoteCalculate": MessageLookupByLibrary.simpleMessage("Calculate"),
    "quoteEmpty": MessageLookupByLibrary.simpleMessage(
      "Pick at least one product to see the maths",
    ),
    "quoteGift": MessageLookupByLibrary.simpleMessage("Gift"),
    "quoteGrossTotal": MessageLookupByLibrary.simpleMessage(
      "Total before any discount",
    ),
    "quoteNoDiscount": MessageLookupByLibrary.simpleMessage(
      "No discounts apply to this cart",
    ),
    "quoteOrderDiscount": MessageLookupByLibrary.simpleMessage(
      "Order discount",
    ),
    "quotePickProducts": MessageLookupByLibrary.simpleMessage(
      "Pick products and quantities",
    ),
    "quoteSavings": MessageLookupByLibrary.simpleMessage("You save"),
    "quoteScopeShop": MessageLookupByLibrary.simpleMessage(
      "Test for a specific shop",
    ),
    "quoteSubtitle": MessageLookupByLibrary.simpleMessage(
      "Try a cart and see how discounts land before a barber orders",
    ),
    "quoteSubtotal": MessageLookupByLibrary.simpleMessage(
      "Total after product discounts",
    ),
    "quoteTitle": MessageLookupByLibrary.simpleMessage("Price preview"),
    "quoteTotal": MessageLookupByLibrary.simpleMessage("Final total"),
    "quoteUnitAfterDiscount": MessageLookupByLibrary.simpleMessage(
      "Unit price after discount",
    ),
    "rankLabel": m19,
    "rateBarberSubtitle": m20,
    "rateBarberTitle": MessageLookupByLibrary.simpleMessage("Rate the barber"),
    "rateBooking": MessageLookupByLibrary.simpleMessage("Rate booking"),
    "rateNoteHint": MessageLookupByLibrary.simpleMessage(
      "Write your feedback (optional)",
    ),
    "rateShopSubtitle": m21,
    "rateShopTitle": MessageLookupByLibrary.simpleMessage("Rate the shop"),
    "rateShopToo": MessageLookupByLibrary.simpleMessage("Rate the shop too"),
    "ratingLabel": MessageLookupByLibrary.simpleMessage("Rating"),
    "ratingSubmittedMessage": MessageLookupByLibrary.simpleMessage(
      "Thanks for your rating",
    ),
    "receiptPhotoAttached": MessageLookupByLibrary.simpleMessage(
      "Receipt photo attached",
    ),
    "regenerateInviteConfirm": MessageLookupByLibrary.simpleMessage(
      "The old link will stop working. Are you sure?",
    ),
    "regenerateInviteTitle": MessageLookupByLibrary.simpleMessage(
      "Regenerate link",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "registerBarber": MessageLookupByLibrary.simpleMessage(
      "Register as barber",
    ),
    "registerCustomer": MessageLookupByLibrary.simpleMessage(
      "Create a new account",
    ),
    "registerMerchant": MessageLookupByLibrary.simpleMessage(
      "Register a new merchant",
    ),
    "registerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Register your business and start selling barber supplies wholesale.",
    ),
    "registerSubtitleBarber": MessageLookupByLibrary.simpleMessage(
      "Register your shop and start taking bookings",
    ),
    "registerSubtitleCustomer": MessageLookupByLibrary.simpleMessage(
      "Register to book a haircut and buy care products from a nearby salon.",
    ),
    "rejectBooking": MessageLookupByLibrary.simpleMessage("Reject booking"),
    "rejectOrder": MessageLookupByLibrary.simpleMessage("Reject order"),
    "rejectReason": MessageLookupByLibrary.simpleMessage("Rejection reason"),
    "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
      "e.g. item is out of stock",
    ),
    "remove_leading_zero": MessageLookupByLibrary.simpleMessage(
      "Remove the leading zero",
    ),
    "renewAction": MessageLookupByLibrary.simpleMessage("Renew"),
    "replaceDocument": MessageLookupByLibrary.simpleMessage("Replace"),
    "requestStatusApproved": MessageLookupByLibrary.simpleMessage("Approved"),
    "requestStatusPending": MessageLookupByLibrary.simpleMessage(
      "Pending review",
    ),
    "requestStatusRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "requestTypeRenew": MessageLookupByLibrary.simpleMessage("Renew"),
    "requestTypeSubscribe": MessageLookupByLibrary.simpleMessage("Subscribe"),
    "requiredField": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "resend_code": MessageLookupByLibrary.simpleMessage("Resend code"),
    "resetPasswordConfirm": MessageLookupByLibrary.simpleMessage(
      "Set a new temporary password for this member?",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset password",
    ),
    "responsibleBarber": m22,
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "reviewsCount": m23,
    "reviewsTitle": MessageLookupByLibrary.simpleMessage("Reviews"),
    "rewardAmount": MessageLookupByLibrary.simpleMessage("Fixed amount"),
    "rewardFree": MessageLookupByLibrary.simpleMessage("Free"),
    "rewardPercent": MessageLookupByLibrary.simpleMessage("Percent %"),
    "rewardQuantityLabel": MessageLookupByLibrary.simpleMessage(
      "How many do they get?",
    ),
    "rewardTypeLabel": MessageLookupByLibrary.simpleMessage("Reward type"),
    "runningLowProducts": MessageLookupByLibrary.simpleMessage("Running low"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Save changes"),
    "saveNewPassword": MessageLookupByLibrary.simpleMessage("Save password"),
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
    "seeAll": MessageLookupByLibrary.simpleMessage("See all"),
    "selectStarsError": MessageLookupByLibrary.simpleMessage(
      "Select a star rating first",
    ),
    "sendBroadcast": MessageLookupByLibrary.simpleMessage("Send notification"),
    "sendCode": MessageLookupByLibrary.simpleMessage("Send code"),
    "servesClientsLabel": MessageLookupByLibrary.simpleMessage(
      "I work on clients",
    ),
    "servesClientsOffHint": MessageLookupByLibrary.simpleMessage(
      "You are hidden from customers and the queue, and you free an employee slot in your plan.",
    ),
    "servesClientsOnHint": MessageLookupByLibrary.simpleMessage(
      "Customers can see you and book with you.",
    ),
    "servesClientsTitle": MessageLookupByLibrary.simpleMessage(
      "Do you take clients?",
    ),
    "servesClientsUpdated": MessageLookupByLibrary.simpleMessage(
      "Your status has been updated",
    ),
    "serviceDurationHint": MessageLookupByLibrary.simpleMessage("e.g. 30"),
    "serviceDurationLabel": MessageLookupByLibrary.simpleMessage(
      "Duration (minutes)",
    ),
    "serviceLabel": MessageLookupByLibrary.simpleMessage("Service"),
    "serviceMetaLine": m24,
    "servicePriceHint": MessageLookupByLibrary.simpleMessage("e.g. 100"),
    "servicePriceLabel": MessageLookupByLibrary.simpleMessage("Price"),
    "servicesTitle": MessageLookupByLibrary.simpleMessage("Services"),
    "setNewPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Choose a new password for your account",
    ),
    "setNewPasswordTitle": MessageLookupByLibrary.simpleMessage("New password"),
    "shareDocument": MessageLookupByLibrary.simpleMessage("Share"),
    "shopDetailTitle": MessageLookupByLibrary.simpleMessage("Salon details"),
    "shopLabel": MessageLookupByLibrary.simpleMessage("Barbershop"),
    "shopName": MessageLookupByLibrary.simpleMessage("Shop name"),
    "shopNameHint": MessageLookupByLibrary.simpleMessage("Elegance Barbershop"),
    "shopNameRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the shop name",
    ),
    "shopOwner": MessageLookupByLibrary.simpleMessage("Shop owner"),
    "shopSection": MessageLookupByLibrary.simpleMessage("Shop"),
    "shops": MessageLookupByLibrary.simpleMessage("Salons"),
    "shopsAllHint": MessageLookupByLibrary.simpleMessage(
      "Selecting none = the offer applies to all salons",
    ),
    "shopsAllNote": MessageLookupByLibrary.simpleMessage(
      "The offer will apply to all salons",
    ),
    "shopsSelectedHint": m25,
    "shopsTitle": MessageLookupByLibrary.simpleMessage("Salons"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "skipForNow": MessageLookupByLibrary.simpleMessage("Not now"),
    "snapchat_error": MessageLookupByLibrary.simpleMessage(
      "Could not open Snapchat",
    ),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "sponsorshipActive": MessageLookupByLibrary.simpleMessage(
      "Promotion is live",
    ),
    "sponsorshipBarberSubtitle": MessageLookupByLibrary.simpleMessage(
      "Put your shop at the top of the customers\' list",
    ),
    "sponsorshipBought": MessageLookupByLibrary.simpleMessage(
      "Promotion activated",
    ),
    "sponsorshipBuy": MessageLookupByLibrary.simpleMessage(
      "Promote for a month",
    ),
    "sponsorshipConfirmMessage": m26,
    "sponsorshipConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Activate promotion",
    ),
    "sponsorshipDaysLeft": m27,
    "sponsorshipEndsAt": MessageLookupByLibrary.simpleMessage("Ends on"),
    "sponsorshipInactive": MessageLookupByLibrary.simpleMessage(
      "Promotion is off",
    ),
    "sponsorshipInsufficient": m28,
    "sponsorshipMerchantSubtitle": MessageLookupByLibrary.simpleMessage(
      "Put your products at the top of the barbers\' store",
    ),
    "sponsorshipMonthlyPrice": MessageLookupByLibrary.simpleMessage(
      "Monthly price",
    ),
    "sponsorshipTitle": MessageLookupByLibrary.simpleMessage("Promotion"),
    "sponsorshipTopUp": MessageLookupByLibrary.simpleMessage(
      "Top up the wallet",
    ),
    "sponsorshipWalletAvailable": MessageLookupByLibrary.simpleMessage(
      "Available in your wallet",
    ),
    "startedAtLabel": MessageLookupByLibrary.simpleMessage("Started at"),
    "statusAccepted": MessageLookupByLibrary.simpleMessage("Accepted"),
    "statusCancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "statusDelivered": MessageLookupByLibrary.simpleMessage("Delivered"),
    "statusOutForDelivery": MessageLookupByLibrary.simpleMessage(
      "Out for delivery",
    ),
    "statusPending": MessageLookupByLibrary.simpleMessage("Awaiting response"),
    "statusPickedUpAtBranch": MessageLookupByLibrary.simpleMessage(
      "Picked up at branch",
    ),
    "statusPreparing": MessageLookupByLibrary.simpleMessage("Preparing"),
    "statusReadyForPickup": MessageLookupByLibrary.simpleMessage(
      "Ready for pickup",
    ),
    "statusRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
    "stockQuantity": MessageLookupByLibrary.simpleMessage("Available stock"),
    "stockUnits": m29,
    "storeAndSalesSection": MessageLookupByLibrary.simpleMessage("Your Store"),
    "storeOrdersTitle": MessageLookupByLibrary.simpleMessage(
      "My supply orders",
    ),
    "storeTitle": MessageLookupByLibrary.simpleMessage("Suppliers store"),
    "storefrontCategoriesTitle": MessageLookupByLibrary.simpleMessage(
      "Storefront categories",
    ),
    "storefrontDeliveryMenuTitle": MessageLookupByLibrary.simpleMessage(
      "Storefront delivery",
    ),
    "storefrontOrdersSubtitle": MessageLookupByLibrary.simpleMessage(
      "Orders placed by customers from your storefront",
    ),
    "storefrontOrdersTitle": MessageLookupByLibrary.simpleMessage(
      "Storefront orders",
    ),
    "storefrontProductFormNote": MessageLookupByLibrary.simpleMessage(
      "This product appears to customers browsing your shop in the app.",
    ),
    "storefrontProductsNote": MessageLookupByLibrary.simpleMessage(
      "What you list here is what customers see and can order from your shop",
    ),
    "storefrontProductsTitle": MessageLookupByLibrary.simpleMessage(
      "My storefront",
    ),
    "storefrontTitle": MessageLookupByLibrary.simpleMessage("Your storefront"),
    "styleLabel": MessageLookupByLibrary.simpleMessage("Style"),
    "submitRating": MessageLookupByLibrary.simpleMessage("Submit rating"),
    "submitWalletRequest": MessageLookupByLibrary.simpleMessage(
      "Submit request",
    ),
    "subscribeAction": MessageLookupByLibrary.simpleMessage("Subscribe"),
    "subscriptionActivated": MessageLookupByLibrary.simpleMessage(
      "Subscription activated successfully",
    ),
    "subscriptionRequestSentPending": MessageLookupByLibrary.simpleMessage(
      "Wallet balance is insufficient — a request was sent to the admin for approval",
    ),
    "subscriptionRequestsTitle": MessageLookupByLibrary.simpleMessage(
      "Subscription request history",
    ),
    "subscriptionTitle": MessageLookupByLibrary.simpleMessage("Subscription"),
    "supplierSpendLabel": MessageLookupByLibrary.simpleMessage(
      "Supplier spend this month",
    ),
    "supportSection": MessageLookupByLibrary.simpleMessage("Support"),
    "switchShopCartConfirm": MessageLookupByLibrary.simpleMessage("Continue"),
    "switchShopCartMessage": MessageLookupByLibrary.simpleMessage(
      "Your cart has items from another shop. Continuing will clear it so you can start fresh with this shop.",
    ),
    "switchShopCartTitle": MessageLookupByLibrary.simpleMessage(
      "Clear current cart?",
    ),
    "tabAccount": MessageLookupByLibrary.simpleMessage("Account"),
    "tabBookings": MessageLookupByLibrary.simpleMessage("Bookings"),
    "tabDashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "tabFavorites": MessageLookupByLibrary.simpleMessage("Favorites"),
    "tabHome": MessageLookupByLibrary.simpleMessage("Home"),
    "tabOrders": MessageLookupByLibrary.simpleMessage("Orders"),
    "tabProducts": MessageLookupByLibrary.simpleMessage("Products"),
    "tabServices": MessageLookupByLibrary.simpleMessage("Services"),
    "tabStore": MessageLookupByLibrary.simpleMessage("Store"),
    "teamMember": MessageLookupByLibrary.simpleMessage("Team member"),
    "teamTitle": MessageLookupByLibrary.simpleMessage("Team"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "tiktok_error": MessageLookupByLibrary.simpleMessage(
      "Could not open TikTok",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "topProducts": MessageLookupByLibrary.simpleMessage("Most stocked"),
    "totalStockUnits": MessageLookupByLibrary.simpleMessage("Total units"),
    "transferAccountAccountNumber": MessageLookupByLibrary.simpleMessage(
      "Number",
    ),
    "transferAccountLabel": MessageLookupByLibrary.simpleMessage("Transfer to"),
    "transferAccountRequired": MessageLookupByLibrary.simpleMessage(
      "You must choose the account to transfer to",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
    "twitter_error": MessageLookupByLibrary.simpleMessage("Could not open X"),
    "underDevelopment": MessageLookupByLibrary.simpleMessage(
      "This app is still under development",
    ),
    "underReview": MessageLookupByLibrary.simpleMessage("Under review"),
    "unitDiscountPercentLabel": m30,
    "unitPrice": MessageLookupByLibrary.simpleMessage("Unit price (EGP)"),
    "upcomingBookingsTitle": MessageLookupByLibrary.simpleMessage(
      "Your upcoming bookings",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "updateRequired": MessageLookupByLibrary.simpleMessage("Update required"),
    "updateRequiredBody": MessageLookupByLibrary.simpleMessage(
      "A new version of the app is available. Please update to continue.",
    ),
    "uploadDocument": MessageLookupByLibrary.simpleMessage("Upload"),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "Use current location",
    ),
    "userName": MessageLookupByLibrary.simpleMessage("Name"),
    "userNameHint": MessageLookupByLibrary.simpleMessage("e.g. Mohamed Ahmed"),
    "userNameRequired": MessageLookupByLibrary.simpleMessage("Enter your name"),
    "vehicleType": MessageLookupByLibrary.simpleMessage("Vehicle type"),
    "verifiedBarber": MessageLookupByLibrary.simpleMessage("Verified barber"),
    "verifiedMerchant": MessageLookupByLibrary.simpleMessage(
      "Verified merchant",
    ),
    "verify": MessageLookupByLibrary.simpleMessage("Verify"),
    "verifyPhoneSubtitle": MessageLookupByLibrary.simpleMessage(
      "We sent a 6-digit code to your phone",
    ),
    "verifyPhoneTitle": MessageLookupByLibrary.simpleMessage(
      "Verify phone number",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "view": MessageLookupByLibrary.simpleMessage("View"),
    "viewCart": MessageLookupByLibrary.simpleMessage("View cart"),
    "viewDocument": MessageLookupByLibrary.simpleMessage("View"),
    "walkInAddonsLabel": MessageLookupByLibrary.simpleMessage(
      "Add-ons (optional)",
    ),
    "walkInBarberLabel": MessageLookupByLibrary.simpleMessage("Team member"),
    "walkInConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Confirm and add customer",
    ),
    "walkInConfirmEdit": MessageLookupByLibrary.simpleMessage("Edit"),
    "walkInConfirmTitle": MessageLookupByLibrary.simpleMessage("Review order"),
    "walkInConfirmTotalLabel": MessageLookupByLibrary.simpleMessage(
      "Extras total",
    ),
    "walkInNoteHint": MessageLookupByLibrary.simpleMessage("e.g. in a hurry"),
    "walkInNoteLabel": MessageLookupByLibrary.simpleMessage("Note (optional)"),
    "walkInPickerAddMore": MessageLookupByLibrary.simpleMessage("Add"),
    "walkInPickerDone": MessageLookupByLibrary.simpleMessage("Done"),
    "walkInPickerNoneSelected": MessageLookupByLibrary.simpleMessage("None"),
    "walkInSlotTimeLabel": MessageLookupByLibrary.simpleMessage("Time"),
    "walkInSlotTimeNow": MessageLookupByLibrary.simpleMessage("Now"),
    "walkInSlotTimeSpecific": MessageLookupByLibrary.simpleMessage(
      "Pick a time",
    ),
    "walletAvailableLabel": m31,
    "walletBalanceLabel": MessageLookupByLibrary.simpleMessage(
      "Current balance",
    ),
    "walletRequestAmountHint": MessageLookupByLibrary.simpleMessage(
      "Enter the amount",
    ),
    "walletRequestAmountLabel": MessageLookupByLibrary.simpleMessage("Amount"),
    "walletRequestAttachmentLabel": MessageLookupByLibrary.simpleMessage(
      "Receipt",
    ),
    "walletRequestCancelledSuccess": MessageLookupByLibrary.simpleMessage(
      "Request cancelled",
    ),
    "walletRequestCreatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Request submitted",
    ),
    "walletRequestDecidedAtLabel": MessageLookupByLibrary.simpleMessage(
      "Decided at",
    ),
    "walletRequestDecidedByLabel": MessageLookupByLibrary.simpleMessage(
      "Decided by",
    ),
    "walletRequestDecisionNoteLabel": MessageLookupByLibrary.simpleMessage(
      "Decision note",
    ),
    "walletRequestNoteHint": MessageLookupByLibrary.simpleMessage(
      "Add a note (optional)",
    ),
    "walletRequestNoteLabel": MessageLookupByLibrary.simpleMessage("Note"),
    "walletRequestStatusApproved": MessageLookupByLibrary.simpleMessage(
      "Approved",
    ),
    "walletRequestStatusCancelled": MessageLookupByLibrary.simpleMessage(
      "Cancelled",
    ),
    "walletRequestStatusPending": MessageLookupByLibrary.simpleMessage(
      "Pending",
    ),
    "walletRequestStatusRejected": MessageLookupByLibrary.simpleMessage(
      "Rejected",
    ),
    "walletRequestTypeDeposit": MessageLookupByLibrary.simpleMessage("Deposit"),
    "walletRequestTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Request type",
    ),
    "walletRequestTypeWithdraw": MessageLookupByLibrary.simpleMessage(
      "Withdraw",
    ),
    "walletRequestsEmpty": MessageLookupByLibrary.simpleMessage(
      "No requests yet",
    ),
    "walletRequestsTitle": MessageLookupByLibrary.simpleMessage(
      "Wallet requests",
    ),
    "walletTitle": MessageLookupByLibrary.simpleMessage("Wallet"),
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
    "withdrawAccountHint": MessageLookupByLibrary.simpleMessage(
      "The wallet/account number you want the money sent to",
    ),
    "withdrawAccountLabel": MessageLookupByLibrary.simpleMessage(
      "We\'ll transfer to this account",
    ),
    "withdrawAccountRequired": MessageLookupByLibrary.simpleMessage(
      "You must enter the account number to receive the money",
    ),
    "withdrawMethodLabel": MessageLookupByLibrary.simpleMessage(
      "How do you want to receive it?",
    ),
    "workingHoursTitle": MessageLookupByLibrary.simpleMessage("Working hours"),
    "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "youLabel": MessageLookupByLibrary.simpleMessage("You"),
    "your_session_has_been_expired": MessageLookupByLibrary.simpleMessage(
      "Your session has expired",
    ),
  };
}
