import 'package:flutter/material.dart';
import 'package:movie_app/core/common/params/now_playing_params.dart';
import 'package:movie_app/domain/entities/now_playing_entity.dart';

import '../../../domain/usecases/movie/get_now_playing_movies.dart';
import '../../../domain/usecases/movie/get_popular_movies.dart';
import '../../../domain/usecases/movie/get_top_rated_movies.dart';
import '../../../domain/usecases/movie/get_upcoming_movies.dart';

enum NowPlayingStatus { initial, loading, success, error }

enum PopularStatus { initial, loading, success, error }

enum TopRatedStatus { initial, loading, success, error }

enum UpcomingStatus { initial, loading, success, error }

class MovieProvider extends ChangeNotifier {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;

  MovieProvider({
    required this.getNowPlayingMoviesUseCase,
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
    required this.getUpcomingMoviesUseCase,
  }) {
    _initialize();
  }

  NowPlayingStatus nowPlayingStatus = NowPlayingStatus.initial;
  PopularStatus popularStatus = PopularStatus.initial;
  TopRatedStatus topRatedStatus = TopRatedStatus.initial;
  UpcomingStatus upcomingStatus = UpcomingStatus.initial;

  String errorMessage = "";

  var _nowPlayingList = <ResultsNpEntity>[];
  var _popularList = <ResultsNpEntity>[];
  var _topRatedList = <ResultsNpEntity>[];
  var _upcomingList = <ResultsNpEntity>[];

  List<ResultsNpEntity> get nowPlayingList => _nowPlayingList;
  List<ResultsNpEntity> get popularList => _popularList;
  List<ResultsNpEntity> get topRatedList => _topRatedList;
  List<ResultsNpEntity> get upcomingList => _upcomingList;

  void _initialize() {
    getNowPlayingList();
    getPopularList();
    getTopRatedList();
    getUpcomingList();
  }

  Future<void> refreshPage() async {
    _initialize();
  }

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
}
