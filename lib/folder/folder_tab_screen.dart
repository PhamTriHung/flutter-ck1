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
                                PopupMenuItem(child: Text("Delete folder"), value: 1)
                              ];
                            },
                            onSelected: (value) {
                              switch (value) {
                                case 0:
                                  break;
                                case 1:
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
