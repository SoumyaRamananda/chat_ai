import '../entities/user_entity.dart';

abstract class AuthRepository {
  UserEntity? getCurrentUser();

  Future<UserEntity> signInAnonymously();

  Future<UserEntity> signInWithGoogle();

  Future<UserEntity> linkWithGoogle();

  Future<UserEntity> signInWithApple();

  Future<void> signOut();
}
