import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ck/models/TopicsModel.dart';
import 'package:ck/models/WordModel.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class TopicRepository extends GetxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> createTopic(TopicsModel topic) async {
    print(_db);
    DocumentReference docRef =
        await _db.collection('Topics').add(topic.toJson());
    return docRef.id; // Return the ID of the newly created topic
  }

  Future<void> addWordToTopic(String topicId, WordModel word) async {
    await _db
        .collection('Topics')
        .doc(topicId)
        .collection('Words')
        .add(word.toJson());
  }
}
