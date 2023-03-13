import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/services/movie_service.dart';
import 'package:movie/widgets/trailer_dialog.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Consumer<MovieService>(
        builder: (_, movieService, __) {
          // final genreNames = movieService.getGenreNames(movie.genreIds);
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500/${movie.backdropPath}',
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      Text(
                        movie.overview,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => TrailerDialog(movie: movie),
                          );
                        },
                        child: const Text('Watch Trailer'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
