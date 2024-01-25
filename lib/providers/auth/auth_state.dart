import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

enum AuthStatus { unkonwn, authenticated, unAuthenticated }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final fb_auth.User? user;
  const AuthState({
    required this.authStatus,
    this.user,
  });

  factory AuthState.unkonwn() {
    return const AuthState(authStatus: AuthStatus.unkonwn);
  }

  @override
  String toString() => 'AuthState(authStatus: $authStatus, user: $user)';

  @override
  List<Object?> get props => [authStatus, user];

  AuthState copyWith({
    AuthStatus? authStatus,
    fbAfb_authuth.User? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }
}
