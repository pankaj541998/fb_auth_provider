import 'package:equatable/equatable.dart';

import 'package:firebase_auth_provider/models/custom_error.dart';

enum SignInStatus { initial, submitting, success,failed }
class SignInState extends Equatable {
  final SignInStatus signinStatus;
  final CustomError error;
 const SignInState({
    required this.signinStatus,
    required this.error,
  });

  factory SignInState.initial(){
    return SignInState(signinStatus: SignInStatus.initial, error: CustomError());
  }


  @override
  List<Object> get props => [signinStatus, error];

  @override
  String toString() => 'SignInState(signinStatus: $signinStatus, customError: $error)';

  SignInState copyWith({
    SignInStatus? signinStatus,
    CustomError? customError,
  }) {
    return SignInState(
      signinStatus: signinStatus ?? this.signinStatus,
      error: customError ?? this.error,
    );
  }
}
