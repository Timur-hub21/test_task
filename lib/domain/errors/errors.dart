abstract class Errors {
  final String message;
  const Errors([this.message = "An unexpected error occurred"]);
}

// Network-related errors
class NetworkError extends Errors {
  const NetworkError([super.message = "No internet connection"]);
}

// Server returned an error response
class ServerError extends Errors {
  final int statusCode;
  const ServerError(this.statusCode, [String message = "Server error"]) : super(message);
}

// Not found / 404
class NotFoundError extends Errors {
  const NotFoundError([super.message = "Resource not found"]);
}

// Generic / unknown error
class UnknownError extends Errors {
  const UnknownError([super.message = "Unknown error occurred"]);
}
