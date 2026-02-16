// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthDTO {

 String? get username; String? get access_token; String? get refresh_token; String? get token_type;
/// Create a copy of AuthDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthDTOCopyWith<AuthDTO> get copyWith => _$AuthDTOCopyWithImpl<AuthDTO>(this as AuthDTO, _$identity);

  /// Serializes this AuthDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthDTO&&(identical(other.username, username) || other.username == username)&&(identical(other.access_token, access_token) || other.access_token == access_token)&&(identical(other.refresh_token, refresh_token) || other.refresh_token == refresh_token)&&(identical(other.token_type, token_type) || other.token_type == token_type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,access_token,refresh_token,token_type);

@override
String toString() {
  return 'AuthDTO(username: $username, access_token: $access_token, refresh_token: $refresh_token, token_type: $token_type)';
}


}

/// @nodoc
abstract mixin class $AuthDTOCopyWith<$Res>  {
  factory $AuthDTOCopyWith(AuthDTO value, $Res Function(AuthDTO) _then) = _$AuthDTOCopyWithImpl;
@useResult
$Res call({
 String? username, String? access_token, String? refresh_token, String? token_type
});




}
/// @nodoc
class _$AuthDTOCopyWithImpl<$Res>
    implements $AuthDTOCopyWith<$Res> {
  _$AuthDTOCopyWithImpl(this._self, this._then);

  final AuthDTO _self;
  final $Res Function(AuthDTO) _then;

/// Create a copy of AuthDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = freezed,Object? access_token = freezed,Object? refresh_token = freezed,Object? token_type = freezed,}) {
  return _then(_self.copyWith(
username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,access_token: freezed == access_token ? _self.access_token : access_token // ignore: cast_nullable_to_non_nullable
as String?,refresh_token: freezed == refresh_token ? _self.refresh_token : refresh_token // ignore: cast_nullable_to_non_nullable
as String?,token_type: freezed == token_type ? _self.token_type : token_type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthDTO].
extension AuthDTOPatterns on AuthDTO {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthDTO() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthDTO value)  $default,){
final _that = this;
switch (_that) {
case _AuthDTO():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthDTO value)?  $default,){
final _that = this;
switch (_that) {
case _AuthDTO() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? username,  String? access_token,  String? refresh_token,  String? token_type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthDTO() when $default != null:
return $default(_that.username,_that.access_token,_that.refresh_token,_that.token_type);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? username,  String? access_token,  String? refresh_token,  String? token_type)  $default,) {final _that = this;
switch (_that) {
case _AuthDTO():
return $default(_that.username,_that.access_token,_that.refresh_token,_that.token_type);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? username,  String? access_token,  String? refresh_token,  String? token_type)?  $default,) {final _that = this;
switch (_that) {
case _AuthDTO() when $default != null:
return $default(_that.username,_that.access_token,_that.refresh_token,_that.token_type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthDTO extends AuthDTO {
  const _AuthDTO({this.username, this.access_token, this.refresh_token, this.token_type}): super._();
  factory _AuthDTO.fromJson(Map<String, dynamic> json) => _$AuthDTOFromJson(json);

@override final  String? username;
@override final  String? access_token;
@override final  String? refresh_token;
@override final  String? token_type;

/// Create a copy of AuthDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthDTOCopyWith<_AuthDTO> get copyWith => __$AuthDTOCopyWithImpl<_AuthDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthDTO&&(identical(other.username, username) || other.username == username)&&(identical(other.access_token, access_token) || other.access_token == access_token)&&(identical(other.refresh_token, refresh_token) || other.refresh_token == refresh_token)&&(identical(other.token_type, token_type) || other.token_type == token_type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,access_token,refresh_token,token_type);

@override
String toString() {
  return 'AuthDTO(username: $username, access_token: $access_token, refresh_token: $refresh_token, token_type: $token_type)';
}


}

/// @nodoc
abstract mixin class _$AuthDTOCopyWith<$Res> implements $AuthDTOCopyWith<$Res> {
  factory _$AuthDTOCopyWith(_AuthDTO value, $Res Function(_AuthDTO) _then) = __$AuthDTOCopyWithImpl;
@override @useResult
$Res call({
 String? username, String? access_token, String? refresh_token, String? token_type
});




}
/// @nodoc
class __$AuthDTOCopyWithImpl<$Res>
    implements _$AuthDTOCopyWith<$Res> {
  __$AuthDTOCopyWithImpl(this._self, this._then);

  final _AuthDTO _self;
  final $Res Function(_AuthDTO) _then;

/// Create a copy of AuthDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = freezed,Object? access_token = freezed,Object? refresh_token = freezed,Object? token_type = freezed,}) {
  return _then(_AuthDTO(
username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,access_token: freezed == access_token ? _self.access_token : access_token // ignore: cast_nullable_to_non_nullable
as String?,refresh_token: freezed == refresh_token ? _self.refresh_token : refresh_token // ignore: cast_nullable_to_non_nullable
as String?,token_type: freezed == token_type ? _self.token_type : token_type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
