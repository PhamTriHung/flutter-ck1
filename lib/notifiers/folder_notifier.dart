import 'package:ck/models/FolderModel.dart';
import 'package:ck/models/TopicsModel.dart';
import 'package:ck/repository/folder_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FolderNotifier extends ChangeNotifier {
  final folderRepository = FolderRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<void> saveFolderWithTopics(
      String folderName, List<TextEditingController> topicsController) async {
    String? email = _auth.currentUser?.email;
    if (email == null) {
      return;
    }

    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";

    FolderModel folderModel = FolderModel(
        name: folderName,
        description: 'Generated description',
        creatorId: email);

    String folderID = await folderRepository.createFolder(folderModel);

    for (int i = 0; i < topicsController.length; i++) {
      TopicsModel topicsModel = TopicsModel(
          name: topicsController[i].text,
          description: "Generated description",
          creationDate: formattedDate,
          lastAccessed: formattedDate,
          creatorId: email,
          public: true);
      folderRepository.addTopicToFolder(folderID, topicsModel);
    }
  }

  Stream<List<Map<String, dynamic>>> fetchFoldersStream() {
    var email = FirebaseAuth.instance.currentUser?.email;
    return _db
        .collection('Folders')
        .where('creatorId', isEqualTo: email)
        .snapshots()
        .asyncMap((snapshot) async {
          List<Map<String, dynamic>> folderList = [];
          for (var doc in snapshot.docs) {
            var topicQuerySnapshot = await doc.reference.collection('Topics').get();
            folderList.add({
              'folderId': doc.id,
              'name': doc['name'],
              'topics': topicQuerySnapshot.docs.map((topicDoc) => topicDoc.data()).toList(),
            });
          }
          return folderList;
    });
  }

  void deleteFolder(folderId) {
    _db.collection('Folders').doc(folderId).delete();
  }
}
