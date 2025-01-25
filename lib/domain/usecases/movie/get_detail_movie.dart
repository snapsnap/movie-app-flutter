import 'package:movie_app/core/params/detail_movie_params.dart';
import 'package:movie_app/core/usecase/param_usecase.dart';
import 'package:movie_app/domain/entities/detail_movie_entity.dart';
import 'package:movie_app/domain/repositories/home_repo.dart';

class GetDetailMovieUseCase
    implements ParamUseCase<DetailMovieEntity, DetailMovieParams> {
  final HomeRepo homeRepo;
  GetDetailMovieUseCase(this.homeRepo);

  @override
  Future<DetailMovieEntity> call(DetailMovieParams params) async {
    return await homeRepo.getDetailMovieById(params: params);
  }
}
