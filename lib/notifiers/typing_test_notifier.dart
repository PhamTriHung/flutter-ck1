import 'package:ck/model/answer.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/word.dart';

class TypingTestNotifier extends ChangeNotifier {
  TypingTestNotifier() {
    lstSelectedWord.shuffle();
    word = lstSelectedWord[0];
  }
  late Word word;
  List<Answer> lstCorrectAnswer = [];
  List<Answer> lstWrongAnswer = [];
  bool scaleAnimate = false;
  bool resetScaleAnimate = false;
  bool isCorrect = false;
  bool learningMode = false;
  bool isInitFinish = false;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Word> lstSelectedWord = [
    Word(firstLanguage: "dog", secondLanguage: "cho"),
    Word(firstLanguage: "cat", secondLanguage: "meo"),
    Word(firstLanguage: "chicken", secondLanguage: "ga"),
    Word(firstLanguage: "dug", secondLanguage: "vit"),
  ];

  int currQuestionIdx = 0;
  String message = '';

  getNextQuestion() {
    currQuestionIdx += 1;
    if (currQuestionIdx < lstSelectedWord.length) {
      word = lstSelectedWord[currQuestionIdx];
    }

    notifyListeners();
  }

  answerQuestion({required String answer}) {
    String correctAnswer = learningMode
        ? word.firstLanguage.toLowerCase()
        : word.secondLanguage.toLowerCase();

    if (correctAnswer == answer.toLowerCase()) {
      lstCorrectAnswer
          .add(Answer(correctAnswer: correctAnswer, userAnswer: answer));
      isCorrect = true;
    } else {
      lstWrongAnswer
          .add(new Answer(correctAnswer: correctAnswer, userAnswer: answer));
      isCorrect = false;
    }
    notifyListeners();
  }

  runScaleAnimation(message) {
    scaleAnimate = true;
    this.message = message;
    notifyListeners();
  }

  resetAnimation() {
    resetScaleAnimate = true;
    scaleAnimate = false;
    notifyListeners();
  }

  switchLearningMode() {
    learningMode = !learningMode;
    currQuestionIdx = 0;
    word = lstSelectedWord[currQuestionIdx];
    notifyListeners();
  }

  shuffleQuestion() {
    currQuestionIdx = 0;
    lstSelectedWord.shuffle();
    word = lstSelectedWord[currQuestionIdx];
    notifyListeners();
  }

  init(topicId) async {
    CollectionReference collection = _db
        .collection('Topics')
        .doc('pqeFaJo1oxqTAQzloFVk')
        .collection('Words');

    QuerySnapshot snapshot = await collection.get();
    int i = 0;
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
