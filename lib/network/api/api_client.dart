import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../utils/config.dart';
import 'custom_exception.dart';

class ApiClient {
  Future<dynamic> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    dynamic responseJson;

    try {
      final headerApi = {
        "accept": "application/json",
        "Authorization": "Bearer $apiReadAccessToken",
      };
      final queryParams = queryParameters!.map(
        (key, value) => MapEntry(key, value.toString()),
      );
      final uri = Uri(
        scheme: 'https',
        host: baseURL,
        path: url,
        queryParameters: queryParams,
      );
      final response = await http
          .get(uri, headers: headerApi)
          .timeout(const Duration(seconds: timeOutRequest));
      debugPrint("res: ${response.statusCode}");

      responseJson = customResponseStatus(response);
    } on SocketException {
      debugPrint("no internet");
      throw FetchDataException("No Internet Connection");
    } on TimeoutException {
      debugPrint("timeout");
      throw FetchDataException("Request Timeout");
    }

    return responseJson;
  }

  Future<dynamic> postData({required String url, Object? body}) async {
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
