import 'package:ck/ScreenArgument.dart';
import 'package:ck/notifiers/typing_test_notifier.dart';
import 'package:ck/result_bottom_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class TypingPage extends StatefulWidget {
  const TypingPage({super.key});

  @override
  State<TypingPage> createState() => _TypingPageState();
}

class _TypingPageState extends State<TypingPage> {
  FlutterTts flutterTts = FlutterTts();
  TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    late final TypingTestNotifier quizNotifier;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      quizNotifier = Provider.of<TypingTestNotifier>(context, listen: false);
      quizNotifier.isInitFinish = false;
      quizNotifier.currQuestionIdx = 0;
      quizNotifier.lstSelectedWord = [];
      quizNotifier.lstWrongAnswer = [];
      quizNotifier.lstCorrectAnswer = [];
    });
    super.initState();
  }

  Future<void> speak(String text, String language) async {
    await flutterTts.setLanguage(language);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.8);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TypingTestNotifier>(builder: (_, notifier, __) {
      final args = ModalRoute.of(context)!.settings.arguments as ScreenArgument;
      notifier.init(args.topicId);
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: () {
            if (notifier.currQuestionIdx >= notifier.lstSelectedWord.length) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Text("Correct " +
                          notifier.lstCorrectAnswer.length.toString() +
                          " in " +
                          notifier.lstSelectedWord.length.toString())),
                  Text("Correct words"),
                  Expanded(
                      flex: 4,
                      child: ListView.builder(
                          itemCount: notifier.lstCorrectAnswer.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(notifier
                                        .lstCorrectAnswer[index].correctAnswer),
                                  ],
                                ),
                              ),
                            );
                          })),
                  Text("Incorrect words"),
                  Expanded(
                      flex: 4,
                      child: ListView.builder(
                          itemCount: notifier.lstWrongAnswer.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(notifier
                                        .lstWrongAnswer[index].correctAnswer),
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            IconButton(onPressed: () {
                              if(notifier.learningMode) {
                                speak(notifier.word.secondLanguage, 'vi-VN');
                              } else {
                                speak(notifier.word.firstLanguage, 'en-US');
                              }
                            }, icon: Icon(Icons.speaker)),
                            Spacer(),
                            Text("en/vi"),
                            Switch(
                                onChanged: (value) {
                                  notifier.switchLearningMode();
                                },
                                value: notifier.learningMode),
                            IconButton(
                                onPressed: () {
                                  notifier.shuffleQuestion();
                                },
                                icon: Icon(Icons.shuffle))
                          ],
                        ),
                      ),
                      Text("Question " +
                          (notifier.currQuestionIdx + 1).toString() +
                          "/" +
                          notifier.lstSelectedWord.length.toString()),
                      const Text(
                        "What is the meaning of this word?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        notifier.learningMode
                            ? notifier.word.secondLanguage
                            : notifier.word.firstLanguage,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 56,
                        ),
                      ),
                      TextFormField(
                        controller: answerController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your answer here'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        notifier.answerQuestion(answer: answerController.text);
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ResultBottomModal(
                                  onNextQuestionClick: () {
                                    notifier.getNextQuestion();
                                    Navigator.pop(context);
                                  },
                                  isCorrect: notifier.isCorrect);
                            });
                        answerController.text = '';
                      },
                      child: const Text("Submit")),
                ],
              );
            }
          }(),
        ),
      );
    });
  }
}
