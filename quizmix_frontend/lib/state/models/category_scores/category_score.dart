class CategoryScore {
  const CategoryScore({
    required this.category,
    required this.score,
  });

  final String category;
  final double score;

  CategoryScore.base()
      : category = '',
        score = 0;
}
