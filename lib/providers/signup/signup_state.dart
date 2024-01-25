import 'package:equatable/equatable.dart';

import 'package:firebase_auth_provider/models/custom_error.dart';

enum SignUpStatus { initial, submitting, success,failed }
class SignUpState extends Equatable {
  final SignUpStatus signupStatus;
  final CustomError error;
 const SignUpState({
    required this.signupStatus,
    required this.error,
  });

  factory SignUpState.initial(){
    return SignUpState(signupStatus: SignUpStatus.initial, error: CustomError());
  }


  @override
  List<Object> get props => [signupStatus, error];

  @override
  String toString() => 'SignUpState(signupStatus: $signupStatus, customError: $error)';

  SignUpState copyWith({
    SignUpStatus? signupStatus,
    CustomError? customError,
  }) {
    return SignUpState(
      signupStatus: signupStatus ?? this.signupStatus,
      error: customError ?? this.error,
    );
  }
}
