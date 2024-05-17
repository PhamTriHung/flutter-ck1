import 'package:ck/notifiers/quiz_notifier.dart';
import 'package:ck/result_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizAnswerCard extends StatelessWidget {
  const QuizAnswerCard({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizNotifier>(builder: (_, notifier, __) {
      return GestureDetector(
        onTap: () {
          notifier.handleAnswer(answer);
          showModalBottomSheet(context: context, builder: (context) {
            return ResultBottomModal(onNextQuestionClick: () {
              notifier.getNextQuestion();
              Navigator.pop(context);
            }, isCorrect: notifier.isCorrect);
          });
        },
        child: Card(
          child: Center(
            child: Text(answer),
          ),
        ),
      );
    }) ;
  }
}
