import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_dto.freezed.dart';
part 'response_dto.g.dart';

@freezed
abstract class ResponseDTO with _$ResponseDTO {
  const ResponseDTO._();

  const factory ResponseDTO({
    int? code,
    String? message,
    String? status
  }) = _ResponseDTO;

  factory ResponseDTO.fromJson(Map<String, dynamic> json) => _$ResponseDTOFromJson(json);

}