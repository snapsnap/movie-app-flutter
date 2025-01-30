import 'package:movie_app/domain/repositories/home_repo.dart';

import '../../../core/common/params/now_playing_params.dart';
import '../../../core/usecase/param_usecase.dart';
import '../../entities/now_playing_entity.dart';

class GetNowPlayingMoviesUseCase
    implements ParamUseCase<NowPlayingEntity, NowPlayingParams> {
  final HomeRepo repository;
  GetNowPlayingMoviesUseCase(this.repository);

  @override
  Future<NowPlayingEntity> call(NowPlayingParams params) async {
    return await repository.getNowPlayingMovies(params: params);
  }
}
