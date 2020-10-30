// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRequest _$TokenRequestFromJson(Map<String, dynamic> json) {
  return TokenRequest(
    status: loadResponseCode(json['response_code'] as int),
    message: json['response_message'] as String,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$TokenRequestToJson(TokenRequest instance) =>
    <String, dynamic>{
      'response_code': dumpResponseCode(instance.status),
      'response_message': instance.message,
      'token': instance.token,
    };
