// This file will contain the code for fetching movie data from the TMDb API

//In this code, we create an instance of Dio and use it to make a GET request to the TMDb API.
// We pass in the API key, language, and page number as query parameters.
// The response is then parsed into a list of Movie objects using the fromJson method.

import 'package:dio/dio.dart';

class MovieService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getPopularMovies(int page) async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/popular',
        queryParameters: {
          'api_key': 'YOUR_API_KEY',
          'language': 'en-US',
          'page': page,
        },
      );
      return response.data;
    } on DioError catch (e) {
      print(e.error);
      return null;
    }
  }

  // Add other API requests as needed.
}
