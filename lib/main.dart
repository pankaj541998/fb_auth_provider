import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_auth_provider/pages/home_page.dart';
import 'package:firebase_auth_provider/pages/signup_page.dart';
import 'package:firebase_auth_provider/pages/splash_page.dart';
import 'package:firebase_auth_provider/providers/auth/auth_provider.dart';
import 'package:firebase_auth_provider/providers/profile/profile_provider.dart';
import 'package:firebase_auth_provider/providers/signin/sigin_provider.dart';
import 'package:firebase_auth_provider/repositories/auth_repositories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/signin_page.dart';
import 'providers/providers.dart';
import 'providers/signup/signup_provider.dart';
import 'repositories/profile_repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepositories>(
          create: (context) => AuthRepositories(
              firebaseFirestore: FirebaseFirestore.instance,
              firebaseAuth: fb_auth.FirebaseAuth.instance),
        ),
        Provider<ProfileRepositories>(
          create: (context) => ProfileRepositories(
              firebaseFirestore: FirebaseFirestore.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AuthRepositories>().user,
            initialData: null),
        ChangeNotifierProxyProvider<fb_auth.User?, AuthProvider>(
          create: (context) =>
              AuthProvider(authRepositories: context.read<AuthRepositories>()),
          update:
              (context, fb_auth.User? userStream, AuthProvider? authProvider) =>
                  authProvider!..update(userStream),
        ),
        ChangeNotifierProvider<SignInProvider>(
          create: (context) => SignInProvider(
              authRepositories: context.read<AuthRepositories>()),
        ),
        ChangeNotifierProvider<SignUpProvider>(
          create: (context) => SignUpProvider(
              authRepositories: context.read<AuthRepositories>()),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(
              profileRepository: context.read<ProfileRepositories>()),
        ),
      ],
      child: MaterialApp(
        title: 'Auth Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashPage(),
        routes: {
          SignUpPage.routeName: (context) => const SignUpPage(),
          SignInPage.routeName: (context) => const SignInPage(),
          HomePage.routeName: (context) => const HomePage(),
        },
      ),
    );
  }
}
