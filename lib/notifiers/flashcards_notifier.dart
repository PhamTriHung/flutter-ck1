import 'dart:async';
import 'dart:math';

import 'package:ck/enum/slide_direction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/word.dart';

class FlashcardNotifier extends ChangeNotifier {
  String topic = "";
  bool flipCard1 = false, flipCard2 = false, swipeCard2 = false, slideCard1 = false;
  bool resetFlipCard1 = false, resetFlipCard2 = false, resetSwipeCard2 = false, resetSlideCard1 = false;
  bool ignoreTouches = true;
  bool isAuto = false;
  bool learningMode = false;
  SlideDirection swipeDirection = SlideDirection.none;
  SlideDirection slideDirection = SlideDirection.none;
  Word word1 = Word(firstLanguage: "", secondLanguage: "");
  Word word2 = Word(firstLanguage: "", secondLanguage: "");
  bool isInitFinish = false;
  late Timer autoTimer;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Word> lstSelectedWord = [
    Word(firstLanguage: "dog", secondLanguage: "cho"),
    Word(firstLanguage: "cat", secondLanguage: "meo"),
    Word(firstLanguage: "chicken", secondLanguage: "ga"),
    Word(firstLanguage: "dug", secondLanguage: "vit"),
  ];
  int intTotalListLength = 0;
  int currWordIdx = 0;

  FlashcardNotifier() {
    intTotalListLength = lstSelectedWord.length;
    word1 = lstSelectedWord[0];
    word2 = lstSelectedWord[0];
  }


  runSlideCard1({required SlideDirection direction}) {
    slideCard1 = true;
    slideDirection = direction;
    resetSlideCard1 = false;
    notifyListeners();
  }

  runFlipcard() {
    flipCard1 = true;
    resetFlipCard1 = false;
    notifyListeners();
  }

  runFlipcard2() {
    flipCard2 = true;
    resetFlipCard2 = false;
    notifyListeners();
  }

  runSwipeCard2({required SlideDirection direction}) {
    swipeDirection = direction;
    swipeCard2 = true;
    resetSwipeCard2 = false;
    notifyListeners();
  }

  resetCard1() {
    resetSlideCard1 = true;
    resetFlipCard1 = true;
    slideCard1 = false;
    flipCard1 = false;
    swipeDirection = SlideDirection.none;
  }

  resetCard2() {
    resetSwipeCard2 = true;
    resetFlipCard2 = true;
    flipCard2 = false;
    swipeCard2 = false;
    swipeDirection = SlideDirection.none;
  }

  setIgnoreTouch({required bool ignore}) {
    ignoreTouches = ignore;
    notifyListeners();
  }

  getNextWord() {
    if(currWordIdx < intTotalListLength) {
      currWordIdx += 1;
      word1 = lstSelectedWord[currWordIdx];
    } else {
      print("end of list");
    }

    Future.delayed(Duration(milliseconds: 1000), () {
      word2 = word1;
    });
  }

  getPrevWord() {
    if(currWordIdx > 0) {
      currWordIdx -= 1;
      word1 = lstSelectedWord[currWordIdx];
    } else {
      print("end of list");
    }

    Future.delayed(Duration(milliseconds: 1000), () {
      word2 = word1;
    });
  }

  auto() {
    autoTimer = Timer.periodic(Duration(milliseconds: 4000), (timer) {
      Future.delayed(Duration(milliseconds: 1000), () {
        runFlipcard();
        Future.delayed(Duration(milliseconds: 1000), () {
          runFlipcard2();
          resetCard1();
          Future.delayed(Duration(milliseconds: 2000), () {
            runSwipeCard2(direction: SlideDirection.rightAway);
            runSlideCard1(direction: SlideDirection.rightIn);
            getNextWord();
            Future.delayed(Duration(milliseconds: 1000), () {
              resetCard2();
            });
          });
        });
      });
    });
  }

  runAuto({required bool isAuto}) {
    this.isAuto = isAuto;

    if(this.isAuto) {
      auto();
    } else {
      autoTimer.cancel();
    }
  }

  shuffleLst() {
    lstSelectedWord.shuffle();
    currWordIdx = 0;
    word1 = lstSelectedWord[currWordIdx];
    notifyListeners();
  }

  switchLearningMode() {
    learningMode = !learningMode;
    notifyListeners();
  }

  init(topicId) async {
    CollectionReference collection = _db
        .collection('Topics')
        .doc(topicId)
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
