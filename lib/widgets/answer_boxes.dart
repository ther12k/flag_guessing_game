import 'package:flag_guessing_game/models/answer_box.dart';
import 'package:flutter/material.dart';

class AnswerBoxes extends StatelessWidget {
  final List<AnswerBox> answerBoxes;
  final int currentIndex;

  const AnswerBoxes({
    Key? key,
    required this.answerBoxes,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: answerBoxes.asMap().entries.map((entry) {
        int index = entry.key;
        AnswerBox box = entry.value;
        return _buildBox(box, index == currentIndex);
      }).toList(),
    );
  }

  Widget _buildBox(AnswerBox box, bool isCurrent) {
    Color boxColor;
    switch (box.status) {
      case 'correct':
        boxColor = Colors.green;
        break;
      case 'incorrect':
        boxColor = Colors.red;
        break;
      case 'prefilled':
        boxColor = Color(0xFF60A5FA);
        break;
      case 'empty':
        boxColor = Color(0xFF3B82F6);
        break;
      default:
        boxColor = Color(0xFF60A5FA);
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(8),
        border: isCurrent ? Border.all(color: Colors.yellow, width: 2) : null,
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