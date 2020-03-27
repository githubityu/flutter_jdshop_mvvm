class ApiException implements Exception {
  final String message;

  final int code;

  const ApiException([this.code, this.message = ""]);
}
