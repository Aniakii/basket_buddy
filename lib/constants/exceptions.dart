class AccountExistsException implements Exception {
  final String message;

  AccountExistsException(this.message);
}
