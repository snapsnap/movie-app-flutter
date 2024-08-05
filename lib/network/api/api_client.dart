import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../utils/config.dart';
import 'custom_exception.dart';

class ApiClient {
  Future<dynamic> getData(String url) async {
    dynamic responseJson;

    try {
      final headerApi = {
        "accept": "application/json",
        "Authorization": "Bearer $apiReadAccessToken",
      };
      final response = await http
          .get(Uri.parse(baseURL + url), headers: headerApi)
          .timeout(const Duration(seconds: timeOutRequest));

      responseJson = customResponseStatus(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on TimeoutException {
      throw FetchDataException("Request Timeout");
    }

    return responseJson;
  }

  Future<dynamic> postData(String url, Object? body) async {
    dynamic responseJson;

    try {
      final headerApi = {
        "accept": "application/json",
        "Authorization": "Bearer $apiReadAccessToken",
      };
      final response = await http
          .post(
            Uri.parse(baseURL + url),
            headers: headerApi,
            body: body,
          )
          .timeout(const Duration(seconds: timeOutRequest));

      responseJson = customResponseStatus(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on TimeoutException {
      throw FetchDataException("Request Timeout");
    }
    return responseJson;
  }
}
