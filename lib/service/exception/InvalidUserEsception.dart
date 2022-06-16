class InvalidUserException implements Exception {
  String message;

  InvalidUserException(this.message);

  @override
  String toString() {
    return message;
  }
}
