import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/data/models/mdl_now_playing.dart';

import '../../../core/common/params/detail_movie_params.dart';
import '../../../core/common/params/now_playing_params.dart';
import '../../models/mdl_detail_movie.dart';

abstract interface class HomeRds {
  Future<NowPlayingModel> getNowPlayingMovies(
      {required NowPlayingParams params});
  Future<NowPlayingModel> getPopularMovies({required NowPlayingParams params});
  Future<NowPlayingModel> getTopRatedMovies({required NowPlayingParams params});
  Future<NowPlayingModel> getUpcomingMovies({required NowPlayingParams params});
  Future<DetailMovieModel> getDetailMovieById(
      {required DetailMovieParams params});
}

class HomeRdsImpl implements HomeRds {
  final ApiClient apiClient;
  HomeRdsImpl(this.apiClient);

  @override
  Future<NowPlayingModel> getNowPlayingMovies(
      {required NowPlayingParams params}) async {
    final body = {
      "language": params.language ?? "en-US",
      "page": params.page ?? 1,
    };
    final data = await apiClient.getRequest(
      "/3/movie/now_playing",
      query: body,
    );
    return NowPlayingModel.fromJson(data);
  }

  @override
  Future<DetailMovieModel> getDetailMovieById(
      {required DetailMovieParams params}) async {
    final body = {
      "language": params.language ?? "en-US",
      "append_to_response": params.appendToResponse ?? "",
    };
    final data = await apiClient.getRequest(
      "/3/movie/${params.movieId}",
      query: body,
    );
    return DetailMovieModel.fromJson(data);
  }

  @override
  Future<NowPlayingModel> getPopularMovies(
      {required NowPlayingParams params}) async {
    final body = {
      "language": params.language ?? "en-US",
      "page": params.page ?? 1,
    };
    final data = await apiClient.getRequest(
      "/3/movie/popular",
      query: body,
    );
    return NowPlayingModel.fromJson(data);
  }

  @override
  Future<NowPlayingModel> getTopRatedMovies(
      {required NowPlayingParams params}) async {
    final body = {
      "language": params.language ?? "en-US",
      "page": params.page ?? 1,
    };
    final data = await apiClient.getRequest(
      "/3/movie/top_rated",
      query: body,
    );
    return NowPlayingModel.fromJson(data);
  }

  @override
  Future<NowPlayingModel> getUpcomingMovies(
      {required NowPlayingParams params}) async {
    final body = {
      "language": params.language ?? "en-US",
      "page": params.page ?? 1,
    };
    final data = await apiClient.getRequest(
      "/3/movie/upcoming",
      query: body,
    );
    return NowPlayingModel.fromJson(data);
  }
}
