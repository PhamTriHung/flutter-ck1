import 'package:ck/Login.dart';
<<<<<<< HEAD
import 'package:ck/register.dart';
import 'package:ck/firebase_options.dart';
=======
import 'package:ck/flashcards_page.dart';
import 'package:ck/folder/app_home_screen.dart';
>>>>>>> be2ef0a78c65651c3497a55516d551ab17d9e3b2
import 'package:ck/notifiers/quiz_notifier.dart';
import 'package:ck/notifiers/topic_notifier.dart';
import 'package:ck/notifiers/typing_test_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifiers/flashcards_notifier.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

<<<<<<< HEAD
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlashcardNotifier()),
        ChangeNotifierProvider(create: (_) => QuizNotifier()),
        ChangeNotifierProvider(create: (_) => TypingTestNotifier())
      ],
      child: const MyApp(),
    ));
  });
=======
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FlashcardNotifier()),
      ChangeNotifierProvider(create: (_) => QuizNotifier()),
      ChangeNotifierProvider(create: (_) => TypingTestNotifier()),
      ChangeNotifierProvider(create: (_) => TopicNotifier())
    ],
    child: const MyApp(),
  ));
>>>>>>> be2ef0a78c65651c3497a55516d551ab17d9e3b2
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
=======
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              initialRoute: '/home',
              routes: {
                '/login': (context) => const LoginPage(),
                '/register': (context) => const RegisterPage(),
                '/quiz': (context) => const QuizPage(),
                '/flashcard': (context) => const FlashcardPages(),
                '/typing_test': (context) => const TypingPage(),
                '/home': (context) => const HomeScreen(),
              },
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const MyHomePage(title: 'Flutter Demo Home Page'),
            );
          }
          return MaterialApp();
        });
>>>>>>> be2ef0a78c65651c3497a55516d551ab17d9e3b2
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
