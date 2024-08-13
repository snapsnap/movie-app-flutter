import 'dart:convert';

import 'package:movie_app/network/api/api_client.dart';

import '../models/mdl_now_playing.dart';

class MovieListsApi {
  final apiClient = ApiClient();

  Future<NowPlayingModel> getNowPlayingMovies({
    String? language,
    int? page,
  }) async {
    final params = {
      "language": language ?? "en-US",
      "page": page ?? 1,
    };
    final response = await apiClient.getData(
      url: "/3/movie/now_playing",
      queryParameters: params,
    );
    return NowPlayingModel.fromJson(response);
  }

  Future<NowPlayingModel> getPopularMovies({
    String? language,
    int? page,
  }) async {
    final params = {
      "language": language ?? "en-US",
      "page": page ?? 1,
    };
    final response = await apiClient.getData(
      url: "/3/movie/popular",
      queryParameters: params,
    );
    return NowPlayingModel.fromJson(response);
  }

  Future<NowPlayingModel> getTopRatedMovies({
    String? language,
    int? page,
  }) async {
    final params = {
      "language": language ?? "en-US",
      "page": page ?? 1,
    };
    final response = await apiClient.getData(
      url: "/3/movie/top_rated",
      queryParameters: params,
    );
    return NowPlayingModel.fromJson(response);
  }

  Future<NowPlayingModel> getUpcomingMovies({
    String? language,
    int? page,
  }) async {
    final params = {
      "language": language ?? "en-US",
      "page": page ?? 1,
    };
    final response = await apiClient.getData(
      url: "/3/movie/upcoming",
      queryParameters: params,
    );
    return NowPlayingModel.fromJson(response);
  }

  // Future getNoHp(String user, String pass) async {
  //   Object? body = jsonEncode({
  //     "keypaket": keypaket,
  //     "namapaket": namapaket,
  //     "lang": "in",
  //     "user": user,
  //     "pass": pass,
  //   });
  //   final response = await _api.postData(getNoHpUrl, body);
  //   return NowPlayingModel.fromJson(response);
  // }
}
