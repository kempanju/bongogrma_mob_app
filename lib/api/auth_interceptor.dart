import 'dart:async';

import 'package:chopper/chopper.dart';

import '../service/authentication_service.dart';


class CollectUserAuthInterceptor implements Authenticator {

  @override
  FutureOr<Request?> authenticate(Request request, Response response, [Request? originalRequest]) {
    if (AuthenticationService.authToken == null) return request;

    final h = Map<String, String>.from(request.headers);
    h[AuthenticationService.AUTH_TOKEN_HEADER_KEY] = AuthenticationService.authToken!;
    request.headers.addAll(h);
    return request;
  }

  @override
  // TODO: implement onAuthenticationFailed
  AuthenticationCallback? get onAuthenticationFailed => throw UnimplementedError();

  @override
  // TODO: implement onAuthenticationSuccessful
  AuthenticationCallback? get onAuthenticationSuccessful => throw UnimplementedError();
}
