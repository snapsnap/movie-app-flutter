import 'package:flutter/material.dart';
import 'package:movie_app/core/params/now_playing_params.dart';
import 'package:movie_app/domain/entities/detail_movie_entity.dart';
import 'package:movie_app/domain/entities/now_playing_entity.dart';
import 'package:movie_app/domain/usecases/movie/get_detail_movie.dart';

import '../../../core/params/detail_movie_params.dart';
import '../../../domain/usecases/movie/get_now_playing_movies.dart';
import '../../../domain/usecases/movie/get_popular_movies.dart';
import '../../../domain/usecases/movie/get_top_rated_movies.dart';
import '../../../domain/usecases/movie/get_upcoming_movies.dart';

enum NowPlayingStatus { initial, loading, success, error }

enum PopularStatus { initial, loading, success, error }

enum TopRatedStatus { initial, loading, success, error }

enum UpcomingStatus { initial, loading, success, error }

enum DetailMovieStatus { initial, loading, success, error }

class MovieProvider extends ChangeNotifier {
  final GetDetailMovieUseCase getDetailMovieUseCase;
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;

  MovieProvider({
    required this.getDetailMovieUseCase,
    required this.getNowPlayingMoviesUseCase,
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
    required this.getUpcomingMoviesUseCase,
  });

  NowPlayingStatus nowPlayingStatus = NowPlayingStatus.initial;
  PopularStatus popularStatus = PopularStatus.initial;
  TopRatedStatus topRatedStatus = TopRatedStatus.initial;
  UpcomingStatus upcomingStatus = UpcomingStatus.initial;
  DetailMovieStatus detailMovieStatus = DetailMovieStatus.initial;

  String errorMessage = "";

  var _nowPlayingList = <ResultsNpEntity>[];
  var _popularList = <ResultsNpEntity>[];
  var _topRatedList = <ResultsNpEntity>[];
  var _upcomingList = <ResultsNpEntity>[];
  var _detailMovie = DetailMovieEntity();

  List<ResultsNpEntity> get nowPlayingList => _nowPlayingList;
  List<ResultsNpEntity> get popularList => _popularList;
  List<ResultsNpEntity> get topRatedList => _topRatedList;
  List<ResultsNpEntity> get upcomingList => _upcomingList;
  DetailMovieEntity get detailMovie => _detailMovie;

  Future<void> getNowPlayingList() async {
    nowPlayingStatus = NowPlayingStatus.loading;
    notifyListeners();
    try {
      final params = NowPlayingParams();
      final result = await getNowPlayingMoviesUseCase.call(params);
      nowPlayingStatus = NowPlayingStatus.success;
      _nowPlayingList = result.results!;
      notifyListeners();
    } catch (e) {
      nowPlayingStatus = NowPlayingStatus.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> getPopularList() async {
    popularStatus = PopularStatus.loading;
    notifyListeners();
    try {
      final params = NowPlayingParams();
      final result = await getPopularMoviesUseCase.call(params);
      popularStatus = PopularStatus.success;
      _popularList = result.results!;
      notifyListeners();
    } catch (e) {
      popularStatus = PopularStatus.error;
      notifyListeners();
    }
  }

  Future<void> getTopRatedList() async {
    topRatedStatus = TopRatedStatus.loading;
    notifyListeners();
    try {
      final params = NowPlayingParams();
      final result = await getTopRatedMoviesUseCase.call(params);
      topRatedStatus = TopRatedStatus.success;
      _topRatedList = result.results!;
      notifyListeners();
    } catch (e) {
      topRatedStatus = TopRatedStatus.error;
      notifyListeners();
    }
  }

  Future<void> getUpcomingList() async {
    upcomingStatus = UpcomingStatus.loading;
    notifyListeners();
    try {
      final params = NowPlayingParams();
      final result = await getUpcomingMoviesUseCase.call(params);
      upcomingStatus = UpcomingStatus.success;
      _upcomingList = result.results!;
      notifyListeners();
    } catch (e) {
      upcomingStatus = UpcomingStatus.error;
      notifyListeners();
    }
  }

  Future<void> getDetailMovie({required String movieId}) async {
    detailMovieStatus = DetailMovieStatus.loading;
    notifyListeners();
    try {
      final params = DetailMovieParams(
        movieId: movieId,
      );
      final result = await getDetailMovieUseCase.call(params);
      detailMovieStatus = DetailMovieStatus.success;
      _detailMovie = result;
      notifyListeners();
    } catch (e) {
      detailMovieStatus = DetailMovieStatus.error;
      notifyListeners();
    }
  }
}
