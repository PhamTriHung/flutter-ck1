import 'package:ck/notifiers/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class TTSButton extends StatefulWidget {
  const TTSButton({super.key});

  @override
  State<TTSButton> createState() => _TTSButtonState();
}

class _TTSButtonState extends State<TTSButton> {
  bool _isTapped = false;
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    _setupTts();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardNotifier>(builder: (_, notifier, __) {
      return IconButton(
          onPressed: () {
            _runTts(text: notifier.word1.secondLanguage);
            _isTapped = true;
            setState(() {});
            Future.delayed(Duration(milliseconds: 500), () {
              _isTapped = false;
              setState(() {});
            });
          },
          icon: Icon(
            Icons.audiotrack,
            size: 50,
            color: _isTapped ? Colors.yellow : Colors.white,
          ));
    });
  }

  _setupTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.4);
  }

  _runTts({required String text}) async {
    await flutterTts.speak(text);
  }
}
