import 'package:flutter/material.dart';

class TimerAndLives extends StatelessWidget {
  final int lives;
  final int timer;

  const TimerAndLives({Key? key, required this.lives, required this.timer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: List.generate(5, (index) => 
            Icon(
              index < lives ? Icons.favorite : Icons.favorite_border,
              color: index < lives ? Colors.red : Colors.grey,
              size: 20,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            '${timer}s',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
        ),
      ],
    );
  }
}