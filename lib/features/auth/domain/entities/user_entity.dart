import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final bool isAnonymous;
  final String? email;
  final String? displayName;

  const UserEntity({
    required this.uid,
    required this.isAnonymous,
    this.email,
    this.displayName,
  });

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      isAnonymous: isAnonymous,
      email: email,
      displayName: displayName,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        isAnonymous,
        email,
        displayName,
      ];
}
