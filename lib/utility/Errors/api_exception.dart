class ApiException implements Exception {
  String? errorMessage;
  int? statusCode;
  ApiException(this.errorMessage, this.statusCode);
}
