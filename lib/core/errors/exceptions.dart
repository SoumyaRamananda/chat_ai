class ServerException implements Exception {
  final String message;

  const ServerException([this.message = "Server error occurred"]);
}

class CacheException implements Exception {
  final String message;

  const CacheException([this.message = "Cache error occurred"]);
}

class NetworkException implements Exception {
  final String message;

  const NetworkException([this.message = "No internet connection"]);
}

class AuthException implements Exception {
  final String message;

  const AuthException([this.message = "Authentication failed"]);
}

class PermissionException implements Exception {
  final String message;

  const PermissionException([this.message = "Permission denied"]);
}

class UnknownException implements Exception {
  final String message;

  const UnknownException([this.message = "Unexpected error occurred"]);
}
