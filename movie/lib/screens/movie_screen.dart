// //In this code, we create a MoviesScreen widget that displays a grid of movie cards using the GridView.
// //builder widget. We also use the Consumer widget from the provider package to listen to changes in the MovieService state.
// // The MovieCard widget is defined in the widgets folder.

import 'package:flutter/material.dart';
import 'package:movie/screens/movie_details_screen.dart';
import 'package:movie/services/movie_service.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final MovieService _movieService = MovieService();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Provider.of<MovieService>(context, listen: false).getMovies(1);
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      Provider.of<MovieService>(context, listen: false).loadMoreMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: Consumer<MovieService>(
        builder: (_, movieService, __) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: movieService.movies.length,
            itemBuilder: (_, index) {
              final movie = movieService.movies[index];
              return MovieCard(
                movie: movie,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => MovieDetailsScreen(movie: movie),
                  ));
                },
              );
            },
            controller: _scrollController,
          );
        },
      ),
    );
  }
}
