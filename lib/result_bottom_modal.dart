import 'package:flutter/material.dart';

class ResultBottomModal extends StatefulWidget {
  const ResultBottomModal({super.key, required this.onNextQuestionClick, required this.isCorrect});
  final VoidCallback onNextQuestionClick;
  final bool isCorrect;

  @override
  State<ResultBottomModal> createState() => _ResultBottomModalState();
}

class _ResultBottomModalState extends State<ResultBottomModal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: widget.isCorrect ? Colors.green : Colors.redAccent
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(widget.isCorrect ? 'Correct' : 'Incorrect',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white
                ),),
              ),
              Expanded(
                child: ElevatedButton(onPressed: () {
                  widget.onNextQuestionClick.call();
                }, child: Text("Next Question")),
              )
            ],
          ),
        ),
      ),
    ) ;
  }
}
