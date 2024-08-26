import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onClearLetter;
  final VoidCallback onRefresh;
  final VoidCallback onHint;
  final int hints;

  const ActionButtons({
    Key? key,
    required this.onClearLetter,
    required this.onRefresh,
    required this.onHint,
    required this.hints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.arrow_back, onClearLetter),
        _buildActionButton(Icons.refresh, onRefresh),
        Stack(
          children: [
            _buildActionButton(Icons.lightbulb_outline, onHint, color: Colors.amber),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$hints',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed, {Color color = Colors.blue}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}