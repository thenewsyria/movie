// This file will contain the code for fetching movie data from the TMDb API

//In this code, we create an instance of Dio and use it to make a GET request to the TMDb API.
// We pass in the API key, language, and page number as query parameters.
// The response is then parsed into a list of Movie objects using the fromJson method.

import 'package:dio/dio.dart';
import 'package:movie/models/movie.dart';

class MovieService {
  final Dio _dio = Dio();

  Future<List<Movie>> getMovies(int page) async {
    final response = await _dio.get(
      'https://api.themoviedb.org/3/movie/popular',
      queryParameters: {
        'api_key': 'YOUR_API_KEY_HERE',
        'language': 'en-US',
        'page': page,
      },
    );

    final results = List<Map<String, dynamic>>.from(response.data['results']);
    final movies = results.map((movie) => Movie.fromJson(movie)).toList();
    return movies;
  }
}
