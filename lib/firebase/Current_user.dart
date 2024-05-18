import 'package:ck/model/Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>> getUserInfo() async {
  try {
    // Lấy thông tin người dùng hiện tại từ Firebase Authentication
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Lấy thông tin người dùng từ Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data()!;
        return {
          'id': userData['id'],
          'name': userData['name'],
          'username': userData['username'],
          'email': currentUser.email,
        };
      }
    }
  } catch (e) {
    print('Error getting user info: $e');
  }
  return {
    'id': '',
    'name': '',
    'username': '',
    'email': '',
  };
}

Future<void> update({required Users user}) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update(user.toJson());
  } catch (e) {
    print('Error updating user info: $e');
  }
}
