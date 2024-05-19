import 'package:ck/app_theme.dart';
import 'package:ck/folder/add_folder_dialog.dart';
import 'package:ck/folder/classroom_tab_screen.dart';
import 'package:ck/folder/course-tab-screen.dart';
import 'package:ck/folder/folder_tab_screen.dart';
import 'package:ck/folder/new_class_screen.dart';
import 'package:ck/folder/topics-tab-screen.dart';
import 'package:flutter/material.dart';

import '../profile/profile_screen.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key, this.animationController});

  final AnimationController? animationController;
  @override
  _FolderScreenState createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen>
    with SingleTickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  double topBarOpacity = 0.0;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.background,
        title: const Text(
          'Thư viện',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showTab(context);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black.withOpacity(0.7),
            tabs: const [
              Tab(text: 'Học phần'),
              Tab(text: 'Thư mục'),
              Tab(text: 'Thông tin'),
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CourseTabScreen(),
          FolderTabScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }

  void _showTab(BuildContext context) {
    switch (_tabController.index) {
      case 0: //Tab học phần
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CourseTabScreen()),
        );
        break;
      case 1:
        FolderDialog.showAddFolderDialog(context);
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewClassScreen()),
        );
        break;
      default:
        break;
    }
  }
}
