class EndPoints {
  static const String support = 'support';

  static const String customerRegister = 'customer/register';
  static const String customerRegisterVerifyOtp = 'customer/register/verifyOtp';
  static const String customerRegisterResendOtp = 'customer/register/resendOtp';
  static const String customerLogin = 'customer/login';
  static const String customerPasswordForgot = 'customer/password/forgot';
  static const String customerPasswordVerifyOtp = 'customer/password/verifyOtp';
  static const String customerPasswordReset = 'customer/password/reset';
  static const String customerPassword = 'customer/password';
  static const String customerMe = 'customer';

  static const String customerShop = 'customer/shop';
  static String customerShopById(int id) => 'customer/shop/$id';

  static const String customerBookingSlots = 'customer/booking/slots';
  static const String customerBooking = 'customer/booking';
  static String customerBookingById(int id) => 'customer/booking/$id';
  static String customerBookingCancel(int id) => 'customer/booking/$id/cancel';

  static const String customerHomeServiceShop = 'customer/homeService/shop';
  static String customerHomeServiceHours(int shopId) =>
      'customer/homeService/hours/$shopId';
  static const String customerHomeService = 'customer/homeService';
  static String customerHomeServiceById(int id) => 'customer/homeService/$id';
  static String customerHomeServiceConfirmPrice(int id) =>
      'customer/homeService/$id/confirmPrice';
  static String customerHomeServiceCancel(int id) =>
      'customer/homeService/$id/cancel';
  static String customerHomeServiceRetry(int id) =>
      'customer/homeService/$id/retry';

  static const String customerRating = 'customer/rating';
  static const String customerRatingPending = 'customer/rating/pending';
  static const String customerRatingVisit = 'customer/rating/visit';
  static const String customerRatingOrder = 'customer/rating/order';

  static String customerShopProfileImage(int shopId) =>
      'customer/shop/$shopId/profileImage';
  static String customerShopStorefront(int shopId) =>
      'customer/shop/$shopId/storefront';
  static String customerShopStorefrontProductImage(int shopId, int productId) =>
      'customer/shop/$shopId/storefront/product/$productId/image';

  static const String customerCart = 'customer/cart';
  static const String customerCartCheckout = 'customer/cart/checkout';
  static const String customerOrder = 'customer/order';
  static String customerOrderById(int id) => 'customer/order/$id';
  static String customerOrderCancel(int id) => 'customer/order/$id/cancel';

  static const String customerPaymentMethod = 'customer/paymentMethod';

  static const String customerFavorite = 'customer/favorite';
  static String customerFavoriteById(int barberId) =>
      'customer/favorite/$barberId';
  static String customerFavoriteInvite(String inviteCode) =>
      'customer/favorite/invite/$inviteCode';

  static String invitePreview(String code) => 'invite/$code';

  static const String customerNotification = 'customer/notification';
  static const String customerNotificationUnseenCount =
      'customer/notification/unseenCount';
  static const String customerNotificationSeen = 'customer/notification/seen';
  static String customerNotificationSeenById(int id) =>
      'customer/notification/$id/seen';
  static String customerNotificationClickedById(int id) =>
      'customer/notification/$id/clicked';

  static const String customerDeviceToken = 'customer/deviceToken';
  static const String customerDeviceTokenAll = 'customer/deviceToken/all';

  static const String customerWallet = 'customer/wallet';
  static const String customerTransferAccount = 'customer/transferAccount';
  static const String customerWithdrawMethods =
      'customer/transferAccount/withdrawMethods';
  static const String customerWalletRequests = 'customer/walletRequests';
  static String customerWalletRequestById(int id) =>
      'customer/walletRequests/$id';
  static String customerWalletRequestAttachment(int id) =>
      'customer/walletRequests/$id/attachment';
  static String customerWalletRequestCancel(int id) =>
      'customer/walletRequests/$id/cancel';

  static const String merchantRegister = 'merchant/register';
  static const String merchantRegisterVerifyOtp = 'merchant/register/verifyOtp';
  static const String merchantRegisterResendOtp = 'merchant/register/resendOtp';
  static const String merchantLogin = 'merchant/login';
  static const String merchantPasswordForgot = 'merchant/password/forgot';
  static const String merchantPasswordVerifyOtp = 'merchant/password/verifyOtp';
  static const String merchantPasswordReset = 'merchant/password/reset';

