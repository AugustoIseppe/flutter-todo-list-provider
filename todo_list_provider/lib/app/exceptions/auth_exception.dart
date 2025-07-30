class AuthException {
  final String message;

  AuthException({required this.message});

  @override
  String toString() {
    return message;
  }
}
