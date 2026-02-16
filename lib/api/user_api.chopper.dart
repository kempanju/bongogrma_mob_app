// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'user_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$UserAPI extends UserAPI {
  _$UserAPI([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = UserAPI;

  @override
  Future<Response<User>> auth(String authToken, Map<String, dynamic> data) {
    final Uri $url = Uri.parse('/secUser/userDetailById');
    final Map<String, String> $headers = {'Authorization': authToken};
    final $body = data;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<User, User>($request);
  }
}
