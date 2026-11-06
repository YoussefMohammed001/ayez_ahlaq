class AnalyticsEvents {
  const AnalyticsEvents._();

  static const login = 'login';
  static const signUp = 'sign_up';
  static const otpVerified = 'otp_verified';
  static const logout = 'logout';

  static const shopViewed = 'shop_viewed';
  static const shopViewOnMap = 'shop_view_on_map';
  static const favoriteAdded = 'favorite_added';
  static const favoriteRemoved = 'favorite_removed';
  static const locationPicked = 'location_picked';
  static const locationEnableTapped = 'location_enable_tapped';

  static const bookingStarted = 'booking_started';
  static const bookingCreated = 'booking_created';
  static const bookingCancelled = 'booking_cancelled';
  static const bookingRated = 'booking_rated';
  static const homeServiceRequested = 'home_service_requested';
  static const storeOrderPlaced = 'store_order_placed';

  static const barberBookingAccepted = 'barber_booking_accepted';
  static const barberBookingRejected = 'barber_booking_rejected';
  static const barberBookingCompleted = 'barber_booking_completed';
  static const barberServiceAdded = 'barber_service_added';
  static const barberLocationSaved = 'barber_location_saved';

  static const merchantProductAdded = 'merchant_product_added';
  static const merchantOrderUpdated = 'merchant_order_updated';

  static const reviewPromptShown = 'review_prompt_shown';

  static const tourStarted = 'tour_started';
  static const tourCompleted = 'tour_completed';
  static const tourSkipped = 'tour_skipped';
  static const setupStepOpened = 'setup_step_opened';
  static const setupCompleted = 'setup_completed';
  static const helpOpened = 'help_opened';
  static const helpQuestionOpened = 'help_question_opened';
  static const helpTourRequested = 'help_tour_requested';
  static const autoAttendanceToggled = 'auto_attendance_toggled';
  static const autoAttendanceTriggered = 'auto_attendance_triggered';
  static const languageChanged = 'language_changed';
  static const themeChanged = 'theme_changed';
  static const externalLinkOpened = 'external_link_opened';
}
