import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];

  void getAllTasksFromFireStore() async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection().get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }
}
