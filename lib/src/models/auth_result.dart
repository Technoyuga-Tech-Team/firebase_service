import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final bool status;
  final String? message;
  final User? user;

  const AuthResult({
    required this.status,
    this.message,
    this.user,
  });

  AuthResult copyWith({
    bool? status,
    String? message,
    User? user,
  }) {
    return AuthResult(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'AuthResult('
        'status: $status, '
        'message: $message, '
        'user: $user)';
  }
}
