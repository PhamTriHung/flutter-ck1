import 'package:ck/ScreenArgument.dart';
import 'package:ck/folder/add_folder_dialog.dart';
import 'package:ck/notifiers/folder_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FolderTabScreen extends StatelessWidget {
  const FolderTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FolderNotifier>(
      builder: (_, notifier, __) {
        return StreamBuilder(
          stream: notifier.fetchFoldersStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final folderList = snapshot.data;
              return Scaffold(
                body: Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        Text("Add new folder"),
                        IconButton(onPressed: () {
                          Navigator.pushNamed(context, '/create_folder_with_topic');
                        }, icon: Icon(Icons.add)),
                      ],
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        final folder = folderList[index];
                        return ListTile(
                         title: Text(folder['name']),
                          trailing: PopupMenuButton<int>(
                            itemBuilder: (context) {
                              return <PopupMenuEntry<int>> [
                                PopupMenuItem(child: Text("View topic"), value: 0),
                                PopupMenuItem(child: Text("Delete folder"), value: 1),
                                PopupMenuItem(child: Text("Add topic"), value: 2)
                              ];
                            },
                            onSelected: (value) {
                              switch (value) {
                                case 0:
                                  Navigator.pushNamed(context, '/list_topics_in_folder', arguments: ScreenArgument(folder['folderId']));
                                  break;
                                case 1:
                                  notifier.deleteFolder(folder['folderId']);
                                  break;
                                case 2:
                                  Navigator.pushNamed(context, '/add_topic_to_folder', arguments: ScreenArgument(folder['folderId']));
                                  break;

                              }
                            },
                          ),
                        );
                      },
                      itemCount: folderList!.length,
                    ))
                  ],
                ),
              );
            } else {
              return Placeholder();
            }
          },
        );
      },
    );
  }
}
