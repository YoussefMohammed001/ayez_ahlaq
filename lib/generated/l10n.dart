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

  /// `Good morning,`
  String get greeting {
    return Intl.message('Good morning,', name: 'greeting', desc: '', args: []);
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

  /// `Active products`
  String get activeProducts {
    return Intl.message(
      'Active products',
      name: 'activeProducts',
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

  /// `New order`
  String get notifNewOrderTitle {
    return Intl.message(
      'New order',
      name: 'notifNewOrderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Salon Al Malek sent an order worth 2880 EGP`
  String get notifNewOrderBody {
    return Intl.message(
      'Salon Al Malek sent an order worth 2880 EGP',
      name: 'notifNewOrderBody',
      desc: '',
      args: [],
    );
  }

  /// `Order cancelled`
  String get notifOrderCancelledTitle {
    return Intl.message(
      'Order cancelled',
      name: 'notifOrderCancelledTitle',
      desc: '',
      args: [],
    );
  }

  /// `Barber House cancelled order #PO-2170`
  String get notifOrderCancelledBody {
    return Intl.message(
      'Barber House cancelled order #PO-2170',
      name: 'notifOrderCancelledBody',
      desc: '',
      args: [],
    );
  }

  /// `Low stock`
  String get notifLowStockTitle {
    return Intl.message(
      'Low stock',
      name: 'notifLowStockTitle',
      desc: '',
      args: [],
    );
  }

  /// `Beard oil is down to 8 units`
  String get notifLowStockBody {
    return Intl.message(
      'Beard oil is down to 8 units',
      name: 'notifLowStockBody',
      desc: '',
      args: [],
    );
  }

  /// `Offer ended`
  String get notifDiscountEndedTitle {
    return Intl.message(
      'Offer ended',
      name: 'notifDiscountEndedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your "Buy 4 get 1 free" offer has been closed`
  String get notifDiscountEndedBody {
    return Intl.message(
      'Your "Buy 4 get 1 free" offer has been closed',
      name: 'notifDiscountEndedBody',
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