  static const String barberRegister = 'barber/register';
  static const String barberRegisterVerifyOtp = 'barber/register/verifyOtp';
  static const String barberRegisterResendOtp = 'barber/register/resendOtp';
  static const String barberLogin = 'barber/login';
  static const String barberPasswordForgot = 'barber/password/forgot';
  static const String barberPasswordVerifyOtp = 'barber/password/verifyOtp';
  static const String barberPasswordReset = 'barber/password/reset';
  static const String barberMe = 'barber';
  static const String barberLocation = 'barber/location';
  static const String barberPassword = 'barber/password';
  static const String barberServesClients = 'barber/servesClients';
  static const String barberPaymentMethod = 'barber/paymentMethod';

  static const String barberHours = 'barber/hours';

  static const String barberHomeService = 'barber/homeService';
  static const String barberHomeServiceHours = 'barber/homeService/hours';
  static const String barberHomeServiceRequest = 'barber/homeService/request';
  static String barberHomeServiceRequestById(int id) =>
      'barber/homeService/request/$id';
  static String barberHomeServiceRequestPrice(int id) =>
      'barber/homeService/request/$id/price';
  static String barberHomeServiceRequestAccept(int id) =>
      'barber/homeService/request/$id/accept';
  static String barberHomeServiceRequestReject(int id) =>
      'barber/homeService/request/$id/reject';
  static String barberHomeServiceRequestStatus(int id) =>
      'barber/homeService/request/$id/status';

  static const String barberHomeServiceBroadcast =
      'barber/homeService/broadcast';
  static String barberHomeServiceBroadcastRequest(int requestId) =>
      'barber/homeService/broadcast/request/$requestId';
  static String barberHomeServiceBroadcastAccept(int broadcastId) =>
      'barber/homeService/broadcast/$broadcastId/accept';
  static String barberHomeServiceBroadcastReject(int broadcastId) =>
      'barber/homeService/broadcast/$broadcastId/reject';

  static const String barberServiceCatalog = 'barber/service/catalog';
  static const String barberService = 'barber/service';
  static String barberServiceById(int id) => 'barber/service/$id';
  static const String barberOwnService = 'barber/service/own';
  static String barberOwnServiceById(int id) => 'barber/service/own/$id';

  static const String barberAttendance = 'barber/attendance';
  static const String barberAttendanceCurrent = 'barber/attendance/current';
  static const String barberAttendanceCheckIn = 'barber/attendance/checkIn';
  static const String barberAttendanceCheckOut = 'barber/attendance/checkOut';
  static const String barberAttendanceFeature = 'barber/attendanceFeature';
  static const String barberAttendanceFeatureRequest =
      'barber/attendanceFeature/request';
  static String barberAttendanceFeatureRequestCancel(int id) =>
      'barber/attendanceFeature/request/$id/cancel';
  static const String barberAttendanceSetting = 'barber/attendance/setting';
  static const String barberAttendanceSettingLog =
      'barber/attendance/setting/log';
  static const String barberAttendanceTeam = 'barber/attendance/team';
  static String barberAttendanceById(int id) => 'barber/attendance/$id';
  static const String barberTeam = 'barber/team';
  static String barberTeamById(int id) => 'barber/team/$id';
  static String barberTeamAvailability(int id) =>
      'barber/team/$id/availability';
  static String barberTeamActivate(int id) => 'barber/team/$id/activate';
  static String barberTeamPermissions(int id) => 'barber/team/$id/permissions';
  static String barberTeamPermanent(int id) => 'barber/team/$id/permanent';
  static String barberTeamMemberEarnings(int id) => 'barber/team/$id/earnings';
  static String barberTeamMemberClients(int id) => 'barber/team/$id/clients';
  static String barberTeamHours(int id) => 'barber/team/$id/hours';
  static String barberTeamSalary(int id) => 'barber/team/$id/salary';
  static String barberTeamCommission(int id) => 'barber/team/$id/commission';
  static const String barberSalary = 'barber/salary';
  static const String barberSalaryDeduction = 'barber/salaryDeduction';
  static const String barberSalaryDeductionPendingCount =
      'barber/salaryDeduction/pendingCount';
  static const String barberSalaryDeductionSetting =
      'barber/salaryDeduction/setting';
  static String barberTeamPassword(int id) => 'barber/team/$id/password';
  static String barberTeamService(int id) => 'barber/team/$id/service';
  static String barberTeamServiceCatalog(int id) =>
      'barber/team/$id/service/catalog';
  static String barberTeamServiceById(int id, int serviceId) =>
      'barber/team/$id/service/$serviceId';
  static const String barberEarnings = 'barber/earnings';

