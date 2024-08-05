import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

dynamic customResponseStatus(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 201:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString(), 400);
    case 401:
      throw UnauthorizedException(response.body.toString(), 401);
    case 403:
      throw ForbiddenException(response.body.toString(), 403);
    case 404:
      throw NotFoundException(response.body.toString(), 404);
    case 500:
      throw InternalErrorException(response.body.toString(), 500);
    default:
      throw FetchDataException();
  }
}

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

class FetchDataException extends CustomException {
  FetchDataException([String? message])
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
