import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:provider/provider.dart';

import '../repositories/auth_repositories.dart';
import '../repositories/profile_repositories.dart';
import 'auth/auth_provider.dart';
import 'profile/profile_provider.dart';
import 'signin/sigin_provider.dart';
import 'signup/signup_provider.dart';

List providers = [
  [
        Provider<AuthRepositories>(create: (context) => AuthRepositories(firebaseFirestore: FirebaseFirestore.instance, firebaseAuth: fb_auth.FirebaseAuth.instance),),
        Provider<ProfileRepositories>(create: (context) => ProfileRepositories(firebaseFirestore: FirebaseFirestore.instance),),
        StreamProvider(create: (context) => context.read<AuthRepositories>().user, initialData: null),
        ChangeNotifierProxyProvider<fb_auth.User?, AuthProvider>(create: (context) => AuthProvider(authRepositories: context.read<AuthRepositories>()), update: (context, fb_auth.User? userStream, AuthProvider? authProvider) =>authProvider!..update(userStream) ,),
        ChangeNotifierProvider<SignInProvider>(create: (context) => SignInProvider(authRepositories: context.read<AuthRepositories>()),),
        ChangeNotifierProvider<SignUpProvider>(create: (context) => SignUpProvider(authRepositories: context.read<AuthRepositories>()),),
        ChangeNotifierProvider<ProfileProvider>(create: (context) => ProfileProvider(profileRepository: context.read<ProfileRepositories>()),),
      ]
];