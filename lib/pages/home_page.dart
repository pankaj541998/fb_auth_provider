import 'package:firebase_auth_provider/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../providers/auth/auth_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Home'),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<AuthProvider>().signOut();
                },
                icon: const Icon(Icons.exit_to_app),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                icon: const Icon(Icons.account_circle),
              ),
            ],
          ),
          body: const Center(
            child: Text('Welcome Dear '),
          ),
        ));
  }
}
