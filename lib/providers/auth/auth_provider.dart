import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import 'package:firebase_auth_provider/providers/auth/auth_state.dart';
import 'package:firebase_auth_provider/repositories/auth_repositories.dart';

class AuthProvider with ChangeNotifier {
  AuthState _state = AuthState.unkonwn();
  AuthState get state => _state;

  final AuthRepositories authRepositories;
  AuthProvider({
    required this.authRepositories,
  });
  void update (fbAuth.User? user){
    if(user != null){
      _state = _state.copyWith(authStatus: AuthStatus.authenticated,user:user);
    }else {
      _state = _state.copyWith(authStatus: AuthStatus.unAuthenticated,user:null);
    }
    log('autheticate status: ${_state}');
    notifyListeners();
  }

  void signOut() async{
    await authRepositories.signOut();
  }
}
