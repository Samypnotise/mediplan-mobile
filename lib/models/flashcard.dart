class Flashcard {
  final String id;
  final String answer;
  final String question;
  final int difficulty; // UNKNOWN: 0 - EASY : 1 - MEDIUM : 2 - HARD : 3
  final String lessonId;
  final String userId;

  Flashcard({
    required this.id,
    required this.answer,
    required this.question,
    required this.difficulty,
    required this.lessonId,
    required this.userId,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'],
      answer: json['answer'],
      question: json['question'],
      difficulty: json['difficulty'],
      lessonId: json['lesson_id'],
      userId: json['user_id'],
    );
  }
}
