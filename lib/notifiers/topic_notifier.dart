import 'package:ck/repository/topic_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/TopicsModel.dart';
import '../models/WordModel.dart';

class TopicNotifier extends ChangeNotifier {
  final topicRepository = TopicRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveTopicWithWords(
      String topicName,
      bool isPublic,
      List<TextEditingController> termControllers,
      List<TextEditingController> definitionControllers) async {
    String? email = _auth.currentUser?.email;
    if (email == null) {
      // Get.snackbar("Error", "User is not logged in",
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white);
      return;
    }

    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";

    TopicsModel newTopic = TopicsModel(
      name: topicName,
      description: "Generated programmatically",
      creatorId: email,
      creationDate: formattedDate,
      lastAccessed: formattedDate,
      public: isPublic, // Setting the public attribute based on the switch
    );

    try {
      String topicId = await topicRepository.createTopic(newTopic);
      for (int i = 0; i < termControllers.length; i++) {
        WordModel word = WordModel(
            description: "Generated word",
            english: termControllers[i].text,
            vietnamese: definitionControllers[i].text,
            illustration: "",
            pronunciation: "");
        await topicRepository.addWordToTopic(topicId, word);
      }
      // Get.snackbar("Success", "Topic and words added successfully",
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.green,
      //     colorText: Colors.white);
    } catch (e) {
      // Get.snackbar("Error", "Failed to create topic and words: $e",
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white);
    }
  }

  Stream<List<Map<String, dynamic>>> fetchCoursesStream() {
    var email = FirebaseAuth.instance.currentUser?.email;
    return FirebaseFirestore.instance
        .collection('Topics')
        .where('creatorId', isEqualTo: email)
        .snapshots()
        .asyncMap((snapshot) async {
      List<Map<String, dynamic>> coursesList = [];
      for (var doc in snapshot.docs) {
        var wordsQuerySnapshot = await doc.reference.collection('Words').get();
        print(doc.reference.id);
        print(wordsQuerySnapshot);
        var wordCount = await doc.reference
            .collection('Words')
            .get()
            .then((snap) => snap.size);
        coursesList.add({
          "courseId": doc.reference.id,
          "courseName": doc['name'],
          "termCount": wordCount,
          "addedBy": doc['creatorId'],
          "words":
              wordsQuerySnapshot.docs.map((wordDoc) => wordDoc.data()).toList(),
        });
      }
      return coursesList;
    });
  }
}
