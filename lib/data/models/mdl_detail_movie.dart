import '../../domain/entities/detail_movie_entity.dart';

class DetailMovieModel extends DetailMovieEntity {
  DetailMovieModel({
    super.adult,
    super.backdropPath,
    super.belongsToCollection,
    super.budget,
    super.genres,
    super.homepage,
    super.id,
    super.imdbId,
    super.originCountry,
    super.originalLanguage,
    super.originalTitle,
    super.overview,
    super.popularity,
    super.posterPath,
    super.productionCompanies,
    super.productionCountries,
    super.releaseDate,
    super.revenue,
    super.runtime,
    super.spokenLanguages,
    super.status,
    super.tagline,
    super.title,
    super.video,
    super.voteAverage,
    super.voteCount,
  });

  factory DetailMovieModel.fromJson(Map<String, dynamic> json) {
    return DetailMovieModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      belongsToCollection: json['belongs_to_collection'] != null
          ? BelongsToCollection.fromJson(json['belongs_to_collection'])
          : null,
      budget: json['budget'],
      genres:
          (json['genres'] as List?)?.map((e) => Genres.fromJson(e)).toList(),
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originCountry: (json['origin_country'] as List?)?.cast<String>(),
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      productionCompanies: (json['production_companies'] as List?)
          ?.map((e) => ProductionCompanies.fromJson(e))
          .toList(),
      productionCountries: (json['production_countries'] as List?)
          ?.map((e) => ProductionCountries.fromJson(e))
          .toList(),
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: (json['spoken_languages'] as List?)
          ?.map((e) => SpokenLanguages.fromJson(e))
          .toList(),
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      video: json['video'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    if (belongsToCollection != null) {
      data['belongs_to_collection'] =
          (belongsToCollection! as BelongsToCollection).toJson();
    }
    data['budget'] = budget;
    if (genres != null) {
      data['genres'] = genres!.map((v) => (v as Genres).toJson()).toList();
    }
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    if (productionCompanies != null) {
      data['production_companies'] = productionCompanies!
          .map((v) => (v as ProductionCompanies).toJson())
          .toList();
    }
    if (productionCountries != null) {
      data['production_countries'] = productionCountries!
          .map((v) => (v as ProductionCountries).toJson())
          .toList();
    }
    data['release_date'] = releaseDate;
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    if (spokenLanguages != null) {
      data['spoken_languages'] =
          spokenLanguages!.map((v) => (v as SpokenLanguages).toJson()).toList();
    }
    data['status'] = status;
    data['tagline'] = tagline;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

// Genres Model
class Genres extends GenresEntity {
  Genres({
    super.id,
    super.name,
  });

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

// ProductionCompanies Model
class ProductionCompanies extends ProductionCompaniesEntity {
  ProductionCompanies({
    super.id,
    super.logoPath,
    super.name,
    super.originCountry,
  });

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) {
    return ProductionCompanies(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }
}

// BelongsToCollection Model
class BelongsToCollection extends BelongsToCollectionEntity {
  BelongsToCollection({
    super.id,
    super.name,
    super.posterPath,
    super.backdropPath,
  });

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) {
    return BelongsToCollection(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
    };
  }
}

// ProductionCountries Model
class ProductionCountries extends ProductionCountriesEntity {
  ProductionCountries({
    super.iso31661,
    super.name,
  });

  factory ProductionCountries.fromJson(Map<String, dynamic> json) {
    return ProductionCountries(
      iso31661: json['iso_3166_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_3166_1': iso31661,
      'name': name,
    };
  }
}

// SpokenLanguages Model
class SpokenLanguages extends SpokenLanguagesEntity {
  SpokenLanguages({
    super.iso6391,
    super.name,
  });

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) {
    return SpokenLanguages(
      iso6391: json['iso_639_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_639_1': iso6391,
      'name': name,
    };
  }
}
