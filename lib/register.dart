import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User?> registerUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "User email",
                  prefixIcon: Icon(Icons.mail, color: Colors.black,)
              ),
            ),
            SizedBox(
              height: 26,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.black,)
              ),
            ),TextFormField(
              decoration: InputDecoration(
                  hintText: "Confirm password",
                  prefixIcon: Icon(Icons.lock, color: Colors.black,)
              ),
            ),
            Text("forgot pass word?", style: TextStyle(color: Colors.blue),),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  onPressed: () {
                    registerUsingEmailPassword(email: emailController.text.trim(), password: passwordController.text.trim(), context: context);
                  },
                  child: Text("Register")
              ),
            )
          ],
        ),
      ),
    );
  }
}
