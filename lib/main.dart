import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebase_auth_provider/pages/home_page.dart';
import 'package:firebase_auth_provider/pages/signup_page.dart';
import 'package:firebase_auth_provider/pages/splash_page.dart';
import 'package:firebase_auth_provider/providers/auth/auth_provider.dart';
import 'package:firebase_auth_provider/repositories/auth_repositories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/signin_page.dart';

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
        Provider<AuthRepositories>(create: (context) => AuthRepositories(firebaseFirestore: FirebaseFirestore.instance, firebaseAuth: fbAuth.FirebaseAuth.instance),),
        StreamProvider(create: (context) => context.read<AuthRepositories>().user, initialData: null),
        ChangeNotifierProxyProvider<fbAuth.User?, AuthProvider>(create: (context) => AuthProvider(authRepositories: context.read<AuthRepositories>()), update: (context, fbAuth.User? userStream, AuthProvider? authProvider) =>authProvider!..update(userStream) ,),
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
          SignUpPage.routeName:(context) => const SignUpPage(),
          SignInPage.routeName:(context) =>const SignInPage(),
          HomePage.routeName:(context) =>const HomePage(),
        },
      ),
    );
  }
}


