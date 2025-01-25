import 'package:movie_app/domain/entities/now_playing_entity.dart';

import '../../core/params/detail_movie_params.dart';
import '../../core/params/now_playing_params.dart';
import '../entities/detail_movie_entity.dart';

abstract class HomeRepo {
  Future<NowPlayingEntity> getNowPlayingMovies({
    required NowPlayingParams params,
  });
  Future<NowPlayingEntity> getPopularMovies({
    required NowPlayingParams params,
  });
  Future<NowPlayingEntity> getTopRatedMovies({
    required NowPlayingParams params,
  });
  Future<NowPlayingEntity> getUpcomingMovies({
    required NowPlayingParams params,
  });
  Future<DetailMovieEntity> getDetailMovieById({
    required DetailMovieParams params,
  });
}
