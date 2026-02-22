import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/errors/exceptions.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  UserEntity? getCurrentUser() {
    final user = remoteDataSource.getCurrentUser();
    if (user == null) return null;
    final model = UserModel.fromFirebaseUser(user);
    return model.toEntity();
  }

  @override
  Future<UserEntity> signInAnonymously() async {
    try {
      final user = await remoteDataSource.signInAnonymously();
      final model = UserModel.fromFirebaseUser(user);
      return model.toEntity();
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (_) {
      throw const UnknownFailure();
    }
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      final user = await remoteDataSource.signInWithGoogle();
      final model = UserModel.fromFirebaseUser(user);
      return model.toEntity();
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (_) {
      throw const UnknownFailure();
    }
  }

  @override
  Future<UserEntity> linkWithGoogle() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;

      if (googleAuth == null) {
        throw Exception("Google auth failed");
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await currentUser!.linkWithCredential(credential);

      final user = userCredential.user!;

      final model = UserModel.fromFirebaseUser(user);

      return model.toEntity();
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<UserEntity> signInWithApple() async {
    try {
      final user = await remoteDataSource.signInWithApple();
      final model = UserModel.fromFirebaseUser(user);
      return model.toEntity();
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (_) {
      throw const UnknownFailure();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await remoteDataSource.signOut();
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (_) {
      throw const UnknownFailure();
    }
  }
}
