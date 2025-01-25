import 'package:movie_app/domain/entities/now_playing_entity.dart';

class NowPlayingModel extends NowPlayingEntity {
  NowPlayingModel({
    super.dates,
    super.page,
    super.results,
    super.totalPages,
    super.totalResults,
  });

  factory NowPlayingModel.fromJson(Map<String, dynamic> json) {
    return NowPlayingModel(
      dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
      page: json['page'] as int?,
      results: json['results'] != null
          ? List<ResultsNp>.from(
              (json['results'] as List).map((v) => ResultsNp.fromJson(v)),
            )
          : <ResultsNp>[],
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dates is Dates) {
      data['dates'] = (dates as Dates).toJson(); // Use the model's `toJson`
    }
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => (v as ResultsNp).toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Dates extends DatesEntity {
  Dates({
    super.maximum,
    super.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: json['maximum'] as String?,
      minimum: json['minimum'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maximum': maximum,
      'minimum': minimum,
    };
  }
}

class ResultsNp extends ResultsNpEntity {
  ResultsNp({
    super.adult,
    super.backdropPath,
    super.genreIds,
    super.id,
    super.originalLanguage,
    super.originalTitle,
    super.overview,
    super.popularity,
    super.posterPath,
    super.releaseDate,
    super.title,
    super.video,
    super.voteAverage,
    super.voteCount,
  });

  factory ResultsNp.fromJson(Map<String, dynamic> json) {
    return ResultsNp(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List?)?.cast<int>(),
      id: json['id'] as int?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
