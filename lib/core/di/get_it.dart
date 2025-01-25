import 'package:get_it/get_it.dart';
import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/data/datasources/remote/home_rds.dart';
import 'package:movie_app/domain/usecases/movie/get_detail_movie.dart';
import 'package:movie_app/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:movie_app/domain/usecases/movie/get_popular_movies.dart';
import 'package:movie_app/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:movie_app/domain/usecases/movie/get_upcoming_movies.dart';
import 'package:movie_app/presentation/home/provider/movie_provider.dart';

import '../../data/repositories/home_repo_impl.dart';
import '../../domain/repositories/home_repo.dart';
import '../config/env.dart';

var getIt = GetIt.instance;

Future<void> setup() async {
  registerApiClient();
  registerDataSources();
  registerRepositories();
  registerUseCases();
  registerProviders();
}

void registerApiClient() async {
  getIt.registerSingleton(ApiClient(Env.baseURL));
}

void registerDataSources() async {
  getIt.registerSingleton<HomeRds>(HomeRdsImpl(getIt()));
}

void registerRepositories() async {
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl(getIt()));
}

void registerUseCases() async {
  getIt.registerSingleton(GetDetailMovieUseCase(getIt()));
  getIt.registerSingleton(GetNowPlayingMoviesUseCase(getIt()));
  getIt.registerSingleton(GetPopularMoviesUseCase(getIt()));
  getIt.registerSingleton(GetTopRatedMoviesUseCase(getIt()));
  getIt.registerSingleton(GetUpcomingMoviesUseCase(getIt()));
}

void registerProviders() async {
  getIt.registerSingleton(MovieProvider(
      getDetailMovieUseCase: getIt(),
      getNowPlayingMoviesUseCase: getIt(),
      getPopularMoviesUseCase: getIt(),
      getTopRatedMoviesUseCase: getIt(),
      getUpcomingMoviesUseCase: getIt()));
}
