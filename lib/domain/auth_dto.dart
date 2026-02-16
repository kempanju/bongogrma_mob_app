import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_dto.freezed.dart';
part 'auth_dto.g.dart';

@freezed
abstract class AuthDTO with _$AuthDTO {
  const AuthDTO._();

  const factory AuthDTO({
    String? username,
    String? access_token,
    String? refresh_token,
    String? token_type
  }) = _AuthDTO;

  factory AuthDTO.fromJson(Map<String, dynamic> json) => _$AuthDTOFromJson(json);

}