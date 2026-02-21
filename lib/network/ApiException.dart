class ApiException implements Exception {
  final String? message;
  final String? _prefix;
  ApiException([this.message, this._prefix]);

  @override
  String toString() {
    return '$message$_prefix';
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String? message])
      : super(message, 'Error with Connection');
}

class BadRequestException extends ApiException {
  BadRequestException([String? message]) : super(message, 'Bad Request');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized Request');
}

class InvalidException extends ApiException {
  InvalidException([String? message]) : super(message, 'Invalid Request');
}