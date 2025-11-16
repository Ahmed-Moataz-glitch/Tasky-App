// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/models/user_model.dart';
import 'package:tasky/views/widgets/firebase_result.dart';

abstract class FirebaseAuthentication {
  static const String collection = 'users';

  static Future<FirebaseResult<UserModel>> register(UserModel user) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email ?? '',
            password: user.password ?? '',
          );
      user.id = credential.user?.uid;
      await _getCollection.doc(user.id).set(user);
      return FirebaseSuccess(user);
    } catch (e) {
      return FirebaseError(e.toString());
    }
  }

  static CollectionReference<UserModel> get _getCollection {
    return FirebaseFirestore.instance
        .collection(FirebaseAuthentication.collection)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toJson(),
        );
  }

  static Future<void> addUser(UserModel user) async {
    try {
      await _getCollection.doc(user.id).set(user);
    } catch (e) {
      throw 'Error from added user $e';
    }
  }

  static Future<FirebaseResult<UserCredential>> login({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return FirebaseSuccess(credential);
    } catch (e) {
      return FirebaseError(e.toString());
    }
  }
}
