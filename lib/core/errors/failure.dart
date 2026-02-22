import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server failure"]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = "Cache failure"]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "No internet connection"]);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = "Authentication failure"]);
}

class PermissionFailure extends Failure {
  const PermissionFailure([super.message = "Permission denied"]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = "Unexpected failure"]);
}
