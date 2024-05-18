import 'package:ck/folder/add_folder_dialog.dart';
import 'package:flutter/material.dart';

class FolderTabScreen extends StatelessWidget {
  const FolderTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder, size: 64),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Sắp xếp học phần của bạn theo chủ đề, giáo viên, khóa học, v.v.',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FolderDialog.showAddFolderDialog(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Màu chữ của nút
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Độ bo tròn của viền nút
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15), // Padding của nút
              ),
              child: const Text('Tạo thư mục'),
            ),
          ],
        ),
      ),
    );
  }
}
