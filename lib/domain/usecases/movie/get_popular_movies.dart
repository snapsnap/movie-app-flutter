import '../../../core/common/params/now_playing_params.dart';
import '../../../core/usecase/param_usecase.dart';
import '../../entities/now_playing_entity.dart';
import '../../repositories/home_repo.dart';

class GetPopularMoviesUseCase
    implements ParamUseCase<NowPlayingEntity, NowPlayingParams> {
  final HomeRepo repository;
  GetPopularMoviesUseCase(this.repository);

  @override
  Future<NowPlayingEntity> call(NowPlayingParams params) async {
    return await repository.getPopularMovies(params: params);
  }
}
