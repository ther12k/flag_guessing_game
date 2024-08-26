import 'dart:math';

List<T> shuffleArray<T>(List<T> array) {
  if (array.isEmpty) return [];
  final shuffled = List<T>.from(array);
  for (var i = shuffled.length - 1; i > 0; i--) {
    final j = Random().nextInt(i + 1);
    final temp = shuffled[i];
    shuffled[i] = shuffled[j];
    shuffled[j] = temp;
  }
  return shuffled;
}

int getPreFilledCount(int wordLength, String gameMode) {
  switch (gameMode) {
    case 'veryEasy':
      return (wordLength * 0.5).floor();
    case 'easy':
      return (wordLength * 0.3).floor();
    case 'medium':
      return (wordLength * 0.2).floor();
    case 'hard':
      return 0;
    default:
      return 0;
  }
}

List<String> getButtonLetters(String countryName) {
  final countryLetters = countryName.toUpperCase().replaceAll(' ', '').split('');
  final uniqueLetters = countryLetters.toSet().toList();
  final extraLettersCount = (uniqueLetters.length * 0.4).floor();
  final allLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
  final extraLetters = shuffleArray(allLetters)
      .where((letter) => !uniqueLetters.contains(letter))
      .take(extraLettersCount)
      .toList();
  return shuffleArray([...uniqueLetters, ...extraLetters]);
}