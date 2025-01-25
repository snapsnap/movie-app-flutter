class DetailMovieEntity {
  bool? adult;
  String? backdropPath;
  BelongsToCollectionEntity? belongsToCollection;
  int? budget;
  List<GenresEntity>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompaniesEntity>? productionCompanies;
  List<ProductionCountriesEntity>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguagesEntity>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  DetailMovieEntity(
      {this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originCountry,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});
}

class BelongsToCollectionEntity {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  BelongsToCollectionEntity(
      {this.id, this.name, this.posterPath, this.backdropPath});
}

class GenresEntity {
  int? id;
  String? name;

  GenresEntity({this.id, this.name});
}

class ProductionCompaniesEntity {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompaniesEntity(
      {this.id, this.logoPath, this.name, this.originCountry});
}

class ProductionCountriesEntity {
  String? iso31661;
  String? name;

  ProductionCountriesEntity({this.iso31661, this.name});
}

class SpokenLanguagesEntity {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguagesEntity({this.englishName, this.iso6391, this.name});
}
