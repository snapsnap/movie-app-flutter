import 'package:movie_app/core/common/params/now_playing_params.dart';

import 'package:movie_app/domain/entities/now_playing_entity.dart';

import '../../core/common/params/detail_movie_params.dart';
import '../../domain/entities/detail_movie_entity.dart';
import '../../domain/repositories/home_repo.dart';
import '../datasources/remote/home_rds.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRds homeRds;
  HomeRepoImpl(this.homeRds);

  @override
  Future<DetailMovieEntity> getDetailMovieById(
      {required DetailMovieParams params}) async {
    return await homeRds.getDetailMovieById(params: params);
  }

  @override
  Future<NowPlayingEntity> getNowPlayingMovies(
      {required NowPlayingParams params}) async {
    return await homeRds.getNowPlayingMovies(params: params);
  }

  @override
  Future<NowPlayingEntity> getPopularMovies(
      {required NowPlayingParams params}) async {
    return await homeRds.getPopularMovies(params: params);
  }

  @override
  Future<NowPlayingEntity> getTopRatedMovies(
      {required NowPlayingParams params}) async {
    return await homeRds.getTopRatedMovies(params: params);
  }

  @override
  Future<NowPlayingEntity> getUpcomingMovies(
      {required NowPlayingParams params}) async {
    return await homeRds.getUpcomingMovies(params: params);
  }
}
