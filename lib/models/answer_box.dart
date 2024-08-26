class AnswerBox {
  String letter;
  String status;

  AnswerBox({
    required this.letter,
    required this.status,
  });

  // Optional: Add a copyWith method for easy modifications
  AnswerBox copyWith({
    String? letter,
    String? status,
  }) {
    return AnswerBox(
      letter: letter ?? this.letter,
      status: status ?? this.status,
    );
  }

  // Optional: Add a toString method for easier debugging
  @override
  String toString() => 'AnswerBox(letter: $letter, status: $status)';
}

// You can also define an enum for the status if you prefer
enum AnswerBoxStatus {
  empty,
  filled,
  prefilled,
  hint,
  correct,
  incorrect,
}

// Then you would use it like this:
// AnswerBox(letter: 'A', status: AnswerBoxStatus.filled.toString())