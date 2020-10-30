// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionList _$QuestionListFromJson(Map<String, dynamic> json) {
  return QuestionList(
    status: loadResponseCode(json['response_code'] as int),
    questions: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Question.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionListToJson(QuestionList instance) =>
    <String, dynamic>{
      'response_code': dumpResponseCode(instance.status),
      'results': instance.questions,
    };
