class EndPoints {
  static const String merchantRegister = 'merchant/register';
  static const String merchantLogin = 'merchant/login';

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
}
