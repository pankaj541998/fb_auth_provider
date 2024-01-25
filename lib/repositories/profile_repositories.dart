import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_provider/constants/db_contstant.dart';
import 'package:firebase_auth_provider/models/custom_error.dart';

import '../models/user_model.dart';

class ProfileRepositories {
  final FirebaseFirestore firebaseFirestore;
  ProfileRepositories({
    required this.firebaseFirestore,
  });

  Future<User> getProfilr({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await userRef.doc(uid).get();
      final User currentUser = User.fromDoc(userDoc);
      return currentUser;
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, messgae: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          messgae: e.toString(),
          plugin: 'flutter_error/server_error');
    }
  }
}
