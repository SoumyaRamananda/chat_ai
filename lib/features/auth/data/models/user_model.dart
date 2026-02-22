import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final bool isAnonymous;
  final String? email;
  final String? displayName;

  UserModel({
    required this.uid,
    required this.isAnonymous,
    this.email,
    this.displayName,
  });

  /// Convert Firebase User to UserModel
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      isAnonymous: user.isAnonymous,
      email: user.email,
      displayName: user.displayName,
    );
  }

  /// Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'isAnonymous': isAnonymous,
      'email': email,
      'displayName': displayName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      isAnonymous: map['isAnonymous'],
      email: map['email'],
      displayName: map['displayName'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      isAnonymous: isAnonymous,
      email: email,
      displayName: displayName,
    );
  }
}
