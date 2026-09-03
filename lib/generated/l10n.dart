// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message('Try again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Not now`
  String get notNow {
    return Intl.message('Not now', name: 'notNow', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternet {
    return Intl.message(
      'No internet connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please check your connection and try again`
  String get pleaseCheckYourConnectionAndTryAgain {
    return Intl.message(
      'Please check your connection and try again',
      name: 'pleaseCheckYourConnectionAndTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Back online`
  String get backOnline {
    return Intl.message('Back online', name: 'backOnline', desc: '', args: []);
  }

  /// `Your session has expired`
  String get your_session_has_been_expired {
    return Intl.message(
      'Your session has expired',
      name: 'your_session_has_been_expired',
      desc: '',
      args: [],
    );
  }

  /// `Could not open the link`
  String get could_not_launch {
    return Intl.message(
      'Could not open the link',
      name: 'could_not_launch',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome_message {
    return Intl.message('Welcome', name: 'welcome_message', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your password`
  String get enter_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Update required`
  String get updateRequired {
    return Intl.message(
      'Update required',
      name: 'updateRequired',
      desc: '',
      args: [],
    );
  }

  /// `A new version of the app is available. Please update to continue.`
  String get updateRequiredBody {
    return Intl.message(
      'A new version of the app is available. Please update to continue.',
      name: 'updateRequiredBody',
      desc: '',
      args: [],
    );
  }

  /// `Account under review`
  String get pendingApprovalTitle {
    return Intl.message(
      'Account under review',
      name: 'pendingApprovalTitle',
      desc: '',
      args: [],
    );
  }

  /// `This feature will be available once your account is approved.`
  String get featureLockedApproval {
    return Intl.message(
      'This feature will be available once your account is approved.',
      name: 'featureLockedApproval',
      desc: '',
      args: [],
    );
  }

  /// `Missing documents`
  String get missingDocsTitle {
    return Intl.message(
      'Missing documents',
      name: 'missingDocsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please upload the required documents to activate your account.`
  String get missingDocsBody {
    return Intl.message(
      'Please upload the required documents to activate your account.',
      name: 'missingDocsBody',
      desc: '',
      args: [],
    );
  }

  /// `Go to documents`
  String get goToDocuments {
    return Intl.message(
      'Go to documents',
      name: 'goToDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Add photo`
  String get addPhoto {
    return Intl.message('Add photo', name: 'addPhoto', desc: '', args: []);
  }

  /// `Choose image source`
  String get choose_image_source {
    return Intl.message(
      'Choose image source',
      name: 'choose_image_source',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `This field is required`
  String get field_required {
    return Intl.message(
      'This field is required',
      name: 'field_required',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get name_required {
    return Intl.message(
      'Name is required',
      name: 'name_required',
      desc: '',
      args: [],
    );
  }

  /// `Name is too short`
  String get name_too_short {
    return Intl.message(
      'Name is too short',
      name: 'name_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Name is too long`
  String get name_too_long {
    return Intl.message(
      'Name is too long',
      name: 'name_too_long',
      desc: '',
      args: [],
    );
  }

  /// `Name contains invalid characters`
  String get name_invalid_characters {
    return Intl.message(
      'Name contains invalid characters',
      name: 'name_invalid_characters',
      desc: '',
      args: [],
    );
  }

  /// `Name has invalid spacing`
  String get name_invalid_spacing {
    return Intl.message(
      'Name has invalid spacing',
      name: 'name_invalid_spacing',
      desc: '',
      args: [],
    );
  }

  /// `Name must be in Arabic`
  String get arabic_name_required {
    return Intl.message(
      'Name must be in Arabic',
      name: 'arabic_name_required',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name in Arabic`
  String get arabic_full_name_required {
    return Intl.message(
      'Please enter your full name in Arabic',
      name: 'arabic_full_name_required',
      desc: '',
      args: [],
    );
  }

  /// `Address is required`
  String get address_required {
    return Intl.message(
      'Address is required',
      name: 'address_required',
      desc: '',
      args: [],
    );
  }

  /// `Message is required`
  String get message_required {
    return Intl.message(
      'Message is required',
      name: 'message_required',
      desc: '',
      args: [],
    );
  }

  /// `Message is too short`
  String get message_too_short {
    return Intl.message(
      'Message is too short',
      name: 'message_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get email_required {
    return Intl.message(
      'Email is required',
      name: 'email_required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get email_invalid {
    return Intl.message(
      'Invalid email address',
      name: 'email_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Password is too weak`
  String get weak_password {
    return Intl.message(
      'Password is too weak',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Passwords match`
  String get passwordMatches {
    return Intl.message(
      'Passwords match',
      name: 'passwordMatches',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters`
  String get min_8_char {
    return Intl.message(
      'At least 8 characters',
      name: 'min_8_char',
      desc: '',
      args: [],
    );
  }

  /// `Contains an uppercase letter`
  String get contain_uppercase {
    return Intl.message(
      'Contains an uppercase letter',
      name: 'contain_uppercase',
      desc: '',
      args: [],
    );
  }

  /// `Contains a number and a special character`
  String get contain_number_and_special {
    return Intl.message(
      'Contains a number and a special character',
      name: 'contain_number_and_special',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get phone_number_is_required {
    return Intl.message(
      'Phone number is required',
      name: 'phone_number_is_required',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must contain digits only`
  String get phone_number_must_contain_only_digits {
    return Intl.message(
      'Phone number must contain digits only',
      name: 'phone_number_must_contain_only_digits',
      desc: '',
      args: [],
    );
  }

  /// `Phone number cannot start with 00`
  String get phone_number_cannot_start_with_double_zero {
    return Intl.message(
      'Phone number cannot start with 00',
      name: 'phone_number_cannot_start_with_double_zero',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get please_enter_a_valid_phone_number {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'please_enter_a_valid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Remove the leading zero`
  String get remove_leading_zero {
    return Intl.message(
      'Remove the leading zero',
      name: 'remove_leading_zero',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get resend_code {
    return Intl.message('Resend code', name: 'resend_code', desc: '', args: []);
  }

  /// `National ID is required`
  String get national_id_required {
    return Intl.message(
      'National ID is required',
      name: 'national_id_required',
      desc: '',
      args: [],
    );
  }

  /// `National ID must be 14 digits`
  String get national_id_must_be_14_digits {
    return Intl.message(
      'National ID must be 14 digits',
      name: 'national_id_must_be_14_digits',
      desc: '',
      args: [],
    );
  }

  /// `Invalid national ID`
  String get invalid_national_id {
    return Intl.message(
      'Invalid national ID',
      name: 'invalid_national_id',
      desc: '',
      args: [],
    );
  }

  /// `Birthdate does not match the national ID:`
  String get birthdate_does_not_match_national_id {
    return Intl.message(
      'Birthdate does not match the national ID:',
      name: 'birthdate_does_not_match_national_id',
      desc: '',
      args: [],
    );
  }

  /// `Passport number is required`
  String get passport_required {
    return Intl.message(
      'Passport number is required',
      name: 'passport_required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid passport number length`
  String get passport_length_invalid {
    return Intl.message(
      'Invalid passport number length',
      name: 'passport_length_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Invalid passport number format`
  String get passport_format_invalid {
    return Intl.message(
      'Invalid passport number format',
      name: 'passport_format_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Could not open WhatsApp`
  String get whatsapp_error {
    return Intl.message(
      'Could not open WhatsApp',
      name: 'whatsapp_error',
      desc: '',
      args: [],
    );
  }

  /// `Could not open Instagram`
  String get instagram_error {
    return Intl.message(
      'Could not open Instagram',
      name: 'instagram_error',
      desc: '',
      args: [],
    );
  }

  /// `Could not open X`
  String get twitter_error {
    return Intl.message(
      'Could not open X',
      name: 'twitter_error',
      desc: '',
      args: [],
    );
  }

  /// `Could not open Snapchat`
  String get snapchat_error {
    return Intl.message(
      'Could not open Snapchat',
      name: 'snapchat_error',
      desc: '',
      args: [],
    );
  }

  /// `Could not open TikTok`
  String get tiktok_error {
    return Intl.message(
      'Could not open TikTok',
      name: 'tiktok_error',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle type`
  String get vehicleType {
    return Intl.message(
      'Vehicle type',
      name: 'vehicleType',
      desc: '',
      args: [],
    );
  }

  /// `Seats`
  String get seats {
    return Intl.message('Seats', name: 'seats', desc: '', args: []);
  }

  /// `Ayez Ahlaq`
  String get appName {
    return Intl.message('Ayez Ahlaq', name: 'appName', desc: '', args: []);
  }

  /// `Your cut, your way`
  String get appTagline {
    return Intl.message(
      'Your cut, your way',
      name: 'appTagline',
      desc: '',
      args: [],
    );
  }

  /// `Choose your account type`
  String get chooseAccountType {
    return Intl.message(
      'Choose your account type',
      name: 'chooseAccountType',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message('Customer', name: 'customer', desc: '', args: []);
  }

  /// `Book a haircut and buy care products`
  String get customerHint {
    return Intl.message(
      'Book a haircut and buy care products',
      name: 'customerHint',
      desc: '',
      args: [],
    );
  }

  /// `Barber`
  String get barber {
    return Intl.message('Barber', name: 'barber', desc: '', args: []);
  }

  /// `Manage your queue, schedule and earnings`
  String get barberHint {
    return Intl.message(
      'Manage your queue, schedule and earnings',
      name: 'barberHint',
      desc: '',
      args: [],
    );
  }

  /// `Merchant`
  String get merchant {
    return Intl.message('Merchant', name: 'merchant', desc: '', args: []);
  }

  /// `Sell barber supplies wholesale to salons`
  String get merchantHint {
    return Intl.message(
      'Sell barber supplies wholesale to salons',
      name: 'merchantHint',
      desc: '',
      args: [],
    );
  }

  /// `This app is still under development`
  String get underDevelopment {
    return Intl.message(
      'This app is still under development',
      name: 'underDevelopment',
      desc: '',
      args: [],
    );
  }

  /// `Welcome 👋`
  String get welcomeBack {
    return Intl.message('Welcome 👋', name: 'welcomeBack', desc: '', args: []);
  }

  /// `Sign in with your merchant account to manage products and orders`
  String get loginSubtitle {
    return Intl.message(
      'Sign in with your merchant account to manage products and orders',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message('Sign in', name: 'signIn', desc: '', args: []);
  }

  /// `Don't have an account? Register as a merchant`
  String get noAccountRegister {
    return Intl.message(
      'Don\'t have an account? Register as a merchant',
      name: 'noAccountRegister',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Sign in`
  String get alreadyHaveAccountLogin {
    return Intl.message(
      'Already have an account? Sign in',
      name: 'alreadyHaveAccountLogin',
      desc: '',
      args: [],
    );
  }

  /// `Percentage cannot exceed 100%`
  String get percentAboveMax {
    return Intl.message(
      'Percentage cannot exceed 100%',
      name: 'percentAboveMax',
      desc: '',
      args: [],
    );
  }

  /// `Amount must be less than the order value`
  String get amountAboveTotal {
    return Intl.message(
      'Amount must be less than the order value',
      name: 'amountAboveTotal',
      desc: '',
      args: [],
    );
  }

  /// `Create a merchant account`
  String get createMerchantAccount {
    return Intl.message(
      'Create a merchant account',
      name: 'createMerchantAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register a new merchant`
  String get registerMerchant {
    return Intl.message(
      'Register a new merchant',
      name: 'registerMerchant',
      desc: '',
      args: [],
    );
  }

  /// `Register your business and start selling barber supplies wholesale.`
  String get registerSubtitle {
    return Intl.message(
      'Register your business and start selling barber supplies wholesale.',
      name: 'registerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Business name`
  String get businessName {
    return Intl.message(
      'Business name',
      name: 'businessName',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Golden Supplies`
  String get businessNameHint {
    return Intl.message(
      'e.g. Golden Supplies',
      name: 'businessNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter the business name`
  String get businessNameRequired {
    return Intl.message(
      'Enter the business name',
      name: 'businessNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Owner name`
  String get ownerName {
    return Intl.message('Owner name', name: 'ownerName', desc: '', args: []);
  }

  /// `e.g. Ahmed Ali`
  String get ownerNameHint {
    return Intl.message(
      'e.g. Ahmed Ali',
      name: 'ownerNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get ownerNameRequired {
    return Intl.message(
      'Enter your name',
      name: 'ownerNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `At least 6 characters`
  String get passwordMinHint {
    return Intl.message(
      'At least 6 characters',
      name: 'passwordMinHint',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short`
  String get passwordTooShort {
    return Intl.message(
      'Password is too short',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get createAccount {
    return Intl.message(
      'Create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get tabDashboard {
    return Intl.message('Dashboard', name: 'tabDashboard', desc: '', args: []);
  }

  /// `Products`
  String get tabProducts {
    return Intl.message('Products', name: 'tabProducts', desc: '', args: []);
  }

  /// `Orders`
  String get tabOrders {
    return Intl.message('Orders', name: 'tabOrders', desc: '', args: []);
  }

  /// `Account`
  String get tabAccount {
    return Intl.message('Account', name: 'tabAccount', desc: '', args: []);
  }

  /// `Services`
  String get tabServices {
    return Intl.message('Services', name: 'tabServices', desc: '', args: []);
  }

  /// `Store`
  String get tabStore {
    return Intl.message('Store', name: 'tabStore', desc: '', args: []);
  }

  /// `Bookings`
  String get tabBookings {
    return Intl.message('Bookings', name: 'tabBookings', desc: '', args: []);
  }

  /// `Home`
  String get tabHome {
    return Intl.message('Home', name: 'tabHome', desc: '', args: []);
  }

  /// `Good morning,`
  String get greeting {
    return Intl.message('Good morning,', name: 'greeting', desc: '', args: []);
  }

  /// `Needs your attention`
  String get homeNeedsAttentionTitle {
    return Intl.message(
      'Needs your attention',
      name: 'homeNeedsAttentionTitle',
      desc: '',
      args: [],
    );
  }

  /// `No pending bookings`
  String get homeAllClear {
    return Intl.message(
      'No pending bookings',
      name: 'homeAllClear',
      desc: '',
      args: [],
    );
  }

  /// `No bookings queued for today`
  String get homeNoQueueToday {
    return Intl.message(
      'No bookings queued for today',
      name: 'homeNoQueueToday',
      desc: '',
      args: [],
    );
  }

  /// `All your customers are barbers and salons registered on the platform — wholesale only.`
  String get merchantDashboardNote {
    return Intl.message(
      'All your customers are barbers and salons registered on the platform — wholesale only.',
      name: 'merchantDashboardNote',
      desc: '',
      args: [],
    );
  }

  /// `Pending orders`
  String get pendingOrders {
    return Intl.message(
      'Pending orders',
      name: 'pendingOrders',
      desc: '',
      args: [],
    );
  }

  /// `Month revenue`
  String get monthRevenue {
    return Intl.message(
      'Month revenue',
      name: 'monthRevenue',
      desc: '',
      args: [],
    );
  }

  /// `Active orders`
  String get activeOrders {
    return Intl.message(
      'Active orders',
      name: 'activeOrders',
      desc: '',
      args: [],
    );
  }

  /// `Delivered this month`
  String get deliveredThisMonth {
    return Intl.message(
      'Delivered this month',
      name: 'deliveredThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `Active products`
  String get activeProducts {
    return Intl.message(
      'Active products',
      name: 'activeProducts',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overviewTitle {
    return Intl.message('Overview', name: 'overviewTitle', desc: '', args: []);
  }

  /// `Needs your attention`
  String get needsAttention {
    return Intl.message(
      'Needs your attention',
      name: 'needsAttention',
      desc: '',
      args: [],
    );
  }

  /// `Out of stock`
  String get outOfStockProducts {
    return Intl.message(
      'Out of stock',
      name: 'outOfStockProducts',
      desc: '',
      args: [],
    );
  }

  /// `Discounted products`
  String get discountedProducts {
    return Intl.message(
      'Discounted products',
      name: 'discountedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Paused products`
  String get inactiveProducts {
    return Intl.message(
      'Paused products',
      name: 'inactiveProducts',
      desc: '',
      args: [],
    );
  }

  /// `Inventory`
  String get inventoryTitle {
    return Intl.message(
      'Inventory',
      name: 'inventoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Total units`
  String get totalStockUnits {
    return Intl.message(
      'Total units',
      name: 'totalStockUnits',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get productsCount {
    return Intl.message('Products', name: 'productsCount', desc: '', args: []);
  }

  /// `Out of stock`
  String get outOfStockShort {
    return Intl.message(
      'Out of stock',
      name: 'outOfStockShort',
      desc: '',
      args: [],
    );
  }

  /// `Most stocked`
  String get topProducts {
    return Intl.message(
      'Most stocked',
      name: 'topProducts',
      desc: '',
      args: [],
    );
  }

  /// `Running low`
  String get runningLowProducts {
    return Intl.message(
      'Running low',
      name: 'runningLowProducts',
      desc: '',
      args: [],
    );
  }

  /// `{count} units`
  String stockUnits(Object count) {
    return Intl.message(
      '$count units',
      name: 'stockUnits',
      desc: '',
      args: [count],
    );
  }

  /// `All good — nothing needs action`
  String get everythingFine {
    return Intl.message(
      'All good — nothing needs action',
      name: 'everythingFine',
      desc: '',
      args: [],
    );
  }

  /// `Latest orders`
  String get latestOrders {
    return Intl.message(
      'Latest orders',
      name: 'latestOrders',
      desc: '',
      args: [],
    );
  }

  /// `All orders`
  String get allOrders {
    return Intl.message('All orders', name: 'allOrders', desc: '', args: []);
  }

  /// `What you list here is only visible to barbers in their supplies store`
  String get productsNote {
    return Intl.message(
      'What you list here is only visible to barbers in their supplies store',
      name: 'productsNote',
      desc: '',
      args: [],
    );
  }

  /// `No products yet`
  String get noProductsYet {
    return Intl.message(
      'No products yet',
      name: 'noProductsYet',
      desc: '',
      args: [],
    );
  }

  /// `Delete product`
  String get deleteProduct {
    return Intl.message(
      'Delete product',
      name: 'deleteProduct',
      desc: '',
      args: [],
    );
  }

  /// `It will be removed from the barbers' store. Are you sure?`
  String get deleteProductConfirm {
    return Intl.message(
      'It will be removed from the barbers\' store. Are you sure?',
      name: 'deleteProductConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Add wholesale product`
  String get addWholesaleProduct {
    return Intl.message(
      'Add wholesale product',
      name: 'addWholesaleProduct',
      desc: '',
      args: [],
    );
  }

  /// `Edit product`
  String get editProduct {
    return Intl.message(
      'Edit product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `This product appears only in the supplies store inside the barbers' app, not to regular customers.`
  String get productFormNote {
    return Intl.message(
      'This product appears only in the supplies store inside the barbers\' app, not to regular customers.',
      name: 'productFormNote',
      desc: '',
      args: [],
    );
  }

  /// `Publish product`
  String get publishProduct {
    return Intl.message(
      'Publish product',
      name: 'publishProduct',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get saveChanges {
    return Intl.message(
      'Save changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Product images`
  String get productImages {
    return Intl.message(
      'Product images',
      name: 'productImages',
      desc: '',
      args: [],
    );
  }

  /// `Product name`
  String get productName {
    return Intl.message(
      'Product name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Strong hold wax - salon pack`
  String get productNameHint {
    return Intl.message(
      'e.g. Strong hold wax - salon pack',
      name: 'productNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter the product name`
  String get productNameRequired {
    return Intl.message(
      'Enter the product name',
      name: 'productNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message('Brand', name: 'brand', desc: '', args: []);
  }

  /// `e.g. Wahl`
  String get brandHint {
    return Intl.message('e.g. Wahl', name: 'brandHint', desc: '', args: []);
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Unit price (EGP)`
  String get unitPrice {
    return Intl.message(
      'Unit price (EGP)',
      name: 'unitPrice',
      desc: '',
      args: [],
    );
  }

  /// `Invalid price`
  String get invalidPrice {
    return Intl.message(
      'Invalid price',
      name: 'invalidPrice',
      desc: '',
      args: [],
    );
  }

  /// `Minimum order`
  String get minOrderQty {
    return Intl.message(
      'Minimum order',
      name: 'minOrderQty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid number`
  String get invalidNumber {
    return Intl.message(
      'Invalid number',
      name: 'invalidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Available stock`
  String get stockQuantity {
    return Intl.message(
      'Available stock',
      name: 'stockQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Product description`
  String get productDescription {
    return Intl.message(
      'Product description',
      name: 'productDescription',
      desc: '',
      args: [],
    );
  }

  /// `Write a short description and its benefits for barbers`
  String get productDescriptionHint {
    return Intl.message(
      'Write a short description and its benefits for barbers',
      name: 'productDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Barber orders`
  String get barberOrders {
    return Intl.message(
      'Barber orders',
      name: 'barberOrders',
      desc: '',
      args: [],
    );
  }

  /// `All the orders you received from salons`
  String get barberOrdersSubtitle {
    return Intl.message(
      'All the orders you received from salons',
      name: 'barberOrdersSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `No orders yet`
  String get noOrdersYet {
    return Intl.message(
      'No orders yet',
      name: 'noOrdersYet',
      desc: '',
      args: [],
    );
  }

  /// `Ordered items`
  String get orderedItems {
    return Intl.message(
      'Ordered items',
      name: 'orderedItems',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get orderTotal {
    return Intl.message('Total', name: 'orderTotal', desc: '', args: []);
  }

  /// `Order discount`
  String get orderDiscountLabel {
    return Intl.message(
      'Order discount',
      name: 'orderDiscountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Responsible barber: {name}`
  String responsibleBarber(Object name) {
    return Intl.message(
      'Responsible barber: $name',
      name: 'responsibleBarber',
      desc: '',
      args: [name],
    );
  }

  /// `Accept order`
  String get acceptOrder {
    return Intl.message(
      'Accept order',
      name: 'acceptOrder',
      desc: '',
      args: [],
    );
  }

  /// `Reject order`
  String get rejectOrder {
    return Intl.message(
      'Reject order',
      name: 'rejectOrder',
      desc: '',
      args: [],
    );
  }

  /// `Rejection reason`
  String get rejectReason {
    return Intl.message(
      'Rejection reason',
      name: 'rejectReason',
      desc: '',
      args: [],
    );
  }

  /// `e.g. item is out of stock`
  String get rejectReasonHint {
    return Intl.message(
      'e.g. item is out of stock',
      name: 'rejectReasonHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm rejection`
  String get confirmReject {
    return Intl.message(
      'Confirm rejection',
      name: 'confirmReject',
      desc: '',
      args: [],
    );
  }

  /// `Move status to "{status}"`
  String moveStatusTo(Object status) {
    return Intl.message(
      'Move status to "$status"',
      name: 'moveStatusTo',
      desc: '',
      args: [status],
    );
  }

  /// `My categories`
  String get myCategories {
    return Intl.message(
      'My categories',
      name: 'myCategories',
      desc: '',
      args: [],
    );
  }

  /// `Global categories are set by the admin, and you can add up to {limit} of your own.`
  String categoriesNote(Object limit) {
    return Intl.message(
      'Global categories are set by the admin, and you can add up to $limit of your own.',
      name: 'categoriesNote',
      desc: '',
      args: [limit],
    );
  }

  /// `My categories ({count}/{limit})`
  String myCategoriesCount(Object count, Object limit) {
    return Intl.message(
      'My categories ($count/$limit)',
      name: 'myCategoriesCount',
      desc: '',
      args: [count, limit],
    );
  }

  /// `+ Add`
  String get addAction {
    return Intl.message('+ Add', name: 'addAction', desc: '', args: []);
  }

  /// `No custom categories yet`
  String get noOwnCategories {
    return Intl.message(
      'No custom categories yet',
      name: 'noOwnCategories',
      desc: '',
      args: [],
    );
  }

  /// `Global categories`
  String get globalCategories {
    return Intl.message(
      'Global categories',
      name: 'globalCategories',
      desc: '',
      args: [],
    );
  }

  /// `Choose a category`
  String get chooseCategory {
    return Intl.message(
      'Choose a category',
      name: 'chooseCategory',
      desc: '',
      args: [],
    );
  }

  /// `Global`
  String get categoryGlobal {
    return Intl.message('Global', name: 'categoryGlobal', desc: '', args: []);
  }

  /// `Mine`
  String get categoryOwn {
    return Intl.message('Mine', name: 'categoryOwn', desc: '', args: []);
  }

  /// `New category`
  String get newCategory {
    return Intl.message(
      'New category',
      name: 'newCategory',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Premium offers`
  String get newCategoryHint {
    return Intl.message(
      'e.g. Premium offers',
      name: 'newCategoryHint',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Delete category`
  String get deleteCategory {
    return Intl.message(
      'Delete category',
      name: 'deleteCategory',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this category?`
  String get deleteCategoryConfirm {
    return Intl.message(
      'Are you sure you want to delete this category?',
      name: 'deleteCategoryConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Offers and discounts`
  String get discountsTitle {
    return Intl.message(
      'Offers and discounts',
      name: 'discountsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No offers yet`
  String get noDiscountsYet {
    return Intl.message(
      'No offers yet',
      name: 'noDiscountsYet',
      desc: '',
      args: [],
    );
  }

  /// `Live offers`
  String get liveDiscounts {
    return Intl.message(
      'Live offers',
      name: 'liveDiscounts',
      desc: '',
      args: [],
    );
  }

  /// `Closed offers`
  String get closedDiscounts {
    return Intl.message(
      'Closed offers',
      name: 'closedDiscounts',
      desc: '',
      args: [],
    );
  }

  /// `Close offer`
  String get closeDiscount {
    return Intl.message(
      'Close offer',
      name: 'closeDiscount',
      desc: '',
      args: [],
    );
  }

  /// `A closed offer cannot be reopened. Are you sure?`
  String get closeDiscountConfirm {
    return Intl.message(
      'A closed offer cannot be reopened. Are you sure?',
      name: 'closeDiscountConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get closeAction {
    return Intl.message('Close', name: 'closeAction', desc: '', args: []);
  }

  /// `Live`
  String get discountLive {
    return Intl.message('Live', name: 'discountLive', desc: '', args: []);
  }

  /// `Closed`
  String get discountClosed {
    return Intl.message('Closed', name: 'discountClosed', desc: '', args: []);
  }

  /// `All salons`
  String get allShops {
    return Intl.message('All salons', name: 'allShops', desc: '', args: []);
  }

  /// `New offer`
  String get newDiscount {
    return Intl.message('New offer', name: 'newDiscount', desc: '', args: []);
  }

  /// `Offer type`
  String get discountType {
    return Intl.message('Offer type', name: 'discountType', desc: '', args: []);
  }

  /// `Create offer`
  String get createDiscount {
    return Intl.message(
      'Create offer',
      name: 'createDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Offer name`
  String get discountName {
    return Intl.message('Offer name', name: 'discountName', desc: '', args: []);
  }

  /// `e.g. Summer offer`
  String get discountNameHint {
    return Intl.message(
      'e.g. Summer offer',
      name: 'discountNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter the offer name`
  String get discountNameRequired {
    return Intl.message(
      'Enter the offer name',
      name: 'discountNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message('Product', name: 'product', desc: '', args: []);
  }

  /// `Choose the product`
  String get chooseProduct {
    return Intl.message(
      'Choose the product',
      name: 'chooseProduct',
      desc: '',
      args: [],
    );
  }

  /// `Choose a product`
  String get productRequired {
    return Intl.message(
      'Choose a product',
      name: 'productRequired',
      desc: '',
      args: [],
    );
  }

  /// `How many to buy?`
  String get buyQuantityLabel {
    return Intl.message(
      'How many to buy?',
      name: 'buyQuantityLabel',
      desc: '',
      args: [],
    );
  }

  /// `How many do they get?`
  String get rewardQuantityLabel {
    return Intl.message(
      'How many do they get?',
      name: 'rewardQuantityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Minimum order total (EGP)`
  String get minOrderTotalLabel {
    return Intl.message(
      'Minimum order total (EGP)',
      name: 'minOrderTotalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Reward type`
  String get rewardTypeLabel {
    return Intl.message(
      'Reward type',
      name: 'rewardTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Discount value`
  String get discountValue {
    return Intl.message(
      'Discount value',
      name: 'discountValue',
      desc: '',
      args: [],
    );
  }

  /// `Salons`
  String get shops {
    return Intl.message('Salons', name: 'shops', desc: '', args: []);
  }

  /// `Selecting none = the offer applies to all salons`
  String get shopsAllHint {
    return Intl.message(
      'Selecting none = the offer applies to all salons',
      name: 'shopsAllHint',
      desc: '',
      args: [],
    );
  }

  /// `The offer applies to {count} salons`
  String shopsSelectedHint(Object count) {
    return Intl.message(
      'The offer applies to $count salons',
      name: 'shopsSelectedHint',
      desc: '',
      args: [count],
    );
  }

  /// `The offer will apply to all salons`
  String get shopsAllNote {
    return Intl.message(
      'The offer will apply to all salons',
      name: 'shopsAllNote',
      desc: '',
      args: [],
    );
  }

  /// `Product discount`
  String get scopeProduct {
    return Intl.message(
      'Product discount',
      name: 'scopeProduct',
      desc: '',
      args: [],
    );
  }

  /// `A percentage or amount off a single product`
  String get scopeProductHint {
    return Intl.message(
      'A percentage or amount off a single product',
      name: 'scopeProductHint',
      desc: '',
      args: [],
    );
  }

  /// `Buy X get Y`
  String get scopeBuyXGetY {
    return Intl.message(
      'Buy X get Y',
      name: 'scopeBuyXGetY',
      desc: '',
      args: [],
    );
  }

  /// `Buy a quantity and get items free or discounted`
  String get scopeBuyXGetYHint {
    return Intl.message(
      'Buy a quantity and get items free or discounted',
      name: 'scopeBuyXGetYHint',
      desc: '',
      args: [],
    );
  }

  /// `Order total discount`
  String get scopeOrderTotal {
    return Intl.message(
      'Order total discount',
      name: 'scopeOrderTotal',
      desc: '',
      args: [],
    );
  }

  /// `When the order reaches an amount, discount the whole order`
  String get scopeOrderTotalHint {
    return Intl.message(
      'When the order reaches an amount, discount the whole order',
      name: 'scopeOrderTotalHint',
      desc: '',
      args: [],
    );
  }

  /// `Percent %`
  String get rewardPercent {
    return Intl.message('Percent %', name: 'rewardPercent', desc: '', args: []);
  }

  /// `Fixed amount`
  String get rewardAmount {
    return Intl.message(
      'Fixed amount',
      name: 'rewardAmount',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get rewardFree {
    return Intl.message('Free', name: 'rewardFree', desc: '', args: []);
  }

  /// `Wholesale barber supplies`
  String get wholesaleSupplier {
    return Intl.message(
      'Wholesale barber supplies',
      name: 'wholesaleSupplier',
      desc: '',
      args: [],
    );
  }

  /// `Verified merchant`
  String get verifiedMerchant {
    return Intl.message(
      'Verified merchant',
      name: 'verifiedMerchant',
      desc: '',
      args: [],
    );
  }

  /// `Under review`
  String get underReview {
    return Intl.message(
      'Under review',
      name: 'underReview',
      desc: '',
      args: [],
    );
  }

  /// `Business owner`
  String get businessOwner {
    return Intl.message(
      'Business owner',
      name: 'businessOwner',
      desc: '',
      args: [],
    );
  }

  /// `Shop owner`
  String get shopOwner {
    return Intl.message('Shop owner', name: 'shopOwner', desc: '', args: []);
  }

  /// `Team member`
  String get teamMember {
    return Intl.message('Team member', name: 'teamMember', desc: '', args: []);
  }

  /// `Barbershop`
  String get shopLabel {
    return Intl.message('Barbershop', name: 'shopLabel', desc: '', args: []);
  }

  /// `Contact`
  String get contact {
    return Intl.message('Contact', name: 'contact', desc: '', args: []);
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Management`
  String get management {
    return Intl.message('Management', name: 'management', desc: '', args: []);
  }

  /// `Account`
  String get accountSection {
    return Intl.message('Account', name: 'accountSection', desc: '', args: []);
  }

  /// `App settings`
  String get appSettings {
    return Intl.message(
      'App settings',
      name: 'appSettings',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get supportSection {
    return Intl.message('Support', name: 'supportSection', desc: '', args: []);
  }

  /// `Edit my info`
  String get editMyInfo {
    return Intl.message('Edit my info', name: 'editMyInfo', desc: '', args: []);
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `My documents`
  String get myDocuments {
    return Intl.message(
      'My documents',
      name: 'myDocuments',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get aboutApp {
    return Intl.message('About the app', name: 'aboutApp', desc: '', args: []);
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Email (optional)`
  String get emailOptional {
    return Intl.message(
      'Email (optional)',
      name: 'emailOptional',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get currentPassword {
    return Intl.message(
      'Current password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your current password`
  String get currentPasswordRequired {
    return Intl.message(
      'Enter your current password',
      name: 'currentPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password changed`
  String get passwordChanged {
    return Intl.message(
      'Password changed',
      name: 'passwordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Awaiting response`
  String get statusPending {
    return Intl.message(
      'Awaiting response',
      name: 'statusPending',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get statusAccepted {
    return Intl.message('Accepted', name: 'statusAccepted', desc: '', args: []);
  }

  /// `Preparing`
  String get statusPreparing {
    return Intl.message(
      'Preparing',
      name: 'statusPreparing',
      desc: '',
      args: [],
    );
  }

  /// `Ready for pickup`
  String get statusReadyForPickup {
    return Intl.message(
      'Ready for pickup',
      name: 'statusReadyForPickup',
      desc: '',
      args: [],
    );
  }

  /// `Out for delivery`
  String get statusOutForDelivery {
    return Intl.message(
      'Out for delivery',
      name: 'statusOutForDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get statusDelivered {
    return Intl.message(
      'Delivered',
      name: 'statusDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get statusRejected {
    return Intl.message('Rejected', name: 'statusRejected', desc: '', args: []);
  }

  /// `Cancelled`
  String get statusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'statusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get fulfilmentDelivery {
    return Intl.message(
      'Delivery',
      name: 'fulfilmentDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Pickup at branch`
  String get fulfilmentPickup {
    return Intl.message(
      'Pickup at branch',
      name: 'fulfilmentPickup',
      desc: '',
      args: [],
    );
  }

  /// `{amount} EGP`
  String currencyEgp(Object amount) {
    return Intl.message(
      '$amount EGP',
      name: 'currencyEgp',
      desc: '',
      args: [amount],
    );
  }

  /// `{price} EGP · stock {stock} · min {min}`
  String productMetaLine(Object price, Object stock, Object min) {
    return Intl.message(
      '$price EGP · stock $stock · min $min',
      name: 'productMetaLine',
      desc: '',
      args: [price, stock, min],
    );
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `{days} days ago`
  String daysAgo(Object days) {
    return Intl.message(
      '$days days ago',
      name: 'daysAgo',
      desc: '',
      args: [days],
    );
  }

  /// `, `
  String get listSeparator {
    return Intl.message(', ', name: 'listSeparator', desc: '', args: []);
  }

  /// `?`
  String get avatarFallback {
    return Intl.message('?', name: 'avatarFallback', desc: '', args: []);
  }

  /// `Extra phone numbers`
  String get extraPhones {
    return Intl.message(
      'Extra phone numbers',
      name: 'extraPhones',
      desc: '',
      args: [],
    );
  }

  /// `Additional contact numbers for salons to reach you. Your login number is changed by the admin.`
  String get extraPhonesNote {
    return Intl.message(
      'Additional contact numbers for salons to reach you. Your login number is changed by the admin.',
      name: 'extraPhonesNote',
      desc: '',
      args: [],
    );
  }

  /// `No extra numbers yet`
  String get noExtraPhones {
    return Intl.message(
      'No extra numbers yet',
      name: 'noExtraPhones',
      desc: '',
      args: [],
    );
  }

  /// `New number`
  String get addPhoneTitle {
    return Intl.message(
      'New number',
      name: 'addPhoneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Label (optional)`
  String get phoneLabel {
    return Intl.message(
      'Label (optional)',
      name: 'phoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Sales line`
  String get phoneLabelHint {
    return Intl.message(
      'e.g. Sales line',
      name: 'phoneLabelHint',
      desc: '',
      args: [],
    );
  }

  /// `Delete number`
  String get deletePhone {
    return Intl.message(
      'Delete number',
      name: 'deletePhone',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this number?`
  String get deletePhoneConfirm {
    return Intl.message(
      'Are you sure you want to delete this number?',
      name: 'deletePhoneConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Ayez Ahlaq — a wholesale platform connecting barber supply merchants with salons.`
  String get aboutAppBody {
    return Intl.message(
      'Ayez Ahlaq — a wholesale platform connecting barber supply merchants with salons.',
      name: 'aboutAppBody',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Nothing here yet`
  String get emptyDefaultTitle {
    return Intl.message(
      'Nothing here yet',
      name: 'emptyDefaultTitle',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get errorDefaultTitle {
    return Intl.message(
      'Something went wrong',
      name: 'errorDefaultTitle',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `All`
  String get filterAll {
    return Intl.message('All', name: 'filterAll', desc: '', args: []);
  }

  /// `Edit offer`
  String get editDiscount {
    return Intl.message('Edit offer', name: 'editDiscount', desc: '', args: []);
  }

  /// `Edit category`
  String get editCategory {
    return Intl.message(
      'Edit category',
      name: 'editCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category image`
  String get categoryImage {
    return Intl.message(
      'Category image',
      name: 'categoryImage',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `No notifications`
  String get notificationsEmpty {
    return Intl.message(
      'No notifications',
      name: 'notificationsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `New orders and updates will show up here`
  String get notificationsEmptyHint {
    return Intl.message(
      'New orders and updates will show up here',
      name: 'notificationsEmptyHint',
      desc: '',
      args: [],
    );
  }

  /// `Mark all as read`
  String get markAllRead {
    return Intl.message(
      'Mark all as read',
      name: 'markAllRead',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logoutTitle {
    return Intl.message('Log out', name: 'logoutTitle', desc: '', args: []);
  }

  /// `Are you sure you want to log out?`
  String get logoutConfirm {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logoutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Choose language`
  String get chooseLanguage {
    return Intl.message(
      'Choose language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Choose theme`
  String get chooseTheme {
    return Intl.message(
      'Choose theme',
      name: 'chooseTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get themeDark {
    return Intl.message('Dark', name: 'themeDark', desc: '', args: []);
  }

  /// `Light`
  String get themeLight {
    return Intl.message('Light', name: 'themeLight', desc: '', args: []);
  }

  /// `العربية`
  String get arabic {
    return Intl.message('العربية', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `In stock`
  String get inStock {
    return Intl.message('In stock', name: 'inStock', desc: '', args: []);
  }

  /// `Out of stock`
  String get outOfStock {
    return Intl.message('Out of stock', name: 'outOfStock', desc: '', args: []);
  }

  /// `Active offer`
  String get activeDiscount {
    return Intl.message(
      'Active offer',
      name: 'activeDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Product details`
  String get productDetails {
    return Intl.message(
      'Product details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get deliveryTitle {
    return Intl.message('Delivery', name: 'deliveryTitle', desc: '', args: []);
  }

  /// `When delivery is on, salons can order delivery and the fee is added to the order total. When off, pickup from your shop only.`
  String get deliveryNote {
    return Intl.message(
      'When delivery is on, salons can order delivery and the fee is added to the order total. When off, pickup from your shop only.',
      name: 'deliveryNote',
      desc: '',
      args: [],
    );
  }

  /// `I offer delivery`
  String get deliveryOffered {
    return Intl.message(
      'I offer delivery',
      name: 'deliveryOffered',
      desc: '',
      args: [],
    );
  }

  /// `Delivery fee`
  String get deliveryFeeLabel {
    return Intl.message(
      'Delivery fee',
      name: 'deliveryFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 25`
  String get deliveryFeeHint {
    return Intl.message('e.g. 25', name: 'deliveryFeeHint', desc: '', args: []);
  }

  /// `Enter the delivery fee`
  String get deliveryFeeRequired {
    return Intl.message(
      'Enter the delivery fee',
      name: 'deliveryFeeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Free delivery over`
  String get deliveryFreeOverLabel {
    return Intl.message(
      'Free delivery over',
      name: 'deliveryFreeOverLabel',
      desc: '',
      args: [],
    );
  }

  /// `Leave empty for no free delivery`
  String get deliveryFreeOverHint {
    return Intl.message(
      'Leave empty for no free delivery',
      name: 'deliveryFreeOverHint',
      desc: '',
      args: [],
    );
  }

  /// `When the goods total reaches this amount, delivery is free.`
  String get deliveryFreeOverNote {
    return Intl.message(
      'When the goods total reaches this amount, delivery is free.',
      name: 'deliveryFreeOverNote',
      desc: '',
      args: [],
    );
  }

  /// `Delivery is off — pickup only`
  String get deliveryOffLabel {
    return Intl.message(
      'Delivery is off — pickup only',
      name: 'deliveryOffLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delivery settings saved`
  String get deliverySaved {
    return Intl.message(
      'Delivery settings saved',
      name: 'deliverySaved',
      desc: '',
      args: [],
    );
  }

  /// `Delivery fee`
  String get deliveryFeeOrderLabel {
    return Intl.message(
      'Delivery fee',
      name: 'deliveryFeeOrderLabel',
      desc: '',
      args: [],
    );
  }

  /// `Grand total`
  String get grandTotalLabel {
    return Intl.message(
      'Grand total',
      name: 'grandTotalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get freeDelivery {
    return Intl.message('Free', name: 'freeDelivery', desc: '', args: []);
  }

  /// `The admin sets which documents are needed. Upload an image or a PDF for each one, up to {size} MB.`
  String documentsNote(Object size) {
    return Intl.message(
      'The admin sets which documents are needed. Upload an image or a PDF for each one, up to $size MB.',
      name: 'documentsNote',
      desc: '',
      args: [size],
    );
  }

  /// `{uploaded} of {total} uploaded`
  String documentsProgress(Object uploaded, Object total) {
    return Intl.message(
      '$uploaded of $total uploaded',
      name: 'documentsProgress',
      desc: '',
      args: [uploaded, total],
    );
  }

  /// `{count} required documents are still missing`
  String documentsMissingRequired(Object count) {
    return Intl.message(
      '$count required documents are still missing',
      name: 'documentsMissingRequired',
      desc: '',
      args: [count],
    );
  }

  /// `All required documents are uploaded`
  String get documentsAllUploaded {
    return Intl.message(
      'All required documents are uploaded',
      name: 'documentsAllUploaded',
      desc: '',
      args: [],
    );
  }

  /// `Your account is under review until the admin approves your documents.`
  String get documentsPendingReview {
    return Intl.message(
      'Your account is under review until the admin approves your documents.',
      name: 'documentsPendingReview',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get documentRequired {
    return Intl.message(
      'Required',
      name: 'documentRequired',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get documentOptional {
    return Intl.message(
      'Optional',
      name: 'documentOptional',
      desc: '',
      args: [],
    );
  }

  /// `Uploaded`
  String get documentUploaded {
    return Intl.message(
      'Uploaded',
      name: 'documentUploaded',
      desc: '',
      args: [],
    );
  }

  /// `Not uploaded yet`
  String get documentNotUploadedYet {
    return Intl.message(
      'Not uploaded yet',
      name: 'documentNotUploadedYet',
      desc: '',
      args: [],
    );
  }

  /// `Could not load the file`
  String get documentLoadFailed {
    return Intl.message(
      'Could not load the file',
      name: 'documentLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get shareDocument {
    return Intl.message('Share', name: 'shareDocument', desc: '', args: []);
  }

  /// `Added by the admin`
  String get documentAddedByAdmin {
    return Intl.message(
      'Added by the admin',
      name: 'documentAddedByAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get uploadDocument {
    return Intl.message('Upload', name: 'uploadDocument', desc: '', args: []);
  }

  /// `Replace`
  String get replaceDocument {
    return Intl.message('Replace', name: 'replaceDocument', desc: '', args: []);
  }

  /// `View`
  String get viewDocument {
    return Intl.message('View', name: 'viewDocument', desc: '', args: []);
  }

  /// `Delete file`
  String get deleteDocument {
    return Intl.message(
      'Delete file',
      name: 'deleteDocument',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this file? You can upload it again later.`
  String get deleteDocumentConfirm {
    return Intl.message(
      'Are you sure you want to delete this file? You can upload it again later.',
      name: 'deleteDocumentConfirm',
      desc: '',
      args: [],
    );
  }

  /// `File uploaded`
  String get documentUploadedSuccess {
    return Intl.message(
      'File uploaded',
      name: 'documentUploadedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `File deleted`
  String get documentDeletedSuccess {
    return Intl.message(
      'File deleted',
      name: 'documentDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `The file is too large — maximum {size} MB`
  String documentTooLarge(Object size) {
    return Intl.message(
      'The file is too large — maximum $size MB',
      name: 'documentTooLarge',
      desc: '',
      args: [size],
    );
  }

  /// `No documents requested yet`
  String get noDocuments {
    return Intl.message(
      'No documents requested yet',
      name: 'noDocuments',
      desc: '',
      args: [],
    );
  }

  /// `The admin has not requested any documents from you yet.`
  String get noDocumentsMessage {
    return Intl.message(
      'The admin has not requested any documents from you yet.',
      name: 'noDocumentsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your details are verified`
  String get identityLockedTitle {
    return Intl.message(
      'Your details are verified',
      name: 'identityLockedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your name and business name can't be changed after your account is activated. Contact support if you need to update them.`
  String get identityLockedMessage {
    return Intl.message(
      'Your name and business name can\'t be changed after your account is activated. Contact support if you need to update them.',
      name: 'identityLockedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your name and business name can't be changed after activation`
  String get identityLockedAction {
    return Intl.message(
      'Your name and business name can\'t be changed after activation',
      name: 'identityLockedAction',
      desc: '',
      args: [],
    );
  }

  /// `Documents requested`
  String get documentsRequestedTitle {
    return Intl.message(
      'Documents requested',
      name: 'documentsRequestedTitle',
      desc: '',
      args: [],
    );
  }

  /// `The admin is waiting for files from you`
  String get documentsRequestedMessage {
    return Intl.message(
      'The admin is waiting for files from you',
      name: 'documentsRequestedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Required documents`
  String get documentsBlockedTitle {
    return Intl.message(
      'Required documents',
      name: 'documentsBlockedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Upload your documents to continue`
  String get documentsBlockedHeadline {
    return Intl.message(
      'Upload your documents to continue',
      name: 'documentsBlockedHeadline',
      desc: '',
      args: [],
    );
  }

  /// `The admin needs these files before you can use the app. Once they're uploaded, everything unlocks right away.`
  String get documentsBlockedMessage {
    return Intl.message(
      'The admin needs these files before you can use the app. Once they\'re uploaded, everything unlocks right away.',
      name: 'documentsBlockedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Choose upload source`
  String get chooseUploadSource {
    return Intl.message(
      'Choose upload source',
      name: 'chooseUploadSource',
      desc: '',
      args: [],
    );
  }

  /// `Files`
  String get filesSource {
    return Intl.message('Files', name: 'filesSource', desc: '', args: []);
  }

  /// `Only images or PDF files are allowed`
  String get documentUnsupportedType {
    return Intl.message(
      'Only images or PDF files are allowed',
      name: 'documentUnsupportedType',
      desc: '',
      args: [],
    );
  }

  /// `Documents you can add`
  String get documentsOptionalTitle {
    return Intl.message(
      'Documents you can add',
      name: 'documentsOptionalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Optional — upload them whenever you like`
  String get documentsOptionalMessage {
    return Intl.message(
      'Optional — upload them whenever you like',
      name: 'documentsOptionalMessage',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shopSection {
    return Intl.message('Shop', name: 'shopSection', desc: '', args: []);
  }

  /// `Store & Sales`
  String get storeAndSalesSection {
    return Intl.message(
      'Store & Sales',
      name: 'storeAndSalesSection',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get moreSection {
    return Intl.message('More', name: 'moreSection', desc: '', args: []);
  }

  /// `Working hours`
  String get workingHoursTitle {
    return Intl.message(
      'Working hours',
      name: 'workingHoursTitle',
      desc: '',
      args: [],
    );
  }

  /// `Opens at`
  String get openTimeLabel {
    return Intl.message('Opens at', name: 'openTimeLabel', desc: '', args: []);
  }

  /// `Closes at`
  String get closeTimeLabel {
    return Intl.message(
      'Closes at',
      name: 'closeTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Working hours saved`
  String get hoursSaved {
    return Intl.message(
      'Working hours saved',
      name: 'hoursSaved',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get dayMonday {
    return Intl.message('Monday', name: 'dayMonday', desc: '', args: []);
  }

  /// `Tuesday`
  String get dayTuesday {
    return Intl.message('Tuesday', name: 'dayTuesday', desc: '', args: []);
  }

  /// `Wednesday`
  String get dayWednesday {
    return Intl.message('Wednesday', name: 'dayWednesday', desc: '', args: []);
  }

  /// `Thursday`
  String get dayThursday {
    return Intl.message('Thursday', name: 'dayThursday', desc: '', args: []);
  }

  /// `Friday`
  String get dayFriday {
    return Intl.message('Friday', name: 'dayFriday', desc: '', args: []);
  }

  /// `Saturday`
  String get daySaturday {
    return Intl.message('Saturday', name: 'daySaturday', desc: '', args: []);
  }

  /// `Sunday`
  String get daySunday {
    return Intl.message('Sunday', name: 'daySunday', desc: '', args: []);
  }

  /// `Services`
  String get servicesTitle {
    return Intl.message('Services', name: 'servicesTitle', desc: '', args: []);
  }

  /// `Add service`
  String get addServiceTitle {
    return Intl.message(
      'Add service',
      name: 'addServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit service`
  String get editServiceTitle {
    return Intl.message(
      'Edit service',
      name: 'editServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose a service`
  String get chooseService {
    return Intl.message(
      'Choose a service',
      name: 'chooseService',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get servicePriceLabel {
    return Intl.message('Price', name: 'servicePriceLabel', desc: '', args: []);
  }

  /// `e.g. 100`
  String get servicePriceHint {
    return Intl.message(
      'e.g. 100',
      name: 'servicePriceHint',
      desc: '',
      args: [],
    );
  }

  /// `Duration (minutes)`
  String get serviceDurationLabel {
    return Intl.message(
      'Duration (minutes)',
      name: 'serviceDurationLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 30`
  String get serviceDurationHint {
    return Intl.message(
      'e.g. 30',
      name: 'serviceDurationHint',
      desc: '',
      args: [],
    );
  }

  /// `{price} EGP · {duration} min`
  String serviceMetaLine(Object price, Object duration) {
    return Intl.message(
      '$price EGP · $duration min',
      name: 'serviceMetaLine',
      desc: '',
      args: [price, duration],
    );
  }

  /// `Buy supplies`
  String get buySupplies {
    return Intl.message(
      'Buy supplies',
      name: 'buySupplies',
      desc: '',
      args: [],
    );
  }

  /// `Suppliers store`
  String get storeTitle {
    return Intl.message(
      'Suppliers store',
      name: 'storeTitle',
      desc: '',
      args: [],
    );
  }

  /// `No suppliers available yet`
  String get noMerchantsYet {
    return Intl.message(
      'No suppliers available yet',
      name: 'noMerchantsYet',
      desc: '',
      args: [],
    );
  }

  /// `View cart`
  String get viewCart {
    return Intl.message('View cart', name: 'viewCart', desc: '', args: []);
  }

  /// `Cart`
  String get cartTitle {
    return Intl.message('Cart', name: 'cartTitle', desc: '', args: []);
  }

  /// `Your cart is empty`
  String get cartEmpty {
    return Intl.message(
      'Your cart is empty',
      name: 'cartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Fulfilment`
  String get fulfilmentTitle {
    return Intl.message(
      'Fulfilment',
      name: 'fulfilmentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Note (optional)`
  String get orderNoteTitle {
    return Intl.message(
      'Note (optional)',
      name: 'orderNoteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add a note for the supplier`
  String get orderNoteHint {
    return Intl.message(
      'Add a note for the supplier',
      name: 'orderNoteHint',
      desc: '',
      args: [],
    );
  }

  /// `Place order`
  String get placeOrder {
    return Intl.message('Place order', name: 'placeOrder', desc: '', args: []);
  }

  /// `Order placed`
  String get orderPlaced {
    return Intl.message(
      'Order placed',
      name: 'orderPlaced',
      desc: '',
      args: [],
    );
  }

  /// `My supply orders`
  String get storeOrdersTitle {
    return Intl.message(
      'My supply orders',
      name: 'storeOrdersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cancel order`
  String get cancelOrder {
    return Intl.message(
      'Cancel order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get walletTitle {
    return Intl.message('Wallet', name: 'walletTitle', desc: '', args: []);
  }

  /// `Current balance`
  String get walletBalanceLabel {
    return Intl.message(
      'Current balance',
      name: 'walletBalanceLabel',
      desc: '',
      args: [],
    );
  }

  /// `No transactions yet`
  String get noWalletTransactions {
    return Intl.message(
      'No transactions yet',
      name: 'noWalletTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviewsTitle {
    return Intl.message('Reviews', name: 'reviewsTitle', desc: '', args: []);
  }

  /// `{count} reviews`
  String reviewsCount(Object count) {
    return Intl.message(
      '$count reviews',
      name: 'reviewsCount',
      desc: '',
      args: [count],
    );
  }

  /// `No reviews yet`
  String get noReviewsYet {
    return Intl.message(
      'No reviews yet',
      name: 'noReviewsYet',
      desc: '',
      args: [],
    );
  }

  /// `Invite link`
  String get inviteTitle {
    return Intl.message('Invite link', name: 'inviteTitle', desc: '', args: []);
  }

  /// `Share this link with customers — anyone who joins through it becomes your favorite automatically.`
  String get inviteNote {
    return Intl.message(
      'Share this link with customers — anyone who joins through it becomes your favorite automatically.',
      name: 'inviteNote',
      desc: '',
      args: [],
    );
  }

  /// `Link copied`
  String get inviteLinkCopied {
    return Intl.message(
      'Link copied',
      name: 'inviteLinkCopied',
      desc: '',
      args: [],
    );
  }

  /// `Customers via this link`
  String get inviteFavoritesLabel {
    return Intl.message(
      'Customers via this link',
      name: 'inviteFavoritesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Regenerate link`
  String get regenerateInviteTitle {
    return Intl.message(
      'Regenerate link',
      name: 'regenerateInviteTitle',
      desc: '',
      args: [],
    );
  }

  /// `The old link will stop working. Are you sure?`
  String get regenerateInviteConfirm {
    return Intl.message(
      'The old link will stop working. Are you sure?',
      name: 'regenerateInviteConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Link regenerated`
  String get inviteRegenerated {
    return Intl.message(
      'Link regenerated',
      name: 'inviteRegenerated',
      desc: '',
      args: [],
    );
  }

  /// `My storefront`
  String get storefrontProductsTitle {
    return Intl.message(
      'My storefront',
      name: 'storefrontProductsTitle',
      desc: '',
      args: [],
    );
  }

  /// `What you list here is what customers see and can order from your shop`
  String get storefrontProductsNote {
    return Intl.message(
      'What you list here is what customers see and can order from your shop',
      name: 'storefrontProductsNote',
      desc: '',
      args: [],
    );
  }

  /// `This product appears to customers browsing your shop in the app.`
  String get storefrontProductFormNote {
    return Intl.message(
      'This product appears to customers browsing your shop in the app.',
      name: 'storefrontProductFormNote',
      desc: '',
      args: [],
    );
  }

  /// `It will be removed from your storefront. Are you sure?`
  String get deleteStorefrontProductConfirm {
    return Intl.message(
      'It will be removed from your storefront. Are you sure?',
      name: 'deleteStorefrontProductConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Add product`
  String get addStorefrontProduct {
    return Intl.message(
      'Add product',
      name: 'addStorefrontProduct',
      desc: '',
      args: [],
    );
  }

  /// `Storefront categories`
  String get storefrontCategoriesTitle {
    return Intl.message(
      'Storefront categories',
      name: 'storefrontCategoriesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Storefront delivery`
  String get storefrontDeliveryMenuTitle {
    return Intl.message(
      'Storefront delivery',
      name: 'storefrontDeliveryMenuTitle',
      desc: '',
      args: [],
    );
  }

  /// `Storefront orders`
  String get storefrontOrdersTitle {
    return Intl.message(
      'Storefront orders',
      name: 'storefrontOrdersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Orders placed by customers from your storefront`
  String get storefrontOrdersSubtitle {
    return Intl.message(
      'Orders placed by customers from your storefront',
      name: 'storefrontOrdersSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customerLabel {
    return Intl.message('Customer', name: 'customerLabel', desc: '', args: []);
  }

  /// `Customer phone`
  String get customerPhoneLabel {
    return Intl.message(
      'Customer phone',
      name: 'customerPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get paymentMethodLabel {
    return Intl.message(
      'Payment method',
      name: 'paymentMethodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Bookings`
  String get bookingsTitle {
    return Intl.message('Bookings', name: 'bookingsTitle', desc: '', args: []);
  }

  /// `Awaiting confirmation`
  String get bookingsPendingTab {
    return Intl.message(
      'Awaiting confirmation',
      name: 'bookingsPendingTab',
      desc: '',
      args: [],
    );
  }

  /// `Today's queue`
  String get bookingsQueueTab {
    return Intl.message(
      'Today\'s queue',
      name: 'bookingsQueueTab',
      desc: '',
      args: [],
    );
  }

  /// `No bookings awaiting confirmation`
  String get noPendingBookings {
    return Intl.message(
      'No bookings awaiting confirmation',
      name: 'noPendingBookings',
      desc: '',
      args: [],
    );
  }

  /// `The queue is empty`
  String get queueEmpty {
    return Intl.message(
      'The queue is empty',
      name: 'queueEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Awaiting confirmation`
  String get bookingStatusPending {
    return Intl.message(
      'Awaiting confirmation',
      name: 'bookingStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get bookingStatusConfirmed {
    return Intl.message(
      'Confirmed',
      name: 'bookingStatusConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get bookingStatusUpcoming {
    return Intl.message(
      'Upcoming',
      name: 'bookingStatusUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get bookingStatusNext {
    return Intl.message('Next', name: 'bookingStatusNext', desc: '', args: []);
  }

  /// `In progress`
  String get bookingStatusActive {
    return Intl.message(
      'In progress',
      name: 'bookingStatusActive',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get bookingStatusDone {
    return Intl.message('Done', name: 'bookingStatusDone', desc: '', args: []);
  }

  /// `No show`
  String get bookingStatusNoShow {
    return Intl.message(
      'No show',
      name: 'bookingStatusNoShow',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get bookingStatusRejected {
    return Intl.message(
      'Rejected',
      name: 'bookingStatusRejected',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get bookingStatusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'bookingStatusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Confirm booking`
  String get confirmBooking {
    return Intl.message(
      'Confirm booking',
      name: 'confirmBooking',
      desc: '',
      args: [],
    );
  }

  /// `Reject booking`
  String get rejectBooking {
    return Intl.message(
      'Reject booking',
      name: 'rejectBooking',
      desc: '',
      args: [],
    );
  }

  /// `Booking details`
  String get bookingDetailsTitle {
    return Intl.message(
      'Booking details',
      name: 'bookingDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get serviceLabel {
    return Intl.message('Service', name: 'serviceLabel', desc: '', args: []);
  }

  /// `Style`
  String get styleLabel {
    return Intl.message('Style', name: 'styleLabel', desc: '', args: []);
  }

  /// `Date and time`
  String get bookingDateLabel {
    return Intl.message(
      'Date and time',
      name: 'bookingDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Queue position`
  String get queuePositionLabel {
    return Intl.message(
      'Queue position',
      name: 'queuePositionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Respond by`
  String get decisionDeadlineLabel {
    return Intl.message(
      'Respond by',
      name: 'decisionDeadlineLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add-ons`
  String get addonsLabel {
    return Intl.message('Add-ons', name: 'addonsLabel', desc: '', args: []);
  }

  /// `Add a walk-in`
  String get addWalkInTitle {
    return Intl.message(
      'Add a walk-in',
      name: 'addWalkInTitle',
      desc: '',
      args: [],
    );
  }

  /// `Note (optional)`
  String get walkInNoteLabel {
    return Intl.message(
      'Note (optional)',
      name: 'walkInNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. in a hurry`
  String get walkInNoteHint {
    return Intl.message(
      'e.g. in a hurry',
      name: 'walkInNoteHint',
      desc: '',
      args: [],
    );
  }

  /// `Add-ons (optional)`
  String get walkInAddonsLabel {
    return Intl.message(
      'Add-ons (optional)',
      name: 'walkInAddonsLabel',
      desc: '',
      args: [],
    );
  }

  /// `For a team member (optional)`
  String get walkInBarberLabel {
    return Intl.message(
      'For a team member (optional)',
      name: 'walkInBarberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Choose a team member`
  String get chooseTeamMember {
    return Intl.message(
      'Choose a team member',
      name: 'chooseTeamMember',
      desc: '',
      args: [],
    );
  }

  /// `Add walk-in`
  String get addWalkInAction {
    return Intl.message(
      'Add walk-in',
      name: 'addWalkInAction',
      desc: '',
      args: [],
    );
  }

  /// `Your storefront`
  String get storefrontTitle {
    return Intl.message(
      'Your storefront',
      name: 'storefrontTitle',
      desc: '',
      args: [],
    );
  }

  /// `Team`
  String get teamTitle {
    return Intl.message('Team', name: 'teamTitle', desc: '', args: []);
  }

  /// `Add team member`
  String get addMemberTitle {
    return Intl.message(
      'Add team member',
      name: 'addMemberTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get memberNameLabel {
    return Intl.message('Name', name: 'memberNameLabel', desc: '', args: []);
  }

  /// `e.g. Karim`
  String get memberNameHint {
    return Intl.message(
      'e.g. Karim',
      name: 'memberNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get memberPhoneLabel {
    return Intl.message(
      'Phone number',
      name: 'memberPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 01111111111`
  String get memberPhoneHint {
    return Intl.message(
      'e.g. 01111111111',
      name: 'memberPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Tagline`
  String get memberTaglineLabel {
    return Intl.message(
      'Tagline',
      name: 'memberTaglineLabel',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get memberTaglineHint {
    return Intl.message(
      'Optional',
      name: 'memberTaglineHint',
      desc: '',
      args: [],
    );
  }

  /// `Tagline (optional)`
  String get memberTaglineOptionalLabel {
    return Intl.message(
      'Tagline (optional)',
      name: 'memberTaglineOptionalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Rank #{rank}`
  String rankLabel(Object rank) {
    return Intl.message(
      'Rank #$rank',
      name: 'rankLabel',
      desc: '',
      args: [rank],
    );
  }

  /// `Today`
  String get clientsTodayLabel {
    return Intl.message('Today', name: 'clientsTodayLabel', desc: '', args: []);
  }

  /// `This month`
  String get clientsThisMonthLabel {
    return Intl.message(
      'This month',
      name: 'clientsThisMonthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get ratingLabel {
    return Intl.message('Rating', name: 'ratingLabel', desc: '', args: []);
  }

  /// `You`
  String get youLabel {
    return Intl.message('You', name: 'youLabel', desc: '', args: []);
  }

  /// `Owner`
  String get ownerLabel {
    return Intl.message('Owner', name: 'ownerLabel', desc: '', args: []);
  }

  /// `Team member`
  String get memberDetailTitle {
    return Intl.message(
      'Team member',
      name: 'memberDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Available for booking`
  String get availabilityLabel {
    return Intl.message(
      'Available for booking',
      name: 'availabilityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Working hours`
  String get memberHoursTitle {
    return Intl.message(
      'Working hours',
      name: 'memberHoursTitle',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get memberServicesTitle {
    return Intl.message(
      'Services',
      name: 'memberServicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPasswordTitle {
    return Intl.message(
      'Reset password',
      name: 'resetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Set a new temporary password for this member?`
  String get resetPasswordConfirm {
    return Intl.message(
      'Set a new temporary password for this member?',
      name: 'resetPasswordConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Temporary password`
  String get tempPasswordLabel {
    return Intl.message(
      'Temporary password',
      name: 'tempPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. newtemp123`
  String get tempPasswordHint {
    return Intl.message(
      'e.g. newtemp123',
      name: 'tempPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Password reset`
  String get passwordResetSuccess {
    return Intl.message(
      'Password reset',
      name: 'passwordResetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Block member`
  String get blockMemberTitle {
    return Intl.message(
      'Block member',
      name: 'blockMemberTitle',
      desc: '',
      args: [],
    );
  }

  /// `This member will no longer be able to log in. Continue?`
  String get blockMemberConfirm {
    return Intl.message(
      'This member will no longer be able to log in. Continue?',
      name: 'blockMemberConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Re-activate member`
  String get activateMemberTitle {
    return Intl.message(
      'Re-activate member',
      name: 'activateMemberTitle',
      desc: '',
      args: [],
    );
  }

  /// `Allow this member to log in again?`
  String get activateMemberConfirm {
    return Intl.message(
      'Allow this member to log in again?',
      name: 'activateMemberConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Member blocked`
  String get memberBlocked {
    return Intl.message(
      'Member blocked',
      name: 'memberBlocked',
      desc: '',
      args: [],
    );
  }

  /// `Member re-activated`
  String get memberActivated {
    return Intl.message(
      'Member re-activated',
      name: 'memberActivated',
      desc: '',
      args: [],
    );
  }

  /// `Member details saved`
  String get memberSaved {
    return Intl.message(
      'Member details saved',
      name: 'memberSaved',
      desc: '',
      args: [],
    );
  }

  /// `Team member added`
  String get memberAdded {
    return Intl.message(
      'Team member added',
      name: 'memberAdded',
      desc: '',
      args: [],
    );
  }

  /// `Edit member`
  String get editMemberTitle {
    return Intl.message(
      'Edit member',
      name: 'editMemberTitle',
      desc: '',
      args: [],
    );
  }

  /// `Earnings`
  String get earningsTitle {
    return Intl.message('Earnings', name: 'earningsTitle', desc: '', args: []);
  }

  /// `Today`
  String get earningsToday {
    return Intl.message('Today', name: 'earningsToday', desc: '', args: []);
  }

  /// `Last 7 days`
  String get earningsLast7Days {
    return Intl.message(
      'Last 7 days',
      name: 'earningsLast7Days',
      desc: '',
      args: [],
    );
  }

  /// `This month`
  String get earningsThisMonth {
    return Intl.message(
      'This month',
      name: 'earningsThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `Average ticket`
  String get avgTicketLabel {
    return Intl.message(
      'Average ticket',
      name: 'avgTicketLabel',
      desc: '',
      args: [],
    );
  }

  /// `Supplier spend this month`
  String get supplierSpendLabel {
    return Intl.message(
      'Supplier spend this month',
      name: 'supplierSpendLabel',
      desc: '',
      args: [],
    );
  }

  /// `Net this month`
  String get netThisMonthLabel {
    return Intl.message(
      'Net this month',
      name: 'netThisMonthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last 7 days`
  String get dailyBreakdownTitle {
    return Intl.message(
      'Last 7 days',
      name: 'dailyBreakdownTitle',
      desc: '',
      args: [],
    );
  }

  /// `{clients} clients`
  String earningsClientsLine(Object clients) {
    return Intl.message(
      '$clients clients',
      name: 'earningsClientsLine',
      desc: '',
      args: [clients],
    );
  }

  /// `No team members yet`
  String get noTeamMembersYet {
    return Intl.message(
      'No team members yet',
      name: 'noTeamMembersYet',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get activeLabel {
    return Intl.message('Active', name: 'activeLabel', desc: '', args: []);
  }

  /// `Blocked`
  String get blockedLabel {
    return Intl.message('Blocked', name: 'blockedLabel', desc: '', args: []);
  }

  /// `Shop location`
  String get locationTitle {
    return Intl.message(
      'Shop location',
      name: 'locationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pin your shop's location so customers can find you and see accurate distance.`
  String get locationNote {
    return Intl.message(
      'Pin your shop\'s location so customers can find you and see accurate distance.',
      name: 'locationNote',
      desc: '',
      args: [],
    );
  }

  /// `Use current location`
  String get useCurrentLocation {
    return Intl.message(
      'Use current location',
      name: 'useCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get addressLabel {
    return Intl.message('Address', name: 'addressLabel', desc: '', args: []);
  }

  /// `e.g. Abbas El Akkad St, Nasr City`
  String get addressHint {
    return Intl.message(
      'e.g. Abbas El Akkad St, Nasr City',
      name: 'addressHint',
      desc: '',
      args: [],
    );
  }

  /// `Location saved`
  String get locationSaved {
    return Intl.message(
      'Location saved',
      name: 'locationSaved',
      desc: '',
      args: [],
    );
  }

  /// `Please enable location services`
  String get locationServiceDisabled {
    return Intl.message(
      'Please enable location services',
      name: 'locationServiceDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Location permission is required`
  String get locationPermissionDenied {
    return Intl.message(
      'Location permission is required',
      name: 'locationPermissionDenied',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
