class Question {
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final String category;
  final String difficulty;
  final String explanation;

  Question({
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    required this.category,
    required this.difficulty,
    required this.explanation,
  });
}