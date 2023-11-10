import 'package:firebase_service/firebase_service.dart';
import 'package:firebase_service/src/authentication/auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as fb_ath;

class FacebookAuthentication extends FacebookAuth {
  FacebookAuthentication._();

  final fb_ath.FacebookAuth _facebookAuth = fb_ath.FacebookAuth.instance;

  static FacebookAuthentication get instance => FacebookAuthentication._();

  @override
  Future<AuthResult> signIn() async {
    AuthResult result = const AuthResult(status: false);
    try {
      final fb_ath.LoginResult loginResult = await _facebookAuth.login();
      if (loginResult.status == fb_ath.LoginStatus.success) {
        final fb_ath.AccessToken accessToken = loginResult.accessToken!;

        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        return result.copyWith(status: true, user: userCredential.user);
      } else {
        return result.copyWith(status: false, message: loginResult.message);
      }
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
      UserCredential? credential = await firebaseAuth.currentUser
          ?.reauthenticateWithProvider(FacebookAuthProvider());
      await credential?.user?.delete();
      return const AuthResult(status: true);
    } on FirebaseAuthException catch (e) {
      return exception(e);
    }
  }
}
