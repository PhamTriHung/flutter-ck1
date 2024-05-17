import 'dart:math';

import 'package:ck/animations/half_flip_animation.dart';
import 'package:ck/animations/slide_animation.dart';
import 'package:ck/enum/slide_direction.dart';
import 'package:ck/flashcards_page/tts_button.dart';
import 'package:ck/notifiers/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Card2 extends StatelessWidget {
  const Card2({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardNotifier>(builder: (_, notifier, __) {
      return GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 100) {
            notifier.runSwipeCard2(direction: SlideDirection.leftAway);
            notifier.runSlideCard1(direction: SlideDirection.LeftIn);
            notifier.setIgnoreTouch(ignore: true);
            notifier.getPrevWord();
          }
          if (details.primaryVelocity! < -100) {
            notifier.runSwipeCard2(direction: SlideDirection.rightAway);
            notifier.runSlideCard1(direction: SlideDirection.rightIn);
            notifier.setIgnoreTouch(ignore: true);
            notifier.getNextWord();
          }
        },
        child: HalfFlipAnimation(
          animate: notifier.flipCard2,
          animationCompleted: () {
            notifier.setIgnoreTouch(ignore: false);
          },
          reset: notifier.resetFlipCard2,
          flipFromHalfWay: true,
          child: SlideAnimation(
            reset: notifier.resetSwipeCard2,
            animationCompleted: () {
              notifier.resetCard2();
            },
            direction: notifier.swipeDirection,
            animate: notifier.swipeCard2,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  border: Border.all(width: 5, color: Colors.blue),
                ),
                height: size.height * 0.6,
                width: size.width * 0.8,
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child: Text(
                              notifier.learningMode
                                  ? notifier.word2.secondLanguage
                                  : notifier.word2.firstLanguage,
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                      TTSButton()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
