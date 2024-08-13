import 'package:go_router/go_router.dart';
import 'package:movie_app/screens/detail_movie.dart';
import 'package:movie_app/screens/parent_tab.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ParentTab(),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final id = state.pathParameters["id"]!;
        return DetailMovie(movieId: id);
      },
    ),
  ],
);
