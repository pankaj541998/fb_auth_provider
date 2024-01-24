import 'package:equatable/equatable.dart';

import 'package:firebase_auth_provider/models/custom_error.dart';

enum SignInStatus { initial, submittin, success,failed }
class SignInAuth extends Equatable {
  final SignInStatus signinStatus;
  final CustomError customError;
  const SignInAuth({
    required this.signinStatus,
    required this.customError,
  });


  @override
  List<Object> get props => [signinStatus, customError];

  @override
  String toString() => 'SignInAuth(signinStatus: $signinStatus, customError: $customError)';

  SignInAuth copyWith({
    SignInStatus? signinStatus,
    CustomError? customError,
  }) {
    return SignInAuth(
      signinStatus: signinStatus ?? this.signinStatus,
      customError: customError ?? this.customError,
    );
  }
}
