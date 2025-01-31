import 'package:go_router/go_router.dart';
import 'package:movie_app/core/di/get_it.dart';
import 'package:movie_app/presentation/movie_detail/screens/detail_movie.dart';
import 'package:movie_app/presentation/parent/screens/parent_tab.dart';
import 'package:provider/provider.dart';

import '../presentation/movie_detail/provider/detail_movie_provider.dart';
import '../presentation/parent/provider/parent_provider.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => ParentProvider(),
        child: const ParentTab(),
      ),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return ChangeNotifierProvider(
          create: (_) => DetailMovieProvider(
            getDetailMovieUseCase: getIt(),
            movieId: id,
          ),
          child: const DetailMovie(),
        );
      },
    ),
  ],
);
