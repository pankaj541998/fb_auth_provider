import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_auth_provider/constants/db_contstant.dart';
import 'package:firebase_auth_provider/models/custom_error.dart';

class AuthRepositories {
  final FirebaseFirestore firebaseFirestore;
  final fb_auth.FirebaseAuth firebaseAuth;
  AuthRepositories({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Stream<fb_auth.User?> get user => firebaseAuth.userChanges();

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final fb_auth.UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final signedInUser = userCredential.user!;
      await userRef.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
        'profileImage': 'https://picsum.photo/300',
        'point': 0,
        'rank': 'bronze'
      });
    } on fb_auth.FirebaseException catch (e) {
      throw CustomError(code: e.code, messgae: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          messgae: e.toString(),
          plugin: 'flutter_error/server_error');
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on fb_auth.FirebaseException catch (e) {
      throw CustomError(code: e.code, messgae: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          messgae: e.toString(),
          plugin: 'flutter_error/server_error');
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
