import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flag_guessing_game/screens/flag_guessing_game_screen.dart';
import 'package:flag_guessing_game/services/game_logic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flag Guessing Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<GameLogic>(
        create: (context) => GameLogic('medium'),
        child: FlagGuessingGameScreen(),
      ),
    );
  }
}
