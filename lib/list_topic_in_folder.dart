import 'package:ck/ScreenArgument.dart';
import 'package:ck/notifiers/topic_notifier.dart';
import 'package:ck/notifiers/word_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTopicInFolder extends StatefulWidget {
  const ListTopicInFolder({super.key});

  @override
  State<ListTopicInFolder> createState() => _ListTopicInFolderState();
}

class _ListTopicInFolderState extends State<ListTopicInFolder> {
  @override
  void initState() {
    // TODO: implement initState
    late final TopicNotifier topicNotifier;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      topicNotifier = Provider.of<TopicNotifier>(context, listen: false);
      topicNotifier.isInitFinish = false;
      topicNotifier.lstTopic = [];

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArgument;
    return Consumer<TopicNotifier>(
      builder: (_, notifier, __) {
        notifier.init(args.topicId);
        notifier.folderId = args.topicId;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(notifier.lstTopic[index]['name']),
                      trailing: PopupMenuButton<int>(
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<int>>[
                            PopupMenuItem<int>(
                              child: Text("Flash card"),
                              value: 0,
                            ),
                            PopupMenuItem<int>(
                              child: Text("Quiz"),
                              value: 1,
                            ),
                            PopupMenuItem<int>(
                              child: Text("Typing test"),
                              value: 2,
                            ),
                            PopupMenuItem<int>(
                              child: Text("View words"),
                              value: 3,
                            ),
                            PopupMenuItem<int>(
                              child: Text("Add word"),
                              value: 4,
                            ),
                            PopupMenuItem<int>(
                              child: Text("Delete topic"),
                              value: 5,
                            )
                          ];
                        },
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              Navigator.pushNamed(context, '/flashcard',
                                  arguments:
                                  ScreenArgument(notifier.lstTopic[index]['topicId']));
                              break;
                            case 1:
                              Navigator.pushNamed(context, '/quiz',
                                  arguments:
                                  ScreenArgument(notifier.lstTopic[index]['topicId']));
                              break;
                            case 2:
                              Navigator.pushNamed(context, '/typing_test',
                                  arguments:
                                  ScreenArgument(notifier.lstTopic[index]['topicId']));
                              break;
                            case 3:
                              Navigator.pushNamed(context, '/list_word',
                                  arguments:
                                  ScreenArgument(notifier.lstTopic[index]['topicId']));
                              break;
                            case 4:
                              Navigator.pushNamed(context, '/add_word',
                                  arguments:
                                  ScreenArgument(notifier.lstTopic[index]['topicId']));
                              break;
                            case 5:
                              notifier.deleteTopic(notifier.lstTopic[index]['topicId']);
                              notifier.isInitFinish = false;
                              notifier.init(args.topicId);
                              break;
                          }
                        },
                      ),
                    ),
                  );
                },
                itemCount: notifier.lstTopic.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
