// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'auth_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AuthAPI extends AuthAPI {
  _$AuthAPI([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AuthAPI;

  @override
  Future<Response<AuthDTO>> accessToken(Map<String, dynamic> mobile) {
    final Uri $url = Uri.parse('/login');
    final $body = mobile;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<AuthDTO, AuthDTO>($request);
  }
}
