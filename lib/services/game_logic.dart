import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flag_guessing_game/models/answer_box.dart';
import 'package:flag_guessing_game/models/flag.dart';
import 'package:flag_guessing_game/utils/constants.dart';
import 'package:flag_guessing_game/utils/helpers.dart';

class GameLogic extends ChangeNotifier {
  int currentIndex = 0;
  String gameMode;
  late Flag currentFlag;
  List<AnswerBox> answerBoxes = [];
  List<String> buttonLetters = [];
  int lives = 5;
  int timer = 30;
  int score = 0;
  int stars = 0;
  int level = 1;
  int hints = 2;
  int progress = 0;
  int consecutiveCorrect = 0;
  List<Flag> remainingFlags = [];
  Timer? _timer;

  GameLogic(this.gameMode) {
    startNewGame();
  }

  void startNewGame() {
    remainingFlags = shuffleArray(flags);
    currentFlag = remainingFlags.removeAt(0);
    setupFlag(currentFlag);
    resetLives();
    resetTimer();
    score = 0;
    stars = 0;
    level = 1;
    hints = 2;
    progress = 0;
    consecutiveCorrect = 0;
    notifyListeners();
  }

  void setupFlag(Flag flag) {
    final countryLetters =
        flag.country.toUpperCase().replaceAll(' ', '').split('');
    final preFilledCount = getPreFilledCount(countryLetters.length, gameMode);
    final preFilledIndices =
        shuffleArray(List.generate(countryLetters.length, (index) => index))
            .sublist(0, preFilledCount);

    answerBoxes = countryLetters.asMap().entries.map((entry) {
      final index = entry.key;
      final letter = entry.value;
      if (preFilledIndices.contains(index)) {
        return AnswerBox(letter: letter, status: 'prefilled');
      } else {
        return AnswerBox(letter: '', status: 'empty');
      }
    }).toList();

    buttonLetters = getButtonLetters(flag.country);
    currentIndex = answerBoxes.indexWhere((box) => box.status == 'empty');
  }

  void resetLives() {
    lives = 5;
  }

  void resetTimer() {
    _timer?.cancel();
    timer = gameMode == 'easy'
        ? 60
        : gameMode == 'medium'
            ? 45
            : 30;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.timer > 0) {
        this.timer--;
        notifyListeners();
      } else {
        handleTimeOut();
      }
    });
  }

  void handleLetterInput(String letter) {
    if (currentIndex < answerBoxes.length &&
        answerBoxes[currentIndex].status != 'prefilled') {
      final correctLetter =
          currentFlag.country.toUpperCase().replaceAll(' ', '')[currentIndex];
      final isCorrect = correctLetter == letter;
      answerBoxes[currentIndex] = AnswerBox(
        letter: letter,
        status: isCorrect ? 'correct' : 'incorrect',
      );
      currentIndex++;

      // Move to the next non-prefilled box
      while (currentIndex < answerBoxes.length &&
          answerBoxes[currentIndex].status == 'prefilled') {
        currentIndex++;
      }

      if (currentIndex == answerBoxes.length ||
          answerBoxes.every((box) => box.letter.isNotEmpty)) {
        handleGuess(answerBoxes.map((box) => box.letter).join(''));
      }
    }
    notifyListeners();
  }

  void handleClearLetter() {
    if (currentIndex > 0) {
      do {
        currentIndex--;
      } while (
          currentIndex > 0 && answerBoxes[currentIndex].status == 'prefilled');

      if (answerBoxes[currentIndex].status != 'prefilled') {
        answerBoxes[currentIndex] = AnswerBox(letter: '', status: 'empty');
      }
    }
    notifyListeners();
  }

  void handleRefresh() {
    answerBoxes = answerBoxes.map((box) {
      if (box.status == 'prefilled') {
        return box;
      } else {
        return AnswerBox(letter: '', status: 'empty');
      }
    }).toList();
    currentIndex = answerBoxes.indexWhere((box) => box.status == 'empty');
    notifyListeners();
  }

  void handleGuess(String guess) {
    final normalizedGuess = guess.toUpperCase().trim().replaceAll(' ', '');
    final normalizedCountry =
        currentFlag.country.toUpperCase().trim().replaceAll(' ', '');

    if (normalizedGuess == normalizedCountry) {
      handleCorrectGuess();
    } else {
      handleIncorrectGuess();
    }
  }

  void handleCorrectGuess() {
    final timeBonus = (timer / 3).ceil();
    final levelBonus = level * 10;
    final difficultyMultiplier = gameMode == 'easy'
        ? 1
        : gameMode == 'medium'
            ? 1.5
            : 2;
    final guessScore =
        ((100 + timeBonus + levelBonus) * difficultyMultiplier).round();

    score += guessScore;
    stars++;
    progress++;
    consecutiveCorrect++;

    if (progress >= 10) {
      level++;
      progress = 0;
    }

    if (consecutiveCorrect % 3 == 0) {
      hints++;
    }

    Future.delayed(Duration(milliseconds: 1500), () {
      newFlag();
    });

    notifyListeners();
  }

  void handleIncorrectGuess() {
    lives--;
    consecutiveCorrect = 0;

    if (lives <= 0) {
      _gameOver();
    } else {
      Future.delayed(Duration(seconds: 2), () {
        answerBoxes = answerBoxes
            .map((box) => box.status == 'prefilled'
                ? box
                : AnswerBox(letter: '', status: 'empty'))
            .toList();
        notifyListeners();
      });
    }
  }

  void handleTimeOut() {
    lives--;
    consecutiveCorrect = 0;

    if (lives <= 0) {
      _gameOver();
    } else {
      Future.delayed(Duration(seconds: 2), () {
        newFlag();
      });
    }
  }

  void _gameOver() {
    _timer?.cancel();
    // You might want to show an alert dialog here or navigate to a game over screen
    // For now, we'll just restart the game
    startNewGame();
  }

  void handleHint() {
    if (hints > 0 && gameMode != 'hard') {
      final emptyBoxIndex =
          answerBoxes.indexWhere((box) => box.status == 'empty');
      if (emptyBoxIndex != -1) {
        final correctLetter = currentFlag.country[emptyBoxIndex].toUpperCase();
        answerBoxes[emptyBoxIndex] =
            AnswerBox(letter: correctLetter, status: 'hint');
        hints--;
        notifyListeners();
      }
    }
  }

  void newFlag() {
    if (remainingFlags.isEmpty) {
      remainingFlags = shuffleArray(flags);
    }
    currentFlag = remainingFlags.removeAt(0);
    setupFlag(currentFlag);
    notifyListeners();
  }

  void changeFlag() {
    if (remainingFlags.isEmpty) {
      remainingFlags = shuffleArray(flags);
    }
    currentFlag = remainingFlags.removeAt(0);
    setupFlag(currentFlag);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
