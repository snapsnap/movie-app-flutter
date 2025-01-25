import 'package:movie_app/core/usecase/param_usecase.dart';

import '../../../core/params/now_playing_params.dart';
import '../../entities/now_playing_entity.dart';
import '../../repositories/home_repo.dart';

class GetTopRatedMoviesUseCase
    implements ParamUseCase<NowPlayingEntity, NowPlayingParams> {
  final HomeRepo repository;
  GetTopRatedMoviesUseCase(this.repository);

  @override
  Future<NowPlayingEntity> call(NowPlayingParams params) async {
    return await repository.getTopRatedMovies(params: params);
  }
}
