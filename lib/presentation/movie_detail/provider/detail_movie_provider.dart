import 'package:flutter/material.dart';

import '../../../core/params/detail_movie_params.dart';
import '../../../domain/entities/detail_movie_entity.dart';
import '../../../domain/usecases/movie/get_detail_movie.dart';

enum DetailMovieStatus { initial, loading, success, error }

class DetailMovieProvider extends ChangeNotifier {
  final GetDetailMovieUseCase getDetailMovieUseCase;

  DetailMovieProvider({
    required this.getDetailMovieUseCase,
  });

  DetailMovieStatus detailMovieStatus = DetailMovieStatus.initial;

  String errorMessage = "";

  var _detailMovie = DetailMovieEntity();
  DetailMovieEntity get detailMovie => _detailMovie;

  void resetData() {
    _detailMovie = DetailMovieEntity();
    notifyListeners();
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
