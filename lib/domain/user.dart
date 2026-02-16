import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
@HiveType(typeId: 6, adapterName: 'UserAdapter')
abstract class User with _$User {
  static String OFFLINE_STORAGE_NAME = "USERS";

  const User._();

  const factory User(
    @HiveField(0) int id,
    @HiveField(1) String loginId,
    @HiveField(2) String name
  ) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
