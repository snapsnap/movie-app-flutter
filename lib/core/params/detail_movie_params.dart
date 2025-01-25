class DetailMovieParams {
  final String movieId;
  final String? language;
  final String? appendToResponse;

  DetailMovieParams({
    required this.movieId,
    this.language,
    this.appendToResponse,
  });
}
