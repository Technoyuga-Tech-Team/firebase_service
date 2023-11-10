import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_service/src/models/auth_result.dart';
import 'package:firebase_service/src/utils/auth_error.dart';

abstract class Auth {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<AuthResult> signIn();

  Future<void> signOut();

  Future<AuthResult> delete();

  User? get currentUser => firebaseAuth.currentUser;
}

abstract class EmailAuth with AuthError {
  Future<AuthResult> signUp({required String email, required String password});

  Future<AuthResult> signIn({required String email, required String password});

  Future<AuthResult> sendPasswordResetEmail({required String email});

  Future<AuthResult> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<AuthResult> delete({required String password});

  Future<void> signOut();

  User? get currentUser;
}

abstract class GoogleAuth = Auth with AuthError;

abstract class FacebookAuth = Auth with AuthError;

abstract class AppleAuth = Auth with AuthError;

abstract class AnonymousAuth = Auth with AuthError;
