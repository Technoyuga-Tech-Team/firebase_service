import 'package:firebase_service/firebase_service.dart';
import 'package:firebase_service/src/authentication/auth.dart';

class GuestAuthentication extends AnonymousAuth {
  GuestAuthentication._();

  static GuestAuthentication get instance => GuestAuthentication._();

  @override
  Future<AuthResult> signIn() async {
    AuthResult result = const AuthResult(status: false);
    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();

      User? user = userCredential.user;
      result = result.copyWith(status: true, user: user);
      return result;
    } on FirebaseAuthException catch (e) {
      return exception(e);
    } catch (e) {
      return result.copyWith(status: false, message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }

  @override
  Future<AuthResult> delete() async {
    try {
      await firebaseAuth.currentUser?.delete();
      return const AuthResult(status: true);
    } on FirebaseAuthException catch (e) {
      return exception(e);
    }
  }
}
