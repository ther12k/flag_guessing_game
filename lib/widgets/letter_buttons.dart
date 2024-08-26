import 'package:flutter/material.dart';

class LetterButtons extends StatelessWidget {
  final List<String> buttonLetters;
  final Function(String) onLetterPress;

  const LetterButtons(
      {Key? key, required this.buttonLetters, required this.onLetterPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children:
          buttonLetters.map((letter) => _buildLetterButton(letter)).toList(),
    );
  }

  Widget _buildLetterButton(String letter) {
    return GestureDetector(
      onTap: () => onLetterPress(letter),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF9CA3AF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
