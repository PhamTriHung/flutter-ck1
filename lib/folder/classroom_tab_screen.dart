import 'package:ck/folder/new_class_screen.dart';
import 'package:flutter/material.dart';

class ClassroomTabScreen extends StatelessWidget {
  const ClassroomTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people, size: 64),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Góp tài liệu học để tiết kiệm thời gian và chia sẻ với các thành viên Elerner khác',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewClassScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Màu chữ của nút
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Độ bo tròn của viền nút
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15), // Padding của nút
              ),
              child: const Text('Tạo Lớp học'),
            ),
          ],
        ),
      ),
    );
  }
}
