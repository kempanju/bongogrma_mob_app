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

  @override
  Future<Response<ResponseDTO>> blockUser(
    String authToken,
    Map<String, dynamic> data,
  ) {
    final Uri $url = Uri.parse('/secUser/blockUser');
    final Map<String, String> $headers = {'Authorization': authToken};
    final $body = data;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ResponseDTO, ResponseDTO>($request);
  }

  @override
  Future<Response<ResponseDTO>> searchUser(
    String authToken,
    Map<String, dynamic> data,
  ) {
    final Uri $url = Uri.parse('/secUser/searchUser');
    final Map<String, String> $headers = {'Authorization': authToken};
    final $body = data;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ResponseDTO, ResponseDTO>($request);
  }

  @override
  Future<Response<ResponseDTO>> changeFollowStatus(
    String authToken,
    Map<String, dynamic> data,
  ) {
    final Uri $url = Uri.parse('/secUser/changeFollowStatus');
    final Map<String, String> $headers = {'Authorization': authToken};
    final $body = data;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ResponseDTO, ResponseDTO>($request);
  }

  @override
  Future<Response<ResponseDTO>> verifyUser(
    String authToken,
    Map<String, dynamic> data,
  ) {
    final Uri $url = Uri.parse('/secUser/verifyUser');
    final Map<String, String> $headers = {'Authorization': authToken};
    final $body = data;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ResponseDTO, ResponseDTO>($request);
  }

  @override
  Future<Response<ResponseDTO>> myProfile(
    String authToken,
    Map<String, dynamic> data,
  ) {
    final Uri $url = Uri.parse('/secUser/myProfile');
    final Map<String, String> $headers = {'Authorization': authToken};
    final $body = data;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ResponseDTO, ResponseDTO>($request);
  }

  @override
  Future<Response<ResponseDTO>> updateMyProfile(
    String authToken,
    Map<String, dynamic> data,
  ) {
    final Uri $url = Uri.parse('/secUser/updateMyProfile');
    final Map<String, String> $headers = {'Authorization': authToken};
    final $body = data;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<ResponseDTO, ResponseDTO>($request);
  }
}
