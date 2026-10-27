class QuickexApiConfig {
  QuickexApiConfig._();

  static const String _baseUrl = 'https://quickex.io/api';

  static const String instrumentsPublic = '$_baseUrl/v2/instruments/public';
  static const String instrumentsValidateAddress = '$_baseUrl/v1/instruments/public/validate-address';
  static const String pairsPublic = '$_baseUrl/v2/pairs/public';
  static const String ratesPublicOne = '$_baseUrl/v2/rates/public/one';
  static const String createOrder = '$_baseUrl/v2/orders/public/create';
  static const String orderInfo = '$_baseUrl/v2/orders/public-info';
  static const String ordersList = '$_baseUrl/v2/orders/public';
  static const String setOrderEmail = '$_baseUrl/v2/orders/public/set-email';
}
