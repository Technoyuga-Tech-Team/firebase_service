import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_service/src/authentication/auth.dart';
import 'package:firebase_service/src/models/auth_result.dart';

class EmailAuthentication extends EmailAuth {
  EmailAuthentication._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static EmailAuthentication get instance => EmailAuthentication._();

  @override
  Future<AuthResult> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(status: true, user: credential.user);
    } on FirebaseAuthException catch (e) {
      return exception(e);
    }
  }

  @override
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(status: true, user: credential.user);
    } on FirebaseAuthException catch (e) {
      return exception(e);
    }
  }

  @override
  Future<AuthResult> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const AuthResult(status: true);
    } on FirebaseAuthException catch (e) {
      return exception(e);
    }
  }

  @override
  Future<AuthResult> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      UserCredential? userCredential =
          await _reauthenticateWithCredential(password: oldPassword);
      await userCredential?.user?.updatePassword(newPassword);
      return const AuthResult(status: true);
    } on FirebaseAuthException catch (e) {
      return exception(e);
    }
  }

  @override
  Future<AuthResult> delete({required String password}) async {
    try {
      UserCredential? credential =
          await _reauthenticateWithCredential(password: password);
      await credential?.user?.delete();
      return const AuthResult(status: true);
    } on FirebaseAuthException catch (e) {
      return exception(e);
    }
  }

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<UserCredential>? _reauthenticateWithCredential(
      {required String password}) {
    final AuthCredential authCredential = EmailAuthProvider.credential(
      email: currentUser?.email ?? '',
      password: password,
    );
    return currentUser?.reauthenticateWithCredential(authCredential);
  }
}
