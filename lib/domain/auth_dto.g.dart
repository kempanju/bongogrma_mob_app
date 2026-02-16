// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthDTO _$AuthDTOFromJson(Map<String, dynamic> json) => _AuthDTO(
  username: json['username'] as String?,
  access_token: json['access_token'] as String?,
  refresh_token: json['refresh_token'] as String?,
  token_type: json['token_type'] as String?,
);

Map<String, dynamic> _$AuthDTOToJson(_AuthDTO instance) => <String, dynamic>{
  'username': instance.username,
  'access_token': instance.access_token,
  'refresh_token': instance.refresh_token,
  'token_type': instance.token_type,
};
