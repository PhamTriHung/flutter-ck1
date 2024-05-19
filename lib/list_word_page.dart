import 'package:ck/ScreenArgument.dart';
import 'package:ck/model/word.dart';
import 'package:ck/notifiers/word_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class ListWordPage extends StatefulWidget {
  const ListWordPage({super.key});

  @override
  State<ListWordPage> createState() => _ListWordPageState();
}

class _ListWordPageState extends State<ListWordPage> {
  FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text, String language) async {
    await flutterTts.setLanguage(language);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    // TODO: implement initState
    late final WordNotifier wordNotifier;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wordNotifier = Provider.of<WordNotifier>(context, listen: false);
      wordNotifier.isInitFinish = false;
      wordNotifier.lstWord = [];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WordNotifier>(builder: (_, notifider, __) {
      final ScreenArgument screenArgument =
          ModalRoute.of(context)!.settings.arguments as ScreenArgument;
      notifider.init(screenArgument.topicId);
      notifider.topicId = screenArgument.topicId;
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Center(
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: IconButton(icon: Icon(Icons.speaker), onPressed: () {
                          speak(notifider.lstWord[index].english, 'en-US');
                        },),
                        title: Text(notifider.lstWord[index].english),
                        subtitle: Text(notifider.lstWord[index].vietnamese),
                        trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {
                          notifider.deleteWord(notifider.lstWord[index].wordId);
                          notifider.isInitFinish = false;
                          notifider.lstWord = [];
                        },),
                      ),
                    );
                  },
                  itemCount: notifider.lstWord.length,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