  static const String barberHaircutStyle = 'barber/haircutStyle';
  static String barberHaircutStyleById(int id) => 'barber/haircutStyle/$id';

  static const String barberAttachment = 'barber/attachment';
  static String barberAttachmentFile(int id) => 'barber/attachment/$id/file';

  static const String barberProfileImage = 'barber/profileImage';

  static const String barberStoreMerchant = 'barber/store/merchant';
  static String barberStoreMerchantProducts(int merchantId) =>
      'barber/store/merchant/$merchantId/product';
  static String barberStoreMerchantProductImage(
    int merchantId,
    int productId,
  ) => 'barber/store/merchant/$merchantId/product/$productId/image';
  static const String barberStoreProduct = 'barber/store/product';
  static String barberStoreProductImage(int productId) =>
      'barber/store/product/$productId/image';
  static const String barberStoreCategory = 'barber/store/category';
  static const String barberCart = 'barber/cart';
  static const String barberCartCheckout = 'barber/cart/checkout';
  static const String barberStoreQuote = 'barber/store/quote';
  static const String barberOrder = 'barber/order';
  static String barberOrderById(int id) => 'barber/order/$id';
  static String barberOrderCancel(int id) => 'barber/order/$id/cancel';

  static const String barberWallet = 'barber/wallet';
  static const String barberTransferAccount = 'barber/transferAccount';
  static const String barberWithdrawMethods =
      'barber/transferAccount/withdrawMethods';
  static const String barberWalletRequests = 'barber/walletRequests';
  static String barberWalletRequestById(int id) => 'barber/walletRequests/$id';
  static String barberWalletRequestAttachment(int id) =>
      'barber/walletRequests/$id/attachment';
  static String barberWalletRequestCancel(int id) =>
      'barber/walletRequests/$id/cancel';

  static const String barberMoneyItem = 'barber/money/item';
  static String barberMoneyItemById(int id) => 'barber/money/item/$id';
  static const String barberMoneyEntry = 'barber/money/entry';
  static const String barberMoneySummary = 'barber/money/summary';
  static const String barberMoneyOccurrencePending =
      'barber/money/occurrence/pending';
  static String barberMoneyOccurrenceConfirm(int id) =>
      'barber/money/occurrence/$id/confirm';
  static String barberMoneyOccurrenceDismiss(int id) =>
      'barber/money/occurrence/$id/dismiss';

  static const String barberMoneyPin = 'barber/moneyPin';
  static const String barberMoneyPinVerify = 'barber/moneyPin/verify';
  static const String barberMoneyPinResetRequest =
      'barber/moneyPin/resetRequest';

  static const String barberReview = 'barber/review';
  static const String barberRatingPending = 'barber/rating/pending';
  static const String barberRatingMerchant = 'barber/rating/merchant';

  static const String barberBooking = 'barber/booking';
  static const String barberBookingPending = 'barber/booking/pending';
  static const String barberBookingQueue = 'barber/booking/queue';
  static String barberBookingById(int id) => 'barber/booking/$id';
  static String barberBookingConfirm(int id) => 'barber/booking/$id/confirm';
  static String barberBookingReject(int id) => 'barber/booking/$id/reject';
  static String barberBookingStatus(int id) => 'barber/booking/$id/status';
  static const String barberBookingWalkin = 'barber/booking/walkin';
  static const String barberBookingWalkinOptions =
      'barber/booking/walkin/options';
  static const String barberBookingUnresolved = 'barber/booking/unresolved';
  static const String barberBookingSettle = 'barber/booking/settle';
  static String barberBookingBilling(int id) => 'barber/booking/$id/billing';

