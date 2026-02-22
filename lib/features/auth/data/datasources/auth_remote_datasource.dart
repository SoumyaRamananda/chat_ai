import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/errors/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<User> signInAnonymously();

  Future<User> signInWithGoogle();

  Future<User> linkWithGoogle();

  Future<User> signInWithApple();

  Future<void> signOut();

  User? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  @override
  Future<User> signInAnonymously() async {
    try {
      final credential = await _auth.signInAnonymously();
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? "Anonymous sign-in failed");
    } catch (_) {
      throw const UnknownException();
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw const AuthException("Google sign-in cancelled");
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);

      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? "Google sign-in failed");
    } catch (_) {
      throw const UnknownException();
    }
  }

  @override
  Future<User> linkWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw const AuthException("Google linking cancelled");
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _auth.currentUser!.linkWithCredential(credential);

      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? "Google linking failed");
    } catch (_) {
      throw const UnknownException();
    }
  }

  @override
  Future<User> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final result = await _auth.signInWithCredential(oauthCredential);

      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? "Apple sign-in failed");
    } catch (_) {
      throw const UnknownException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (_) {
      throw const AuthException("Sign out failed");
    }
  }
}
