class AppException implements Exception {
  const AppException(this.cause, this.stackTrace);

  factory AppException.wrap(Object cause, StackTrace stackTrace) {
    if (cause is AppException) {
      return cause;
    } else {
      return AppException(cause, stackTrace);
    }
  }

  final StackTrace stackTrace;
  final Object? cause;

  @override
  String toString() {
    return 'AppException(cause: $cause)';
  }
}
