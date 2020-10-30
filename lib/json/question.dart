/// Provides the [Question] class.
import 'package:html_unescape/html_unescape.dart';
import 'package:json_annotation/json_annotation.dart';

import 'answer.dart';

part 'question.g.dart';

final HtmlUnescape unescape = HtmlUnescape();

enum QuestionTypes {
  multiple,
  boolean,
}

String dumpQuestionType(QuestionTypes value) {
  String s = value.toString();
  s = s.substring(s.indexOf('.'));
  return s;
}

QuestionTypes loadQuestionType(String value) {
  for (QuestionTypes qt in QuestionTypes.values) {
    String s = qt.toString();
    s = s.substring(s.indexOf('.'));
    if (s == value) {
      return qt;
    }
  }
  return null;
}

enum QuestionDifficulties {
  easy,
  medium,
  hard,
}

final Map<String, QuestionDifficulties> questionDifficultiesMap =
    <String, QuestionDifficulties>{
  'easy': QuestionDifficulties.easy,
  'medium': QuestionDifficulties.medium,
  'hard': QuestionDifficulties.hard
};

String dumpQuestionDifficulty(QuestionDifficulties value) {
  final List<String> possibilities = <String>[];
  questionDifficultiesMap.forEach((String name, QuestionDifficulties d) {
    if (d == value) {
      possibilities.add(name);
    }
  });
  if (possibilities.isNotEmpty) {
    return possibilities.first;
  }
  return null;
}

QuestionDifficulties loadQuestionDifficulty(String value) =>
    questionDifficultiesMap[value];

@JsonSerializable()
class Question {
  Question(
      {this.type,
      this.category,
      this.difficulty,
      this.question,
      // ignore: non_constant_identifier_names
      this.correct_answer,
      // ignore: non_constant_identifier_names
      this.incorrect_answers}) {
    answers.add(Answer(correct_answer, true));
    incorrect_answers
        .forEach((String text) => answers.add(Answer(text, false)));
    answers.shuffle();
  }

  final String category;

  @JsonKey(name: 'type', toJson: dumpQuestionType, fromJson: loadQuestionType)
  QuestionTypes type;

  @JsonKey(
      name: 'difficulty',
      fromJson: loadQuestionDifficulty,
      toJson: dumpQuestionDifficulty)
  QuestionDifficulties difficulty;

  // ignore: non_constant_identifier_names
  final String correct_answer;
  // ignore: non_constant_identifier_names
  final List<String> incorrect_answers;
  final String question;

  final List<Answer> answers = <Answer>[];

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  String getText() => unescape.convert(question);
}
