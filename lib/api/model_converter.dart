import 'dart:async';

import 'package:chopper/chopper.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

class JsonSerializableConverter extends JsonConverter {
  final Map<Type, JsonFactory> factories;

  const JsonSerializableConverter(this.factories);

  T _decodeMap<T>(Map<String, dynamic> values) {
    /// Get jsonFactory using Type parameters
    /// if not found or invalid, throw error or return null
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      throw Exception("Serializer not found!");
    }

    return jsonFactory(values);
  }

  List<T> _decodeIterable<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => _decode<T>(v)).toList();

  dynamic _decode<T>(entity) {
    if (entity is Iterable) return _decodeIterable<T>(entity);

    if (entity is Map<String, dynamic>) {
      if (_isPage(entity)) {
        return _decodeIterable<T>(entity["content"]);
      } else {
        return _decodeMap<T>(entity);
      }
    }
    return entity;
  }

  bool _isPage(Map entity) {
    return entity.containsKey("content") &&
        entity.containsKey("size") &&
        entity.containsKey("number");
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => _decode<T>(v)).toList();


  @override
  FutureOr<Response<ResultType>> convertResponse<ResultType, Item>(
      Response response,
      ) async {
    // use [JsonConverter] to decode json
    final jsonRes = await super.convertResponse(response);

    return jsonRes.copyWith<ResultType>(body: _decode<Item>(jsonRes.body));
  }


}
