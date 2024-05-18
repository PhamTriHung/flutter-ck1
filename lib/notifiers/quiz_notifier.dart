import 'dart:math';

<<<<<<< HEAD
=======
import 'package:ck/model/answer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
>>>>>>> be2ef0a78c65651c3497a55516d551ab17d9e3b2
import 'package:flutter/material.dart';

import '../model/word.dart';

class QuizNotifier extends ChangeNotifier {
  bool isCorrect = false;
  bool isInitFinish = false;
  QuizNotifier() {
    randomAnswer();
    lstSelectedWord.shuffle();
  }
  List<Word> lstSelectedWord = [
    Word(firstLanguage: "dog", secondLanguage: "cho"),
    Word(firstLanguage: "cat", secondLanguage: "meo"),
    Word(firstLanguage: "chicken", secondLanguage: "ga"),
    Word(firstLanguage: "dug", secondLanguage: "vit"),
  ];
  int currQuestionIdx = 0;
  bool learningMode = false;
  late Word word = lstSelectedWord[0];
  late List<String> lstAnswer;
<<<<<<< HEAD
  List<Word> lstCorrectAnswer = [];
  List<Word> lstWrongAnswer = [];
=======
  List<Answer> lstCorrectAnswer = [];
  List<Answer> lstWrongAnswer = [];
  FirebaseFirestore _db = FirebaseFirestore.instance;
>>>>>>> be2ef0a78c65651c3497a55516d551ab17d9e3b2

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
<<<<<<< HEAD
    if(learningMode ? word.secondLanguage == answer : word.firstLanguage == answer) {
      lstCorrectAnswer.add(word);
      isCorrect = true;
    } else {
      lstWrongAnswer.add(word);
=======
    var correctAnswer = learningMode ? word.secondLanguage : word.firstLanguage;
    if (correctAnswer == answer) {
      lstCorrectAnswer
          .add(Answer(correctAnswer: correctAnswer, userAnswer: answer));
      isCorrect = true;
    } else {
      lstWrongAnswer
          .add(Answer(correctAnswer: correctAnswer, userAnswer: answer));
>>>>>>> be2ef0a78c65651c3497a55516d551ab17d9e3b2
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

<<<<<<< HEAD
}
=======
  shuffleQuestion() {
    currQuestionIdx = 0;
    lstSelectedWord.shuffle();
    word = lstSelectedWord[currQuestionIdx];
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
    }
    isInitFinish = true;
    notifyListeners();
  }
}
>>>>>>> be2ef0a78c65651c3497a55516d551ab17d9e3b2
