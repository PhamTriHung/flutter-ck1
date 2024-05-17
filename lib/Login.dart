import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<LoginPage> createState() => _LogomPageState();
}

class _LogomPageState extends State<LoginPage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                  hintText: "User email",
                  prefixIcon: Icon(Icons.mail, color: Colors.black,)
              ),
            ),
            SizedBox(
              height: 26,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.black,)
              ),
            ),
            Text("forgot pass word?", style: TextStyle(color: Colors.blue),),
            GestureDetector(
              child: Text("Do not have account yet?", style: TextStyle(color: Colors.blue),),
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  onPressed: () {},
                  child: Text("Login")
              ),
            )

          ],

        ),
      ),
    );
  }
}
