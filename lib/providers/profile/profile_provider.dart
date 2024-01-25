import 'package:firebase_auth_provider/models/custom_error.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth_provider/providers/profile/profile_state.dart';
import 'package:firebase_auth_provider/repositories/profile_repositories.dart';

import '../../models/user_model.dart';

class ProfileProvider with ChangeNotifier {

  ProfileState _state = ProfileState.initial();
  ProfileState get state=>_state;

  final ProfileRepositories profileRepository;
  ProfileProvider({
    required this.profileRepository,
  });

  Future<void> getProfile({required String uid}) async{
    _state = _state.copyWith(profileStatus: ProfileStatus.loading);
    notifyListeners();

    try {
      final User user = await profileRepository.getProfilr(uid: uid);
      _state =_state.copyWith(profileStatus: ProfileStatus.loadded,user: user);
      notifyListeners();
      
    }on CustomError catch (e) {
      _state= _state.copyWith(profileStatus: ProfileStatus.error,customError: e);
      notifyListeners();
      
    }
  }


}
