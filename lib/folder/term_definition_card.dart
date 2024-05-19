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
            Text('English'),
            TextField(
              controller: termController,
              decoration: InputDecoration(
                hintText: 'Enter vocabulary',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Text('Vietnamese'),
            TextField(
              controller: definitionController,
              decoration: InputDecoration(
                hintText: 'Enter vocabulary',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
