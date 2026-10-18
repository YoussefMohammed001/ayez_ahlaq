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

  /// `Change account type`
  String get changeAccountType {
    return Intl.message(
      'Change account type',
      name: 'changeAccountType',
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

  /// `Sign in to book your barber and order your favorite products`
  String get loginSubtitleCustomer {
    return Intl.message(
      'Sign in to book your barber and order your favorite products',
      name: 'loginSubtitleCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with your barber account to manage your bookings and shop`
  String get loginSubtitleBarber {
    return Intl.message(
      'Sign in with your barber account to manage your bookings and shop',
      name: 'loginSubtitleBarber',
      desc: '',
      args: [],
    );
  }

  /// `{type} account`
  String accountTypeBadge(String type) {
    return Intl.message(
      '$type account',
      name: 'accountTypeBadge',
      desc: '',
      args: [type],
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

  /// `Don't have an account? Register now`
  String get noAccountRegisterCustomer {
    return Intl.message(
      'Don\'t have an account? Register now',
      name: 'noAccountRegisterCustomer',
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

  /// `Create your account`
  String get createCustomerAccount {
    return Intl.message(
      'Create your account',
      name: 'createCustomerAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create a new account`
  String get registerCustomer {
    return Intl.message(
      'Create a new account',
      name: 'registerCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Register to book a haircut and buy care products from a nearby salon.`
  String get registerSubtitleCustomer {
    return Intl.message(
      'Register to book a haircut and buy care products from a nearby salon.',
      name: 'registerSubtitleCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get userName {
    return Intl.message('Name', name: 'userName', desc: '', args: []);
  }

  /// `e.g. Mohamed Ahmed`
  String get userNameHint {
    return Intl.message(
      'e.g. Mohamed Ahmed',
      name: 'userNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get userNameRequired {
    return Intl.message(
      'Enter your name',
      name: 'userNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `You're in! The rest of the app is coming soon.`
  String get customerShellPlaceholder {
    return Intl.message(
      'You\'re in! The rest of the app is coming soon.',
      name: 'customerShellPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get customerOrdersTitle {
    return Intl.message(
      'My Orders',
      name: 'customerOrdersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get dashboardTitle {
    return Intl.message('Home', name: 'dashboardTitle', desc: '', args: []);
  }

  /// `Quick actions`
  String get quickActionsTitle {
    return Intl.message(
      'Quick actions',
      name: 'quickActionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message('See all', name: 'seeAll', desc: '', args: []);
  }

  /// `Your upcoming bookings`
  String get upcomingBookingsTitle {
    return Intl.message(
      'Your upcoming bookings',
      name: 'upcomingBookingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `You have no upcoming bookings right now`
  String get noUpcomingBookingsHint {
    return Intl.message(
      'You have no upcoming bookings right now',
      name: 'noUpcomingBookingsHint',
      desc: '',
      args: [],
    );
  }

  /// `Nearest salons to you`
  String get nearestShopsTitle {
    return Intl.message(
      'Nearest salons to you',
      name: 'nearestShopsTitle',
      desc: '',
      args: [],
    );
  }

  /// `km`
  String get kmUnit {
    return Intl.message('km', name: 'kmUnit', desc: '', args: []);
  }

  /// `Salons`
  String get shopsTitle {
    return Intl.message('Salons', name: 'shopsTitle', desc: '', args: []);
  }

  /// `No salons available right now`
  String get noShopsYet {
    return Intl.message(
      'No salons available right now',
      name: 'noShopsYet',
      desc: '',
      args: [],
    );
  }

  /// `Salon details`
  String get shopDetailTitle {
    return Intl.message(
      'Salon details',
      name: 'shopDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Barbers`
  String get barbersSectionTitle {
    return Intl.message(
      'Barbers',
      name: 'barbersSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Haircut styles`
  String get haircutStylesSectionTitle {
    return Intl.message(
      'Haircut styles',
      name: 'haircutStylesSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Available payment methods`
  String get paymentMethodsSectionTitle {
    return Intl.message(
      'Available payment methods',
      name: 'paymentMethodsSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Available services`
  String get availableServicesSectionTitle {
    return Intl.message(
      'Available services',
      name: 'availableServicesSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `No barbers available at this salon right now`
  String get noBarbersYet {
    return Intl.message(
      'No barbers available at this salon right now',
      name: 'noBarbersYet',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favoritesTitle {
    return Intl.message(
      'Favorites',
      name: 'favoritesTitle',
      desc: '',
      args: [],
    );
  }

  /// `You haven't favorited any barber yet`
  String get noFavoritesYet {
    return Intl.message(
      'You haven\'t favorited any barber yet',
      name: 'noFavoritesYet',
      desc: '',
      args: [],
    );
  }

  /// `Enter invite code`
  String get enterInviteCodeTitle {
    return Intl.message(
      'Enter invite code',
      name: 'enterInviteCodeTitle',
      desc: '',
      args: [],
    );
  }

  /// `e.g. ABC123`
  String get inviteCodeHint {
    return Intl.message(
      'e.g. ABC123',
      name: 'inviteCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter the invite code`
  String get inviteCodeRequired {
    return Intl.message(
      'Enter the invite code',
      name: 'inviteCodeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueLabel {
    return Intl.message('Continue', name: 'continueLabel', desc: '', args: []);
  }

  /// `Barber invite`
  String get inviteePreviewTitle {
    return Intl.message(
      'Barber invite',
      name: 'inviteePreviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add to favorites`
  String get addToFavorites {
    return Intl.message(
      'Add to favorites',
      name: 'addToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Added to favorites`
  String get addedToFavorites {
    return Intl.message(
      'Added to favorites',
      name: 'addedToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Book now`
  String get bookNow {
    return Intl.message('Book now', name: 'bookNow', desc: '', args: []);
  }

  /// `min`
  String get minutesUnit {
    return Intl.message('min', name: 'minutesUnit', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Choose a service`
  String get chooseServiceTitle {
    return Intl.message(
      'Choose a service',
      name: 'chooseServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose a style`
  String get chooseStyleTitle {
    return Intl.message(
      'Choose a style',
      name: 'chooseStyleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose a barber`
  String get chooseBarberTitle {
    return Intl.message(
      'Choose a barber',
      name: 'chooseBarberTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose a time`
  String get chooseTimeTitle {
    return Intl.message(
      'Choose a time',
      name: 'chooseTimeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Any available barber`
  String get autoSelectBarber {
    return Intl.message(
      'Any available barber',
      name: 'autoSelectBarber',
      desc: '',
      args: [],
    );
  }

  /// `The least busy barber will be picked automatically`
  String get autoSelectBarberHint {
    return Intl.message(
      'The least busy barber will be picked automatically',
      name: 'autoSelectBarberHint',
      desc: '',
      args: [],
    );
  }

  /// `Booking at {shopName}`
  String bookingWithShopLabel(Object shopName) {
    return Intl.message(
      'Booking at $shopName',
      name: 'bookingWithShopLabel',
      desc: '',
      args: [shopName],
    );
  }

  /// `Available now`
  String get barberAvailableNow {
    return Intl.message(
      'Available now',
      name: 'barberAvailableNow',
      desc: '',
      args: [],
    );
  }

  /// `Busy`
  String get barberBusyNow {
    return Intl.message('Busy', name: 'barberBusyNow', desc: '', args: []);
  }

  /// `No slots available on this day`
  String get noSlotsAvailable {
    return Intl.message(
      'No slots available on this day',
      name: 'noSlotsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Booking summary`
  String get bookingSummaryTitle {
    return Intl.message(
      'Booking summary',
      name: 'bookingSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Barber`
  String get barberLabel {
    return Intl.message('Barber', name: 'barberLabel', desc: '', args: []);
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

  /// `Are you sure you want to confirm this booking?`
  String get confirmBookingMessage {
    return Intl.message(
      'Are you sure you want to confirm this booking?',
      name: 'confirmBookingMessage',
      desc: '',
      args: [],
    );
  }

  /// `You already have another booking on {date}. It may be for you or a friend. Do you want to book again?`
  String sameDayBookingWarningMessage(Object date) {
    return Intl.message(
      'You already have another booking on $date. It may be for you or a friend. Do you want to book again?',
      name: 'sameDayBookingWarningMessage',
      desc: '',
      args: [date],
    );
  }

  /// `Yes, book again`
  String get sameDayBookingConfirmLabel {
    return Intl.message(
      'Yes, book again',
      name: 'sameDayBookingConfirmLabel',
      desc: '',
      args: [],
    );
  }

  /// `Your booking request was sent, the salon will confirm within 30 minutes`
  String get bookingCreatedMessage {
    return Intl.message(
      'Your booking request was sent, the salon will confirm within 30 minutes',
      name: 'bookingCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get bookingsUpcomingTab {
    return Intl.message(
      'Upcoming',
      name: 'bookingsUpcomingTab',
      desc: '',
      args: [],
    );
  }

  /// `Past`
  String get bookingsPastTab {
    return Intl.message('Past', name: 'bookingsPastTab', desc: '', args: []);
  }

  /// `You haven't made any bookings yet`
  String get noBookingsYet {
    return Intl.message(
      'You haven\'t made any bookings yet',
      name: 'noBookingsYet',
      desc: '',
      args: [],
    );
  }

  /// `Booking cancelled`
  String get bookingCancelledMessage {
    return Intl.message(
      'Booking cancelled',
      name: 'bookingCancelledMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel booking`
  String get cancelBooking {
    return Intl.message(
      'Cancel booking',
      name: 'cancelBooking',
      desc: '',
      args: [],
    );
  }

  /// `People ahead of you`
  String get peopleAheadLabel {
    return Intl.message(
      'People ahead of you',
      name: 'peopleAheadLabel',
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

  /// `Favorites`
  String get tabFavorites {
    return Intl.message('Favorites', name: 'tabFavorites', desc: '', args: []);
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

  /// `You have {count} new orders on your store`
  String newStorefrontOrdersCount(Object count) {
    return Intl.message(
      'You have $count new orders on your store',
      name: 'newStorefrontOrdersCount',
      desc: '',
      args: [count],
    );
  }

  /// `{count} required documents are missing`
  String missingDocumentsHomeCount(Object count) {
    return Intl.message(
      '$count required documents are missing',
      name: 'missingDocumentsHomeCount',
      desc: '',
      args: [count],
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

  /// `Edit stock`
  String get editStockTitle {
    return Intl.message(
      'Edit stock',
      name: 'editStockTitle',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 20`
  String get stockQuantityHint {
    return Intl.message(
      'e.g. 20',
      name: 'stockQuantityHint',
      desc: '',
      args: [],
    );
  }

  /// `Stock updated`
  String get stockUpdated {
    return Intl.message(
      'Stock updated',
      name: 'stockUpdated',
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

  /// `Product price changed, now {price}`
  String priceChangedSinceOrderLabel(Object price) {
    return Intl.message(
      'Product price changed, now $price',
      name: 'priceChangedSinceOrderLabel',
      desc: '',
      args: [price],
    );
  }

  /// `This product now has a {percent}% discount, priced at {price}`
  String newDiscountSinceOrderLabel(Object percent, Object price) {
    return Intl.message(
      'This product now has a $percent% discount, priced at $price',
      name: 'newDiscountSinceOrderLabel',
      desc: '',
      args: [percent, price],
    );
  }

  /// `{percent}% off`
  String unitDiscountPercentLabel(Object percent) {
    return Intl.message(
      '$percent% off',
      name: 'unitDiscountPercentLabel',
      desc: '',
      args: [percent],
    );
  }

  /// `Order details`
  String get orderInfoTitle {
    return Intl.message(
      'Order details',
      name: 'orderInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Fulfilment type`
  String get orderFulfilmentTypeLabel {
    return Intl.message(
      'Fulfilment type',
      name: 'orderFulfilmentTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Order note`
  String get orderNoteLabel {
    return Intl.message(
      'Order note',
      name: 'orderNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delivery address`
  String get orderDeliveryAddressLabel {
    return Intl.message(
      'Delivery address',
      name: 'orderDeliveryAddressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Order date`
  String get orderDateLabel {
    return Intl.message(
      'Order date',
      name: 'orderDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Accepted at`
  String get orderAcceptedAtLabel {
    return Intl.message(
      'Accepted at',
      name: 'orderAcceptedAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delivered at`
  String get orderDeliveredAtLabel {
    return Intl.message(
      'Delivered at',
      name: 'orderDeliveredAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `Rejected at`
  String get orderRejectedAtLabel {
    return Intl.message(
      'Rejected at',
      name: 'orderRejectedAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `Rejection reason`
  String get orderRejectionReasonLabel {
    return Intl.message(
      'Rejection reason',
      name: 'orderRejectionReasonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled at`
  String get orderCancelledAtLabel {
    return Intl.message(
      'Cancelled at',
      name: 'orderCancelledAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancellation reason`
  String get orderCancellationNoteLabel {
    return Intl.message(
      'Cancellation reason',
      name: 'orderCancellationNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled by`
  String get orderCancelledByLabel {
    return Intl.message(
      'Cancelled by',
      name: 'orderCancelledByLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get orderTotal {
    return Intl.message('Total', name: 'orderTotal', desc: '', args: []);
  }

  /// `Service price`
  String get bookingBasePriceLabel {
    return Intl.message(
      'Service price',
      name: 'bookingBasePriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Style price`
  String get bookingStyleDeltaLabel {
    return Intl.message(
      'Style price',
      name: 'bookingStyleDeltaLabel',
      desc: '',
      args: [],
    );
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

  /// `Order discount ({percent}%)`
  String orderDiscountWithPercentLabel(Object percent) {
    return Intl.message(
      'Order discount ($percent%)',
      name: 'orderDiscountWithPercentLabel',
      desc: '',
      args: [percent],
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

  /// `My customers`
  String get myCustomers {
    return Intl.message(
      'My customers',
      name: 'myCustomers',
      desc: '',
      args: [],
    );
  }

  /// `Barbers and salons who ordered from your store`
  String get myCustomersSubtitle {
    return Intl.message(
      'Barbers and salons who ordered from your store',
      name: 'myCustomersSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Search by name or phone`
  String get customersSearchHint {
    return Intl.message(
      'Search by name or phone',
      name: 'customersSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `No customers yet`
  String get noCustomersYet {
    return Intl.message(
      'No customers yet',
      name: 'noCustomersYet',
      desc: '',
      args: [],
    );
  }

  /// `{count} orders`
  String customerOrderCount(Object count) {
    return Intl.message(
      '$count orders',
      name: 'customerOrderCount',
      desc: '',
      args: [count],
    );
  }

  /// `Total spend`
  String get customerTotalSpend {
    return Intl.message(
      'Total spend',
      name: 'customerTotalSpend',
      desc: '',
      args: [],
    );
  }

  /// `Last order: {date}`
  String customerLastOrderAt(Object date) {
    return Intl.message(
      'Last order: $date',
      name: 'customerLastOrderAt',
      desc: '',
      args: [date],
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

  /// `Verified barber`
  String get verifiedBarber {
    return Intl.message(
      'Verified barber',
      name: 'verifiedBarber',
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

  /// `Do you take clients?`
  String get servesClientsTitle {
    return Intl.message(
      'Do you take clients?',
      name: 'servesClientsTitle',
      desc: '',
      args: [],
    );
  }

  /// `I work on clients`
  String get servesClientsLabel {
    return Intl.message(
      'I work on clients',
      name: 'servesClientsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Customers can see you and book with you.`
  String get servesClientsOnHint {
    return Intl.message(
      'Customers can see you and book with you.',
      name: 'servesClientsOnHint',
      desc: '',
      args: [],
    );
  }

  /// `You are hidden from customers and the queue, and you free an employee slot in your plan.`
  String get servesClientsOffHint {
    return Intl.message(
      'You are hidden from customers and the queue, and you free an employee slot in your plan.',
      name: 'servesClientsOffHint',
      desc: '',
      args: [],
    );
  }

  /// `Your status has been updated`
  String get servesClientsUpdated {
    return Intl.message(
      'Your status has been updated',
      name: 'servesClientsUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Drinks`
  String get drinksTitle {
    return Intl.message('Drinks', name: 'drinksTitle', desc: '', args: []);
  }

  /// `Your shop's drink menu, added to the customer's bill`
  String get drinksSubtitle {
    return Intl.message(
      'Your shop\'s drink menu, added to the customer\'s bill',
      name: 'drinksSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `No drinks yet`
  String get noDrinks {
    return Intl.message('No drinks yet', name: 'noDrinks', desc: '', args: []);
  }

  /// `Add tea, coffee and water so you can put them on the bill.`
  String get noDrinksHint {
    return Intl.message(
      'Add tea, coffee and water so you can put them on the bill.',
      name: 'noDrinksHint',
      desc: '',
      args: [],
    );
  }

  /// `Add a drink`
  String get addDrink {
    return Intl.message('Add a drink', name: 'addDrink', desc: '', args: []);
  }

  /// `Edit drink`
  String get editDrink {
    return Intl.message('Edit drink', name: 'editDrink', desc: '', args: []);
  }

  /// `Drink name`
  String get drinkName {
    return Intl.message('Drink name', name: 'drinkName', desc: '', args: []);
  }

  /// `Tea, coffee, water…`
  String get drinkNameHint {
    return Intl.message(
      'Tea, coffee, water…',
      name: 'drinkNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Price in EGP`
  String get drinkPrice {
    return Intl.message('Price in EGP', name: 'drinkPrice', desc: '', args: []);
  }

  /// `10`
  String get drinkPriceHint {
    return Intl.message('10', name: 'drinkPriceHint', desc: '', args: []);
  }

  /// `Enter the drink name`
  String get drinkNameRequired {
    return Intl.message(
      'Enter the drink name',
      name: 'drinkNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid price`
  String get drinkPriceRequired {
    return Intl.message(
      'Enter a valid price',
      name: 'drinkPriceRequired',
      desc: '',
      args: [],
    );
  }

  /// `Available to customers`
  String get drinkActive {
    return Intl.message(
      'Available to customers',
      name: 'drinkActive',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get drinkInactive {
    return Intl.message('Off', name: 'drinkInactive', desc: '', args: []);
  }

  /// `Delete drink`
  String get deleteDrink {
    return Intl.message(
      'Delete drink',
      name: 'deleteDrink',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this drink from the menu?`
  String get deleteDrinkConfirm {
    return Intl.message(
      'Are you sure you want to remove this drink from the menu?',
      name: 'deleteDrinkConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Edit the bill`
  String get editBillTitle {
    return Intl.message(
      'Edit the bill',
      name: 'editBillTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit the bill`
  String get editBillAction {
    return Intl.message(
      'Edit the bill',
      name: 'editBillAction',
      desc: '',
      args: [],
    );
  }

  /// `This bill is locked`
  String get billLocked {
    return Intl.message(
      'This bill is locked',
      name: 'billLocked',
      desc: '',
      args: [],
    );
  }

  /// `Confirm bill changes`
  String get confirmBillTitle {
    return Intl.message(
      'Confirm bill changes',
      name: 'confirmBillTitle',
      desc: '',
      args: [],
    );
  }

  /// `Review the new bill details before saving`
  String get confirmBillMessage {
    return Intl.message(
      'Review the new bill details before saving',
      name: 'confirmBillMessage',
      desc: '',
      args: [],
    );
  }

  /// `No drinks or extras on this bill`
  String get confirmBillNoChanges {
    return Intl.message(
      'No drinks or extras on this bill',
      name: 'confirmBillNoChanges',
      desc: '',
      args: [],
    );
  }

  /// `New total`
  String get confirmBillNewTotal {
    return Intl.message(
      'New total',
      name: 'confirmBillNewTotal',
      desc: '',
      args: [],
    );
  }

  /// `Confirm & save`
  String get confirmBillSave {
    return Intl.message(
      'Confirm & save',
      name: 'confirmBillSave',
      desc: '',
      args: [],
    );
  }

  /// `Extras and discounts`
  String get billAdjustments {
    return Intl.message(
      'Extras and discounts',
      name: 'billAdjustments',
      desc: '',
      args: [],
    );
  }

  /// `Add a charge or discount`
  String get addAdjustment {
    return Intl.message(
      'Add a charge or discount',
      name: 'addAdjustment',
      desc: '',
      args: [],
    );
  }

  /// `Add at least one charge or discount`
  String get addAtLeastOneAdjustment {
    return Intl.message(
      'Add at least one charge or discount',
      name: 'addAtLeastOneAdjustment',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get adjustmentLabel {
    return Intl.message('Reason', name: 'adjustmentLabel', desc: '', args: []);
  }

  /// `Extra beard trim, discount…`
  String get adjustmentLabelHint {
    return Intl.message(
      'Extra beard trim, discount…',
      name: 'adjustmentLabelHint',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get adjustmentAmount {
    return Intl.message('Amount', name: 'adjustmentAmount', desc: '', args: []);
  }

  /// `30`
  String get adjustmentAmountHint {
    return Intl.message('30', name: 'adjustmentAmountHint', desc: '', args: []);
  }

  /// `Addition`
  String get adjustmentTypeAddition {
    return Intl.message(
      'Addition',
      name: 'adjustmentTypeAddition',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get adjustmentTypeDiscount {
    return Intl.message(
      'Discount',
      name: 'adjustmentTypeDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Enter a reason for the line`
  String get adjustmentLabelRequired {
    return Intl.message(
      'Enter a reason for the line',
      name: 'adjustmentLabelRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid amount`
  String get adjustmentAmountRequired {
    return Intl.message(
      'Enter a valid amount',
      name: 'adjustmentAmountRequired',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get billTotal {
    return Intl.message('Total', name: 'billTotal', desc: '', args: []);
  }

  /// `The bill has been updated`
  String get billSaved {
    return Intl.message(
      'The bill has been updated',
      name: 'billSaved',
      desc: '',
      args: [],
    );
  }

  /// `Price preview`
  String get quoteTitle {
    return Intl.message(
      'Price preview',
      name: 'quoteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Try a cart and see how discounts land before a barber orders`
  String get quoteSubtitle {
    return Intl.message(
      'Try a cart and see how discounts land before a barber orders',
      name: 'quoteSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Pick products and quantities`
  String get quotePickProducts {
    return Intl.message(
      'Pick products and quantities',
      name: 'quotePickProducts',
      desc: '',
      args: [],
    );
  }

  /// `Test for a specific shop`
  String get quoteScopeShop {
    return Intl.message(
      'Test for a specific shop',
      name: 'quoteScopeShop',
      desc: '',
      args: [],
    );
  }

  /// `All shops`
  String get quoteAllShops {
    return Intl.message('All shops', name: 'quoteAllShops', desc: '', args: []);
  }

  /// `Calculate`
  String get quoteCalculate {
    return Intl.message(
      'Calculate',
      name: 'quoteCalculate',
      desc: '',
      args: [],
    );
  }

  /// `Pick at least one product to see the maths`
  String get quoteEmpty {
    return Intl.message(
      'Pick at least one product to see the maths',
      name: 'quoteEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No discounts apply to this cart`
  String get quoteNoDiscount {
    return Intl.message(
      'No discounts apply to this cart',
      name: 'quoteNoDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Discounts that fired`
  String get quoteAppliedTitle {
    return Intl.message(
      'Discounts that fired',
      name: 'quoteAppliedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Total before any discount`
  String get quoteGrossTotal {
    return Intl.message(
      'Total before any discount',
      name: 'quoteGrossTotal',
      desc: '',
      args: [],
    );
  }

  /// `Total after product discounts`
  String get quoteSubtotal {
    return Intl.message(
      'Total after product discounts',
      name: 'quoteSubtotal',
      desc: '',
      args: [],
    );
  }

  /// `Order discount`
  String get quoteOrderDiscount {
    return Intl.message(
      'Order discount',
      name: 'quoteOrderDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Final total`
  String get quoteTotal {
    return Intl.message('Final total', name: 'quoteTotal', desc: '', args: []);
  }

  /// `You save`
  String get quoteSavings {
    return Intl.message('You save', name: 'quoteSavings', desc: '', args: []);
  }

  /// `Gift`
  String get quoteGift {
    return Intl.message('Gift', name: 'quoteGift', desc: '', args: []);
  }

  /// `Unit price after discount`
  String get quoteUnitAfterDiscount {
    return Intl.message(
      'Unit price after discount',
      name: 'quoteUnitAfterDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Promotion`
  String get sponsorshipTitle {
    return Intl.message(
      'Promotion',
      name: 'sponsorshipTitle',
      desc: '',
      args: [],
    );
  }

  /// `Put your products at the top of the barbers' store`
  String get sponsorshipMerchantSubtitle {
    return Intl.message(
      'Put your products at the top of the barbers\' store',
      name: 'sponsorshipMerchantSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Put your shop at the top of the customers' list`
  String get sponsorshipBarberSubtitle {
    return Intl.message(
      'Put your shop at the top of the customers\' list',
      name: 'sponsorshipBarberSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Promotion is live`
  String get sponsorshipActive {
    return Intl.message(
      'Promotion is live',
      name: 'sponsorshipActive',
      desc: '',
      args: [],
    );
  }

  /// `Promotion is off`
  String get sponsorshipInactive {
    return Intl.message(
      'Promotion is off',
      name: 'sponsorshipInactive',
      desc: '',
      args: [],
    );
  }

  /// `Ends on`
  String get sponsorshipEndsAt {
    return Intl.message(
      'Ends on',
      name: 'sponsorshipEndsAt',
      desc: '',
      args: [],
    );
  }

  /// `{days} days left`
  String sponsorshipDaysLeft(Object days) {
    return Intl.message(
      '$days days left',
      name: 'sponsorshipDaysLeft',
      desc: '',
      args: [days],
    );
  }

  /// `Monthly price`
  String get sponsorshipMonthlyPrice {
    return Intl.message(
      'Monthly price',
      name: 'sponsorshipMonthlyPrice',
      desc: '',
      args: [],
    );
  }

  /// `Available in your wallet`
  String get sponsorshipWalletAvailable {
    return Intl.message(
      'Available in your wallet',
      name: 'sponsorshipWalletAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Promote for a month`
  String get sponsorshipBuy {
    return Intl.message(
      'Promote for a month',
      name: 'sponsorshipBuy',
      desc: '',
      args: [],
    );
  }

  /// `Promotion activated`
  String get sponsorshipBought {
    return Intl.message(
      'Promotion activated',
      name: 'sponsorshipBought',
      desc: '',
      args: [],
    );
  }

  /// `Your wallet is short by {amount}, top up first`
  String sponsorshipInsufficient(Object amount) {
    return Intl.message(
      'Your wallet is short by $amount, top up first',
      name: 'sponsorshipInsufficient',
      desc: '',
      args: [amount],
    );
  }

  /// `Top up the wallet`
  String get sponsorshipTopUp {
    return Intl.message(
      'Top up the wallet',
      name: 'sponsorshipTopUp',
      desc: '',
      args: [],
    );
  }

  /// `Activate promotion`
  String get sponsorshipConfirmTitle {
    return Intl.message(
      'Activate promotion',
      name: 'sponsorshipConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `{amount} will be charged from your wallet and you stay promoted for 30 days.`
  String sponsorshipConfirmMessage(Object amount) {
    return Intl.message(
      '$amount will be charged from your wallet and you stay promoted for 30 days.',
      name: 'sponsorshipConfirmMessage',
      desc: '',
      args: [amount],
    );
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

  /// `Contact us on WhatsApp`
  String get whatsappSupport {
    return Intl.message(
      'Contact us on WhatsApp',
      name: 'whatsappSupport',
      desc: '',
      args: [],
    );
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

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms and conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Could not open the link`
  String get linkOpenError {
    return Intl.message(
      'Could not open the link',
      name: 'linkOpenError',
      desc: '',
      args: [],
    );
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

  /// `Picked up at branch`
  String get statusPickedUpAtBranch {
    return Intl.message(
      'Picked up at branch',
      name: 'statusPickedUpAtBranch',
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

  /// `Cash on delivery`
  String get paymentMethodCash {
    return Intl.message(
      'Cash on delivery',
      name: 'paymentMethodCash',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get paymentMethodCard {
    return Intl.message('Card', name: 'paymentMethodCard', desc: '', args: []);
  }

  /// `Wallet`
  String get paymentMethodWallet {
    return Intl.message(
      'Wallet',
      name: 'paymentMethodWallet',
      desc: '',
      args: [],
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

  /// `Delete shop photo`
  String get shopPhotoDeleteTitle {
    return Intl.message(
      'Delete shop photo',
      name: 'shopPhotoDeleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `The shop photo will be removed from your profile. You can upload another one anytime.`
  String get shopPhotoDeleteMessage {
    return Intl.message(
      'The shop photo will be removed from your profile. You can upload another one anytime.',
      name: 'shopPhotoDeleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Shop photo updated`
  String get shopPhotoUpdated {
    return Intl.message(
      'Shop photo updated',
      name: 'shopPhotoUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Shop photo deleted`
  String get shopPhotoDeleted {
    return Intl.message(
      'Shop photo deleted',
      name: 'shopPhotoDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Shop photo`
  String get shopPhotoEditTitle {
    return Intl.message(
      'Shop photo',
      name: 'shopPhotoEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Change photo`
  String get shopPhotoReplace {
    return Intl.message(
      'Change photo',
      name: 'shopPhotoReplace',
      desc: '',
      args: [],
    );
  }

  /// `Remove photo`
  String get shopPhotoRemove {
    return Intl.message(
      'Remove photo',
      name: 'shopPhotoRemove',
      desc: '',
      args: [],
    );
  }

  /// `Extra number`
  String get extraPhoneFallbackLabel {
    return Intl.message(
      'Extra number',
      name: 'extraPhoneFallbackLabel',
      desc: '',
      args: [],
    );
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

  /// `Ayez Ahlaq — book your haircut at the nearest salon in seconds, choosing the barber, service and time that suit you.`
  String get aboutAppBody {
    return Intl.message(
      'Ayez Ahlaq — book your haircut at the nearest salon in seconds, choosing the barber, service and time that suit you.',
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

  /// `Remove current image`
  String get removeCurrentImage {
    return Intl.message(
      'Remove current image',
      name: 'removeCurrentImage',
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

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
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

  /// `Delete service`
  String get deleteServiceTitle {
    return Intl.message(
      'Delete service',
      name: 'deleteServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this service? Past bookings won't be affected.`
  String get deleteServiceConfirm {
    return Intl.message(
      'Are you sure you want to delete this service? Past bookings won\'t be affected.',
      name: 'deleteServiceConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Delete custom service`
  String get deleteOwnServiceTitle {
    return Intl.message(
      'Delete custom service',
      name: 'deleteOwnServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this custom service?`
  String get deleteOwnServiceConfirm {
    return Intl.message(
      'Are you sure you want to delete this custom service?',
      name: 'deleteOwnServiceConfirm',
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

  /// `Menu`
  String get menuTitle {
    return Intl.message('Menu', name: 'menuTitle', desc: '', args: []);
  }

  /// `Account Management`
  String get accountManagementSection {
    return Intl.message(
      'Account Management',
      name: 'accountManagementSection',
      desc: '',
      args: [],
    );
  }

  /// `Bookings & Services`
  String get bookingsAndServicesSection {
    return Intl.message(
      'Bookings & Services',
      name: 'bookingsAndServicesSection',
      desc: '',
      args: [],
    );
  }

  /// `Account Details`
  String get profileDetailsTitle {
    return Intl.message(
      'Account Details',
      name: 'profileDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameLabel {
    return Intl.message('Name', name: 'nameLabel', desc: '', args: []);
  }

  /// `Shop`
  String get shopSection {
    return Intl.message('Shop', name: 'shopSection', desc: '', args: []);
  }

  /// `Your Store`
  String get storeAndSalesSection {
    return Intl.message(
      'Your Store',
      name: 'storeAndSalesSection',
      desc: '',
      args: [],
    );
  }

  /// `Purchases`
  String get purchasesSection {
    return Intl.message(
      'Purchases',
      name: 'purchasesSection',
      desc: '',
      args: [],
    );
  }

  /// `Financials`
  String get financialSection {
    return Intl.message(
      'Financials',
      name: 'financialSection',
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

  /// `Most requested`
  String get servicePopularLabel {
    return Intl.message(
      'Most requested',
      name: 'servicePopularLabel',
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

  /// `Your custom services`
  String get ownServicesTitle {
    return Intl.message(
      'Your custom services',
      name: 'ownServicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add custom service`
  String get addOwnServiceTitle {
    return Intl.message(
      'Add custom service',
      name: 'addOwnServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Service name`
  String get ownServiceNameLabel {
    return Intl.message(
      'Service name',
      name: 'ownServiceNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Signature cut`
  String get ownServiceNameHint {
    return Intl.message(
      'e.g. Signature cut',
      name: 'ownServiceNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get ownServiceDescriptionLabel {
    return Intl.message(
      'Description',
      name: 'ownServiceDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Write a short description`
  String get ownServiceDescriptionHint {
    return Intl.message(
      'Write a short description',
      name: 'ownServiceDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `No custom services yet`
  String get noOwnServicesYet {
    return Intl.message(
      'No custom services yet',
      name: 'noOwnServicesYet',
      desc: '',
      args: [],
    );
  }

  /// `Haircut styles`
  String get haircutStylesTitle {
    return Intl.message(
      'Haircut styles',
      name: 'haircutStylesTitle',
      desc: '',
      args: [],
    );
  }

  /// `No styles in the catalog yet`
  String get noHaircutStylesYet {
    return Intl.message(
      'No styles in the catalog yet',
      name: 'noHaircutStylesYet',
      desc: '',
      args: [],
    );
  }

  /// `Not priced yet`
  String get haircutStyleNotPricedYet {
    return Intl.message(
      'Not priced yet',
      name: 'haircutStyleNotPricedYet',
      desc: '',
      args: [],
    );
  }

  /// `Price delta: {delta} EGP`
  String haircutStylePriceDeltaLine(Object delta) {
    return Intl.message(
      'Price delta: $delta EGP',
      name: 'haircutStylePriceDeltaLine',
      desc: '',
      args: [delta],
    );
  }

  /// `Style price`
  String get editHaircutStylePriceTitle {
    return Intl.message(
      'Style price',
      name: 'editHaircutStylePriceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Price delta (EGP)`
  String get haircutStylePriceDeltaLabel {
    return Intl.message(
      'Price delta (EGP)',
      name: 'haircutStylePriceDeltaLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 20 or -10`
  String get haircutStylePriceDeltaHint {
    return Intl.message(
      'e.g. 20 or -10',
      name: 'haircutStylePriceDeltaHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid number (negative allowed)`
  String get haircutStylePriceDeltaInvalid {
    return Intl.message(
      'Enter a valid number (negative allowed)',
      name: 'haircutStylePriceDeltaInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Bookable`
  String get haircutStyleActiveLabel {
    return Intl.message(
      'Bookable',
      name: 'haircutStyleActiveLabel',
      desc: '',
      args: [],
    );
  }

  /// `Style price updated`
  String get haircutStylePriceUpdated {
    return Intl.message(
      'Style price updated',
      name: 'haircutStylePriceUpdated',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get requiredField {
    return Intl.message(
      'This field is required',
      name: 'requiredField',
      desc: '',
      args: [],
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

  /// `Store`
  String get storeTitle {
    return Intl.message('Store', name: 'storeTitle', desc: '', args: []);
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

  /// `Clear current cart?`
  String get switchShopCartTitle {
    return Intl.message(
      'Clear current cart?',
      name: 'switchShopCartTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your cart has items from another shop. Continuing will clear it so you can start fresh with this shop.`
  String get switchShopCartMessage {
    return Intl.message(
      'Your cart has items from another shop. Continuing will clear it so you can start fresh with this shop.',
      name: 'switchShopCartMessage',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get switchShopCartConfirm {
    return Intl.message(
      'Continue',
      name: 'switchShopCartConfirm',
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

  /// `This merchant does not offer delivery`
  String get deliveryNotOfferedReason {
    return Intl.message(
      'This merchant does not offer delivery',
      name: 'deliveryNotOfferedReason',
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

  /// `Clear cart?`
  String get clearCartTitle {
    return Intl.message(
      'Clear cart?',
      name: 'clearCartTitle',
      desc: '',
      args: [],
    );
  }

  /// `All items in this cart will be removed.`
  String get clearCartMessage {
    return Intl.message(
      'All items in this cart will be removed.',
      name: 'clearCartMessage',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clearCartConfirm {
    return Intl.message('Clear', name: 'clearCartConfirm', desc: '', args: []);
  }

  /// `Confirm order`
  String get placeOrderConfirmTitle {
    return Intl.message(
      'Confirm order',
      name: 'placeOrderConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `This order will be sent to the supplier. Continue?`
  String get placeOrderConfirmMessage {
    return Intl.message(
      'This order will be sent to the supplier. Continue?',
      name: 'placeOrderConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get placeOrderConfirmAction {
    return Intl.message(
      'Send',
      name: 'placeOrderConfirmAction',
      desc: '',
      args: [],
    );
  }

  /// `Choose a fulfilment option first`
  String get selectFulfillmentRequired {
    return Intl.message(
      'Choose a fulfilment option first',
      name: 'selectFulfillmentRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a delivery address first`
  String get deliveryAddressRequired {
    return Intl.message(
      'Enter a delivery address first',
      name: 'deliveryAddressRequired',
      desc: '',
      args: [],
    );
  }

  /// `Cancel order?`
  String get cancelOrderConfirmTitle {
    return Intl.message(
      'Cancel order?',
      name: 'cancelOrderConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `You won't be able to undo this once the order is cancelled.`
  String get cancelOrderConfirmMessage {
    return Intl.message(
      'You won\'t be able to undo this once the order is cancelled.',
      name: 'cancelOrderConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel order`
  String get cancelOrderConfirmAction {
    return Intl.message(
      'Cancel order',
      name: 'cancelOrderConfirmAction',
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

  /// `Available: {amount} EGP`
  String walletAvailableLabel(Object amount) {
    return Intl.message(
      'Available: $amount EGP',
      name: 'walletAvailableLabel',
      desc: '',
      args: [amount],
    );
  }

  /// `Wallet requests`
  String get walletRequestsTitle {
    return Intl.message(
      'Wallet requests',
      name: 'walletRequestsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No requests yet`
  String get walletRequestsEmpty {
    return Intl.message(
      'No requests yet',
      name: 'walletRequestsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `New wallet request`
  String get createWalletRequestTitle {
    return Intl.message(
      'New wallet request',
      name: 'createWalletRequestTitle',
      desc: '',
      args: [],
    );
  }

  /// `Request type`
  String get walletRequestTypeLabel {
    return Intl.message(
      'Request type',
      name: 'walletRequestTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get walletRequestTypeDeposit {
    return Intl.message(
      'Deposit',
      name: 'walletRequestTypeDeposit',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get walletRequestTypeWithdraw {
    return Intl.message(
      'Withdraw',
      name: 'walletRequestTypeWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get walletRequestAmountLabel {
    return Intl.message(
      'Amount',
      name: 'walletRequestAmountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter the amount`
  String get walletRequestAmountHint {
    return Intl.message(
      'Enter the amount',
      name: 'walletRequestAmountHint',
      desc: '',
      args: [],
    );
  }

  /// `Transfer to`
  String get transferAccountLabel {
    return Intl.message(
      'Transfer to',
      name: 'transferAccountLabel',
      desc: '',
      args: [],
    );
  }

  /// `You must choose the account to transfer to`
  String get transferAccountRequired {
    return Intl.message(
      'You must choose the account to transfer to',
      name: 'transferAccountRequired',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get transferAccountAccountNumber {
    return Intl.message(
      'Number',
      name: 'transferAccountAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `How do you want to receive it?`
  String get withdrawMethodLabel {
    return Intl.message(
      'How do you want to receive it?',
      name: 'withdrawMethodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a withdrawal method`
  String get withdrawMethodRequired {
    return Intl.message(
      'Please choose a withdrawal method',
      name: 'withdrawMethodRequired',
      desc: '',
      args: [],
    );
  }

  /// `We'll transfer to this account`
  String get withdrawAccountLabel {
    return Intl.message(
      'We\'ll transfer to this account',
      name: 'withdrawAccountLabel',
      desc: '',
      args: [],
    );
  }

  /// `The wallet/account number you want the money sent to`
  String get withdrawAccountHint {
    return Intl.message(
      'The wallet/account number you want the money sent to',
      name: 'withdrawAccountHint',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the account number to receive the money`
  String get withdrawAccountRequired {
    return Intl.message(
      'You must enter the account number to receive the money',
      name: 'withdrawAccountRequired',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get walletRequestNoteLabel {
    return Intl.message(
      'Note',
      name: 'walletRequestNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add a note (optional)`
  String get walletRequestNoteHint {
    return Intl.message(
      'Add a note (optional)',
      name: 'walletRequestNoteHint',
      desc: '',
      args: [],
    );
  }

  /// `Receipt`
  String get walletRequestAttachmentLabel {
    return Intl.message(
      'Receipt',
      name: 'walletRequestAttachmentLabel',
      desc: '',
      args: [],
    );
  }

  /// `Attach a receipt photo`
  String get attachReceiptPhoto {
    return Intl.message(
      'Attach a receipt photo',
      name: 'attachReceiptPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Receipt photo attached`
  String get receiptPhotoAttached {
    return Intl.message(
      'Receipt photo attached',
      name: 'receiptPhotoAttached',
      desc: '',
      args: [],
    );
  }

  /// `Please attach a transfer proof photo`
  String get walletRequestAttachmentRequired {
    return Intl.message(
      'Please attach a transfer proof photo',
      name: 'walletRequestAttachmentRequired',
      desc: '',
      args: [],
    );
  }

  /// `Submit request`
  String get submitWalletRequest {
    return Intl.message(
      'Submit request',
      name: 'submitWalletRequest',
      desc: '',
      args: [],
    );
  }

  /// `Request submitted`
  String get walletRequestCreatedSuccess {
    return Intl.message(
      'Request submitted',
      name: 'walletRequestCreatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Confirm deposit`
  String get confirmWalletRequestDepositTitle {
    return Intl.message(
      'Confirm deposit',
      name: 'confirmWalletRequestDepositTitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm withdrawal`
  String get confirmWalletRequestWithdrawTitle {
    return Intl.message(
      'Confirm withdrawal',
      name: 'confirmWalletRequestWithdrawTitle',
      desc: '',
      args: [],
    );
  }

  /// `You're about to submit a request for {amount} EGP. Are you sure?`
  String confirmWalletRequestMessage(Object amount) {
    return Intl.message(
      'You\'re about to submit a request for $amount EGP. Are you sure?',
      name: 'confirmWalletRequestMessage',
      desc: '',
      args: [amount],
    );
  }

  /// `Pending`
  String get walletRequestStatusPending {
    return Intl.message(
      'Pending',
      name: 'walletRequestStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get walletRequestStatusApproved {
    return Intl.message(
      'Approved',
      name: 'walletRequestStatusApproved',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get walletRequestStatusRejected {
    return Intl.message(
      'Rejected',
      name: 'walletRequestStatusRejected',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get walletRequestStatusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'walletRequestStatusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Decision note`
  String get walletRequestDecisionNoteLabel {
    return Intl.message(
      'Decision note',
      name: 'walletRequestDecisionNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Decided by`
  String get walletRequestDecidedByLabel {
    return Intl.message(
      'Decided by',
      name: 'walletRequestDecidedByLabel',
      desc: '',
      args: [],
    );
  }

  /// `Decided at`
  String get walletRequestDecidedAtLabel {
    return Intl.message(
      'Decided at',
      name: 'walletRequestDecidedAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel request`
  String get cancelWalletRequestAction {
    return Intl.message(
      'Cancel request',
      name: 'cancelWalletRequestAction',
      desc: '',
      args: [],
    );
  }

  /// `Cancel request`
  String get cancelWalletRequestTitle {
    return Intl.message(
      'Cancel request',
      name: 'cancelWalletRequestTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this request?`
  String get cancelWalletRequestConfirm {
    return Intl.message(
      'Are you sure you want to cancel this request?',
      name: 'cancelWalletRequestConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Request cancelled`
  String get walletRequestCancelledSuccess {
    return Intl.message(
      'Request cancelled',
      name: 'walletRequestCancelledSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Money Manager`
  String get moneyManagerTitle {
    return Intl.message(
      'Money Manager',
      name: 'moneyManagerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Set a PIN to protect your revenue data`
  String get moneyPinSetupTitle {
    return Intl.message(
      'Set a PIN to protect your revenue data',
      name: 'moneyPinSetupTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your PIN to view your revenue`
  String get moneyPinEnterTitle {
    return Intl.message(
      'Enter your PIN to view your revenue',
      name: 'moneyPinEnterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save PIN`
  String get moneyPinSetupAction {
    return Intl.message(
      'Save PIN',
      name: 'moneyPinSetupAction',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get moneyPinConfirmAction {
    return Intl.message(
      'Continue',
      name: 'moneyPinConfirmAction',
      desc: '',
      args: [],
    );
  }

  /// `Change PIN`
  String get changeMoneyPinTitle {
    return Intl.message(
      'Change PIN',
      name: 'changeMoneyPinTitle',
      desc: '',
      args: [],
    );
  }

  /// `Change PIN`
  String get changeMoneyPinAction {
    return Intl.message(
      'Change PIN',
      name: 'changeMoneyPinAction',
      desc: '',
      args: [],
    );
  }

  /// `Current PIN`
  String get currentMoneyPinLabel {
    return Intl.message(
      'Current PIN',
      name: 'currentMoneyPinLabel',
      desc: '',
      args: [],
    );
  }

  /// `New PIN`
  String get newMoneyPinLabel {
    return Intl.message(
      'New PIN',
      name: 'newMoneyPinLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new PIN`
  String get confirmMoneyPinLabel {
    return Intl.message(
      'Confirm new PIN',
      name: 'confirmMoneyPinLabel',
      desc: '',
      args: [],
    );
  }

  /// `New PIN doesn't match`
  String get moneyPinNotMatch {
    return Intl.message(
      'New PIN doesn\'t match',
      name: 'moneyPinNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `PIN changed`
  String get moneyPinChanged {
    return Intl.message(
      'PIN changed',
      name: 'moneyPinChanged',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your PIN?`
  String get moneyPinForgotAction {
    return Intl.message(
      'Forgot your PIN?',
      name: 'moneyPinForgotAction',
      desc: '',
      args: [],
    );
  }

  /// `Request a PIN reset`
  String get moneyPinResetConfirmTitle {
    return Intl.message(
      'Request a PIN reset',
      name: 'moneyPinResetConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `We'll send a reset request to the admin team. You'll be able to set a new PIN once it's approved.`
  String get moneyPinResetConfirmMessage {
    return Intl.message(
      'We\'ll send a reset request to the admin team. You\'ll be able to set a new PIN once it\'s approved.',
      name: 'moneyPinResetConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Send request`
  String get moneyPinResetConfirmAction {
    return Intl.message(
      'Send request',
      name: 'moneyPinResetConfirmAction',
      desc: '',
      args: [],
    );
  }

  /// `Reset request sent`
  String get moneyPinResetPendingTitle {
    return Intl.message(
      'Reset request sent',
      name: 'moneyPinResetPendingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your request is being reviewed by the admin team. You'll be notified once it's resolved.`
  String get moneyPinResetPendingMessage {
    return Intl.message(
      'Your request is being reviewed by the admin team. You\'ll be notified once it\'s resolved.',
      name: 'moneyPinResetPendingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Reset request rejected`
  String get moneyPinResetRejectedTitle {
    return Intl.message(
      'Reset request rejected',
      name: 'moneyPinResetRejectedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Total added`
  String get moneyTotalAdded {
    return Intl.message(
      'Total added',
      name: 'moneyTotalAdded',
      desc: '',
      args: [],
    );
  }

  /// `Total subtracted`
  String get moneyTotalSubtracted {
    return Intl.message(
      'Total subtracted',
      name: 'moneyTotalSubtracted',
      desc: '',
      args: [],
    );
  }

  /// `Net`
  String get moneyNet {
    return Intl.message('Net', name: 'moneyNet', desc: '', args: []);
  }

  /// `Needs confirmation`
  String get moneyPendingOccurrences {
    return Intl.message(
      'Needs confirmation',
      name: 'moneyPendingOccurrences',
      desc: '',
      args: [],
    );
  }

  /// `Nothing needs confirmation right now`
  String get moneyNoPendingOccurrences {
    return Intl.message(
      'Nothing needs confirmation right now',
      name: 'moneyNoPendingOccurrences',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get moneyOccurrenceConfirm {
    return Intl.message(
      'Confirm',
      name: 'moneyOccurrenceConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get moneyOccurrenceDismiss {
    return Intl.message(
      'Dismiss',
      name: 'moneyOccurrenceDismiss',
      desc: '',
      args: [],
    );
  }

  /// `Ledger`
  String get moneyLedgerTitle {
    return Intl.message('Ledger', name: 'moneyLedgerTitle', desc: '', args: []);
  }

  /// `No entries yet`
  String get moneyNoEntries {
    return Intl.message(
      'No entries yet',
      name: 'moneyNoEntries',
      desc: '',
      args: [],
    );
  }

  /// `New entry`
  String get moneyNewEntry {
    return Intl.message('New entry', name: 'moneyNewEntry', desc: '', args: []);
  }

  /// `Recurring items`
  String get moneyRecurringItemsTitle {
    return Intl.message(
      'Recurring items',
      name: 'moneyRecurringItemsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No recurring items yet`
  String get moneyNoItems {
    return Intl.message(
      'No recurring items yet',
      name: 'moneyNoItems',
      desc: '',
      args: [],
    );
  }

  /// `New recurring item`
  String get moneyNewItem {
    return Intl.message(
      'New recurring item',
      name: 'moneyNewItem',
      desc: '',
      args: [],
    );
  }

  /// `Edit recurring item`
  String get moneyEditItem {
    return Intl.message(
      'Edit recurring item',
      name: 'moneyEditItem',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get moneyDescriptionHint {
    return Intl.message(
      'Description',
      name: 'moneyDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get moneyAmountLabel {
    return Intl.message('Amount', name: 'moneyAmountLabel', desc: '', args: []);
  }

  /// `Enter the amount`
  String get moneyAmountHint {
    return Intl.message(
      'Enter the amount',
      name: 'moneyAmountHint',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get moneyDirectionLabel {
    return Intl.message(
      'Type',
      name: 'moneyDirectionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get moneyDirectionAdd {
    return Intl.message('Add', name: 'moneyDirectionAdd', desc: '', args: []);
  }

  /// `Subtract`
  String get moneyDirectionSubtract {
    return Intl.message(
      'Subtract',
      name: 'moneyDirectionSubtract',
      desc: '',
      args: [],
    );
  }

  /// `Frequency`
  String get moneyFrequencyLabel {
    return Intl.message(
      'Frequency',
      name: 'moneyFrequencyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get moneyFrequencyDaily {
    return Intl.message(
      'Daily',
      name: 'moneyFrequencyDaily',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get moneyFrequencyWeekly {
    return Intl.message(
      'Weekly',
      name: 'moneyFrequencyWeekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get moneyFrequencyMonthly {
    return Intl.message(
      'Monthly',
      name: 'moneyFrequencyMonthly',
      desc: '',
      args: [],
    );
  }

  /// `Day of week`
  String get moneyDayOfWeekLabel {
    return Intl.message(
      'Day of week',
      name: 'moneyDayOfWeekLabel',
      desc: '',
      args: [],
    );
  }

  /// `Day of month`
  String get moneyDayOfMonthLabel {
    return Intl.message(
      'Day of month',
      name: 'moneyDayOfMonthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delete recurring item`
  String get moneyDeleteItemTitle {
    return Intl.message(
      'Delete recurring item',
      name: 'moneyDeleteItemTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this item?`
  String get moneyDeleteItemMessage {
    return Intl.message(
      'Are you sure you want to delete this item?',
      name: 'moneyDeleteItemMessage',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get weekdaySunday {
    return Intl.message('Sunday', name: 'weekdaySunday', desc: '', args: []);
  }

  /// `Monday`
  String get weekdayMonday {
    return Intl.message('Monday', name: 'weekdayMonday', desc: '', args: []);
  }

  /// `Tuesday`
  String get weekdayTuesday {
    return Intl.message('Tuesday', name: 'weekdayTuesday', desc: '', args: []);
  }

  /// `Wednesday`
  String get weekdayWednesday {
    return Intl.message(
      'Wednesday',
      name: 'weekdayWednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get weekdayThursday {
    return Intl.message(
      'Thursday',
      name: 'weekdayThursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get weekdayFriday {
    return Intl.message('Friday', name: 'weekdayFriday', desc: '', args: []);
  }

  /// `Saturday`
  String get weekdaySaturday {
    return Intl.message(
      'Saturday',
      name: 'weekdaySaturday',
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

  /// `Barber rating`
  String get barberRatingLabel {
    return Intl.message(
      'Barber rating',
      name: 'barberRatingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Shop rating`
  String get shopRatingLabel {
    return Intl.message(
      'Shop rating',
      name: 'shopRatingLabel',
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

  /// `Subscription`
  String get subscriptionTitle {
    return Intl.message(
      'Subscription',
      name: 'subscriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your current plan`
  String get currentPlanLabel {
    return Intl.message(
      'Your current plan',
      name: 'currentPlanLabel',
      desc: '',
      args: [],
    );
  }

  /// `No active plan right now`
  String get noActivePlan {
    return Intl.message(
      'No active plan right now',
      name: 'noActivePlan',
      desc: '',
      args: [],
    );
  }

  /// `Awaiting approval`
  String get planStatusPending {
    return Intl.message(
      'Awaiting approval',
      name: 'planStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get planStatusActive {
    return Intl.message('Active', name: 'planStatusActive', desc: '', args: []);
  }

  /// `Paused`
  String get planStatusPaused {
    return Intl.message('Paused', name: 'planStatusPaused', desc: '', args: []);
  }

  /// `Unknown status`
  String get planStatusUnknown {
    return Intl.message(
      'Unknown status',
      name: 'planStatusUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Next renewal`
  String get nextRenewalLabel {
    return Intl.message(
      'Next renewal',
      name: 'nextRenewalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Started at`
  String get startedAtLabel {
    return Intl.message(
      'Started at',
      name: 'startedAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `Auto-renewal is on`
  String get autoChargeOn {
    return Intl.message(
      'Auto-renewal is on',
      name: 'autoChargeOn',
      desc: '',
      args: [],
    );
  }

  /// `Auto-renewal is off`
  String get autoChargeOff {
    return Intl.message(
      'Auto-renewal is off',
      name: 'autoChargeOff',
      desc: '',
      args: [],
    );
  }

  /// `Employees`
  String get quotaEmployees {
    return Intl.message(
      'Employees',
      name: 'quotaEmployees',
      desc: '',
      args: [],
    );
  }

  /// `Own services`
  String get quotaOwnServices {
    return Intl.message(
      'Own services',
      name: 'quotaOwnServices',
      desc: '',
      args: [],
    );
  }

  /// `Notifications (all)`
  String get quotaNotificationsAll {
    return Intl.message(
      'Notifications (all)',
      name: 'quotaNotificationsAll',
      desc: '',
      args: [],
    );
  }

  /// `Notifications (zone)`
  String get quotaNotificationsZone {
    return Intl.message(
      'Notifications (zone)',
      name: 'quotaNotificationsZone',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get quotaProducts {
    return Intl.message('Products', name: 'quotaProducts', desc: '', args: []);
  }

  /// `Drinks`
  String get quotaDrinks {
    return Intl.message('Drinks', name: 'quotaDrinks', desc: '', args: []);
  }

  /// `Own categories`
  String get quotaOwnCategories {
    return Intl.message(
      'Own categories',
      name: 'quotaOwnCategories',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited`
  String get quotaUnlimited {
    return Intl.message(
      'Unlimited',
      name: 'quotaUnlimited',
      desc: '',
      args: [],
    );
  }

  /// `{used} of {cap}`
  String quotaUsedOfCap(Object used, Object cap) {
    return Intl.message(
      '$used of $cap',
      name: 'quotaUsedOfCap',
      desc: '',
      args: [used, cap],
    );
  }

  /// `Available plans`
  String get availablePlansTitle {
    return Intl.message(
      'Available plans',
      name: 'availablePlansTitle',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribeAction {
    return Intl.message(
      'Subscribe',
      name: 'subscribeAction',
      desc: '',
      args: [],
    );
  }

  /// `Renew`
  String get renewAction {
    return Intl.message('Renew', name: 'renewAction', desc: '', args: []);
  }

  /// `Switch to this plan`
  String get changePlanAction {
    return Intl.message(
      'Switch to this plan',
      name: 'changePlanAction',
      desc: '',
      args: [],
    );
  }

  /// `Your current plan`
  String get currentPlanBadge {
    return Intl.message(
      'Your current plan',
      name: 'currentPlanBadge',
      desc: '',
      args: [],
    );
  }

  /// `Confirm subscription`
  String get confirmSubscribeTitle {
    return Intl.message(
      'Confirm subscription',
      name: 'confirmSubscribeTitle',
      desc: '',
      args: [],
    );
  }

  /// `You're subscribing to the "{planName}" plan for {price} EGP. Are you sure?`
  String confirmSubscribeMessage(Object planName, Object price) {
    return Intl.message(
      'You\'re subscribing to the "$planName" plan for $price EGP. Are you sure?',
      name: 'confirmSubscribeMessage',
      desc: '',
      args: [planName, price],
    );
  }

  /// `Wallet balance is insufficient — a request was sent to the admin for approval`
  String get subscriptionRequestSentPending {
    return Intl.message(
      'Wallet balance is insufficient — a request was sent to the admin for approval',
      name: 'subscriptionRequestSentPending',
      desc: '',
      args: [],
    );
  }

  /// `Subscription activated successfully`
  String get subscriptionActivated {
    return Intl.message(
      'Subscription activated successfully',
      name: 'subscriptionActivated',
      desc: '',
      args: [],
    );
  }

  /// `Subscription request history`
  String get subscriptionRequestsTitle {
    return Intl.message(
      'Subscription request history',
      name: 'subscriptionRequestsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No requests yet`
  String get noSubscriptionRequests {
    return Intl.message(
      'No requests yet',
      name: 'noSubscriptionRequests',
      desc: '',
      args: [],
    );
  }

  /// `Pending review`
  String get requestStatusPending {
    return Intl.message(
      'Pending review',
      name: 'requestStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get requestStatusApproved {
    return Intl.message(
      'Approved',
      name: 'requestStatusApproved',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get requestStatusRejected {
    return Intl.message(
      'Rejected',
      name: 'requestStatusRejected',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get requestTypeSubscribe {
    return Intl.message(
      'Subscribe',
      name: 'requestTypeSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Renew`
  String get requestTypeRenew {
    return Intl.message('Renew', name: 'requestTypeRenew', desc: '', args: []);
  }

  /// `Send notification`
  String get sendBroadcast {
    return Intl.message(
      'Send notification',
      name: 'sendBroadcast',
      desc: '',
      args: [],
    );
  }

  /// `Send notification`
  String get broadcastTitle {
    return Intl.message(
      'Send notification',
      name: 'broadcastTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send a push notification to your customers.`
  String get broadcastNote {
    return Intl.message(
      'Send a push notification to your customers.',
      name: 'broadcastNote',
      desc: '',
      args: [],
    );
  }

  /// `Notification title`
  String get broadcastTitleFieldHint {
    return Intl.message(
      'Notification title',
      name: 'broadcastTitleFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Notification message`
  String get broadcastBodyFieldHint {
    return Intl.message(
      'Notification message',
      name: 'broadcastBodyFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `All customers`
  String get broadcastScopeAll {
    return Intl.message(
      'All customers',
      name: 'broadcastScopeAll',
      desc: '',
      args: [],
    );
  }

  /// `My customers only`
  String get broadcastScopeMine {
    return Intl.message(
      'My customers only',
      name: 'broadcastScopeMine',
      desc: '',
      args: [],
    );
  }

  /// `My zone only`
  String get broadcastScopeZone {
    return Intl.message(
      'My zone only',
      name: 'broadcastScopeZone',
      desc: '',
      args: [],
    );
  }

  /// `Your zone is not set yet, so this will be sent to all customers`
  String get broadcastZoneUnavailable {
    return Intl.message(
      'Your zone is not set yet, so this will be sent to all customers',
      name: 'broadcastZoneUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get broadcastSendAction {
    return Intl.message(
      'Send',
      name: 'broadcastSendAction',
      desc: '',
      args: [],
    );
  }

  /// `Notification sent successfully`
  String get broadcastSentSuccess {
    return Intl.message(
      'Notification sent successfully',
      name: 'broadcastSentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sent notifications`
  String get broadcastListTitle {
    return Intl.message(
      'Sent notifications',
      name: 'broadcastListTitle',
      desc: '',
      args: [],
    );
  }

  /// `You haven't sent any notification yet`
  String get broadcastListEmpty {
    return Intl.message(
      'You haven\'t sent any notification yet',
      name: 'broadcastListEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Pending review`
  String get broadcastStatusPending {
    return Intl.message(
      'Pending review',
      name: 'broadcastStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get broadcastStatusApproved {
    return Intl.message(
      'Approved',
      name: 'broadcastStatusApproved',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get broadcastStatusRejected {
    return Intl.message(
      'Rejected',
      name: 'broadcastStatusRejected',
      desc: '',
      args: [],
    );
  }

  /// `{count} recipients`
  String broadcastRecipientCount(Object count) {
    return Intl.message(
      '$count recipients',
      name: 'broadcastRecipientCount',
      desc: '',
      args: [count],
    );
  }

  /// `Rejection reason`
  String get broadcastRejectionReasonLabel {
    return Intl.message(
      'Rejection reason',
      name: 'broadcastRejectionReasonLabel',
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

  /// `Customer (optional)`
  String get customerLabelOptional {
    return Intl.message(
      'Customer (optional)',
      name: 'customerLabelOptional',
      desc: '',
      args: [],
    );
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

  /// `Customer phone (optional)`
  String get customerPhoneLabelOptional {
    return Intl.message(
      'Customer phone (optional)',
      name: 'customerPhoneLabelOptional',
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

  /// `History`
  String get bookingsHistoryTab {
    return Intl.message(
      'History',
      name: 'bookingsHistoryTab',
      desc: '',
      args: [],
    );
  }

  /// `Unresolved`
  String get bookingsUnresolvedTab {
    return Intl.message(
      'Unresolved',
      name: 'bookingsUnresolvedTab',
      desc: '',
      args: [],
    );
  }

  /// `No unresolved bookings`
  String get noUnresolvedBookings {
    return Intl.message(
      'No unresolved bookings',
      name: 'noUnresolvedBookings',
      desc: '',
      args: [],
    );
  }

  /// `Approve`
  String get settleApprove {
    return Intl.message('Approve', name: 'settleApprove', desc: '', args: []);
  }

  /// `Cancel`
  String get settleCancel {
    return Intl.message('Cancel', name: 'settleCancel', desc: '', args: []);
  }

  /// `Reason for cancelling`
  String get settleCancelReasonHint {
    return Intl.message(
      'Reason for cancelling',
      name: 'settleCancelReasonHint',
      desc: '',
      args: [],
    );
  }

  /// `{count} selected`
  String settleSelectedCount(Object count) {
    return Intl.message(
      '$count selected',
      name: 'settleSelectedCount',
      desc: '',
      args: [count],
    );
  }

  /// `Apply decisions`
  String get settleSubmitAction {
    return Intl.message(
      'Apply decisions',
      name: 'settleSubmitAction',
      desc: '',
      args: [],
    );
  }

  /// `Bookings settled`
  String get settleSuccess {
    return Intl.message(
      'Bookings settled',
      name: 'settleSuccess',
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

  /// `No bookings yet`
  String get noBookingHistory {
    return Intl.message(
      'No bookings yet',
      name: 'noBookingHistory',
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

  /// `Team member`
  String get walkInBarberLabel {
    return Intl.message(
      'Team member',
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

  /// `You must choose a team member`
  String get chooseTeamMemberRequired {
    return Intl.message(
      'You must choose a team member',
      name: 'chooseTeamMemberRequired',
      desc: '',
      args: [],
    );
  }

  /// `You must choose a service`
  String get chooseServiceRequired {
    return Intl.message(
      'You must choose a service',
      name: 'chooseServiceRequired',
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

  /// `Time`
  String get walkInSlotTimeLabel {
    return Intl.message(
      'Time',
      name: 'walkInSlotTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Now`
  String get walkInSlotTimeNow {
    return Intl.message('Now', name: 'walkInSlotTimeNow', desc: '', args: []);
  }

  /// `Pick a time`
  String get walkInSlotTimeSpecific {
    return Intl.message(
      'Pick a time',
      name: 'walkInSlotTimeSpecific',
      desc: '',
      args: [],
    );
  }

  /// `Tap to add`
  String get walkInPickerNoneSelected {
    return Intl.message(
      'Tap to add',
      name: 'walkInPickerNoneSelected',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get walkInPickerDone {
    return Intl.message('Done', name: 'walkInPickerDone', desc: '', args: []);
  }

  /// `Add`
  String get walkInPickerAddMore {
    return Intl.message('Add', name: 'walkInPickerAddMore', desc: '', args: []);
  }

  /// `Review order`
  String get walkInConfirmTitle {
    return Intl.message(
      'Review order',
      name: 'walkInConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm and add customer`
  String get walkInConfirmAction {
    return Intl.message(
      'Confirm and add customer',
      name: 'walkInConfirmAction',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get walkInConfirmEdit {
    return Intl.message('Edit', name: 'walkInConfirmEdit', desc: '', args: []);
  }

  /// `Total`
  String get walkInConfirmTotalLabel {
    return Intl.message(
      'Total',
      name: 'walkInConfirmTotalLabel',
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

  /// `Last 7 days`
  String get clientsLast7DaysLabel {
    return Intl.message(
      'Last 7 days',
      name: 'clientsLast7DaysLabel',
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

  /// `Member earnings`
  String get memberEarningsTitle {
    return Intl.message(
      'Member earnings',
      name: 'memberEarningsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Member clients`
  String get memberClientsTitle {
    return Intl.message(
      'Member clients',
      name: 'memberClientsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No clients in this period`
  String get memberClientsEmpty {
    return Intl.message(
      'No clients in this period',
      name: 'memberClientsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Change period`
  String get memberClientsDateRangeAction {
    return Intl.message(
      'Change period',
      name: 'memberClientsDateRangeAction',
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

  /// `Delete member permanently`
  String get deleteMemberPermanentlyTitle {
    return Intl.message(
      'Delete member permanently',
      name: 'deleteMemberPermanentlyTitle',
      desc: '',
      args: [],
    );
  }

  /// `This member will be permanently deleted and this cannot be undone. Continue?`
  String get deleteMemberPermanentlyConfirm {
    return Intl.message(
      'This member will be permanently deleted and this cannot be undone. Continue?',
      name: 'deleteMemberPermanentlyConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Member deleted permanently`
  String get memberDeletedPermanently {
    return Intl.message(
      'Member deleted permanently',
      name: 'memberDeletedPermanently',
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

  /// `Product revenue this month`
  String get productsThisMonthLabel {
    return Intl.message(
      'Product revenue this month',
      name: 'productsThisMonthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Product orders this month`
  String get productOrdersThisMonthLabel {
    return Intl.message(
      'Product orders this month',
      name: 'productOrdersThisMonthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total this month`
  String get totalThisMonthLabel {
    return Intl.message(
      'Total this month',
      name: 'totalThisMonthLabel',
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

  /// `Till additions`
  String get tillAddedLabel {
    return Intl.message(
      'Till additions',
      name: 'tillAddedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Till withdrawals`
  String get tillSubtractedLabel {
    return Intl.message(
      'Till withdrawals',
      name: 'tillSubtractedLabel',
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

  /// `Products: {amount} EGP`
  String productsAmountLine(Object amount) {
    return Intl.message(
      'Products: $amount EGP',
      name: 'productsAmountLine',
      desc: '',
      args: [amount],
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

  /// `Pick location on the map`
  String get pickLocationOnMap {
    return Intl.message(
      'Pick location on the map',
      name: 'pickLocationOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Change location on the map`
  String get changeLocationOnMap {
    return Intl.message(
      'Change location on the map',
      name: 'changeLocationOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Select location`
  String get pickLocationTitle {
    return Intl.message(
      'Select location',
      name: 'pickLocationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm location`
  String get confirmLocation {
    return Intl.message(
      'Confirm location',
      name: 'confirmLocation',
      desc: '',
      args: [],
    );
  }

  /// `Selected location`
  String get selectedLocationLabel {
    return Intl.message(
      'Selected location',
      name: 'selectedLocationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Finding the address...`
  String get searchingAddress {
    return Intl.message(
      'Finding the address...',
      name: 'searchingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Move the map to choose a spot`
  String get moveMapToChooseLocation {
    return Intl.message(
      'Move the map to choose a spot',
      name: 'moveMapToChooseLocation',
      desc: '',
      args: [],
    );
  }

  /// `Pick the location on the map first`
  String get locationRequiredFromMap {
    return Intl.message(
      'Pick the location on the map first',
      name: 'locationRequiredFromMap',
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

  /// `Set your shop location to continue`
  String get locationBlockedHeadline {
    return Intl.message(
      'Set your shop location to continue',
      name: 'locationBlockedHeadline',
      desc: '',
      args: [],
    );
  }

  /// `We need your shop's location before you can use the app. Once it's saved, everything unlocks right away.`
  String get locationBlockedMessage {
    return Intl.message(
      'We need your shop\'s location before you can use the app. Once it\'s saved, everything unlocks right away.',
      name: 'locationBlockedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Rate booking`
  String get rateBooking {
    return Intl.message(
      'Rate booking',
      name: 'rateBooking',
      desc: '',
      args: [],
    );
  }

  /// `Rate home service`
  String get rateHomeService {
    return Intl.message(
      'Rate home service',
      name: 'rateHomeService',
      desc: '',
      args: [],
    );
  }

  /// `Rate the barber`
  String get rateBarberTitle {
    return Intl.message(
      'Rate the barber',
      name: 'rateBarberTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rate the shop`
  String get rateShopTitle {
    return Intl.message(
      'Rate the shop',
      name: 'rateShopTitle',
      desc: '',
      args: [],
    );
  }

  /// `How was your experience with {barberName}?`
  String rateBarberSubtitle(String barberName) {
    return Intl.message(
      'How was your experience with $barberName?',
      name: 'rateBarberSubtitle',
      desc: '',
      args: [barberName],
    );
  }

  /// `How was your experience with {shopName}?`
  String rateShopSubtitle(String shopName) {
    return Intl.message(
      'How was your experience with $shopName?',
      name: 'rateShopSubtitle',
      desc: '',
      args: [shopName],
    );
  }

  /// `Write your feedback (optional)`
  String get rateNoteHint {
    return Intl.message(
      'Write your feedback (optional)',
      name: 'rateNoteHint',
      desc: '',
      args: [],
    );
  }

  /// `Submit rating`
  String get submitRating {
    return Intl.message(
      'Submit rating',
      name: 'submitRating',
      desc: '',
      args: [],
    );
  }

  /// `Rate the shop too`
  String get rateShopToo {
    return Intl.message(
      'Rate the shop too',
      name: 'rateShopToo',
      desc: '',
      args: [],
    );
  }

  /// `Not now`
  String get skipForNow {
    return Intl.message('Not now', name: 'skipForNow', desc: '', args: []);
  }

  /// `Thanks for your rating`
  String get ratingSubmittedMessage {
    return Intl.message(
      'Thanks for your rating',
      name: 'ratingSubmittedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Select a star rating first`
  String get selectStarsError {
    return Intl.message(
      'Select a star rating first',
      name: 'selectStarsError',
      desc: '',
      args: [],
    );
  }

  /// `You already rated the barber`
  String get alreadyRatedBarber {
    return Intl.message(
      'You already rated the barber',
      name: 'alreadyRatedBarber',
      desc: '',
      args: [],
    );
  }

  /// `You already rated the shop`
  String get alreadyRatedShop {
    return Intl.message(
      'You already rated the shop',
      name: 'alreadyRatedShop',
      desc: '',
      args: [],
    );
  }

  /// `Verify phone number`
  String get verifyPhoneTitle {
    return Intl.message(
      'Verify phone number',
      name: 'verifyPhoneTitle',
      desc: '',
      args: [],
    );
  }

  /// `We sent a 6-digit code to your phone`
  String get verifyPhoneSubtitle {
    return Intl.message(
      'We sent a 6-digit code to your phone',
      name: 'verifyPhoneSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Code sent to`
  String get otpSentTo {
    return Intl.message('Code sent to', name: 'otpSentTo', desc: '', args: []);
  }

  /// `Enter the verification code`
  String get enterOtpCode {
    return Intl.message(
      'Enter the verification code',
      name: 'enterOtpCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter the full code`
  String get otpRequired {
    return Intl.message(
      'Enter the full code',
      name: 'otpRequired',
      desc: '',
      args: [],
    );
  }

  /// `A new code has been sent`
  String get otpResentMessage {
    return Intl.message(
      'A new code has been sent',
      name: 'otpResentMessage',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Recover password`
  String get forgotPasswordTitle {
    return Intl.message(
      'Recover password',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number and we'll send a code`
  String get forgotPasswordSubtitle {
    return Intl.message(
      'Enter your phone number and we\'ll send a code',
      name: 'forgotPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get sendCode {
    return Intl.message('Send code', name: 'sendCode', desc: '', args: []);
  }

  /// `New password`
  String get setNewPasswordTitle {
    return Intl.message(
      'New password',
      name: 'setNewPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose a new password for your account`
  String get setNewPasswordSubtitle {
    return Intl.message(
      'Choose a new password for your account',
      name: 'setNewPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Save password`
  String get saveNewPassword {
    return Intl.message(
      'Save password',
      name: 'saveNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register as barber`
  String get registerBarber {
    return Intl.message(
      'Register as barber',
      name: 'registerBarber',
      desc: '',
      args: [],
    );
  }

  /// `Register your shop and start taking bookings`
  String get registerSubtitleBarber {
    return Intl.message(
      'Register your shop and start taking bookings',
      name: 'registerSubtitleBarber',
      desc: '',
      args: [],
    );
  }

  /// `Create barber account`
  String get createBarberAccount {
    return Intl.message(
      'Create barber account',
      name: 'createBarberAccount',
      desc: '',
      args: [],
    );
  }

  /// `Shop name`
  String get shopName {
    return Intl.message('Shop name', name: 'shopName', desc: '', args: []);
  }

  /// `Elegance Barbershop`
  String get shopNameHint {
    return Intl.message(
      'Elegance Barbershop',
      name: 'shopNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter the shop name`
  String get shopNameRequired {
    return Intl.message(
      'Enter the shop name',
      name: 'shopNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message('Area', name: 'area', desc: '', args: []);
  }

  /// `Nasr City`
  String get areaHint {
    return Intl.message('Nasr City', name: 'areaHint', desc: '', args: []);
  }

  /// `Enter the area`
  String get areaRequired {
    return Intl.message(
      'Enter the area',
      name: 'areaRequired',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Enter the address`
  String get addressRequired {
    return Intl.message(
      'Enter the address',
      name: 'addressRequired',
      desc: '',
      args: [],
    );
  }

  /// `Barber name`
  String get barberName {
    return Intl.message('Barber name', name: 'barberName', desc: '', args: []);
  }

  /// `Enter the barber name`
  String get barberNameRequired {
    return Intl.message(
      'Enter the barber name',
      name: 'barberNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `No account? Register as barber`
  String get noAccountRegisterBarber {
    return Intl.message(
      'No account? Register as barber',
      name: 'noAccountRegisterBarber',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Permanently delete account`
  String get deleteAccountTitle {
    return Intl.message(
      'Permanently delete account',
      name: 'deleteAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your account and all your data will be permanently deleted. Enter your password to confirm.`
  String get deleteAccountWarning {
    return Intl.message(
      'Your account and all your data will be permanently deleted. Enter your password to confirm.',
      name: 'deleteAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `Confirm deletion`
  String get deleteAccountConfirm {
    return Intl.message(
      'Confirm deletion',
      name: 'deleteAccountConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted`
  String get accountDeleted {
    return Intl.message(
      'Account deleted',
      name: 'accountDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get passwordRequired {
    return Intl.message(
      'Enter your password',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password change required`
  String get forceChangePasswordTitle {
    return Intl.message(
      'Password change required',
      name: 'forceChangePasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `You signed in with a temporary password. Choose a new one to continue.`
  String get forceChangePasswordMessage {
    return Intl.message(
      'You signed in with a temporary password. Choose a new one to continue.',
      name: 'forceChangePasswordMessage',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message('View', name: 'view', desc: '', args: []);
  }

  /// `Home service`
  String get homeServiceSettingsTitle {
    return Intl.message(
      'Home service',
      name: 'homeServiceSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Turn this on to reach customers who want a haircut at home. Set your base price, any notes, then your availability.`
  String get homeServiceNote {
    return Intl.message(
      'Turn this on to reach customers who want a haircut at home. Set your base price, any notes, then your availability.',
      name: 'homeServiceNote',
      desc: '',
      args: [],
    );
  }

  /// `Home service`
  String get homeServiceOffered {
    return Intl.message(
      'Home service',
      name: 'homeServiceOffered',
      desc: '',
      args: [],
    );
  }

  /// `Not enabled`
  String get homeServiceOffLabel {
    return Intl.message(
      'Not enabled',
      name: 'homeServiceOffLabel',
      desc: '',
      args: [],
    );
  }

  /// `Base price`
  String get homeServicePriceLabel {
    return Intl.message(
      'Base price',
      name: 'homeServicePriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 150`
  String get homeServicePriceHint {
    return Intl.message(
      'e.g. 150',
      name: 'homeServicePriceHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid price`
  String get homeServicePriceRequired {
    return Intl.message(
      'Enter a valid price',
      name: 'homeServicePriceRequired',
      desc: '',
      args: [],
    );
  }

  /// `Note (optional)`
  String get homeServiceNoteLabel {
    return Intl.message(
      'Note (optional)',
      name: 'homeServiceNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Haircut and beard trim only`
  String get homeServiceNoteHint {
    return Intl.message(
      'e.g. Haircut and beard trim only',
      name: 'homeServiceNoteHint',
      desc: '',
      args: [],
    );
  }

  /// `Home service settings saved`
  String get homeServiceSettingsSaved {
    return Intl.message(
      'Home service settings saved',
      name: 'homeServiceSettingsSaved',
      desc: '',
      args: [],
    );
  }

  /// `Home service hours`
  String get homeServiceHoursCta {
    return Intl.message(
      'Home service hours',
      name: 'homeServiceHoursCta',
      desc: '',
      args: [],
    );
  }

  /// `Home service hours`
  String get homeServiceHoursTitle {
    return Intl.message(
      'Home service hours',
      name: 'homeServiceHoursTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enabled — edit price or hours`
  String get homeServiceCardEnabledHint {
    return Intl.message(
      'Enabled — edit price or hours',
      name: 'homeServiceCardEnabledHint',
      desc: '',
      args: [],
    );
  }

  /// `Turn it on to reach new customers at home`
  String get homeServiceCardDisabledHint {
    return Intl.message(
      'Turn it on to reach new customers at home',
      name: 'homeServiceCardDisabledHint',
      desc: '',
      args: [],
    );
  }

  /// `You have {count} home service requests awaiting a reply`
  String homeServicePendingCount(Object count) {
    return Intl.message(
      'You have $count home service requests awaiting a reply',
      name: 'homeServicePendingCount',
      desc: '',
      args: [count],
    );
  }

  /// `Sponsored`
  String get sponsoredLabel {
    return Intl.message(
      'Sponsored',
      name: 'sponsoredLabel',
      desc: '',
      args: [],
    );
  }

  /// `Ordered before`
  String get orderedBeforeLabel {
    return Intl.message(
      'Ordered before',
      name: 'orderedBeforeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Search products or brands`
  String get storeFeedSearchHint {
    return Intl.message(
      'Search products or brands',
      name: 'storeFeedSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Browse suppliers`
  String get storeBrowseMerchantsCta {
    return Intl.message(
      'Browse suppliers',
      name: 'storeBrowseMerchantsCta',
      desc: '',
      args: [],
    );
  }

  /// `Most relevant`
  String get storeSortRelevant {
    return Intl.message(
      'Most relevant',
      name: 'storeSortRelevant',
      desc: '',
      args: [],
    );
  }

  /// `Price: low to high`
  String get storeSortPriceAsc {
    return Intl.message(
      'Price: low to high',
      name: 'storeSortPriceAsc',
      desc: '',
      args: [],
    );
  }

  /// `Price: high to low`
  String get storeSortPriceDesc {
    return Intl.message(
      'Price: high to low',
      name: 'storeSortPriceDesc',
      desc: '',
      args: [],
    );
  }

  /// `Newest`
  String get storeSortNewest {
    return Intl.message('Newest', name: 'storeSortNewest', desc: '', args: []);
  }

  /// `No products available right now`
  String get noStoreProductsYet {
    return Intl.message(
      'No products available right now',
      name: 'noStoreProductsYet',
      desc: '',
      args: [],
    );
  }

  /// `View {merchantName}'s store`
  String viewMerchantStore(Object merchantName) {
    return Intl.message(
      'View $merchantName\'s store',
      name: 'viewMerchantStore',
      desc: '',
      args: [merchantName],
    );
  }

  /// `View {shopName}'s page`
  String viewShopProfile(Object shopName) {
    return Intl.message(
      'View $shopName\'s page',
      name: 'viewShopProfile',
      desc: '',
      args: [shopName],
    );
  }

  /// `Price pending`
  String get homeServicePricePending {
    return Intl.message(
      'Price pending',
      name: 'homeServicePricePending',
      desc: '',
      args: [],
    );
  }

  /// `Starting from {price} EGP`
  String homeServiceStartingPrice(Object price) {
    return Intl.message(
      'Starting from $price EGP',
      name: 'homeServiceStartingPrice',
      desc: '',
      args: [price],
    );
  }

  /// `Note`
  String get homeServiceShopNoteLabel {
    return Intl.message(
      'Note',
      name: 'homeServiceShopNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Home service`
  String get homeServiceShopListTitle {
    return Intl.message(
      'Home service',
      name: 'homeServiceShopListTitle',
      desc: '',
      args: [],
    );
  }

  /// `When do you need a barber?`
  String get homeServiceDateTimeStepTitle {
    return Intl.message(
      'When do you need a barber?',
      name: 'homeServiceDateTimeStepTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pick a date and time, then we'll show you who's available.`
  String get homeServiceDateTimeStepSubtitle {
    return Intl.message(
      'Pick a date and time, then we\'ll show you who\'s available.',
      name: 'homeServiceDateTimeStepSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `No shops offer home service right now`
  String get noHomeServiceShopsYet {
    return Intl.message(
      'No shops offer home service right now',
      name: 'noHomeServiceShopsYet',
      desc: '',
      args: [],
    );
  }

  /// `No shops are available at this time`
  String get noHomeServiceShopsAtThisTime {
    return Intl.message(
      'No shops are available at this time',
      name: 'noHomeServiceShopsAtThisTime',
      desc: '',
      args: [],
    );
  }

  /// `Home service request`
  String get homeServiceRequestTitle {
    return Intl.message(
      'Home service request',
      name: 'homeServiceRequestTitle',
      desc: '',
      args: [],
    );
  }

  /// `Set the address and location first`
  String get homeServiceAddressRequired {
    return Intl.message(
      'Set the address and location first',
      name: 'homeServiceAddressRequired',
      desc: '',
      args: [],
    );
  }

  /// `Choose a date and time first`
  String get homeServiceDateTimeRequired {
    return Intl.message(
      'Choose a date and time first',
      name: 'homeServiceDateTimeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Choose a date and time in the future`
  String get homeServiceDateTimeMustBeFuture {
    return Intl.message(
      'Choose a date and time in the future',
      name: 'homeServiceDateTimeMustBeFuture',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 6th floor, no elevator`
  String get homeServiceRequestNoteHint {
    return Intl.message(
      'e.g. 6th floor, no elevator',
      name: 'homeServiceRequestNoteHint',
      desc: '',
      args: [],
    );
  }

  /// `Submit request`
  String get homeServiceSubmitRequest {
    return Intl.message(
      'Submit request',
      name: 'homeServiceSubmitRequest',
      desc: '',
      args: [],
    );
  }

  /// `Home service request sent`
  String get homeServiceRequestCreated {
    return Intl.message(
      'Home service request sent',
      name: 'homeServiceRequestCreated',
      desc: '',
      args: [],
    );
  }

  /// `Date and time`
  String get homeServiceDateTimeLabel {
    return Intl.message(
      'Date and time',
      name: 'homeServiceDateTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get homeServiceDateLabel {
    return Intl.message(
      'Date',
      name: 'homeServiceDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get homeServiceTimeLabel {
    return Intl.message(
      'Time',
      name: 'homeServiceTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Any available barber`
  String get homeServiceAnyNearbyTitle {
    return Intl.message(
      'Any available barber',
      name: 'homeServiceAnyNearbyTitle',
      desc: '',
      args: [],
    );
  }

  /// `We'll send your request to nearby barbers and the first one available will accept it.`
  String get homeServiceAnyNearbyDescription {
    return Intl.message(
      'We\'ll send your request to nearby barbers and the first one available will accept it.',
      name: 'homeServiceAnyNearbyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Request any nearby barber`
  String get homeServiceAnyNearbyCta {
    return Intl.message(
      'Request any nearby barber',
      name: 'homeServiceAnyNearbyCta',
      desc: '',
      args: [],
    );
  }

  /// `Retry request`
  String get homeServiceRetryRequest {
    return Intl.message(
      'Retry request',
      name: 'homeServiceRetryRequest',
      desc: '',
      args: [],
    );
  }

  /// `Home service requests`
  String get homeServiceRequestsTitle {
    return Intl.message(
      'Home service requests',
      name: 'homeServiceRequestsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home service`
  String get homeServiceRequestsTab {
    return Intl.message(
      'Home service',
      name: 'homeServiceRequestsTab',
      desc: '',
      args: [],
    );
  }

  /// `You haven't made any home service requests yet`
  String get noHomeServiceRequestsYet {
    return Intl.message(
      'You haven\'t made any home service requests yet',
      name: 'noHomeServiceRequestsYet',
      desc: '',
      args: [],
    );
  }

  /// `Request details`
  String get homeServiceRequestDetailTitle {
    return Intl.message(
      'Request details',
      name: 'homeServiceRequestDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Price changed`
  String get homeServicePriceChangedTitle {
    return Intl.message(
      'Price changed',
      name: 'homeServicePriceChangedTitle',
      desc: '',
      args: [],
    );
  }

  /// `The shop wants {newPrice} instead of {oldPrice}. Confirm or cancel the request.`
  String homeServicePriceChangedMessage(Object newPrice, Object oldPrice) {
    return Intl.message(
      'The shop wants $newPrice instead of $oldPrice. Confirm or cancel the request.',
      name: 'homeServicePriceChangedMessage',
      desc: '',
      args: [newPrice, oldPrice],
    );
  }

  /// `Confirm new price`
  String get homeServiceConfirmNewPrice {
    return Intl.message(
      'Confirm new price',
      name: 'homeServiceConfirmNewPrice',
      desc: '',
      args: [],
    );
  }

  /// `Price confirmed`
  String get homeServicePriceConfirmed {
    return Intl.message(
      'Price confirmed',
      name: 'homeServicePriceConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Cancel request`
  String get homeServiceCancelRequest {
    return Intl.message(
      'Cancel request',
      name: 'homeServiceCancelRequest',
      desc: '',
      args: [],
    );
  }

  /// `Cancel request`
  String get homeServiceCancelTitle {
    return Intl.message(
      'Cancel request',
      name: 'homeServiceCancelTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this home service request?`
  String get homeServiceCancelMessage {
    return Intl.message(
      'Are you sure you want to cancel this home service request?',
      name: 'homeServiceCancelMessage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm cancellation`
  String get homeServiceCancelConfirm {
    return Intl.message(
      'Confirm cancellation',
      name: 'homeServiceCancelConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Request cancelled`
  String get homeServiceRequestCancelled {
    return Intl.message(
      'Request cancelled',
      name: 'homeServiceRequestCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Awaiting approval`
  String get homeServiceStatusPending {
    return Intl.message(
      'Awaiting approval',
      name: 'homeServiceStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get homeServiceStatusAccepted {
    return Intl.message(
      'Accepted',
      name: 'homeServiceStatusAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Barber on the way`
  String get homeServiceStatusOnTheWay {
    return Intl.message(
      'Barber on the way',
      name: 'homeServiceStatusOnTheWay',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get homeServiceStatusDone {
    return Intl.message(
      'Done',
      name: 'homeServiceStatusDone',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get homeServiceStatusRejected {
    return Intl.message(
      'Rejected',
      name: 'homeServiceStatusRejected',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get homeServiceStatusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'homeServiceStatusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get homeServiceStatusExpired {
    return Intl.message(
      'Expired',
      name: 'homeServiceStatusExpired',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get distanceLabel {
    return Intl.message('Distance', name: 'distanceLabel', desc: '', args: []);
  }

  /// `No home service requests awaiting a reply`
  String get noPendingHomeServiceRequests {
    return Intl.message(
      'No home service requests awaiting a reply',
      name: 'noPendingHomeServiceRequests',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for the customer to confirm the new price before you can accept`
  String get homeServiceAwaitingPriceConfirmation {
    return Intl.message(
      'Waiting for the customer to confirm the new price before you can accept',
      name: 'homeServiceAwaitingPriceConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Accept request`
  String get acceptHomeServiceRequest {
    return Intl.message(
      'Accept request',
      name: 'acceptHomeServiceRequest',
      desc: '',
      args: [],
    );
  }

  /// `Reject request`
  String get rejectHomeServiceRequest {
    return Intl.message(
      'Reject request',
      name: 'rejectHomeServiceRequest',
      desc: '',
      args: [],
    );
  }

  /// `Edit price`
  String get editHomeServicePriceAction {
    return Intl.message(
      'Edit price',
      name: 'editHomeServicePriceAction',
      desc: '',
      args: [],
    );
  }

  /// `Home service invitations`
  String get homeServiceBroadcastInboxTitle {
    return Intl.message(
      'Home service invitations',
      name: 'homeServiceBroadcastInboxTitle',
      desc: '',
      args: [],
    );
  }

  /// `No home service invitations right now`
  String get noHomeServiceBroadcastsYet {
    return Intl.message(
      'No home service invitations right now',
      name: 'noHomeServiceBroadcastsYet',
      desc: '',
      args: [],
    );
  }

  /// `Invitation details`
  String get homeServiceBroadcastDetailTitle {
    return Intl.message(
      'Invitation details',
      name: 'homeServiceBroadcastDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get homeServiceBroadcastAccept {
    return Intl.message(
      'Accept',
      name: 'homeServiceBroadcastAccept',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get homeServiceBroadcastReject {
    return Intl.message(
      'Reject',
      name: 'homeServiceBroadcastReject',
      desc: '',
      args: [],
    );
  }

  /// `Reject invitation`
  String get homeServiceBroadcastRejectTitle {
    return Intl.message(
      'Reject invitation',
      name: 'homeServiceBroadcastRejectTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to reject this home service invitation?`
  String get homeServiceBroadcastRejectMessage {
    return Intl.message(
      'Are you sure you want to reject this home service invitation?',
      name: 'homeServiceBroadcastRejectMessage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm rejection`
  String get homeServiceBroadcastRejectConfirm {
    return Intl.message(
      'Confirm rejection',
      name: 'homeServiceBroadcastRejectConfirm',
      desc: '',
      args: [],
    );
  }

  /// `You have {count} home service invitations awaiting a reply`
  String homeServiceBroadcastPendingCount(Object count) {
    return Intl.message(
      'You have $count home service invitations awaiting a reply',
      name: 'homeServiceBroadcastPendingCount',
      desc: '',
      args: [count],
    );
  }

  /// `Select location on map`
  String get mapPickerTitle {
    return Intl.message(
      'Select location on map',
      name: 'mapPickerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search for a place or address`
  String get searchPlaceHint {
    return Intl.message(
      'Search for a place or address',
      name: 'searchPlaceHint',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get noPlacesFound {
    return Intl.message(
      'No results found',
      name: 'noPlacesFound',
      desc: '',
      args: [],
    );
  }

  /// `Location selected on map`
  String get unnamedLocation {
    return Intl.message(
      'Location selected on map',
      name: 'unnamedLocation',
      desc: '',
      args: [],
    );
  }

  /// `Location is off`
  String get nearbyLocationOffTitle {
    return Intl.message(
      'Location is off',
      name: 'nearbyLocationOffTitle',
      desc: '',
      args: [],
    );
  }

  /// `Turn on location to see barbers near you`
  String get nearbyLocationOffMessage {
    return Intl.message(
      'Turn on location to see barbers near you',
      name: 'nearbyLocationOffMessage',
      desc: '',
      args: [],
    );
  }

  /// `Enable location`
  String get enableLocationAction {
    return Intl.message(
      'Enable location',
      name: 'enableLocationAction',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get locationSettingLabel {
    return Intl.message(
      'Location',
      name: 'locationSettingLabel',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get locationSettingOn {
    return Intl.message('On', name: 'locationSettingOn', desc: '', args: []);
  }

  /// `Off`
  String get locationSettingOff {
    return Intl.message('Off', name: 'locationSettingOff', desc: '', args: []);
  }

  /// `View on map`
  String get viewOnMap {
    return Intl.message('View on map', name: 'viewOnMap', desc: '', args: []);
  }

  /// `This booking time has passed and can no longer be cancelled`
  String get bookingSlotPassedMessage {
    return Intl.message(
      'This booking time has passed and can no longer be cancelled',
      name: 'bookingSlotPassedMessage',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't find your location`
  String get locationUnresolvedTitle {
    return Intl.message(
      'We couldn\'t find your location',
      name: 'locationUnresolvedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Make sure GPS is on and try again to see distances`
  String get locationUnresolvedMessage {
    return Intl.message(
      'Make sure GPS is on and try again to see distances',
      name: 'locationUnresolvedMessage',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't find your location. Make sure GPS is on and try again`
  String get locationUnavailableMessage {
    return Intl.message(
      'We couldn\'t find your location. Make sure GPS is on and try again',
      name: 'locationUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get guestName {
    return Intl.message('Guest', name: 'guestName', desc: '', args: []);
  }

  /// `Browse as guest`
  String get browseAsGuest {
    return Intl.message(
      'Browse as guest',
      name: 'browseAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue`
  String get guestLoginTitle {
    return Intl.message(
      'Sign in to continue',
      name: 'guestLoginTitle',
      desc: '',
      args: [],
    );
  }

  /// `You need an account to use this feature. Sign in or create one in a few seconds`
  String get guestLoginMessage {
    return Intl.message(
      'You need an account to use this feature. Sign in or create one in a few seconds',
      name: 'guestLoginMessage',
      desc: '',
      args: [],
    );
  }

  /// `You're browsing as a guest`
  String get guestPlaceholderTitle {
    return Intl.message(
      'You\'re browsing as a guest',
      name: 'guestPlaceholderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to see your orders, favorites and account`
  String get guestPlaceholderSubtitle {
    return Intl.message(
      'Sign in to see your orders, favorites and account',
      name: 'guestPlaceholderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `How was your visit?`
  String get visitRatingTitle {
    return Intl.message(
      'How was your visit?',
      name: 'visitRatingTitle',
      desc: '',
      args: [],
    );
  }

  /// `How was your order?`
  String get merchantRatingTitle {
    return Intl.message(
      'How was your order?',
      name: 'merchantRatingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose your account type so we can show the right screens`
  String get chooseBarberRole {
    return Intl.message(
      'Choose your account type so we can show the right screens',
      name: 'chooseBarberRole',
      desc: '',
      args: [],
    );
  }

  /// `Manage the shop, team and earnings`
  String get shopOwnerHint {
    return Intl.message(
      'Manage the shop, team and earnings',
      name: 'shopOwnerHint',
      desc: '',
      args: [],
    );
  }

  /// `Follow your bookings and do your daily work`
  String get teamMemberHint {
    return Intl.message(
      'Follow your bookings and do your daily work',
      name: 'teamMemberHint',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with the account your shop owner created for you`
  String get loginSubtitleTeamMember {
    return Intl.message(
      'Sign in with the account your shop owner created for you',
      name: 'loginSubtitleTeamMember',
      desc: '',
      args: [],
    );
  }

  /// `Your shop owner creates your account and sends you the temporary password`
  String get teamMemberAccountHint {
    return Intl.message(
      'Your shop owner creates your account and sends you the temporary password',
      name: 'teamMemberAccountHint',
      desc: '',
      args: [],
    );
  }

  /// `Member permissions`
  String get memberPermissionsTitle {
    return Intl.message(
      'Member permissions',
      name: 'memberPermissionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `View revenue`
  String get permissionViewRevenue {
    return Intl.message(
      'View revenue',
      name: 'permissionViewRevenue',
      desc: '',
      args: [],
    );
  }

  /// `Sees their own earnings and daily report`
  String get permissionViewRevenueHint {
    return Intl.message(
      'Sees their own earnings and daily report',
      name: 'permissionViewRevenueHint',
      desc: '',
      args: [],
    );
  }

  /// `Close bookings`
  String get permissionCloseBookings {
    return Intl.message(
      'Close bookings',
      name: 'permissionCloseBookings',
      desc: '',
      args: [],
    );
  }

  /// `Finishes bookings (done / no-show), edits the bill and settles unresolved ones`
  String get permissionCloseBookingsHint {
    return Intl.message(
      'Finishes bookings (done / no-show), edits the bill and settles unresolved ones',
      name: 'permissionCloseBookingsHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm payment received`
  String get permissionMarkPaid {
    return Intl.message(
      'Confirm payment received',
      name: 'permissionMarkPaid',
      desc: '',
      args: [],
    );
  }

  /// `Confirms the money was collected after a booking is done`
  String get permissionMarkPaidHint {
    return Intl.message(
      'Confirms the money was collected after a booking is done',
      name: 'permissionMarkPaidHint',
      desc: '',
      args: [],
    );
  }

  /// `Requires the close bookings permission first`
  String get permissionMarkPaidNeedsClose {
    return Intl.message(
      'Requires the close bookings permission first',
      name: 'permissionMarkPaidNeedsClose',
      desc: '',
      args: [],
    );
  }

  /// `The member was added but the permissions were not saved. Edit them from the member page`
  String get memberAddedPermissionsFailed {
    return Intl.message(
      'The member was added but the permissions were not saved. Edit them from the member page',
      name: 'memberAddedPermissionsFailed',
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
