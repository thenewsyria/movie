import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie.dart';
import 'package:movie_app/data/services/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  final MovieService _movieService = MovieService();
  List<Movie> _movies = [];
  int _currentPage = 1;
  bool _isLoading = false;

  List<Movie> get movies => _movies;
  int get currentPage => _currentPage;
  bool get isLoading => _isLoading;

  Future<void> getMovies() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    final response = await _movieService.getPopularMovies(_currentPage);
    final movies = response != null
        ? List<Movie>.from(response['results'].map((data) => Movie(
              id: data['id'],
              title: data['title'],
              overview: data['overview'],
              posterPath: data['poster_path'],
              backdropPath: data['backdrop_path'],
              voteAverage: data['vote_average'].toDouble(),
              releaseDate: data['release_date'],
            )))
        : [];

    _movies.addAll(movies);
    _currentPage++;
    _isLoading = false;
    notifyListeners();
  }
}
