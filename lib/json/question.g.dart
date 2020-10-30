// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    type: loadQuestionType(json['type'] as String),
    category: json['category'] as String,
    difficulty: loadQuestionDifficulty(json['difficulty'] as String),
    question: json['question'] as String,
    correct_answer: json['correct_answer'] as String,
    incorrect_answers:
        (json['incorrect_answers'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'category': instance.category,
      'type': dumpQuestionType(instance.type),
      'difficulty': dumpQuestionDifficulty(instance.difficulty),
      'correct_answer': instance.correct_answer,
      'incorrect_answers': instance.incorrect_answers,
      'question': instance.question,
    };
