import 'package:apple_sign_in_safety/apple_sign_in.dart'
    show PersonNameComponents;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_service/src/models/auth_result.dart';

class AppleAuthResult extends AuthResult {
  final PersonNameComponents? fullName;

  const AppleAuthResult({
    this.fullName,
    required super.status,
    super.message,
    super.user,
  });

  @override
  AppleAuthResult copyWith({
    bool? status,
    String? message,
    User? user,
    PersonNameComponents? fullName,
  }) {
    return AppleAuthResult(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  String toString() {
    return 'AppleAuthResult('
        'status: $status, '
        'message: $message, '
        'user: $user,'
        'fullName: $fullName)';
  }
}
