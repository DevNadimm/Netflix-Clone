import 'dart:convert';

class MovieRecommendationModel {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  MovieRecommendationModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  MovieRecommendationModel copyWith({
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      MovieRecommendationModel(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory MovieRecommendationModel.fromRawJson(String str) =>
      MovieRecommendationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieRecommendationModel.fromJson(Map<String, dynamic> json) =>
      MovieRecommendationModel(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  String? backdropPath;
  int id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  MediaType? mediaType;
  bool adult;
  OriginalLanguage? originalLanguage;
  List<int> genreIds;
  double popularity;
  DateTime? releaseDate;
  bool video;
  double voteAverage;
  int voteCount;

  Result({
    this.backdropPath,
    required this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    required this.adult,
    this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Result copyWith({
    String? backdropPath,
    int? id,
    String? title,
    String? originalTitle,
    String? overview,
    String? posterPath,
    MediaType? mediaType,
    bool? adult,
    OriginalLanguage? originalLanguage,
    List<int>? genreIds,
    double? popularity,
    DateTime? releaseDate,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) =>
      Result(
        backdropPath: backdropPath ?? this.backdropPath,
        id: id ?? this.id,
        title: title ?? this.title,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        mediaType: mediaType ?? this.mediaType,
        adult: adult ?? this.adult,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        genreIds: genreIds ?? this.genreIds,
        popularity: popularity ?? this.popularity,
        releaseDate: releaseDate ?? this.releaseDate,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"] ?? "No Title",
        originalTitle: json["original_title"] ?? "No Original Title",
        overview: json["overview"] ?? "No Overview",
        posterPath: json["poster_path"],
        mediaType: mediaTypeValues.map[json["media_type"]] ?? MediaType.MOVIE,
        adult: json["adult"],
        originalLanguage:
            originalLanguageValues.map[json["original_language"]] ??
                OriginalLanguage.EN,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        releaseDate:
            json["release_date"] != null && json["release_date"].isNotEmpty
                ? DateTime.parse(json["release_date"])
                : null,
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaTypeValues.reverse[mediaType],
        "adult": adult,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "release_date": releaseDate?.toIso8601String(),
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum MediaType { MOVIE }

final mediaTypeValues = EnumValues({"movie": MediaType.MOVIE});

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({"en": OriginalLanguage.EN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
