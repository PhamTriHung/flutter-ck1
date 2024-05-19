import 'package:ck/ScreenArgument.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'folder/term_definition_card.dart';
import 'notifiers/topic_notifier.dart';

class CreateTopicInFolderPage extends StatefulWidget {
  const CreateTopicInFolderPage({super.key});

  @override
  State<CreateTopicInFolderPage> createState() => _CreateTopicInFolderPageState();
}

class _CreateTopicInFolderPageState extends State<CreateTopicInFolderPage> {
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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArgument;
    return Consumer<TopicNotifier>(
      builder: (_, notifier, __) {
        return  MaterialApp(
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
                    notifier.addTopicToFolder(_topicNameController.text, args.topicId, _allowMembersToAdd, _termControllers, _definitionControllers);
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 100),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _topicNameController,
                        decoration: InputDecoration(
                          hintText: 'Tên topic',
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Danh sách học phần'),
                          Row(
                            children: [
                              Text('Chế độ riêng tư'),
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
