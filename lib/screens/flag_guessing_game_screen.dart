import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flag_guessing_game/services/game_logic.dart';
import 'package:flag_guessing_game/widgets/lives_and_timer.dart';
import 'package:flag_guessing_game/widgets/flag_display.dart';
import 'package:flag_guessing_game/widgets/answer_boxes.dart';
import 'package:flag_guessing_game/widgets/letter_buttons.dart';
import 'package:flag_guessing_game/widgets/action_buttons.dart';

class FlagGuessingGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameLogic>(
      builder: (context, gameLogic, child) {
        return Scaffold(
          backgroundColor: Color(0xFF1E3A8A),
          body: SafeArea(
            child: Column(
              children: [
                LivesAndTimer(lives: gameLogic.lives, timer: gameLogic.timer),
                Expanded(
                  child: FlagDisplay(flagSrc: gameLogic.currentFlag.src),
                ),
                ElevatedButton.icon(
                  onPressed: gameLogic.changeFlag,
                  icon: Icon(Icons.refresh),
                  label: Text('Change Flag'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                AnswerBoxes(
                  answerBoxes: gameLogic.answerBoxes,
                  currentIndex: gameLogic.currentIndex,
                ),
                SizedBox(height: 20),
                LetterButtons(
                  buttonLetters: gameLogic.buttonLetters,
                  onLetterPress: gameLogic.handleLetterInput,
                ),
                SizedBox(height: 20),
                ActionButtons(
                  onClearLetter: gameLogic.handleClearLetter,
                  onRefresh: gameLogic.handleRefresh,
                  onHint: gameLogic.handleHint,
                  hints: gameLogic.hints,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
