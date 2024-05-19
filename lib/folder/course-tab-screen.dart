import 'package:ck/controllers/topics_controller.dart';
import 'package:ck/notifiers/topic_notifier.dart';
import 'package:ck/repository/topic_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../ScreenArgument.dart';
import 'term_definition_card.dart'; // Đảm bảo import đúng đường dẫn

class CourseTabScreen extends StatefulWidget {
  const CourseTabScreen({super.key});

  @override
  State<CourseTabScreen> createState() => _CourseTabScreenState();
}

class _CourseTabScreenState extends State<CourseTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TopicNotifier>(builder: (_, notifier, __) {
      return StreamBuilder<List<Map<String, dynamic>>>(
          stream: notifier.fetchCoursesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final courselist = snapshot.data;
              return Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Text("Add new topic"),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/add_topic');
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: courselist!.length,
                      itemBuilder: (context, index) {
                        final course = courselist[index];
                        return Card(
                          child: ListTile(
                            title: Text(course['courseName']),
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
                                            ScreenArgument(course['courseId']));
                                    break;
                                  case 1:
                                    Navigator.pushNamed(context, '/quiz',
                                        arguments:
                                            ScreenArgument(course['courseId']));
                                    break;
                                  case 2:
                                    Navigator.pushNamed(context, '/typing_test',
                                        arguments:
                                            ScreenArgument(course['courseId']));
                                    break;
                                  case 3:
                                    Navigator.pushNamed(context, '/list_word',
                                        arguments:
                                            ScreenArgument(course['courseId']));
                                    break;
                                  case 4:
                                    Navigator.pushNamed(context, '/add_word',
                                        arguments:
                                            ScreenArgument(course['courseId']));
                                    break;
                                  case 5:
                                    notifier.deleteTopic(course['courseId']);
                                    break;
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Text("Loading...", style: TextStyle(fontSize: 20),),
              );
            }
          });
    });
  }
}
