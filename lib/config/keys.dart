class Keys {
  static final String account = "account";
  static final String keyGuide = "keyGuide";
  static const bool inProduction  = const bool.fromEnvironment('dart.vm.product');

  static bool isTest  = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const String phone = 'phone';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String theme = 'AppTheme';
}
