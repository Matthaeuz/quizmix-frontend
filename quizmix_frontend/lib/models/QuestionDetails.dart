class QuestionDetails {
  final String category;
  final String questionText;
  final String imagePath;
  final String answer;
  final String? explanation;
  final List<String>? choices;

  QuestionDetails(
      {required this.category,
      required this.questionText,
      required this.imagePath,
      required this.answer,
      this.explanation,
      this.choices});
}
