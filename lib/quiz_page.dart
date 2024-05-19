import 'package:ck/ScreenArgument.dart';
import 'package:ck/notifiers/quiz_notifier.dart';
import 'package:ck/quiz_page/quiz_answer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

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
    late final QuizNotifier quizNotifier;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      quizNotifier = Provider.of<QuizNotifier>(context, listen: false);
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
    return Consumer<QuizNotifier>(builder: (_, notifier, __) {
      final args = ModalRoute.of(context)!.settings.arguments as ScreenArgument;
      notifier.init(args.topicId);
      print(notifier.isInitFinish);
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: () {
            if (notifier.isInitFinish) {
              if ((notifier.currQuestionIdx) >=
                  notifier.lstSelectedWord.length) {
                return Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                            "Correct ${notifier.lstCorrectAnswer.length} in ${notifier.lstSelectedWord.length}")),
                    const Text("Correct words"),
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
                    const Text("Incorrect words"),
                    Expanded(
                        flex: 4,
                        child: ListView.builder(
                            itemCount: notifier.lstWrongAnswer.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  title: Text(notifier
                                      .lstWrongAnswer[index].userAnswer),
                                ),
                              );
                            }))
                  ],
                );
              } else {
                return Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            if (notifier.learningMode) {
                                              speak(notifier.word.firstLanguage,
                                                  'en-US');
                                            } else {
                                              speak(
                                                  notifier.word.secondLanguage,
                                                  'vi-VN');
                                            }
                                          },
                                          icon: const Icon(Icons.speaker)),
                                      const Spacer(),
                                      const Text("en/vi"),
                                      Switch(
                                        onChanged: (value) {
                                          notifier.switchLearningMode();
                                        },
                                        value: notifier.learningMode,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            notifier.shuffleQuestion();
                                          },
                                          icon: const Icon(Icons.shuffle))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Question ${notifier.currQuestionIdx + 1} in ${notifier.lstSelectedWord.length}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          const Text(
                            "What is the meaning of this word?",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            notifier.learningMode
                                ? notifier.word.firstLanguage
                                : notifier.word.secondLanguage,
                            style: const TextStyle(
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
            } else {
              return Center(
                child: Text('Loading...'),
              );
            }
          }(),
        ),
      );
    });
  }
}
