enum StatusRequest {
  loading ,
  success ,
  failure ,
  serverfailure ,
  timeoutfailure ,
  offlinefailure ,
  stop,
  pleaseCheckAfterSomeTime,
  noInternetException

}


class Failure {
  Failure({this.message = ''});
  final String message;
}

class APIFailure extends Failure {
  APIFailure({String message = ''}) : super(message: message);
}

class InternetConnectionFailure extends Failure {
  InternetConnectionFailure({String message = ''}) : super(message: message);
}


class AuthorizationFailure extends Failure {
  AuthorizationFailure({String message = ''}) : super(message: message);
}

class TimeoutFailure extends Failure {
  TimeoutFailure({String message = ''}) : super(message: message);
}

class ServerDownFailure extends Failure {
  ServerDownFailure({String message = ''}) : super(message: message);
}


class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class NoInternetException extends AppException {
  NoInternetException([String message = ''])
      : super(message, "Error During Communication: ");
}

class FetchDataException extends AppException {
  FetchDataException([String message = ''])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([message]) : super(message, "");
}

class TokenExpiredException extends AppException {
  TokenExpiredException([message]) : super(message, "Token expired: ");
}

class NotFoundException extends AppException {
  NotFoundException([message]) : super(message, "No Data: ");
}