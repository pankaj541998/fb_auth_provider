import 'package:firebase_auth_provider/models/custom_error.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_provider/repositories/auth_repositories.dart';

import 'signup_state.dart';

class SignUpProvider extends ChangeNotifier {
  SignUpState _state = SignUpState.initial();
  SignUpState get state => _state;

  final AuthRepositories authRepositories ;
  SignUpProvider({
    required this.authRepositories,
  });


  Future<void> signup({required String name,required String email, required String password})async{
    _state = _state.copyWith(signupStatus: SignUpStatus.submitting);
    notifyListeners();
    try {
      await authRepositories.signUp(name:name,email: email, password: password);
      _state =_state.copyWith(signupStatus: SignUpStatus.success);
      notifyListeners();
      
    } on CustomError catch (e) {
      _state = _state.copyWith(signupStatus: SignUpStatus.failed,customError: e);
      notifyListeners();
      rethrow;
    }
  }

}
