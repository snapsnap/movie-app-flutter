import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../config/env.dart';
import 'custom_exception.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String baseUrl)
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: Env.timeOutRequest),
            receiveTimeout: const Duration(seconds: Env.timeOutRequest),
            headers: {
              'accept': 'application/json',
            },
          ),
        ) {
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          inspect(options);
          // Tambahkan token otomatis ke setiap request
          final token = await _getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          inspect(response);
          handler.next(response); // Lanjutkan response
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            // _retfreshAndRetry(error, handler);
          } else if (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout) {
            throw TimeoutRequestException();
          } else if (error.type == DioExceptionType.unknown &&
              error.error is SocketException) {
            throw NoConnectionException();
          }
          handler.next(error); // Lanjutkan error lainnya
        },
      ),
    );
  }

  _retfreshAndRetry(DioException error, ErrorInterceptorHandler handler) async {
    // Tangani token expired
    final success = await _refreshToken();
    if (success) {
      // Retry request dengan token baru
      final options = error.requestOptions;
      final token = await _getAccessToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      final retryResponse = await _dio.request(
        options.path,
        options: Options(
          method: options.method,
          headers: options.headers,
        ),
        data: options.data,
        queryParameters: options.queryParameters,
      );
      return handler.resolve(retryResponse);
    } else {
      // Redirect ke login jika refresh token gagal
      throw UnauthorizedException("Session expired. Please login again.");
    }
  }

  Future<String?> _getAccessToken() async {
    // return await StorageService().getSavedToken();
    return Env.apiReadAccessToken;
  }

  Future<bool> _refreshToken() async {
    // try {
    //   final refreshToken =
    //       await StorageService().readStorage(ConstStorage.savedRefreshTokenKey);
    //   final response = await _dio.post(
    //     '/oauth/token',
    //     data: {
    //       'grant_type': 'refresh_token',
    //       'refresh_token': refreshToken,
    //       'client_id': Env.clientId,
    //       'client_secret': Env.clientSecret,
    //     },
    //   );

    //   if (response.statusCode == 200) {
    //     await StorageService().writeStorage(
    //         ConstStorage.savedTokenKey, response.data['access_token']);
    //     await StorageService().writeStorage(
    //         ConstStorage.savedRefreshTokenKey, response.data['refresh_token']);
    //     return true;
    //   }
    // } catch (e) {
    //   inspect(e);
    // }
    // return false;
    return true;
  }

  Future<dynamic> getRequest(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final response = await _dio.get(path, queryParameters: query);
    return customResponseStatus(response);
  }

  Future<dynamic> postRequest(
    String path,
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post(path, data: body);
    return customResponseStatus(response);
  }

  Future<dynamic> putRequest(
    String path,
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.put(path, data: body);
    return customResponseStatus(response);
  }

  Future<dynamic> deleteRequest(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final response = await _dio.delete(path, queryParameters: query);
    return customResponseStatus(response);
  }
}
