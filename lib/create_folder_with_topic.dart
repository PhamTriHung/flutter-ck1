import 'package:ck/notifiers/folder_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateFolderWithTopic extends StatefulWidget {
  const CreateFolderWithTopic({super.key});

  @override
  State<CreateFolderWithTopic> createState() => _CreateFolderWithTopicState();
}

class _CreateFolderWithTopicState extends State<CreateFolderWithTopic> {
  TextEditingController _folderNameController = TextEditingController();
  List<TextEditingController> _topicNameControllers = [];

  void addControllers() {
    _topicNameControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (var controller in _topicNameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FolderNotifier>(
      builder: (_, notifier, __) {
        return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: const Text(
                  'Add folder',
                  style: TextStyle(color: Colors.white),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                iconTheme: const IconThemeData(color: Colors.white),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add), // Biểu tượng lưu
                    onPressed: () {
                      // Thêm hành động lưu dữ liệu
                      setState(() {
                        addControllers();
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.save), // Biểu tượng chia sẻ
                    onPressed: () {
                      notifier.saveFolderWithTopics(
                          _folderNameController.text, _topicNameControllers);
                    },
                  ),
                ],
              ),
              body: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, right: 16, left: 16, bottom: 100),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _folderNameController,
                              decoration: const InputDecoration(
                                hintText: 'Folder name',
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('List topic'),
                                ]),
                            ...List.generate(_topicNameControllers.length,
                                (index) {
                              return TextFormField(
                                controller: _topicNameControllers[index],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Topic name'),
                              );
                            })
                          ]),
                    ),
                  ))),
        );
      },
    );
  }
}