  static const String barberInvite = 'barber/invite';
  static const String barberInviteRegenerate = 'barber/invite/regenerate';

  static const String barberSponsorship = 'barber/sponsorship';

  static const String barberDrink = 'barber/drink';
  static String barberDrinkById(int id) => 'barber/drink/$id';

  static const String barberSubscription = 'barber/subscription';
  static const String barberSubscriptionPlan = 'barber/subscription/plan';
  static const String barberSubscriptionSubscribe =
      'barber/subscription/subscribe';
  static const String barberSubscriptionRequest = 'barber/subscription/request';

  static const String barberNotification = 'barber/notification';
  static const String barberNotificationUnseenCount =
      'barber/notification/unseenCount';
  static const String barberNotificationSeen = 'barber/notification/seen';
  static String barberNotificationSeenById(int id) =>
      'barber/notification/$id/seen';
  static String barberNotificationClickedById(int id) =>
      'barber/notification/$id/clicked';

  static const String barberDeviceToken = 'barber/deviceToken';
  static const String barberDeviceTokenAll = 'barber/deviceToken/all';

  static const String barberBroadcast = 'barber/broadcast';

  static const String barberStorefrontProduct = 'barber/storefront/product';
  static String barberStorefrontProductById(int id) =>
      'barber/storefront/product/$id';
  static String barberStorefrontProductStock(int id) =>
      'barber/storefront/product/$id/stock';
  static String barberStorefrontProductImage(int id) =>
      'barber/storefront/product/$id/image';
  static const String barberStorefrontCategory = 'barber/storefront/category';
  static const String barberStorefrontOwnCategory =
      'barber/storefront/category/own';
  static String barberStorefrontCategoryById(int id) =>
      'barber/storefront/category/$id';
  static String barberStorefrontCategoryImage(int id) =>
      'barber/storefront/category/$id/image';
  static const String barberStorefrontDelivery = 'barber/storefront/delivery';
  static const String barberStorefrontOrder = 'barber/storefront/order';
  static String barberStorefrontOrderById(int id) =>
      'barber/storefront/order/$id';
  static String barberStorefrontOrderAccept(int id) =>
      'barber/storefront/order/$id/accept';
  static String barberStorefrontOrderReject(int id) =>
      'barber/storefront/order/$id/reject';
  static String barberStorefrontOrderStatus(int id) =>
      'barber/storefront/order/$id/status';

  static const String barberDiscount = 'barber/discount';
  static String barberDiscountById(int id) => 'barber/discount/$id';
  static String barberDiscountClose(int id) => 'barber/discount/$id/close';

  static const String merchantMe = 'merchant';
  static const String merchantProfile = 'merchant/profile';
  static const String merchantLocation = 'merchant/location';
  static const String merchantPassword = 'merchant/password';
  static const String merchantPhone = 'merchant/phone';
  static String merchantPhoneById(int id) => 'merchant/phone/$id';

  static const String merchantDelivery = 'merchant/delivery';

  static const String merchantDashboard = 'merchant/dashboard';

  static const String merchantCategory = 'merchant/category';
  static const String merchantOwnCategory = 'merchant/category/own';
  static String merchantCategoryById(int id) => 'merchant/category/$id';
  static String merchantCategoryImage(int id) => 'merchant/category/$id/image';

  static const String merchantProduct = 'merchant/product';
  static String merchantProductById(int id) => 'merchant/product/$id';
  static String merchantProductStock(int id) => 'merchant/product/$id/stock';
  static String merchantProductImage(int id) => 'merchant/product/$id/image';
  static String merchantProductImageById(int id, int imageId) =>
      'merchant/product/$id/image/$imageId';

  static const String merchantOrder = 'merchant/order';
  static String merchantOrderById(int id) => 'merchant/order/$id';
  static String merchantOrderAccept(int id) => 'merchant/order/$id/accept';
  static String merchantOrderReject(int id) => 'merchant/order/$id/reject';
  static String merchantOrderStatus(int id) => 'merchant/order/$id/status';

