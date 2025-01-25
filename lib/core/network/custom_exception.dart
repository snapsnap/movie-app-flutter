import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CustomException implements Exception {
  final dynamic _message;
  final dynamic _prefix;
  final dynamic _statusCode;

  CustomException([this._message, this._prefix, this._statusCode]);

  @override
  String toString() {
    debugPrint("Error Custom Exception {$_prefix $_statusCode $_message}");
    return "$_prefix";
  }
}

dynamic customResponseStatus(Response response) {
  if (response.statusCode! >= 200 && response.statusCode! < 300) {
    return response.data;
  }
  switch (response.statusCode) {
    case 400:
      throw BadRequestException(response.statusMessage.toString(), 400);
    case 401:
      throw UnauthorizedException(response.statusMessage.toString(), 401);
    case 403:
      throw ForbiddenException(response.statusMessage.toString(), 403);
    case 404:
      throw NotFoundException(response.statusMessage.toString(), 404);
    case 500:
      throw InternalErrorException(response.statusMessage.toString(), 500);
    default:
      throw FetchDataException();
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "Gagal Terhubung");
}

class NoConnectionException extends CustomException {
  NoConnectionException([String? message])
      : super(message, "No Internet Connection");
}

class TimeoutRequestException extends CustomException {
  TimeoutRequestException([String? message])
      : super(message, "Request Timeout");
}

class BadRequestException extends CustomException {
  BadRequestException([message, int? statusCode])
      : super(message, "Invalid Request: ", statusCode);
}

class ForbiddenException extends CustomException {
  ForbiddenException([message, int? statusCode])
      : super(message, "Forbidden Access: ", statusCode);
}

class NotFoundException extends CustomException {
  NotFoundException([message, int? statusCode])
      : super(message, "Request Not Found: ", statusCode);
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message, int? statusCode])
      : super(message, "Unauthorized: ", statusCode);
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message, int? statusCode])
      : super(message, "Invalid Input: ", statusCode);
}

class InternalErrorException extends CustomException {
  InternalErrorException([String? message, int? statusCode])
      : super(message, "Internal Server Error: ", statusCode);
}
