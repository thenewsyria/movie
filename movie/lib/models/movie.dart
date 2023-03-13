//In this code, we create a Movie model with the necessary properties.
//We also define a factory method fromJson that takes a JSON object and returns a Movie object

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final DateTime releaseDate;
  final List<int> genreIds;
  final double voteAverage;
  final int voteCount;
  final String videoKey;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.genreIds,
    required this.voteAverage,
    required this.voteCount,
    required this.videoKey,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final genreIds = List<int>.from(json['genre_ids']);
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: DateTime.parse(json['release_date']),
      genreIds: genreIds,
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      videoKey: '',
    );
  }
}
