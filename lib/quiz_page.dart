import 'package:ck/ScreenArgument.dart';
import 'package:ck/notifiers/quiz_notifier.dart';
import 'package:ck/quiz_page/quiz_answer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'model/word.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
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

    return Consumer<QuizNotifier>(builder: (_, notifier, __) {
      final args = ModalRoute.of(context)!.settings.arguments as ScreenArgument;
      notifier.init(args.topicId);
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: () {
            if ((notifier.currQuestionIdx) >= notifier.lstSelectedWord.length) {
              return Column(
                children: [
                  Text("Correct " +
                      notifier.lstCorrectAnswer.length.toString() +
                      " in " +
                      notifier.lstSelectedWord.length.toString()),
                  Text("Correct words"),
                  Expanded(
                      flex: 4,
                      child: ListView.builder(
                          itemCount: notifier.lstCorrectAnswer.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                title: Text(notifier
                                    .lstCorrectAnswer[index].correctAnswer),
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
                                    Text("Correct answer: " +
                                        notifier.lstWrongAnswer[index]
                                            .correctAnswer),
                                    Spacer(),
                                    Text("Your answer: " +
                                        notifier
                                            .lstWrongAnswer[index].userAnswer)
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
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Row(
                                  children: [
                                    IconButton(onPressed: () {
                                      if(notifier.learningMode) {
                                        speak(notifier.word.firstLanguage, 'en-US');
                                      } else {
                                        speak(notifier.word.secondLanguage, 'vi-VN');
                                      }
                                    }, icon: Icon(Icons.speaker)),
                                    Spacer(),
                                    Text("en/vi"),
                                    Switch(
                                      onChanged: (value) {
                                        notifier.switchLearningMode();
                                      },
                                      value: notifier.learningMode,
                                    ),
                                    IconButton(onPressed: ( ) {
                                      notifier.shuffleQuestion();
                                    }, icon: Icon(
                                      Icons.shuffle
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Question " +
                              (notifier.currQuestionIdx + 1).toString() +
                              " in " +
                              notifier.lstSelectedWord.length.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "What is the meaning of this word?",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          notifier.learningMode
                              ? notifier.word.firstLanguage
                              : notifier.word.secondLanguage,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 56),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: (.8 / 1),
                          crossAxisCount: 2,
                          children: notifier.lstAnswer.map((answer) {
                            return QuizAnswerCard(answer: answer);
                          }).toList(),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          }(),
        ),
      );
    });
  }
}
