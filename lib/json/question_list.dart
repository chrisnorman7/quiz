/// Provides the [QuestionList] class.
import 'package:json_annotation/json_annotation.dart';

import 'question.dart';
import 'response_codes.dart';

part 'question_list.g.dart';

@JsonSerializable()
class QuestionList {
  QuestionList({this.status, this.questions});

  @JsonKey(
      name: 'response_code',
      toJson: dumpResponseCode,
      fromJson: loadResponseCode)
  ResponseCodes status;

  @JsonKey(name: 'results')
  final List<Question> questions;

  factory QuestionList.fromJson(Map<String, dynamic> json) =>
      _$QuestionListFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionListToJson(this);
}
