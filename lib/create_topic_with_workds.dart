import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'folder/term_definition_card.dart';
import 'notifiers/topic_notifier.dart';

class CreateTopicWithWords extends StatefulWidget {
  const CreateTopicWithWords({super.key});

  @override
  State<CreateTopicWithWords> createState() => _CreateTopicWithWordsState();
}

class _CreateTopicWithWordsState extends State<CreateTopicWithWords> {
  List<TextEditingController> _termControllers = [];
  List<TextEditingController> _definitionControllers = [];
  TextEditingController _topicNameController = TextEditingController();

  bool _allowMembersToAdd = false;

  @override
  void initState() {
    super.initState();
    addCard();
  }

  void addCard() {
    _termControllers.add(TextEditingController());
    _definitionControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    // Đảm bảo giải phóng tài nguyên của các controllers
    for (var controller in _termControllers) {
      controller.dispose();
    }
    for (var controller in _definitionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TopicNotifier>(
      builder: (_, notifier, __) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                'Tạo học phần',
                style: TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () =>
                    Navigator.of(context).pop(), // Quay lại màn hình trước
              ),
              iconTheme: IconThemeData(color: Colors.white),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add), // Biểu tượng lưu
                  onPressed: () {
                    // Thêm hành động lưu dữ liệu
                    setState(() {
                      addCard();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.save), // Biểu tượng chia sẻ
                  onPressed: () {
                    notifier.saveTopicWithWords(
                        _topicNameController.text,
                        _allowMembersToAdd,
                        _termControllers,
                        _definitionControllers);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            body: Padding(
              padding:
                  EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 100),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _topicNameController,
                        decoration: InputDecoration(
                          hintText: 'Topic name',
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Vocabulary List'),
                          Row(
                            children: [
                              Text('Private mode'),
                              Switch(
                                value: _allowMembersToAdd,
                                onChanged: (newValue) {
                                  setState(() {
                                    _allowMembersToAdd = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      ...List.generate(_termControllers.length, (index) {
                        return TermDefinitionCard(
                          termController: _termControllers[index],
                          definitionController: _definitionControllers[index],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     setState(() {
            //       addCard();
            //     });
            //   },
            //   child: Icon(Icons.add),
            // ),
          ),
        );
      },
    );
  }
}
