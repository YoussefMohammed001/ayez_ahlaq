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

  static String m0(type) => "${type} account";

  static String m1(note) => "Note: ${note}";

  static String m2(date) => "Active until ${date}";

  static String m3(days) => "${days} days left";

  static String m4(date) => "Decided on ${date}";

  static String m5(date) => "Request sent on ${date}";

  static String m6(price) => "Subscription price: ${price} EGP";

  static String m7(hours, minutes) => "${hours} h ${minutes} min";

  static String m8(hours) => "${hours} h";

  static String m9(name, date) => "Last changed by ${name} • ${date}";

  static String m10(from, to) => "Limit: ${from} ← ${to}";

  static String m11(from, to) => "Range: ${from} ← ${to}";

  static String m12(meters) => "${meters} m";

  static String m13(minutes) => "${minutes} min";

  static String m14(meters) =>
      "You must be within ${meters} m of the shop to check in";

  static String m15(duration) => "Shift length: ${duration}";

  static String m16(time) => "Started at ${time}";

  static String m17(duration) => "Today: ${duration}";

  static String m18(shopName) => "Booking at ${shopName}";

  static String m19(count) => "${count} recipients";

  static String m20(limit) =>
      "Global categories are set by the admin, and you can add up to ${limit} of your own.";

  static String m21(planName, price) =>
      "You\'re subscribing to the \"${planName}\" plan for ${price} EGP. Are you sure?";

  static String m22(amount) =>
      "You\'re about to submit a request for ${amount} EGP. Are you sure?";

  static String m23(amount) => "${amount} EGP";

  static String m24(date) => "Last order: ${date}";

  static String m25(count) => "${count} orders";

  static String m26(days) => "${days} days ago";

  static String m27(size) => "The file is too large — maximum ${size} MB";

  static String m28(count) => "${count} required documents are still missing";

  static String m29(size) =>
      "The admin sets which documents are needed. Upload an image or a PDF for each one, up to ${size} MB.";

  static String m30(uploaded, total) => "${uploaded} of ${total} uploaded";

  static String m31(clients) => "${clients} clients";

  static String m32(delta) => "Price delta: ${delta} EGP";

  static String m33(count) =>
      "You have ${count} home service invitations awaiting a reply";

  static String m34(count) =>
      "You have ${count} home service requests awaiting a reply";

  static String m35(newPrice, oldPrice) =>
      "The shop wants ${newPrice} instead of ${oldPrice}. Confirm or cancel the request.";

  static String m36(price) => "Starting from ${price} EGP";

  static String m37(hours) => "${hours} h";

  static String m38(hours, minutes) => "${hours} h ${minutes} min";

  static String m39(open, close) => "Opens ${open}, closes ${close}";

  static String m40(open, close) => "Opens ${open}, closes ${close} (next day)";

  static String m41(count) => "${count} required documents are missing";

  static String m42(status) => "Move status to \"${status}\"";

  static String m43(count, limit) => "My categories (${count}/${limit})";

  static String m44(percent, price) =>
      "This product now has a ${percent}% discount, priced at ${price}";

  static String m45(count) => "You have ${count} new orders on your store";

  static String m46(percent) => "Order discount (${percent}%)";

  static String m47(price) => "Product price changed, now ${price}";

  static String m48(price, stock, min) =>
      "${price} EGP · stock ${stock} · min ${min}";

  static String m49(amount) => "Products: ${amount} EGP";

  static String m50(used, cap) => "${used} of ${cap}";

  static String m51(rank) => "Rank #${rank}";

  static String m52(barberName) =>
      "How was your experience with ${barberName}?";

  static String m53(shopName) => "How was your experience with ${shopName}?";

  static String m54(name) => "Responsible barber: ${name}";

  static String m55(count) => "${count} reviews";

  static String m56(date) =>
      "You already have another booking on ${date}. It may be for you or a friend. Do you want to book again?";

  static String m57(price, duration) => "${price} EGP · ${duration} min";

  static String m58(count) => "${count} selected";

  static String m59(done, total) => "${done} of ${total} steps done";

  static String m60(count) => "The offer applies to ${count} salons";

  static String m61(minutes) =>
      "The service takes ${minutes} min, these are the available times for it.";

  static String m62(amount) =>
      "${amount} will be charged from your wallet and you stay promoted for 30 days.";

  static String m63(days) => "${days} days left";

  static String m64(amount) =>
      "Your wallet is short by ${amount}, top up first";

  static String m65(count) => "${count} units";

  static String m66(percent) => "${percent}% off";

  static String m67(merchantName) => "View ${merchantName}\'s store";

  static String m68(shopName) => "View ${shopName}\'s page";

  static String m69(amount) => "Available: ${amount} EGP";

  static String m70(amount) => "Your available balance: ${amount} EGP";

  static String m71(amount) => "Remaining after withdrawal: ${amount} EGP";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutApp": MessageLookupByLibrary.simpleMessage("About the app"),
    "aboutAppBody": MessageLookupByLibrary.simpleMessage(
      "Ayez Ahlaq — book your haircut at the nearest salon in seconds, choosing the barber, service and time that suit you.",
    ),
    "acceptHomeServiceRequest": MessageLookupByLibrary.simpleMessage(
      "Accept request",
    ),
    "acceptOrder": MessageLookupByLibrary.simpleMessage("Accept order"),
    "accountDeleted": MessageLookupByLibrary.simpleMessage("Account deleted"),
    "accountManagementSection": MessageLookupByLibrary.simpleMessage(
      "Account Management",
    ),
    "accountSection": MessageLookupByLibrary.simpleMessage("Account"),
    "accountTypeBadge": m0,
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
    "addAdjustment": MessageLookupByLibrary.simpleMessage(
      "Add a charge or discount",
    ),
    "addAtLeastOneAdjustment": MessageLookupByLibrary.simpleMessage(
      "Add at least one charge or discount",
    ),
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
    "adjustmentAmountHint": MessageLookupByLibrary.simpleMessage("30"),
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
    "adjustmentTypeAddition": MessageLookupByLibrary.simpleMessage("Addition"),
    "adjustmentTypeDiscount": MessageLookupByLibrary.simpleMessage("Discount"),
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
    "attendanceAdjustNote": m1,
    "attendanceAdjusted": MessageLookupByLibrary.simpleMessage("Adjusted"),
    "attendanceCheckIn": MessageLookupByLibrary.simpleMessage("Check in"),
    "attendanceCheckOut": MessageLookupByLibrary.simpleMessage("Check out"),
    "attendanceCheckedIn": MessageLookupByLibrary.simpleMessage(
      "You are checked in",
    ),
    "attendanceCheckedOut": MessageLookupByLibrary.simpleMessage(
      "You are checked out",
    ),
    "attendanceCorrectAction": MessageLookupByLibrary.simpleMessage("Correct"),
    "attendanceCorrectCheckIn": MessageLookupByLibrary.simpleMessage(
      "Check-in time",
    ),
    "attendanceCorrectCheckOut": MessageLookupByLibrary.simpleMessage(
      "Check-out time",
    ),
    "attendanceCorrectNote": MessageLookupByLibrary.simpleMessage(
      "Reason for the change",
    ),
    "attendanceCorrectNoteRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the reason for the change",
    ),
    "attendanceCorrectOutBeforeIn": MessageLookupByLibrary.simpleMessage(
      "Check-out must be after check-in",
    ),
    "attendanceCorrectSaved": MessageLookupByLibrary.simpleMessage(
      "Record corrected",
    ),
    "attendanceCorrectTitle": MessageLookupByLibrary.simpleMessage(
      "Correct record",
    ),
    "attendanceEnforceHint": MessageLookupByLibrary.simpleMessage(
      "A barber must be within the range of the shop to check in",
    ),
    "attendanceEnforceLabel": MessageLookupByLibrary.simpleMessage(
      "Limit check-in to the shop location",
    ),
    "attendanceEnforceOff": MessageLookupByLibrary.simpleMessage("Off"),
    "attendanceEnforceOn": MessageLookupByLibrary.simpleMessage("On"),
    "attendanceFeatureActiveUntil": m2,
    "attendanceFeatureCancelAction": MessageLookupByLibrary.simpleMessage(
      "Cancel the request",
    ),
    "attendanceFeatureCancelConfirmMessage":
        MessageLookupByLibrary.simpleMessage(
          "Are you sure you want to cancel the activation request?",
        ),
    "attendanceFeatureCancelConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Cancel the activation request",
    ),
    "attendanceFeatureCancelled": MessageLookupByLibrary.simpleMessage(
      "The request was cancelled",
    ),
    "attendanceFeatureDaysLeft": m3,
    "attendanceFeatureDecidedAt": m4,
    "attendanceFeatureEndingSoon": MessageLookupByLibrary.simpleMessage(
      "The subscription ends soon",
    ),
    "attendanceFeatureExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "The attendance subscription has ended",
    ),
    "attendanceFeatureLockedTitle": MessageLookupByLibrary.simpleMessage(
      "Attendance is not enabled",
    ),
    "attendanceFeatureMemberFallback": MessageLookupByLibrary.simpleMessage(
      "Ask the shop owner to enable the feature",
    ),
    "attendanceFeatureOffShort": MessageLookupByLibrary.simpleMessage(
      "Feature not enabled",
    ),
    "attendanceFeatureOwnerFallback": MessageLookupByLibrary.simpleMessage(
      "You can request the feature for your shop",
    ),
    "attendanceFeaturePendingSince": m5,
    "attendanceFeaturePendingTitle": MessageLookupByLibrary.simpleMessage(
      "Your request is under review",
    ),
    "attendanceFeaturePrice": m6,
    "attendanceFeatureRenewAction": MessageLookupByLibrary.simpleMessage(
      "Request renewal",
    ),
    "attendanceFeatureRequestAction": MessageLookupByLibrary.simpleMessage(
      "Request activation",
    ),
    "attendanceFeatureRequestConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "The request will be sent to the administration. Do you want to continue?",
    ),
    "attendanceFeatureRequestConfirmTitle":
        MessageLookupByLibrary.simpleMessage("Request attendance activation"),
    "attendanceFeatureRequested": MessageLookupByLibrary.simpleMessage(
      "The request was sent",
    ),
    "attendanceFeatureRequestsEmpty": MessageLookupByLibrary.simpleMessage(
      "No requests yet",
    ),
    "attendanceFeatureRequestsEmptyHint": MessageLookupByLibrary.simpleMessage(
      "Requests to enable attendance and the status of each will appear here.",
    ),
    "attendanceFeatureRequestsLink": MessageLookupByLibrary.simpleMessage(
      "Activation requests history",
    ),
    "attendanceFeatureRequestsTitle": MessageLookupByLibrary.simpleMessage(
      "Activation requests",
    ),
    "attendanceFeatureSuspendedTitle": MessageLookupByLibrary.simpleMessage(
      "Attendance has been stopped",
    ),
    "attendanceHistoryEmpty": MessageLookupByLibrary.simpleMessage(
      "No attendance records yet",
    ),
    "attendanceHistoryEmptyHint": MessageLookupByLibrary.simpleMessage(
      "Your check-in and check-out history will appear here after your first shift.",
    ),
    "attendanceHistoryTitle": MessageLookupByLibrary.simpleMessage(
      "Attendance history",
    ),
    "attendanceHomeCardAction": MessageLookupByLibrary.simpleMessage(
      "Open attendance",
    ),
    "attendanceHoursAndMinutes": m7,
    "attendanceHoursOnly": m8,
    "attendanceLastChange": m9,
    "attendanceLocationDenied": MessageLookupByLibrary.simpleMessage(
      "We need location permission to confirm you are at the shop",
    ),
    "attendanceLocationDeniedForever": MessageLookupByLibrary.simpleMessage(
      "Location permission is off, enable it from phone settings",
    ),
    "attendanceLocationServiceOff": MessageLookupByLibrary.simpleMessage(
      "Turn on location (GPS) to check in",
    ),
    "attendanceLocationUnavailable": MessageLookupByLibrary.simpleMessage(
      "We could not get your location, try again",
    ),
    "attendanceLogEmpty": MessageLookupByLibrary.simpleMessage(
      "No settings changes yet",
    ),
    "attendanceLogEmptyHint": MessageLookupByLibrary.simpleMessage(
      "Every change the owner makes to attendance settings appears here.",
    ),
    "attendanceLogEnforceChange": m10,
    "attendanceLogRangeChange": m11,
    "attendanceMeters": m12,
    "attendanceMinutesOnly": m13,
    "attendanceNoRange": MessageLookupByLibrary.simpleMessage("Not set"),
    "attendanceOffShift": MessageLookupByLibrary.simpleMessage(
      "Not checked in",
    ),
    "attendanceOnShift": MessageLookupByLibrary.simpleMessage("Checked in"),
    "attendanceOwnerBadge": MessageLookupByLibrary.simpleMessage("Owner"),
    "attendanceRangeHelper": MessageLookupByLibrary.simpleMessage(
      "Between 10 and 5000 meters",
    ),
    "attendanceRangeInvalid": MessageLookupByLibrary.simpleMessage(
      "Enter a distance between 10 and 5000 meters",
    ),
    "attendanceRangeLabel": MessageLookupByLibrary.simpleMessage(
      "Allowed distance (meters)",
    ),
    "attendanceRangeNotRequired": MessageLookupByLibrary.simpleMessage(
      "Check-in is not limited to a place",
    ),
    "attendanceRangeRequired": m14,
    "attendanceSettingsLogTitle": MessageLookupByLibrary.simpleMessage(
      "Settings change log",
    ),
    "attendanceSettingsSaved": MessageLookupByLibrary.simpleMessage(
      "Attendance settings saved",
    ),
    "attendanceSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Attendance settings",
    ),
    "attendanceShiftDuration": m15,
    "attendanceStartedAt": m16,
    "attendanceStillOpen": MessageLookupByLibrary.simpleMessage("Still open"),
    "attendanceTeamEmpty": MessageLookupByLibrary.simpleMessage(
      "There are no barbers in the team",
    ),
    "attendanceTeamNowTitle": MessageLookupByLibrary.simpleMessage(
      "Team attendance now",
    ),
    "attendanceTitle": MessageLookupByLibrary.simpleMessage("Attendance"),
    "attendanceTodayDuration": m17,
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
    "availableServicesSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Available services",
    ),
    "avatarFallback": MessageLookupByLibrary.simpleMessage("?"),
    "avgTicketLabel": MessageLookupByLibrary.simpleMessage("Average ticket"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "backOnline": MessageLookupByLibrary.simpleMessage("Back online"),
    "barber": MessageLookupByLibrary.simpleMessage("Barber"),
    "barberAvailableNow": MessageLookupByLibrary.simpleMessage("Available now"),
    "barberBusyNow": MessageLookupByLibrary.simpleMessage("Busy"),
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
    "barberRatingLabel": MessageLookupByLibrary.simpleMessage("Barber rating"),
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
    "bookingBasePriceLabel": MessageLookupByLibrary.simpleMessage(
      "Service price",
    ),
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
    "bookingSlotPassedMessage": MessageLookupByLibrary.simpleMessage(
      "This booking time has passed and can no longer be cancelled",
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
    "bookingStyleDeltaLabel": MessageLookupByLibrary.simpleMessage(
      "Style price",
    ),
    "bookingSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Booking summary",
    ),
    "bookingWithShopLabel": m18,
    "bookingsAndServicesSection": MessageLookupByLibrary.simpleMessage(
      "Bookings & Services",
    ),
    "bookingsHistoryTab": MessageLookupByLibrary.simpleMessage("History"),
    "bookingsPastTab": MessageLookupByLibrary.simpleMessage("Past"),
    "bookingsPendingTab": MessageLookupByLibrary.simpleMessage(
      "Awaiting confirmation",
    ),
    "bookingsQueueTab": MessageLookupByLibrary.simpleMessage("Today\'s queue"),
    "bookingsTitle": MessageLookupByLibrary.simpleMessage("Bookings"),
    "bookingsUnresolvedTab": MessageLookupByLibrary.simpleMessage("Unresolved"),
    "bookingsUpcomingTab": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "brand": MessageLookupByLibrary.simpleMessage("Brand"),
    "brandHint": MessageLookupByLibrary.simpleMessage("e.g. Wahl"),
    "broadcastBodyFieldHint": MessageLookupByLibrary.simpleMessage(
      "Notification message",
    ),
    "broadcastListEmpty": MessageLookupByLibrary.simpleMessage(
      "You haven\'t sent any notification yet",
    ),
    "broadcastListEmptyHint": MessageLookupByLibrary.simpleMessage(
      "Notifications you send to your customers will appear here.",
    ),
    "broadcastListTitle": MessageLookupByLibrary.simpleMessage(
      "Sent notifications",
    ),
    "broadcastNote": MessageLookupByLibrary.simpleMessage(
      "Send a push notification to your customers.",
    ),
    "broadcastRecipientCount": m19,
    "broadcastRejectionReasonLabel": MessageLookupByLibrary.simpleMessage(
      "Rejection reason",
    ),
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
    "browseAsGuest": MessageLookupByLibrary.simpleMessage("Browse as guest"),
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
    "cancelOrderConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Cancel order",
    ),
    "cancelOrderConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "You won\'t be able to undo this once the order is cancelled.",
    ),
    "cancelOrderConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Cancel order?",
    ),
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
    "cartEmptyHint": MessageLookupByLibrary.simpleMessage(
      "Add products from the store and they will show up here.",
    ),
    "cartTitle": MessageLookupByLibrary.simpleMessage("Cart"),
    "categoriesNote": m20,
    "category": MessageLookupByLibrary.simpleMessage("Category"),
    "categoryGlobal": MessageLookupByLibrary.simpleMessage("Global"),
    "categoryImage": MessageLookupByLibrary.simpleMessage("Category image"),
    "categoryOwn": MessageLookupByLibrary.simpleMessage("Mine"),
    "changeAccountType": MessageLookupByLibrary.simpleMessage(
      "Change account type",
    ),
    "changeLocationOnMap": MessageLookupByLibrary.simpleMessage(
      "Change location on the map",
    ),
    "changeMoneyPinAction": MessageLookupByLibrary.simpleMessage("Change PIN"),
    "changeMoneyPinTitle": MessageLookupByLibrary.simpleMessage("Change PIN"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change password"),
    "changePlanAction": MessageLookupByLibrary.simpleMessage(
      "Switch to this plan",
    ),
    "chooseAccountType": MessageLookupByLibrary.simpleMessage(
      "Choose your account type",
    ),
    "chooseBarberRole": MessageLookupByLibrary.simpleMessage(
      "Choose your account type so we can show the right screens",
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
    "clearCartConfirm": MessageLookupByLibrary.simpleMessage("Clear"),
    "clearCartMessage": MessageLookupByLibrary.simpleMessage(
      "All items in this cart will be removed.",
    ),
    "clearCartTitle": MessageLookupByLibrary.simpleMessage("Clear cart?"),
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
    "confirmBillMessage": MessageLookupByLibrary.simpleMessage(
      "Review the new bill details before saving",
    ),
    "confirmBillNewTotal": MessageLookupByLibrary.simpleMessage("New total"),
    "confirmBillNoChanges": MessageLookupByLibrary.simpleMessage(
      "No drinks or extras on this bill",
    ),
    "confirmBillSave": MessageLookupByLibrary.simpleMessage("Confirm & save"),
    "confirmBillTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm bill changes",
    ),
    "confirmBooking": MessageLookupByLibrary.simpleMessage("Confirm booking"),
    "confirmBookingMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to confirm this booking?",
    ),
    "confirmLocation": MessageLookupByLibrary.simpleMessage("Confirm location"),
    "confirmMoneyPinLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm new PIN",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "confirmReject": MessageLookupByLibrary.simpleMessage("Confirm rejection"),
    "confirmSubscribeMessage": m21,
    "confirmSubscribeTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm subscription",
    ),
    "confirmWalletRequestDepositTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm deposit",
    ),
    "confirmWalletRequestMessage": m22,
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
    "currencyEgp": m23,
    "currentMoneyPinLabel": MessageLookupByLibrary.simpleMessage("Current PIN"),
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
    "customerLastOrderAt": m24,
    "customerOrderCount": m25,
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
    "customerTotalSpend": MessageLookupByLibrary.simpleMessage("Total spend"),
    "customersSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search by name or phone",
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
    "daysAgo": m26,
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
    "deliveryAddressRequired": MessageLookupByLibrary.simpleMessage(
      "Enter a delivery address first",
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
    "distanceLabel": MessageLookupByLibrary.simpleMessage("Distance"),
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
    "documentTooLarge": m27,
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
    "documentsMissingRequired": m28,
    "documentsNote": m29,
    "documentsOptionalMessage": MessageLookupByLibrary.simpleMessage(
      "Optional — upload them whenever you like",
    ),
    "documentsOptionalTitle": MessageLookupByLibrary.simpleMessage(
      "Documents you can add",
    ),
    "documentsPendingReview": MessageLookupByLibrary.simpleMessage(
      "Your account is under review until the admin approves your documents.",
    ),
    "documentsProgress": m30,
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
    "earningsClientsLine": m31,
    "earningsLast7Days": MessageLookupByLibrary.simpleMessage("Last 7 days"),
    "earningsThisMonth": MessageLookupByLibrary.simpleMessage("This month"),
    "earningsTitle": MessageLookupByLibrary.simpleMessage("Earnings"),
    "earningsToday": MessageLookupByLibrary.simpleMessage("Today"),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editBillAction": MessageLookupByLibrary.simpleMessage("Edit the bill"),
    "editBillTitle": MessageLookupByLibrary.simpleMessage("Edit the bill"),
    "editCategory": MessageLookupByLibrary.simpleMessage("Edit category"),
    "editDiscount": MessageLookupByLibrary.simpleMessage("Edit offer"),
    "editDrink": MessageLookupByLibrary.simpleMessage("Edit drink"),
    "editHaircutStylePriceTitle": MessageLookupByLibrary.simpleMessage(
      "Style price",
    ),
    "editHomeServicePriceAction": MessageLookupByLibrary.simpleMessage(
      "Edit price",
    ),
    "editMemberTitle": MessageLookupByLibrary.simpleMessage("Edit member"),
    "editMyInfo": MessageLookupByLibrary.simpleMessage("Edit my info"),
    "editProduct": MessageLookupByLibrary.simpleMessage("Edit product"),
    "editServiceTitle": MessageLookupByLibrary.simpleMessage("Edit service"),
    "editStockTitle": MessageLookupByLibrary.simpleMessage("Edit stock"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailOptional": MessageLookupByLibrary.simpleMessage("Email (optional)"),
    "email_invalid": MessageLookupByLibrary.simpleMessage(
      "Invalid email address",
    ),
    "email_required": MessageLookupByLibrary.simpleMessage("Email is required"),
    "emptyDefaultTitle": MessageLookupByLibrary.simpleMessage(
      "Nothing here yet",
    ),
    "enableLocationAction": MessageLookupByLibrary.simpleMessage(
      "Enable location",
    ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterInviteCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Enter invite code",
    ),
    "enterOtpCode": MessageLookupByLibrary.simpleMessage(
      "Enter the verification code",
    ),
    "enterPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "enterPhoneNumberHint": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number",
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
    "extraPhoneFallbackLabel": MessageLookupByLibrary.simpleMessage(
      "Extra number",
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
    "grandTotalLabel": MessageLookupByLibrary.simpleMessage(
      "Total incl. delivery",
    ),
    "greeting": MessageLookupByLibrary.simpleMessage("Good morning,"),
    "guestLoginMessage": MessageLookupByLibrary.simpleMessage(
      "You need an account to use this feature. Sign in or create one in a few seconds",
    ),
    "guestLoginTitle": MessageLookupByLibrary.simpleMessage(
      "Sign in to continue",
    ),
    "guestName": MessageLookupByLibrary.simpleMessage("Guest"),
    "guestPlaceholderSubtitle": MessageLookupByLibrary.simpleMessage(
      "Sign in to see your orders, favorites and account",
    ),
    "guestPlaceholderTitle": MessageLookupByLibrary.simpleMessage(
      "You\'re browsing as a guest",
    ),
    "haircutStyleActiveLabel": MessageLookupByLibrary.simpleMessage("Bookable"),
    "haircutStyleNotPricedYet": MessageLookupByLibrary.simpleMessage(
      "Not priced yet",
    ),
    "haircutStylePriceDeltaHint": MessageLookupByLibrary.simpleMessage(
      "e.g. 20 or -10",
    ),
    "haircutStylePriceDeltaInvalid": MessageLookupByLibrary.simpleMessage(
      "Enter a valid number (negative allowed)",
    ),
    "haircutStylePriceDeltaLabel": MessageLookupByLibrary.simpleMessage(
      "Price delta (EGP)",
    ),
    "haircutStylePriceDeltaLine": m32,
    "haircutStylePriceUpdated": MessageLookupByLibrary.simpleMessage(
      "Style price updated",
    ),
    "haircutStylesSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Haircut styles",
    ),
    "haircutStylesTitle": MessageLookupByLibrary.simpleMessage(
      "Haircut styles",
    ),
    "helpContactHint": MessageLookupByLibrary.simpleMessage(
      "Didn\'t find your answer? Contact us here.",
    ),
    "helpFaqSection": MessageLookupByLibrary.simpleMessage("Common questions"),
    "helpMemberA1": MessageLookupByLibrary.simpleMessage(
      "Use the attendance card on the home screen. The app may require you to be near the shop.",
    ),
    "helpMemberA2": MessageLookupByLibrary.simpleMessage(
      "The card appears once the shop owner enables attendance.",
    ),
    "helpMemberA3": MessageLookupByLibrary.simpleMessage(
      "Open Bookings from the bottom bar, choose the request and tap accept or decline.",
    ),
    "helpMemberQ1": MessageLookupByLibrary.simpleMessage(
      "How do I check in and out?",
    ),
    "helpMemberQ2": MessageLookupByLibrary.simpleMessage(
      "Why can\'t I see the attendance card?",
    ),
    "helpMemberQ3": MessageLookupByLibrary.simpleMessage(
      "How do I accept or decline a booking?",
    ),
    "helpOwnerA1": MessageLookupByLibrary.simpleMessage(
      "Set your working hours, add your services and prices, then complete your documents. Your shop then appears to customers and they can book.",
    ),
    "helpOwnerA2": MessageLookupByLibrary.simpleMessage(
      "From your account open Shop then Team and tap Add member. You get a temporary password to give them.",
    ),
    "helpOwnerA3": MessageLookupByLibrary.simpleMessage(
      "Change the location under Account, Shop, Location. For the photo, tap the shop picture under Account.",
    ),
    "helpOwnerA4": MessageLookupByLibrary.simpleMessage(
      "Earnings show on the home screen; wallet details and top-up or withdrawal requests are under Account.",
    ),
    "helpOwnerQ1": MessageLookupByLibrary.simpleMessage(
      "How do I receive bookings?",
    ),
    "helpOwnerQ2": MessageLookupByLibrary.simpleMessage(
      "Where do I add a barber to my team?",
    ),
    "helpOwnerQ3": MessageLookupByLibrary.simpleMessage(
      "How do I change my shop location or photo?",
    ),
    "helpOwnerQ4": MessageLookupByLibrary.simpleMessage(
      "How do I follow my earnings and wallet?",
    ),
    "helpTitle": MessageLookupByLibrary.simpleMessage("Help"),
    "helpTourRow": MessageLookupByLibrary.simpleMessage("Guided tour"),
    "helpTourRowHint": MessageLookupByLibrary.simpleMessage(
      "Get to know the app step by step",
    ),
    "homeAllClear": MessageLookupByLibrary.simpleMessage("No pending bookings"),
    "homeNeedsAttentionTitle": MessageLookupByLibrary.simpleMessage(
      "Needs your attention",
    ),
    "homeNoQueueToday": MessageLookupByLibrary.simpleMessage(
      "No bookings queued for today",
    ),
    "homeServiceAddressRequired": MessageLookupByLibrary.simpleMessage(
      "Set the address and location first",
    ),
    "homeServiceAnyNearbyCta": MessageLookupByLibrary.simpleMessage(
      "Request any nearby barber",
    ),
    "homeServiceAnyNearbyDescription": MessageLookupByLibrary.simpleMessage(
      "We\'ll send your request to nearby barbers and the first one available will accept it.",
    ),
    "homeServiceAnyNearbyTitle": MessageLookupByLibrary.simpleMessage(
      "Any available barber",
    ),
    "homeServiceAwaitingPriceConfirmation": MessageLookupByLibrary.simpleMessage(
      "Waiting for the customer to confirm the new price before you can accept",
    ),
    "homeServiceBroadcastAccept": MessageLookupByLibrary.simpleMessage(
      "Accept",
    ),
    "homeServiceBroadcastDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Invitation details",
    ),
    "homeServiceBroadcastInboxTitle": MessageLookupByLibrary.simpleMessage(
      "Home service invitations",
    ),
    "homeServiceBroadcastPendingCount": m33,
    "homeServiceBroadcastReject": MessageLookupByLibrary.simpleMessage(
      "Reject",
    ),
    "homeServiceBroadcastRejectConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirm rejection",
    ),
    "homeServiceBroadcastRejectMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to reject this home service invitation?",
    ),
    "homeServiceBroadcastRejectTitle": MessageLookupByLibrary.simpleMessage(
      "Reject invitation",
    ),
    "homeServiceCancelConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirm cancellation",
    ),
    "homeServiceCancelMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to cancel this home service request?",
    ),
    "homeServiceCancelRequest": MessageLookupByLibrary.simpleMessage(
      "Cancel request",
    ),
    "homeServiceCancelTitle": MessageLookupByLibrary.simpleMessage(
      "Cancel request",
    ),
    "homeServiceCardDisabledHint": MessageLookupByLibrary.simpleMessage(
      "Turn it on to reach new customers at home",
    ),
    "homeServiceCardEnabledHint": MessageLookupByLibrary.simpleMessage(
      "Enabled — edit price or hours",
    ),
    "homeServiceConfirmNewPrice": MessageLookupByLibrary.simpleMessage(
      "Confirm new price",
    ),
    "homeServiceDateLabel": MessageLookupByLibrary.simpleMessage("Date"),
    "homeServiceDateTimeLabel": MessageLookupByLibrary.simpleMessage(
      "Date and time",
    ),
    "homeServiceDateTimeMustBeFuture": MessageLookupByLibrary.simpleMessage(
      "Choose a date and time in the future",
    ),
    "homeServiceDateTimeRequired": MessageLookupByLibrary.simpleMessage(
      "Choose a date and time first",
    ),
    "homeServiceDateTimeStepSubtitle": MessageLookupByLibrary.simpleMessage(
      "Pick a date and time, then we\'ll show you who\'s available.",
    ),
    "homeServiceDateTimeStepTitle": MessageLookupByLibrary.simpleMessage(
      "When do you need a barber?",
    ),
    "homeServiceHoursCta": MessageLookupByLibrary.simpleMessage(
      "Home service hours",
    ),
    "homeServiceHoursTitle": MessageLookupByLibrary.simpleMessage(
      "Home service hours",
    ),
    "homeServiceNote": MessageLookupByLibrary.simpleMessage(
      "Turn this on to reach customers who want a haircut at home. Set your base price, any notes, then your availability.",
    ),
    "homeServiceNoteHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Haircut and beard trim only",
    ),
    "homeServiceNoteLabel": MessageLookupByLibrary.simpleMessage(
      "Note (optional)",
    ),
    "homeServiceOffLabel": MessageLookupByLibrary.simpleMessage("Not enabled"),
    "homeServiceOffered": MessageLookupByLibrary.simpleMessage("Home service"),
    "homeServicePendingCount": m34,
    "homeServicePriceChangedMessage": m35,
    "homeServicePriceChangedTitle": MessageLookupByLibrary.simpleMessage(
      "Price changed",
    ),
    "homeServicePriceConfirmed": MessageLookupByLibrary.simpleMessage(
      "Price confirmed",
    ),
    "homeServicePriceHint": MessageLookupByLibrary.simpleMessage("e.g. 150"),
    "homeServicePriceLabel": MessageLookupByLibrary.simpleMessage("Base price"),
    "homeServicePricePending": MessageLookupByLibrary.simpleMessage(
      "Price pending",
    ),
    "homeServicePriceRequired": MessageLookupByLibrary.simpleMessage(
      "Enter a valid price",
    ),
    "homeServiceRequestCancelled": MessageLookupByLibrary.simpleMessage(
      "Request cancelled",
    ),
    "homeServiceRequestCreated": MessageLookupByLibrary.simpleMessage(
      "Home service request sent",
    ),
    "homeServiceRequestDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Request details",
    ),
    "homeServiceRequestNoteHint": MessageLookupByLibrary.simpleMessage(
      "e.g. 6th floor, no elevator",
    ),
    "homeServiceRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Home service request",
    ),
    "homeServiceRequestsTab": MessageLookupByLibrary.simpleMessage(
      "Home service",
    ),
    "homeServiceRequestsTitle": MessageLookupByLibrary.simpleMessage(
      "Home service requests",
    ),
    "homeServiceRetryRequest": MessageLookupByLibrary.simpleMessage(
      "Retry request",
    ),
    "homeServiceSettingsSaved": MessageLookupByLibrary.simpleMessage(
      "Home service settings saved",
    ),
    "homeServiceSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Home service",
    ),
    "homeServiceShopListTitle": MessageLookupByLibrary.simpleMessage(
      "Home service",
    ),
    "homeServiceShopNoteLabel": MessageLookupByLibrary.simpleMessage("Note"),
    "homeServiceStartingPrice": m36,
    "homeServiceStatusAccepted": MessageLookupByLibrary.simpleMessage(
      "Accepted",
    ),
    "homeServiceStatusCancelled": MessageLookupByLibrary.simpleMessage(
      "Cancelled",
    ),
    "homeServiceStatusDone": MessageLookupByLibrary.simpleMessage("Done"),
    "homeServiceStatusExpired": MessageLookupByLibrary.simpleMessage("Expired"),
    "homeServiceStatusOnTheWay": MessageLookupByLibrary.simpleMessage(
      "Barber on the way",
    ),
    "homeServiceStatusPending": MessageLookupByLibrary.simpleMessage(
      "Awaiting approval",
    ),
    "homeServiceStatusRejected": MessageLookupByLibrary.simpleMessage(
      "Rejected",
    ),
    "homeServiceSubmitRequest": MessageLookupByLibrary.simpleMessage(
      "Submit request",
    ),
    "homeServiceTimeLabel": MessageLookupByLibrary.simpleMessage("Time"),
    "hourPeriodAfternoon": MessageLookupByLibrary.simpleMessage(
      "in the afternoon",
    ),
    "hourPeriodEvening": MessageLookupByLibrary.simpleMessage("in the evening"),
    "hourPeriodMidnight": MessageLookupByLibrary.simpleMessage("midnight"),
    "hourPeriodMorning": MessageLookupByLibrary.simpleMessage("in the morning"),
    "hourPeriodNight": MessageLookupByLibrary.simpleMessage("at night"),
    "hourPeriodNoon": MessageLookupByLibrary.simpleMessage("at noon"),
    "hoursDuration": m37,
    "hoursDurationWithMinutes": m38,
    "hoursNextDay": MessageLookupByLibrary.simpleMessage("next day"),
    "hoursSameTimeError": MessageLookupByLibrary.simpleMessage(
      "Opening and closing time are the same, change one of them",
    ),
    "hoursSaved": MessageLookupByLibrary.simpleMessage("Working hours saved"),
    "hoursSummary": m39,
    "hoursSummaryNextDay": m40,
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
    "linkOpenError": MessageLookupByLibrary.simpleMessage(
      "Could not open the link",
    ),
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
    "locationRequiredFromMap": MessageLookupByLibrary.simpleMessage(
      "Pick the location on the map first",
    ),
    "locationSaved": MessageLookupByLibrary.simpleMessage("Location saved"),
    "locationServiceDisabled": MessageLookupByLibrary.simpleMessage(
      "Please enable location services",
    ),
    "locationSettingLabel": MessageLookupByLibrary.simpleMessage("Location"),
    "locationSettingOff": MessageLookupByLibrary.simpleMessage("Off"),
    "locationSettingOn": MessageLookupByLibrary.simpleMessage("On"),
    "locationTitle": MessageLookupByLibrary.simpleMessage("Shop location"),
    "locationUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t find your location. Make sure GPS is on and try again",
    ),
    "locationUnresolvedMessage": MessageLookupByLibrary.simpleMessage(
      "Make sure GPS is on and try again to see distances",
    ),
    "locationUnresolvedTitle": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t find your location",
    ),
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
    "loginSubtitleTeamMember": MessageLookupByLibrary.simpleMessage(
      "Sign in with the account your shop owner created for you",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Log out"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out?",
    ),
    "logoutTitle": MessageLookupByLibrary.simpleMessage("Log out"),
    "management": MessageLookupByLibrary.simpleMessage("Management"),
    "mapPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Select location on map",
    ),
    "markAllRead": MessageLookupByLibrary.simpleMessage("Mark all as read"),
    "memberActivated": MessageLookupByLibrary.simpleMessage(
      "Member re-activated",
    ),
    "memberAdded": MessageLookupByLibrary.simpleMessage("Team member added"),
    "memberAddedPermissionsFailed": MessageLookupByLibrary.simpleMessage(
      "The member was added but the permissions were not saved. Edit them from the member page",
    ),
    "memberBlocked": MessageLookupByLibrary.simpleMessage("Member blocked"),
    "memberClientsDateRangeAction": MessageLookupByLibrary.simpleMessage(
      "Change period",
    ),
    "memberClientsEmpty": MessageLookupByLibrary.simpleMessage(
      "No clients in this period",
    ),
    "memberClientsEmptyHint": MessageLookupByLibrary.simpleMessage(
      "Try changing the time range to see other clients.",
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
    "memberPasswordResetDone": MessageLookupByLibrary.simpleMessage(
      "The member\'s password was changed",
    ),
    "memberPermissionsTitle": MessageLookupByLibrary.simpleMessage(
      "Member permissions",
    ),
    "memberPhoneHint": MessageLookupByLibrary.simpleMessage("e.g. 01111111111"),
    "memberPhoneLabel": MessageLookupByLibrary.simpleMessage("Phone number"),
    "memberSaved": MessageLookupByLibrary.simpleMessage("Member details saved"),
    "memberServicesTitle": MessageLookupByLibrary.simpleMessage("Services"),
    "memberTaglineHint": MessageLookupByLibrary.simpleMessage("Optional"),
    "memberTaglineLabel": MessageLookupByLibrary.simpleMessage("Tagline"),
    "memberTaglineOptionalLabel": MessageLookupByLibrary.simpleMessage(
      "Tagline (optional)",
    ),
    "memberTempPasswordInvalid": MessageLookupByLibrary.simpleMessage(
      "The password must be at least 6 characters",
    ),
    "memberTempPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Temporary password",
    ),
    "memberTempPasswordOptionalLabel": MessageLookupByLibrary.simpleMessage(
      "Temporary password (optional)",
    ),
    "menuTitle": MessageLookupByLibrary.simpleMessage("Menu"),
    "merchant": MessageLookupByLibrary.simpleMessage("Merchant"),
    "merchantDashboardNote": MessageLookupByLibrary.simpleMessage(
      "All your customers are barbers and salons registered on the platform — wholesale only.",
    ),
    "merchantHint": MessageLookupByLibrary.simpleMessage(
      "Sell barber supplies wholesale to salons",
    ),
    "merchantRatingTitle": MessageLookupByLibrary.simpleMessage(
      "How was your order?",
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
    "missingDocumentsHomeCount": m41,
    "moneyAmountHint": MessageLookupByLibrary.simpleMessage("Enter the amount"),
    "moneyAmountLabel": MessageLookupByLibrary.simpleMessage("Amount"),
    "moneyDayOfMonthLabel": MessageLookupByLibrary.simpleMessage(
      "Day of month",
    ),
    "moneyDayOfWeekLabel": MessageLookupByLibrary.simpleMessage("Day of week"),
    "moneyDeleteItemMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this item?",
    ),
    "moneyDeleteItemTitle": MessageLookupByLibrary.simpleMessage(
      "Delete recurring item",
    ),
    "moneyDescriptionHint": MessageLookupByLibrary.simpleMessage("Description"),
    "moneyDirectionAdd": MessageLookupByLibrary.simpleMessage("Add"),
    "moneyDirectionLabel": MessageLookupByLibrary.simpleMessage("Type"),
    "moneyDirectionSubtract": MessageLookupByLibrary.simpleMessage("Subtract"),
    "moneyEditItem": MessageLookupByLibrary.simpleMessage(
      "Edit recurring item",
    ),
    "moneyFrequencyDaily": MessageLookupByLibrary.simpleMessage("Daily"),
    "moneyFrequencyLabel": MessageLookupByLibrary.simpleMessage("Frequency"),
    "moneyFrequencyMonthly": MessageLookupByLibrary.simpleMessage("Monthly"),
    "moneyFrequencyWeekly": MessageLookupByLibrary.simpleMessage("Weekly"),
    "moneyLedgerTitle": MessageLookupByLibrary.simpleMessage("Ledger"),
    "moneyManagerTitle": MessageLookupByLibrary.simpleMessage("Money Manager"),
    "moneyNet": MessageLookupByLibrary.simpleMessage("Net"),
    "moneyNewEntry": MessageLookupByLibrary.simpleMessage("New entry"),
    "moneyNewItem": MessageLookupByLibrary.simpleMessage("New recurring item"),
    "moneyNoEntries": MessageLookupByLibrary.simpleMessage("No entries yet"),
    "moneyNoEntriesHint": MessageLookupByLibrary.simpleMessage(
      "Add your first income or expense to start tracking your accounts.",
    ),
    "moneyNoItems": MessageLookupByLibrary.simpleMessage(
      "No recurring items yet",
    ),
    "moneyNoPendingOccurrences": MessageLookupByLibrary.simpleMessage(
      "Nothing needs confirmation right now",
    ),
    "moneyNoPendingOccurrencesHint": MessageLookupByLibrary.simpleMessage(
      "Recurring items appear here when they are due so you can confirm them.",
    ),
    "moneyOccurrenceConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "moneyOccurrenceDismiss": MessageLookupByLibrary.simpleMessage("Dismiss"),
    "moneyPendingOccurrences": MessageLookupByLibrary.simpleMessage(
      "Needs confirmation",
    ),
    "moneyPinChanged": MessageLookupByLibrary.simpleMessage("PIN changed"),
    "moneyPinConfirmAction": MessageLookupByLibrary.simpleMessage("Continue"),
    "moneyPinEnterTitle": MessageLookupByLibrary.simpleMessage(
      "Enter your PIN to view your revenue",
    ),
    "moneyPinForgotAction": MessageLookupByLibrary.simpleMessage(
      "Forgot your PIN?",
    ),
    "moneyPinNotMatch": MessageLookupByLibrary.simpleMessage(
      "New PIN doesn\'t match",
    ),
    "moneyPinResetConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Send request",
    ),
    "moneyPinResetConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "We\'ll send a reset request to the admin team. You\'ll be able to set a new PIN once it\'s approved.",
    ),
    "moneyPinResetConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Request a PIN reset",
    ),
    "moneyPinResetPendingMessage": MessageLookupByLibrary.simpleMessage(
      "Your request is being reviewed by the admin team. You\'ll be notified once it\'s resolved.",
    ),
    "moneyPinResetPendingTitle": MessageLookupByLibrary.simpleMessage(
      "Reset request sent",
    ),
    "moneyPinResetRejectedTitle": MessageLookupByLibrary.simpleMessage(
      "Reset request rejected",
    ),
    "moneyPinSetupAction": MessageLookupByLibrary.simpleMessage("Save PIN"),
    "moneyPinSetupTitle": MessageLookupByLibrary.simpleMessage(
      "Set a PIN to protect your revenue data",
    ),
    "moneyRecurringItemsTitle": MessageLookupByLibrary.simpleMessage(
      "Recurring items",
    ),
    "moneyTotalAdded": MessageLookupByLibrary.simpleMessage("Total added"),
    "moneyTotalSubtracted": MessageLookupByLibrary.simpleMessage(
      "Total subtracted",
    ),
    "monthRevenue": MessageLookupByLibrary.simpleMessage("Month revenue"),
    "moreSection": MessageLookupByLibrary.simpleMessage("More"),
    "moveMapToChooseLocation": MessageLookupByLibrary.simpleMessage(
      "Move the map to choose a spot",
    ),
    "moveStatusTo": m42,
    "myCategories": MessageLookupByLibrary.simpleMessage("My categories"),
    "myCategoriesCount": m43,
    "myCustomers": MessageLookupByLibrary.simpleMessage("My customers"),
    "myCustomersSubtitle": MessageLookupByLibrary.simpleMessage(
      "Barbers and salons who ordered from your store",
    ),
    "myDocuments": MessageLookupByLibrary.simpleMessage("My documents"),
    "nameLabel": MessageLookupByLibrary.simpleMessage("Name"),
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
    "nearbyLocationOffMessage": MessageLookupByLibrary.simpleMessage(
      "Turn on location to see barbers near you",
    ),
    "nearbyLocationOffTitle": MessageLookupByLibrary.simpleMessage(
      "Location is off",
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
    "newDiscountSinceOrderLabel": m44,
    "newMoneyPinLabel": MessageLookupByLibrary.simpleMessage("New PIN"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
    "newStorefrontOrdersCount": m45,
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
    "noBookingHistoryHint": MessageLookupByLibrary.simpleMessage(
      "Completed and cancelled bookings appear here once they end.",
    ),
    "noBookingsYet": MessageLookupByLibrary.simpleMessage(
      "You haven\'t made any bookings yet",
    ),
    "noCustomersYet": MessageLookupByLibrary.simpleMessage("No customers yet"),
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
    "noHaircutStylesYet": MessageLookupByLibrary.simpleMessage(
      "No styles in the catalog yet",
    ),
    "noHomeServiceBroadcastsHint": MessageLookupByLibrary.simpleMessage(
      "Nearby home-service invitations will appear here as soon as they arrive.",
    ),
    "noHomeServiceBroadcastsYet": MessageLookupByLibrary.simpleMessage(
      "No home service invitations right now",
    ),
    "noHomeServiceRequestsHint": MessageLookupByLibrary.simpleMessage(
      "Home-service requests from customers will reach you here.",
    ),
    "noHomeServiceRequestsYet": MessageLookupByLibrary.simpleMessage(
      "You haven\'t made any home service requests yet",
    ),
    "noHomeServiceShopsAtThisTime": MessageLookupByLibrary.simpleMessage(
      "No shops are available at this time",
    ),
    "noHomeServiceShopsYet": MessageLookupByLibrary.simpleMessage(
      "No shops offer home service right now",
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
    "noMerchantsYetHint": MessageLookupByLibrary.simpleMessage(
      "Suppliers will appear here once they are available in your area.",
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
    "noPendingBookingsHint": MessageLookupByLibrary.simpleMessage(
      "New booking requests from customers will appear here for you to accept or decline.",
    ),
    "noPendingHomeServiceRequests": MessageLookupByLibrary.simpleMessage(
      "No home service requests awaiting a reply",
    ),
    "noPlacesFound": MessageLookupByLibrary.simpleMessage("No results found"),
    "noProductsYet": MessageLookupByLibrary.simpleMessage("No products yet"),
    "noReviewsYet": MessageLookupByLibrary.simpleMessage("No reviews yet"),
    "noReviewsYetHint": MessageLookupByLibrary.simpleMessage(
      "Customer reviews will appear here after they rate your service.",
    ),
    "noShopsYet": MessageLookupByLibrary.simpleMessage(
      "No salons available right now",
    ),
    "noSlotsAvailable": MessageLookupByLibrary.simpleMessage(
      "No slots available on this day",
    ),
    "noStoreOrdersHint": MessageLookupByLibrary.simpleMessage(
      "Your store purchases and the status of each order will appear here.",
    ),
    "noStoreProductsYet": MessageLookupByLibrary.simpleMessage(
      "No products available right now",
    ),
    "noStoreProductsYetHint": MessageLookupByLibrary.simpleMessage(
      "Products will appear here as soon as suppliers add them.",
    ),
    "noSubscriptionRequests": MessageLookupByLibrary.simpleMessage(
      "No requests yet",
    ),
    "noSubscriptionRequestsHint": MessageLookupByLibrary.simpleMessage(
      "Subscription requests you send and the status of each will appear here.",
    ),
    "noTeamMembersOwnerHint": MessageLookupByLibrary.simpleMessage(
      "Add your first member so they can take bookings and check in from their phone.",
    ),
    "noTeamMembersTitle": MessageLookupByLibrary.simpleMessage(
      "No team members",
    ),
    "noTeamMembersYet": MessageLookupByLibrary.simpleMessage(
      "No team members yet",
    ),
    "noUnresolvedBookings": MessageLookupByLibrary.simpleMessage(
      "No unresolved bookings",
    ),
    "noUnresolvedBookingsHint": MessageLookupByLibrary.simpleMessage(
      "Bookings whose time has passed and still need a final status appear here.",
    ),
    "noUpcomingBookingsHint": MessageLookupByLibrary.simpleMessage(
      "You have no upcoming bookings right now",
    ),
    "noWalletTransactions": MessageLookupByLibrary.simpleMessage(
      "No transactions yet",
    ),
    "noWalletTransactionsHint": MessageLookupByLibrary.simpleMessage(
      "Your wallet activity will appear here after your first transaction.",
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
    "orderDiscountWithPercentLabel": m46,
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
    "orderedBeforeLabel": MessageLookupByLibrary.simpleMessage(
      "Ordered before",
    ),
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
    "permissionCloseBookings": MessageLookupByLibrary.simpleMessage(
      "Close bookings",
    ),
    "permissionCloseBookingsHint": MessageLookupByLibrary.simpleMessage(
      "Finishes bookings (done / no-show), edits the bill and settles unresolved ones",
    ),
    "permissionMarkPaid": MessageLookupByLibrary.simpleMessage(
      "Confirm payment received",
    ),
    "permissionMarkPaidHint": MessageLookupByLibrary.simpleMessage(
      "Confirms the money was collected after a booking is done",
    ),
    "permissionMarkPaidNeedsClose": MessageLookupByLibrary.simpleMessage(
      "Requires the close bookings permission first",
    ),
    "permissionViewRevenue": MessageLookupByLibrary.simpleMessage(
      "View revenue",
    ),
    "permissionViewRevenueHint": MessageLookupByLibrary.simpleMessage(
      "Sees their own earnings and daily report",
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
    "pickLocationOnMap": MessageLookupByLibrary.simpleMessage(
      "Pick location on the map",
    ),
    "pickLocationTitle": MessageLookupByLibrary.simpleMessage(
      "Select location",
    ),
    "placeOrder": MessageLookupByLibrary.simpleMessage("Place order"),
    "placeOrderConfirmAction": MessageLookupByLibrary.simpleMessage("Send"),
    "placeOrderConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "This order will be sent to the supplier. Continue?",
    ),
    "placeOrderConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm order",
    ),
    "planStatusActive": MessageLookupByLibrary.simpleMessage("Active"),
    "planStatusPaused": MessageLookupByLibrary.simpleMessage("Paused"),
    "planStatusPending": MessageLookupByLibrary.simpleMessage(
      "Awaiting approval",
    ),
    "planStatusUnknown": MessageLookupByLibrary.simpleMessage("Unknown status"),
    "pleaseCheckYourConnectionAndTryAgain":
        MessageLookupByLibrary.simpleMessage(
          "Please check your connection and try again",
        ),
    "please_enter_a_valid_phone_number": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid phone number",
    ),
    "priceChangedSinceOrderLabel": m47,
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy policy"),
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
    "productMetaLine": m48,
    "productName": MessageLookupByLibrary.simpleMessage("Product name"),
    "productNameHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Strong hold wax - salon pack",
    ),
    "productNameRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the product name",
    ),
    "productOrdersThisMonthLabel": MessageLookupByLibrary.simpleMessage(
      "Product orders this month",
    ),
    "productRequired": MessageLookupByLibrary.simpleMessage("Choose a product"),
    "productsAmountLine": m49,
    "productsCount": MessageLookupByLibrary.simpleMessage("Products"),
    "productsNote": MessageLookupByLibrary.simpleMessage(
      "What you list here is only visible to barbers in their supplies store",
    ),
    "productsThisMonthLabel": MessageLookupByLibrary.simpleMessage(
      "Product revenue this month",
    ),
    "profileDetailsTitle": MessageLookupByLibrary.simpleMessage(
      "Account Details",
    ),
    "publishProduct": MessageLookupByLibrary.simpleMessage("Publish product"),
    "purchasesSection": MessageLookupByLibrary.simpleMessage("Purchases"),
    "queueEmpty": MessageLookupByLibrary.simpleMessage("The queue is empty"),
    "queueEmptyHint": MessageLookupByLibrary.simpleMessage(
      "Bookings you accepted appear here, ordered by time.",
    ),
    "queuePositionLabel": MessageLookupByLibrary.simpleMessage(
      "Queue position",
    ),
    "quickActionsTitle": MessageLookupByLibrary.simpleMessage("Quick actions"),
    "quotaDrinks": MessageLookupByLibrary.simpleMessage("Drinks"),
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
    "quotaOwnServices": MessageLookupByLibrary.simpleMessage("Own services"),
    "quotaProducts": MessageLookupByLibrary.simpleMessage("Products"),
    "quotaUnlimited": MessageLookupByLibrary.simpleMessage("Unlimited"),
    "quotaUsedOfCap": m50,
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
    "rankLabel": m51,
    "rateBarberSubtitle": m52,
    "rateBarberTitle": MessageLookupByLibrary.simpleMessage("Rate the barber"),
    "rateBooking": MessageLookupByLibrary.simpleMessage("Rate booking"),
    "rateHomeService": MessageLookupByLibrary.simpleMessage(
      "Rate home service",
    ),
    "rateNoteHint": MessageLookupByLibrary.simpleMessage(
      "Write your feedback (optional)",
    ),
    "rateShopSubtitle": m53,
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
    "rejectHomeServiceRequest": MessageLookupByLibrary.simpleMessage(
      "Reject request",
    ),
    "rejectOrder": MessageLookupByLibrary.simpleMessage("Reject order"),
    "rejectReason": MessageLookupByLibrary.simpleMessage("Rejection reason"),
    "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
      "e.g. item is out of stock",
    ),
    "removeCurrentImage": MessageLookupByLibrary.simpleMessage(
      "Remove current image",
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
    "resetMemberPasswordNote": MessageLookupByLibrary.simpleMessage(
      "The member signs in with this password and is asked to change it on first sign in",
    ),
    "resetMemberPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset password",
    ),
    "resetPasswordConfirm": MessageLookupByLibrary.simpleMessage(
      "Set a new temporary password for this member?",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset password",
    ),
    "responsibleBarber": m54,
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "reviewsCount": m55,
    "reviewsTitle": MessageLookupByLibrary.simpleMessage("Reviews"),
    "rewardAmount": MessageLookupByLibrary.simpleMessage("Fixed amount"),
    "rewardFree": MessageLookupByLibrary.simpleMessage("Free"),
    "rewardPercent": MessageLookupByLibrary.simpleMessage("Percent %"),
    "rewardQuantityLabel": MessageLookupByLibrary.simpleMessage(
      "How many do they get?",
    ),
    "rewardTypeLabel": MessageLookupByLibrary.simpleMessage("Reward type"),
    "runningLowProducts": MessageLookupByLibrary.simpleMessage("Running low"),
    "sameDayBookingConfirmLabel": MessageLookupByLibrary.simpleMessage(
      "Yes, book again",
    ),
    "sameDayBookingWarningMessage": m56,
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
    "searchPlaceHint": MessageLookupByLibrary.simpleMessage(
      "Search for a place or address",
    ),
    "searchingAddress": MessageLookupByLibrary.simpleMessage(
      "Finding the address...",
    ),
    "seats": MessageLookupByLibrary.simpleMessage("Seats"),
    "seeAll": MessageLookupByLibrary.simpleMessage("See all"),
    "selectFulfillmentRequired": MessageLookupByLibrary.simpleMessage(
      "Choose a fulfilment option first",
    ),
    "selectStarsError": MessageLookupByLibrary.simpleMessage(
      "Select a star rating first",
    ),
    "selectedLocationLabel": MessageLookupByLibrary.simpleMessage(
      "Selected location",
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
    "serviceMetaLine": m57,
    "servicePopularLabel": MessageLookupByLibrary.simpleMessage(
      "Most requested",
    ),
    "servicePriceHint": MessageLookupByLibrary.simpleMessage("e.g. 100"),
    "servicePriceLabel": MessageLookupByLibrary.simpleMessage("Price"),
    "servicesTitle": MessageLookupByLibrary.simpleMessage("Services"),
    "setNewPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Choose a new password for your account",
    ),
    "setNewPasswordTitle": MessageLookupByLibrary.simpleMessage("New password"),
    "settleApprove": MessageLookupByLibrary.simpleMessage("Approve"),
    "settleCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "settleCancelReasonHint": MessageLookupByLibrary.simpleMessage(
      "Reason for cancelling",
    ),
    "settleSelectedCount": m58,
    "settleSubmitAction": MessageLookupByLibrary.simpleMessage(
      "Apply decisions",
    ),
    "settleSuccess": MessageLookupByLibrary.simpleMessage("Bookings settled"),
    "setupChecklistProgress": m59,
    "setupChecklistTitle": MessageLookupByLibrary.simpleMessage(
      "Finish setting up your shop",
    ),
    "setupStartTour": MessageLookupByLibrary.simpleMessage(
      "Start the guided tour",
    ),
    "setupStepDocumentsHint": MessageLookupByLibrary.simpleMessage(
      "Needed to approve your account",
    ),
    "setupStepDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Upload the required documents",
    ),
    "setupStepHoursHint": MessageLookupByLibrary.simpleMessage(
      "So customers can book during your hours",
    ),
    "setupStepHoursTitle": MessageLookupByLibrary.simpleMessage(
      "Set your working hours",
    ),
    "setupStepPhotoHint": MessageLookupByLibrary.simpleMessage(
      "A photo builds customer trust",
    ),
    "setupStepPhotoTitle": MessageLookupByLibrary.simpleMessage(
      "Add a shop photo",
    ),
    "setupStepServicesHint": MessageLookupByLibrary.simpleMessage(
      "Choose the services you offer and their prices",
    ),
    "setupStepServicesTitle": MessageLookupByLibrary.simpleMessage(
      "Add your services and prices",
    ),
    "shareDocument": MessageLookupByLibrary.simpleMessage("Share"),
    "shopDetailTitle": MessageLookupByLibrary.simpleMessage("Salon details"),
    "shopLabel": MessageLookupByLibrary.simpleMessage("Barbershop"),
    "shopName": MessageLookupByLibrary.simpleMessage("Shop name"),
    "shopNameHint": MessageLookupByLibrary.simpleMessage("Elegance Barbershop"),
    "shopNameRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the shop name",
    ),
    "shopOwner": MessageLookupByLibrary.simpleMessage("Shop owner"),
    "shopOwnerHint": MessageLookupByLibrary.simpleMessage(
      "Manage the shop, team and earnings",
    ),
    "shopPhotoDeleteMessage": MessageLookupByLibrary.simpleMessage(
      "The shop photo will be removed from your profile. You can upload another one anytime.",
    ),
    "shopPhotoDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Delete shop photo",
    ),
    "shopPhotoDeleted": MessageLookupByLibrary.simpleMessage(
      "Shop photo deleted",
    ),
    "shopPhotoEditTitle": MessageLookupByLibrary.simpleMessage("Shop photo"),
    "shopPhotoRemove": MessageLookupByLibrary.simpleMessage("Remove photo"),
    "shopPhotoReplace": MessageLookupByLibrary.simpleMessage("Change photo"),
    "shopPhotoUpdated": MessageLookupByLibrary.simpleMessage(
      "Shop photo updated",
    ),
    "shopRatingLabel": MessageLookupByLibrary.simpleMessage("Shop rating"),
    "shopSection": MessageLookupByLibrary.simpleMessage("Shop"),
    "shops": MessageLookupByLibrary.simpleMessage("Salons"),
    "shopsAllHint": MessageLookupByLibrary.simpleMessage(
      "Selecting none = the offer applies to all salons",
    ),
    "shopsAllNote": MessageLookupByLibrary.simpleMessage(
      "The offer will apply to all salons",
    ),
    "shopsSelectedHint": m60,
    "shopsTitle": MessageLookupByLibrary.simpleMessage("Salons"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "skipForNow": MessageLookupByLibrary.simpleMessage("Not now"),
    "slotsServiceDurationNote": m61,
    "snapchat_error": MessageLookupByLibrary.simpleMessage(
      "Could not open Snapchat",
    ),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "sponsoredLabel": MessageLookupByLibrary.simpleMessage("Sponsored"),
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
    "sponsorshipConfirmMessage": m62,
    "sponsorshipConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Activate promotion",
    ),
    "sponsorshipDaysLeft": m63,
    "sponsorshipEndsAt": MessageLookupByLibrary.simpleMessage("Ends on"),
    "sponsorshipInactive": MessageLookupByLibrary.simpleMessage(
      "Promotion is off",
    ),
    "sponsorshipInsufficient": m64,
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
    "stockQuantityHint": MessageLookupByLibrary.simpleMessage("e.g. 20"),
    "stockUnits": m65,
    "stockUpdated": MessageLookupByLibrary.simpleMessage("Stock updated"),
    "storeAndSalesSection": MessageLookupByLibrary.simpleMessage("Your Store"),
    "storeBrowseMerchantsCta": MessageLookupByLibrary.simpleMessage(
      "Browse suppliers",
    ),
    "storeFeedSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search products or brands",
    ),
    "storeOrdersTitle": MessageLookupByLibrary.simpleMessage(
      "My supply orders",
    ),
    "storeSortNewest": MessageLookupByLibrary.simpleMessage("Newest"),
    "storeSortPriceAsc": MessageLookupByLibrary.simpleMessage(
      "Price: low to high",
    ),
    "storeSortPriceDesc": MessageLookupByLibrary.simpleMessage(
      "Price: high to low",
    ),
    "storeSortRelevant": MessageLookupByLibrary.simpleMessage("Most relevant"),
    "storeTitle": MessageLookupByLibrary.simpleMessage("Store"),
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
    "teamMemberAccountHint": MessageLookupByLibrary.simpleMessage(
      "Your shop owner creates your account and sends you the temporary password",
    ),
    "teamMemberHint": MessageLookupByLibrary.simpleMessage(
      "Follow your bookings and do your daily work",
    ),
    "teamTitle": MessageLookupByLibrary.simpleMessage("Team"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Terms and conditions",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "tiktok_error": MessageLookupByLibrary.simpleMessage(
      "Could not open TikTok",
    ),
    "tillAddedLabel": MessageLookupByLibrary.simpleMessage("Till additions"),
    "tillSubtractedLabel": MessageLookupByLibrary.simpleMessage(
      "Till withdrawals",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "topProducts": MessageLookupByLibrary.simpleMessage("Most stocked"),
    "totalStockUnits": MessageLookupByLibrary.simpleMessage("Total units"),
    "totalThisMonthLabel": MessageLookupByLibrary.simpleMessage(
      "Total this month",
    ),
    "tourAccountTabBody": MessageLookupByLibrary.simpleMessage(
      "Manage services, hours, team and wallet here.",
    ),
    "tourAttendanceBody": MessageLookupByLibrary.simpleMessage(
      "Check in and out of your shift here.",
    ),
    "tourAttendanceTitle": MessageLookupByLibrary.simpleMessage("Attendance"),
    "tourBookingsTabBody": MessageLookupByLibrary.simpleMessage(
      "Follow your queue and booking history.",
    ),
    "tourChecklistBody": MessageLookupByLibrary.simpleMessage(
      "Complete these steps so customers can find and book your shop.",
    ),
    "tourChecklistTitle": MessageLookupByLibrary.simpleMessage(
      "Finish setting up",
    ),
    "tourDone": MessageLookupByLibrary.simpleMessage("Done"),
    "tourNext": MessageLookupByLibrary.simpleMessage("Next"),
    "tourNotificationsBody": MessageLookupByLibrary.simpleMessage(
      "New booking requests and shop alerts reach you here.",
    ),
    "tourNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "tourPendingBody": MessageLookupByLibrary.simpleMessage(
      "Accept or decline customer requests here.",
    ),
    "tourPendingTitle": MessageLookupByLibrary.simpleMessage(
      "Booking requests",
    ),
    "tourQueueBody": MessageLookupByLibrary.simpleMessage(
      "Today\'s bookings, ordered by time.",
    ),
    "tourQueueTitle": MessageLookupByLibrary.simpleMessage("Today\'s queue"),
    "tourSkip": MessageLookupByLibrary.simpleMessage("Skip"),
    "tourStorefrontTabBody": MessageLookupByLibrary.simpleMessage(
      "List your products and receive customer orders.",
    ),
    "tourSummaryBody": MessageLookupByLibrary.simpleMessage(
      "Follow your bookings and earnings here.",
    ),
    "tourSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Your shop summary",
    ),
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
    "unitDiscountPercentLabel": m66,
    "unitPrice": MessageLookupByLibrary.simpleMessage("Unit price (EGP)"),
    "unnamedLocation": MessageLookupByLibrary.simpleMessage(
      "Location selected on map",
    ),
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
    "viewMerchantStore": m67,
    "viewOnMap": MessageLookupByLibrary.simpleMessage("View on map"),
    "viewShopProfile": m68,
    "visitRatingTitle": MessageLookupByLibrary.simpleMessage(
      "How was your visit?",
    ),
    "walkInAddonsLabel": MessageLookupByLibrary.simpleMessage(
      "Add-ons (optional)",
    ),
    "walkInBarberLabel": MessageLookupByLibrary.simpleMessage("Team member"),
    "walkInConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Confirm and add customer",
    ),
    "walkInConfirmEdit": MessageLookupByLibrary.simpleMessage("Edit"),
    "walkInConfirmTitle": MessageLookupByLibrary.simpleMessage("Review order"),
    "walkInConfirmTotalLabel": MessageLookupByLibrary.simpleMessage("Total"),
    "walkInNoteHint": MessageLookupByLibrary.simpleMessage("e.g. in a hurry"),
    "walkInNoteLabel": MessageLookupByLibrary.simpleMessage("Note (optional)"),
    "walkInPickerAddMore": MessageLookupByLibrary.simpleMessage("Add"),
    "walkInPickerDone": MessageLookupByLibrary.simpleMessage("Done"),
    "walkInPickerNoneSelected": MessageLookupByLibrary.simpleMessage(
      "Tap to add",
    ),
    "walkInSlotTimeLabel": MessageLookupByLibrary.simpleMessage("Time"),
    "walkInSlotTimeNow": MessageLookupByLibrary.simpleMessage("Now"),
    "walkInSlotTimeSpecific": MessageLookupByLibrary.simpleMessage(
      "Pick a time",
    ),
    "walletAttachmentTapToView": MessageLookupByLibrary.simpleMessage(
      "Tap to view the full image",
    ),
    "walletAvailableLabel": m69,
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
    "walletRequestAttachmentRequired": MessageLookupByLibrary.simpleMessage(
      "Please attach a transfer proof photo",
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
    "walletRequestsEmptyHint": MessageLookupByLibrary.simpleMessage(
      "Top-up and withdrawal requests and the status of each will appear here.",
    ),
    "walletRequestsTitle": MessageLookupByLibrary.simpleMessage(
      "Wallet requests",
    ),
    "walletTitle": MessageLookupByLibrary.simpleMessage("Wallet"),
    "walletWithdrawAvailableNow": m70,
    "walletWithdrawBalanceUnknown": MessageLookupByLibrary.simpleMessage(
      "Loading your balance...",
    ),
    "walletWithdrawExceedsAvailable": MessageLookupByLibrary.simpleMessage(
      "The amount is more than your available balance",
    ),
    "walletWithdrawRemainingAfter": m71,
    "weak_password": MessageLookupByLibrary.simpleMessage(
      "Password is too weak",
    ),
    "weekdayFriday": MessageLookupByLibrary.simpleMessage("Friday"),
    "weekdayMonday": MessageLookupByLibrary.simpleMessage("Monday"),
    "weekdaySaturday": MessageLookupByLibrary.simpleMessage("Saturday"),
    "weekdaySunday": MessageLookupByLibrary.simpleMessage("Sunday"),
    "weekdayThursday": MessageLookupByLibrary.simpleMessage("Thursday"),
    "weekdayTuesday": MessageLookupByLibrary.simpleMessage("Tuesday"),
    "weekdayWednesday": MessageLookupByLibrary.simpleMessage("Wednesday"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome 👋"),
    "welcome_message": MessageLookupByLibrary.simpleMessage("Welcome"),
    "whatsappSupport": MessageLookupByLibrary.simpleMessage(
      "Contact us on WhatsApp",
    ),
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
    "withdrawMethodRequired": MessageLookupByLibrary.simpleMessage(
      "Please choose a withdrawal method",
    ),
    "workingHoursTitle": MessageLookupByLibrary.simpleMessage("Working hours"),
    "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "youLabel": MessageLookupByLibrary.simpleMessage("You"),
    "your_session_has_been_expired": MessageLookupByLibrary.simpleMessage(
      "Your session has expired",
    ),
  };
}
