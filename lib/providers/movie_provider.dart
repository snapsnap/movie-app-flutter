import 'package:flutter/material.dart';
import 'package:movie_app/network/repository/movie_lists_api.dart';

import '../network/models/mdl_detail_movie.dart';
import '../network/models/mdl_now_playing.dart';

class MovieProvider extends ChangeNotifier {
  final movieListApi = MovieListsApi();

  var _nowPlayingList = <ResultsNp>[];
  var _popularList = <ResultsNp>[];
  var _topRatedList = <ResultsNp>[];
  var _upcomingList = <ResultsNp>[];
  var _detailMovie = DetailMovieModel();

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<ResultsNp> get nowPlayingList => _nowPlayingList;
  List<ResultsNp> get popularList => _popularList;
  List<ResultsNp> get topRatedList => _topRatedList;
  List<ResultsNp> get upcomingList => _upcomingList;
  DetailMovieModel get detailMovie => _detailMovie;

  Future<void> getNowPlayingList() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await movieListApi.getNowPlayingMovies();
      _isLoading = false;
      _nowPlayingList = result.results!;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      debugPrint(e.toString());
      notifyListeners();
    }
  }

  Future<void> getPopularList() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await movieListApi.getPopularMovies();
      _isLoading = false;
      _popularList = result.results!;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      debugPrint(e.toString());
      notifyListeners();
    }
  }

  Future<void> getTopRatedList() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await movieListApi.getTopRatedMovies();
      _isLoading = false;
      _topRatedList = result.results!;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      debugPrint(e.toString());
      notifyListeners();
    }
  }

  Future<void> getUpcomingList() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await movieListApi.getUpcomingMovies();
      _isLoading = false;
      _upcomingList = result.results!;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      debugPrint(e.toString());
      notifyListeners();
    }
  }

  Future<void> getDetailMovie({required String movieId}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await movieListApi.getDetailMovieById(movieId: movieId);
      _isLoading = false;
      _detailMovie = result;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      debugPrint(e.toString());
      notifyListeners();
    }
  }
}
