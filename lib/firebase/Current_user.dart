import 'package:ck/model/Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool isUserLoggedIn() {
  return FirebaseAuth.instance.currentUser != null;
}

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

Future<void> logOut() async {
  try {
    // Đăng xuất người dùng
    await FirebaseAuth.instance.signOut();
    print('Đăng xuất thành công!');
  } catch (e) {
    print('Lỗi khi đăng xuất: $e');
  }
}

Future<bool> verifyCurrentPassword(String currentPassword) async {
  try {
    // Lấy thông tin người dùng hiện tại
    User? user = FirebaseAuth.instance.currentUser;

    // Xác thực người dùng với mật khẩu hiện tại
    AuthCredential credential = EmailAuthProvider.credential(
        email: user?.email ?? '', password: currentPassword);
    await user?.reauthenticateWithCredential(credential);

    // Nếu không gặp lỗi, tức là mật khẩu đúng
    return true;
  } catch (e) {
    // Nếu có lỗi, tức là mật khẩu sai
    return false;
  }
}

Future<void> changePassword(String newPassword) async {
  try {
    // Lấy thông tin người dùng hiện tại
    final user = FirebaseAuth.instance.currentUser;

    // Cập nhật mật khẩu mới
    await user?.updatePassword(newPassword);
    print('Mật khẩu đã được thay đổi thành công!');
  } catch (e) {
    print('Lỗi khi thay đổi mật khẩu: $e');
  }
}
