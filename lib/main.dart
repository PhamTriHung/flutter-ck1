import 'package:ck/CreateTopicInFolder.dart';
import 'package:ck/Login.dart';
import 'package:ck/add_word.dart';
import 'package:ck/create_folder_with_topic.dart';
import 'package:ck/create_topic_with_workds.dart';
import 'package:ck/list_topic_in_folder.dart';
import 'package:ck/notifiers/folder_notifier.dart';
import 'package:ck/register.dart';
import 'package:ck/forgot.dart';
import 'package:ck/firebase_options.dart';
import 'package:ck/firebase/Current_user.dart';
import 'package:ck/flashcards_page.dart';
import 'package:ck/folder/app_home_screen.dart';
import 'package:ck/list_word_page.dart';
import 'package:ck/notifiers/quiz_notifier.dart';
import 'package:ck/notifiers/topic_notifier.dart';
import 'package:ck/notifiers/typing_test_notifier.dart';
import 'package:ck/notifiers/word_notifier.dart';
import 'package:ck/typing_test_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifiers/flashcards_notifier.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'quiz_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FlashcardNotifier()),
      ChangeNotifierProvider(create: (_) => QuizNotifier()),
      ChangeNotifierProvider(create: (_) => TypingTestNotifier()),
      ChangeNotifierProvider(create: (_) => TopicNotifier()),
      ChangeNotifierProvider(create: (_) => WordNotifier()),
      ChangeNotifierProvider(create: (_) => FolderNotifier()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              initialRoute: isUserLoggedIn() ? '/home' : '/login',
              routes: {
                '/login': (context) => const LoginPage(),
                '/forgot': (context) => const ForgotScreen(),
                '/register': (context) => const RegisterPage(),
                '/quiz': (context) => const QuizPage(),
                '/flashcard': (context) => const FlashcardPages(),
                '/typing_test': (context) => const TypingPage(),
                '/home': (context) => const HomeScreen(),
                '/list_word': (context) => const ListWordPage(),
                '/add_word': (context) => const AddWordPage(),
                '/add_topic': (context) => const CreateTopicWithWords(),
                '/create_folder_with_topic': (context) =>
                    const CreateFolderWithTopic(),
                '/list_topics_in_folder': (context) =>
                    const ListTopicInFolder(),
                '/add_topic_to_folder': (context) => CreateTopicInFolderPage()
              },
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              // home: const MyHomePage(title: 'Flutter Demo Home Page'),
            );
          }
          return const MaterialApp();
        });
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
