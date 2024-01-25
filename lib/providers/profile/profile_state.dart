import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth_provider/models/custom_error.dart';

import '../../models/user_model.dart';

enum ProfileStatus {
  initial,
  loading,
  loadded,
  error,
}

class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final User user;
  final CustomError customError;
  const ProfileState({
    required this.profileStatus,
    required this.user,
    required this.customError,
  });

  factory ProfileState.initial() {
    return ProfileState(
      profileStatus: ProfileStatus.initial,
      user: User.initailUser(),
      customError: const CustomError(),
    );
  }
  @override
  List<Object> get props => [profileStatus, user, customError];

  @override
  String toString() =>
      'ProfileState(profileStatus: $profileStatus, user: $user, customError: $customError)';

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    CustomError? customError,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      customError: customError ?? this.customError,
    );
  }
}
