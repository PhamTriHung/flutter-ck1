import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ck/profile/edit_screen.dart';
import 'package:ck/profile/change_password.dart';
import 'package:ck/firebase/Current_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.animationController});

  final AnimationController? animationController;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic> userInfo;
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((querySnapshot) {
      _fetchUserInfo();
    });
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    final userInfo = await getUserInfo();
    setState(() {
      this.userInfo = userInfo;
      usernameController.text = userInfo['username'];
      nameController.text = userInfo['name'];
      emailController.text = userInfo['email'];
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://picsum.photos/200/200'),
            ),
            SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    readOnly: true,
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    readOnly: true,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Fullname',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    readOnly: true,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      // Navigate to the EditUserScreen
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditUserScreen()),
                      );
                    }
                  },
                  child: Text('Edit Information'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Navigate to the ChangePasswordScreen
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()),
                    );
                  },
                  child: Text('Change Password'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
