import 'package:firebase_auth_provider/models/custom_error.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:provider/provider.dart';

import '../providers/signup/signup_provider.dart';
import '../providers/signup/signup_state.dart';
import '../utils/error_dialog.dart';
import 'signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String routeName = '/signUn';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String?name, email,password; //= TextEditingController();
  final passwordController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    print('name: $name email: $email password: ${passwordController.text}');

    try {
      await context
          .read<SignUpProvider>()
          .signup(name:name!,email: email!, password: passwordController.text);
    } on CustomError catch (e) {
      errorDailog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInState = context.watch<SignUpProvider>().state;
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
                    Image.network('https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png'),
                     const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.people),
                      ),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name is required.';
                        }
                        if (value.trim().length<2) {
                          return 'Name must be at least more tha 2 character.';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        name = value;
                      },
                    ),
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
                      controller: passwordController,
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
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (String? value) {
                        if (passwordController.text != value) {
                          return 'Password not match.';
                        }
                        return null;
                      },
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          signInState.signupStatus == SignUpStatus.submitting
                              ? null
                              : _submit,
                      child: Text(
                          signInState.signupStatus == SignUpStatus.submitting
                              ? 'Loadding'
                              : 'Sign Up'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          signInState.signupStatus == SignUpStatus.submitting
                              ? null
                              : () {
                                  Navigator.pushNamed(
                                      context, SignInPage.routeName);
                                },
                      child: const Text('Sign In'),
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
