import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/models/user_model.dart';
import 'package:tasky/views/widgets/firebase_result.dart';

abstract class FirebaseTask {
  static CollectionReference<TaskModel> get _getCollection {
    final tokenUser = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection(UserModel.collection)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toJson(),
        )
        .doc(tokenUser)
        .collection(TaskModel.collection)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toJson(),
        );
  }

  static Future<FirebaseResult<void>> addTask(TaskModel task) async {
    try {
      final doc = _getCollection.doc();
      task.id = doc.id;
      await doc.set(task);
      return FirebaseSuccess(null);
    } catch (e) {
      return FirebaseError(e.toString());
    }
  }

  static Future<FirebaseResult<void>> updateTask(TaskModel task) async {
    try {
      final doc = _getCollection.doc(task.id);
      await doc.update(task.toJson());
      return FirebaseSuccess(null);
    } catch (e) {
      return FirebaseError(e.toString());
    }
  }

  static Future<FirebaseResult<void>> deleteTask(TaskModel task) async {
    try {
      final doc = _getCollection.doc(task.id);
      await doc.delete();
      return FirebaseSuccess(null);
    } catch (e) {
      return FirebaseError(e.toString());
    }
  }

  static Future<FirebaseResult<List<TaskModel>>> getTasks(DateTime date) async {
    final normalDate = DateTime(date.year, date.month, date.day);
    try {
      final querySnapshot = await _getCollection
          .where('date', isEqualTo: normalDate.millisecondsSinceEpoch)
          .get();
      final tasks = querySnapshot.docs
          .map<TaskModel>((doc) => doc.data())
          .toList();
      return FirebaseSuccess(tasks);
    } catch (e) {
      return FirebaseError(e.toString());
    }
  }
}
