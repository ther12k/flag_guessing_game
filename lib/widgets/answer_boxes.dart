import 'package:flag_guessing_game/models/answer_box.dart';
import 'package:flutter/material.dart';

class AnswerBoxes extends StatelessWidget {
  final List<AnswerBox> answerBoxes;

  const AnswerBoxes({Key? key, required this.answerBoxes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: answerBoxes.map((box) => _buildBox(box)).toList(),
    );
  }

  Widget _buildBox(AnswerBox box) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: box.status == 'empty' ? Color(0xFF3B82F6) : Color(0xFF60A5FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          box.letter,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