  static const String merchantDiscount = 'merchant/discount';
  static const String merchantDiscountShop = 'merchant/discount/shop';
  static const String merchantDiscountQuote = 'merchant/discount/quote';
  static String merchantDiscountById(int id) => 'merchant/discount/$id';
  static String merchantDiscountClose(int id) => 'merchant/discount/$id/close';

  static const String merchantSale = 'merchant/sale';
  static const String merchantPaymentMethod = 'merchant/paymentMethod';
  static String merchantSaleById(int id) => 'merchant/sale/$id';
  static String merchantSaleCancel(int id) => 'merchant/sale/$id/cancel';
  static const String merchantMember = 'merchant/member';
  static const String merchantMemberMe = 'merchant/member/me';
  static const String merchantMemberMeHours = 'merchant/member/me/hours';
  static const String merchantMemberMePassword = 'merchant/member/me/password';
  static const String merchantMemberMeAttendance =
      'merchant/member/me/attendance';
  static const String merchantMemberMeAttendanceCurrent =
      'merchant/member/me/attendance/current';
  static const String merchantMemberMeCheckIn = 'merchant/member/me/checkIn';
  static const String merchantMemberMeCheckOut = 'merchant/member/me/checkOut';
  static const String merchantMemberAttendanceSetting =
      'merchant/member/attendance/setting';
  static const String merchantMemberAttendanceSettingLog =
      'merchant/member/attendance/setting/log';
  static const String merchantMemberAttendanceTeam =
      'merchant/member/attendance/team';
  static String merchantMemberAttendanceById(int id) =>
      'merchant/member/attendance/$id';
  static String merchantMemberAttendanceOf(int memberId) =>
      'merchant/member/$memberId/attendance';
  static String merchantMemberById(int id) => 'merchant/member/$id';
  static String merchantMemberSalary(int id) => 'merchant/member/$id/salary';
  static String merchantMemberPermissions(int id) =>
      'merchant/member/$id/permissions';
  static String merchantMemberHours(int id) => 'merchant/member/$id/hours';
  static String merchantMemberBlock(int id) => 'merchant/member/$id/block';
  static String merchantMemberActivate(int id) =>
      'merchant/member/$id/activate';
  static String merchantMemberResetPassword(int id) =>
      'merchant/member/$id/resetPassword';

  static const String merchantCustomer = 'merchant/customer';

  static const String merchantAttachment = 'merchant/attachment';
  static String merchantAttachmentFile(int id) =>
      'merchant/attachment/$id/file';

  static const String merchantNotification = 'merchant/notification';
  static const String merchantNotificationUnseenCount =
      'merchant/notification/unseenCount';
  static const String merchantNotificationSeen = 'merchant/notification/seen';
  static String merchantNotificationSeenById(int id) =>
      'merchant/notification/$id/seen';
  static String merchantNotificationClickedById(int id) =>
      'merchant/notification/$id/clicked';

  static const String merchantDeviceToken = 'merchant/deviceToken';
  static const String merchantDeviceTokenAll = 'merchant/deviceToken/all';

  static const String merchantSponsorship = 'merchant/sponsorship';

  static const String merchantSubscription = 'merchant/subscription';
  static const String merchantSubscriptionPlan = 'merchant/subscription/plan';
  static const String merchantSubscriptionSubscribe =
      'merchant/subscription/subscribe';
  static const String merchantSubscriptionRequest =
      'merchant/subscription/request';

  static const String merchantBroadcast = 'merchant/broadcast';

  static const String merchantWallet = 'merchant/wallet';
  static const String merchantTransferAccount = 'merchant/transferAccount';
  static const String merchantWithdrawMethods =
      'merchant/transferAccount/withdrawMethods';
  static const String merchantWalletRequests = 'merchant/walletRequests';
  static String merchantWalletRequestById(int id) =>
      'merchant/walletRequests/$id';
  static String merchantWalletRequestAttachment(int id) =>
      'merchant/walletRequests/$id/attachment';
  static String merchantWalletRequestCancel(int id) =>
      'merchant/walletRequests/$id/cancel';
}
