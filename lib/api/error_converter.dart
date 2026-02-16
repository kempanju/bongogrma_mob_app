import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';

import '../domain/app_error.dart';

String resolveAPIError(dynamic error) {
  if (error is Response) {
    return error.body.toString();
  } else if (error is SocketException) {
    return "Failed to connect to server";
  } else
    return error.toString();
}

class APIErrorConverter implements ErrorConverter {
  @override
  FutureOr<Response> convertError<BodyType, InnerType>(
      Response response) async {
    String responseBody = response.body;

    String message = "";

    if (responseBody.isNotEmpty) {
      var error = json.decode(responseBody);

      if (error is Map) {
        if (error.containsKey("message")) message = error['message'];
      }
    }
    if (message.isEmpty) message = response.body.toString();

    String type = toErrorType(response.statusCode);

    return response.copyWith(
      body: AppError(type, message),
    );
  }

  String toErrorType(int statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad Request";
      case 401:
      case 403:
        return "Unauthorised";
      case 404:
        return "Not Found";
      case 500:
      default:
        return "Server error";
    }
  }
}
