import 'package:ck/models/FolderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FolderRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> createFolder(FolderModel folderModel) async {
    DocumentReference docRef = await _db.collection('Folders').add(folderModel.toJson());
    return docRef.id;
  }
}