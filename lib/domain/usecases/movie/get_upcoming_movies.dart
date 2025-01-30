import 'package:movie_app/core/usecase/param_usecase.dart';

import '../../../core/common/params/now_playing_params.dart';
import '../../entities/now_playing_entity.dart';
import '../../repositories/home_repo.dart';

class GetUpcomingMoviesUseCase
    implements ParamUseCase<NowPlayingEntity, NowPlayingParams> {
  final HomeRepo repository;
  GetUpcomingMoviesUseCase(this.repository);

  @override
  Future<NowPlayingEntity> call(NowPlayingParams params) async {
    return await repository.getUpcomingMovies(params: params);
  }
}
