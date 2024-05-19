import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/WordModel.dart';
import '../repository/topic_repository.dart';

class WordNotifier extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  bool isInitFinish = false;
  String topicId = '';
  List<WordModel> lstWord = [];
  final topicRepository = TopicRepository();

  WordNotifier() {
    isInitFinish = false;
    lstWord = [];
  }

  init(topicId) async {
    topicId = topicId;
    CollectionReference collection =
        _db.collection('Topics').doc(topicId).collection('Words');

    QuerySnapshot snapshot = await collection.get();

    if (!isInitFinish) {
      snapshot.docs.forEach((doc) {
        lstWord.add(WordModel(
            wordId: doc.id,
            description: doc['description'],
            english: doc['english'],
            illustration: doc['illustration'],
            pronunciation: doc['pronunciation'],
            vietnamese: doc['vietnamese']));
      });
    }
    isInitFinish = true;
    notifyListeners();
  }

  deleteWord(wordId) async {
    DocumentReference documentReference =
        _db.collection('Topics').doc(topicId).collection('Words').doc(wordId);
    documentReference.delete();
    init(topicId);
  }

  Future<void> addWordsToTopic(
      String topicId,
      bool isPulic,
      List<TextEditingController> termControllers,
      List<TextEditingController> definitionControllers) async {
    for (int i = 0; i < termControllers.length; i++) {
      WordModel word = WordModel(
          description: "Generated word",
          english: termControllers[i].text,
          vietnamese: definitionControllers[i].text,
          illustration: "",
          pronunciation: "");
      await topicRepository.addWordToTopic(topicId, word);
    }
  }
}
