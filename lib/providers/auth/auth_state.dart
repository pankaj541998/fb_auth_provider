import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

enum AuthStatus { unkonwn, authenticated, unAuthenticated }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final fbAuth.User? user;
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
    fbAuth.User? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }
}
