class NowPlayingEntity {
  DatesEntity? dates;
  int? page;
  List<ResultsNpEntity>? results;
  int? totalPages;
  int? totalResults;

  NowPlayingEntity({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });
}

class DatesEntity {
  String? maximum;
  String? minimum;

  DatesEntity({
    this.maximum,
    this.minimum,
  });
}

class ResultsNpEntity {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  ResultsNpEntity({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
}
