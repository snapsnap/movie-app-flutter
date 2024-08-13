import 'package:flutter/material.dart';
import 'package:movie_app/network/repository/movie_lists_api.dart';

import '../network/models/mdl_now_playing.dart';

class MovieProvider extends ChangeNotifier {
  final movieListApi = MovieListsApi();
  var _nowPlayingList = <ResultsNp>[];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<ResultsNp> get nowPlayingList => _nowPlayingList;

  Future<void> getNowPlayingList() async {
    _isLoading = true;
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
}
