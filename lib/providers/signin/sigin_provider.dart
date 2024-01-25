import 'package:firebase_auth_provider/models/custom_error.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth_provider/providers/signin/sigin_state.dart';
import 'package:firebase_auth_provider/repositories/auth_repositories.dart';

class SignInProvider extends ChangeNotifier {
  SignInState _state = SignInState.initial();
  SignInState get state => _state;

  final AuthRepositories authRepositories ;
  SignInProvider({
    required this.authRepositories,
  });


  Future<void> signin({required String email, required String password})async{
    _state = _state.copyWith(signinStatus: SignInStatus.submitting);
    notifyListeners();
    try {
      await authRepositories.signIn(email: email, password: password);
      _state =_state.copyWith(signinStatus: SignInStatus.success);
      notifyListeners();
      
    } on CustomError catch (e) {
      _state = _state.copyWith(signinStatus: SignInStatus.failed,customError: e);
      notifyListeners();
      rethrow;
    }
  }

}
