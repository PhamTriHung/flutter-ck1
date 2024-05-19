import 'dart:math';

import 'package:ck/model/answer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/word.dart';

class QuizNotifier extends ChangeNotifier {
  bool isCorrect = false;
  bool isInitFinish = false;
  List<Word> lstSelectedWord = [
  ];
  int currQuestionIdx = 0;
  bool learningMode = false;
  late Word word = lstSelectedWord[0];
  late List<String> lstAnswer;
  List<Answer> lstCorrectAnswer = [];
  List<Answer> lstWrongAnswer = [];
  FirebaseFirestore _db = FirebaseFirestore.instance;

  randomAnswer() {
    Random random = Random();
    lstAnswer = [];

    lstAnswer.add(learningMode
        ? lstSelectedWord[currQuestionIdx].secondLanguage
        : lstSelectedWord[currQuestionIdx].firstLanguage);

    while (lstAnswer.length < 4) {
      var idx = random.nextInt(lstSelectedWord.length);
      var value = lstSelectedWord[idx];
      if (!lstAnswer.contains(
          learningMode ? value.secondLanguage : value.firstLanguage)) {
        lstAnswer
            .add(learningMode ? value.secondLanguage : value.firstLanguage);
      }
    }

    lstAnswer.shuffle();
  }

  handleAnswer(answer) {
    var correctAnswer = learningMode ? word.secondLanguage : word.firstLanguage;
    if (correctAnswer == answer) {
      lstCorrectAnswer
          .add(Answer(correctAnswer: correctAnswer, userAnswer: answer));
      isCorrect = true;
    } else {
      lstWrongAnswer
          .add(Answer(correctAnswer: correctAnswer, userAnswer: answer));
      isCorrect = false;
    }
  }

  getNextQuestion() {
    currQuestionIdx += 1;
    if (currQuestionIdx < lstSelectedWord.length) {
      word = lstSelectedWord[currQuestionIdx];
    }
    randomAnswer();
    notifyListeners();
  }

  switchLearningMode() {
    learningMode = !learningMode;
    currQuestionIdx = 0;
    word = lstSelectedWord[currQuestionIdx];
    lstCorrectAnswer = [];
    lstWrongAnswer = [];
    randomAnswer();
    notifyListeners();
  }

  shuffleQuestion() {
    currQuestionIdx = 0;
    lstSelectedWord.shuffle();
    word = lstSelectedWord[currQuestionIdx];
    lstWrongAnswer = [];
    lstCorrectAnswer = [];
    randomAnswer();
    notifyListeners();
  }

  init(topicId) async {
    CollectionReference collection = _db
        .collection('Topics')
        .doc(topicId)
        .collection('Words');

    QuerySnapshot snapshot = await collection.get();
    if(!isInitFinish) {
      snapshot.docs.forEach((doc) {
        lstSelectedWord.add(
            Word(firstLanguage: doc['english'], secondLanguage: doc['vietnamese'])
        );
      });
      randomAnswer();
      lstSelectedWord.shuffle();
    }
    isInitFinish = true;
    notifyListeners();
  }
}
