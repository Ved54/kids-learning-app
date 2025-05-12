class LearningContent {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final String funFact;
  final List<String> options;
  final String correctAnswer;

  LearningContent({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.funFact,
    required this.options,
    required this.correctAnswer,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}

class LeaderboardEntry {
  final String name;
  final String avatar;
  final int score;
  final int rank;

  LeaderboardEntry({
    required this.name,
    required this.avatar,
    required this.score,
    required this.rank,
  });
}
