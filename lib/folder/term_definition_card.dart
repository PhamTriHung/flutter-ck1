import 'package:flutter/material.dart';

class TermDefinitionCard extends StatelessWidget {
  final TextEditingController termController;
  final TextEditingController definitionController;

  const TermDefinitionCard({
    Key? key,
    required this.termController,
    required this.definitionController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Thuật ngữ'),
            TextField(
              controller: termController,
              decoration: InputDecoration(
                hintText: 'Nhập thuật ngữ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Text('Định nghĩa'),
            TextField(
              controller: definitionController,
              decoration: InputDecoration(
                hintText: 'Nhập định nghĩa',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
