/// Provides the [TokenRequest] class.
import 'package:json_annotation/json_annotation.dart';
import 'package:quiz/json/response_codes.dart';

part 'token_request.g.dart';

@JsonSerializable(nullable: false)
class TokenRequest {
  // ignore: non_constant_identifier_names
  TokenRequest({this.status, this.message, this.token});

  @JsonKey(
      name: 'response_code',
      fromJson: loadResponseCode,
      toJson: dumpResponseCode)
  ResponseCodes status;

  @JsonKey(name: 'response_message')
  final String message;

  final String token;

  factory TokenRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TokenRequestToJson(this);
}
