class EndPoints {
  static const String merchantRegister = 'merchant/register';
  static const String merchantLogin = 'merchant/login';

  static const String barberLogin = 'barber/login';
  static const String barberMe = 'barber/me';
  static const String barberLocation = 'barber/location';
  static const String barberPassword = 'barber/password';

  static const String barberHours = 'barber/hours';

  static const String barberServiceCatalog = 'barber/service/catalog';
  static const String barberService = 'barber/service';
  static String barberServiceById(int id) => 'barber/service/$id';

  static const String barberTeam = 'barber/team';
  static String barberTeamById(int id) => 'barber/team/$id';
  static String barberTeamAvailability(int id) => 'barber/team/$id/availability';
  static String barberTeamPassword(int id) => 'barber/team/$id/password';
  static String barberTeamActivate(int id) => 'barber/team/$id/activate';
  static String barberTeamHours(int id) => 'barber/team/$id/hours';
  static String barberTeamService(int id) => 'barber/team/$id/service';
  static String barberTeamServiceCatalog(int id) =>
      'barber/team/$id/service/catalog';
  static String barberTeamServiceById(int id, int serviceId) =>
      'barber/team/$id/service/$serviceId';
  static const String barberEarnings = 'barber/earnings';

  static const String barberAttachment = 'barber/attachment';
  static String barberAttachmentFile(int id) => 'barber/attachment/$id/file';

  static const String barberStoreMerchant = 'barber/store/merchant';
  static String barberStoreMerchantProducts(int merchantId) =>
      'barber/store/merchant/$merchantId/product';
  static const String barberStoreQuote = 'barber/store/quote';
  static const String barberOrder = 'barber/order';
  static String barberOrderById(int id) => 'barber/order/$id';
  static String barberOrderCancel(int id) => 'barber/order/$id/cancel';

  static const String barberWallet = 'barber/wallet';

  static const String barberReview = 'barber/review';

  static const String barberBooking = 'barber/booking';
  static const String barberBookingPending = 'barber/booking/pending';
  static const String barberBookingQueue = 'barber/booking/queue';
  static String barberBookingById(int id) => 'barber/booking/$id';
  static String barberBookingConfirm(int id) => 'barber/booking/$id/confirm';
  static String barberBookingReject(int id) => 'barber/booking/$id/reject';
  static String barberBookingStatus(int id) => 'barber/booking/$id/status';
  static const String barberBookingWalkin = 'barber/booking/walkin';

  static const String barberInvite = 'barber/invite';
  static const String barberInviteRegenerate = 'barber/invite/regenerate';

  static const String barberNotification = 'barber/notification';
  static const String barberNotificationUnseenCount =
      'barber/notification/unseen_count';
  static const String barberNotificationSeen = 'barber/notification/seen';
  static String barberNotificationSeenById(int id) =>
      'barber/notification/$id/seen';
  static String barberNotificationClickedById(int id) =>
      'barber/notification/$id/clicked';

  static const String barberDeviceToken = 'barber/device_token';
  static const String barberDeviceTokenAll = 'barber/device_token/all';

  static const String barberStorefrontProduct = 'barber/storefront/product';
  static String barberStorefrontProductById(int id) =>
      'barber/storefront/product/$id';
  static String barberStorefrontProductStock(int id) =>
      'barber/storefront/product/$id/stock';
  static const String barberStorefrontCategory = 'barber/storefront/category';
  static const String barberStorefrontOwnCategory =
      'barber/storefront/category/own';
  static String barberStorefrontCategoryById(int id) =>
      'barber/storefront/category/$id';
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

  static const String merchantProfile = 'merchant/profile';
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

  static const String merchantAttachment = 'merchant/attachment';
  static String merchantAttachmentFile(int id) =>
      'merchant/attachment/$id/file';

  static const String merchantNotification = 'merchant/notification';
  static const String merchantNotificationUnseenCount =
      'merchant/notification/unseen_count';
  static const String merchantNotificationSeen = 'merchant/notification/seen';
  static String merchantNotificationSeenById(int id) =>
      'merchant/notification/$id/seen';
  static String merchantNotificationClickedById(int id) =>
      'merchant/notification/$id/clicked';

  static const String merchantDeviceToken = 'merchant/device_token';
  static const String merchantDeviceTokenAll = 'merchant/device_token/all';
}
