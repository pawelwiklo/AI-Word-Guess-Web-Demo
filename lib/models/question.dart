import 'package:word_game_web/data/questions_en.dart';

class Question {
  final int id;
  final String answer;
  final String description;
  List<String> userInput;
  bool finished;
  bool isHintUsed;
  int hintIndex;

  Question({
    required this.id,
    required this.answer,
    required this.description,
    required this.userInput,
    required this.finished,
    required this.isHintUsed,
    required this.hintIndex,
  });
}

List get questionsData => questions_en;
