import 'package:ck/models/TopicsModel.dart';
import 'package:ck/models/WordModel.dart';
import 'package:ck/repository/topic_repository.dart';
import 'package:flutter/material.dart';

class FolderDialog {
  static void showAddFolderDialog(BuildContext context) {
    final TextEditingController folderNameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    TopicRepository topicRepository = TopicRepository();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tạo thư mục'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Tên thư mục:'),
                TextFormField(
                  controller: folderNameController,
                  decoration: const InputDecoration(
                    hintText: 'Nhập tên thư mục',
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Mô tả:'),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Nhập mô tả cho thư mục',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                String result = await topicRepository.createTopic(TopicsModel(
                  name: folderNameController.text,
                  description: descriptionController.text,
                  creationDate: DateTime.now().toString(),
                  lastAccessed: '',
                  creatorId: '',
                  public: true,
                ));
                topicRepository.addWordToTopic('SSgPFatmxtNRxjQetTiI', WordModel(description: 'description', english: '', illustration: '', pronunciation: 's', vietnamese: ''));
                // Thêm hành động lưu thư mục tại đây
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
