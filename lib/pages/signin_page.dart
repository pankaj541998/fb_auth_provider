import 'package:firebase_auth_provider/models/custom_error.dart';
import 'package:firebase_auth_provider/pages/signup_page.dart';
import 'package:firebase_auth_provider/providers/signin/sigin_provider.dart';
import 'package:firebase_auth_provider/providers/signin/sigin_state.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:provider/provider.dart';

import '../utils/error_dialog.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static const String routeName = '/signIn';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? email, password; //= TextEditingController();
  // final passwordController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    print('email: $email password: $password');

    try {
      await context
          .read<SignInProvider>()
          .signin(email: email!, password: password!);
    } on CustomError catch (e) {
      errorDailog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInState = context.watch<SignInProvider>().state;
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: ListView(
                  reverse: true,
                  shrinkWrap: true,
                  children: [
                    // Image.asset('assets/images/fluter_logo.png'),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required.';
                        }
                        if (!isEmail(value.trim())) {
                          return 'Enater Valid email';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        email = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Password required.';
                        }
                        if (value.trim().length < 6) {
                          return 'Password must be 6 characters long';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        password = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          signInState.signinStatus == SignInStatus.submitting
                              ? null
                              : _submit,
                      child: Text(
                          signInState.signinStatus == SignInStatus.submitting
                              ? 'Loadding'
                              : 'Sign In'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          signInState.signinStatus == SignInStatus.submitting
                              ? null
                              : () {
                                  Navigator.pushNamed(
                                    context,
                                    SignUpPage.routeName,
                                  );
                                },
                      child: const Text('Sign Up'),
                    )
                  ].reversed.toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
